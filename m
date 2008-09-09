From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] push: prepare sender to receive extended ref information
 from the receiver
Date: Tue,  9 Sep 2008 01:27:09 -0700
Message-ID: <1220948830-3275-4-git-send-email-gitster@pobox.com>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com>
 <1220948830-3275-2-git-send-email-gitster@pobox.com>
 <1220948830-3275-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 10:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyaX-0005P5-Ap
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYIII10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbYIII10
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:27:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbYIII1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:27:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 287BD5F88E
	for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2C23C5F88D for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:22
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.415.g7bb82
In-Reply-To: <1220948830-3275-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 205B2C20-7E49-11DD-9BF9-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95354>

"git push" enhancement allows the receiving end to report not only its own
refs but refs in repositories it borrows from via the alternate object
store mechanism.  By telling the sender that objects reachable from these
extra refs are already complete in the receiving end, the number of
objects that need to be transfered can be cut down.

These entries are sent over the wire with string ".have", instead of the
actual names of the refs.  This string was chosen so that they are ignored
by older programs at the sending end.  If we sent some random but valid
looking refnames for these entries, "matching refs" rule (triggered when
running "git push" without explicit refspecs, where the sender learns what
refs the receiver has, and updates only the ones with the names of the
refs the sender also has) and "delete missing" rule (triggered when "git
push --mirror" is used, where the sender tells the receiver to delete the
refs it itself does not have) would try to update/delete them, which is
not what we want.

This prepares the send-pack (and "push" that runs native protocol) to
accept extended existing ref information and make use of it.  The ".have"
entries are excluded from ref matching rules, and are exempt from deletion
rule while pushing with --mirror option, but are still used for pack
generation purposes by providing more "bottom" range commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fetch-pack.c |    2 +-
 builtin-send-pack.c  |   21 ++++++++++++++++-----
 cache.h              |    6 +++++-
 connect.c            |   17 ++++++++++++++++-
 transport.c          |    4 ++--
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 459c6f0..e0c2561 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -735,7 +735,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	conn = git_connect(fd, (char *)dest, args.uploadpack,
 			   args.verbose ? CONNECT_VERBOSE : 0);
 	if (conn) {
-		get_remote_heads(fd[0], &ref, 0, NULL, 0);
+		get_remote_heads(fd[0], &ref, 0, NULL, 0, NULL);
 
 		ref = fetch_pack(&args, fd, conn, ref, dest, nr_heads, heads, NULL);
 		close(fd[0]);
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 7588d22..b3c22f6 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -18,7 +18,7 @@ static struct send_pack_args args = {
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs)
+static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *extra)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -34,6 +34,8 @@ static int pack_objects(int fd, struct ref *refs)
 		NULL,
 	};
 	struct child_process po;
+	int i;
+	char buf[42];
 
 	if (args.use_thin_pack)
 		argv[4] = "--thin";
@@ -49,9 +51,15 @@ static int pack_objects(int fd, struct ref *refs)
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
-	while (refs) {
-		char buf[42];
+	for (i = 0; i < extra->nr; i++) {
+		memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
+		buf[0] = '^';
+		buf[41] = '\n';
+		if (!write_or_whine(po.in, buf, 42, "send-pack: send refs"))
+			break;
+	}
 
+	while (refs) {
 		if (!is_null_sha1(refs->old_sha1) &&
 		    has_sha1_file(refs->old_sha1)) {
 			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
@@ -381,14 +389,17 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int expect_status_report = 0;
 	int flags = MATCH_REFS_NONE;
 	int ret;
+	struct extra_have_objects extra_have;
 
+	memset(&extra_have, 0, sizeof(extra_have));
 	if (args.send_all)
 		flags |= MATCH_REFS_ALL;
 	if (args.send_mirror)
 		flags |= MATCH_REFS_MIRROR;
 
 	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
+	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL,
+				       &extra_have);
 	get_local_heads();
 
 	/* Does the other end support the reporting? */
@@ -496,7 +507,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	packet_flush(out);
 	if (new_refs && !args.dry_run) {
-		if (pack_objects(out, remote_refs) < 0)
+		if (pack_objects(out, remote_refs, &extra_have) < 0)
 			return -1;
 	}
 	else
diff --git a/cache.h b/cache.h
index ce1f630..98a7421 100644
--- a/cache.h
+++ b/cache.h
@@ -709,7 +709,11 @@ extern struct child_process *git_connect(int fd[2], const char *url, const char
 extern int finish_connect(struct child_process *conn);
 extern int path_match(const char *path, int nr, char **match);
 extern int get_ack(int fd, unsigned char *result_sha1);
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags);
+struct extra_have_objects {
+	int nr, alloc;
+	unsigned char (*array)[20];
+};
+extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
diff --git a/connect.c b/connect.c
index dd96f8e..071e355 100644
--- a/connect.c
+++ b/connect.c
@@ -41,12 +41,21 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, strlen(ref->name), flags);
 }
 
+static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1)
+{
+	if (extra->alloc <= extra->nr)
+		ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
+	hashcpy(&(extra->array[extra->nr][0]), sha1);
+	extra->nr++;
+}
+
 /*
  * Read all the refs from the other end
  */
 struct ref **get_remote_heads(int in, struct ref **list,
 			      int nr_match, char **match,
-			      unsigned int flags)
+			      unsigned int flags,
+			      struct extra_have_objects *extra_have)
 {
 	*list = NULL;
 	for (;;) {
@@ -72,6 +81,12 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			server_capabilities = xstrdup(name + name_len + 1);
 		}
 
+		if (extra_have &&
+		    name_len == 5 && !memcmp(".have", name, 5)) {
+			add_extra_have(extra_have, old_sha1);
+			continue;
+		}
+
 		if (!check_ref(name, name_len, flags))
 			continue;
 		if (nr_match && !path_match(name, nr_match, match))
diff --git a/transport.c b/transport.c
index 71433d9..f7db5d9 100644
--- a/transport.c
+++ b/transport.c
@@ -619,7 +619,7 @@ static struct ref *get_refs_via_connect(struct transport *transport)
 	struct ref *refs;
 
 	connect_setup(transport);
-	get_remote_heads(data->fd[0], &refs, 0, NULL, 0);
+	get_remote_heads(data->fd[0], &refs, 0, NULL, 0, NULL);
 
 	return refs;
 }
@@ -652,7 +652,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	if (!data->conn) {
 		connect_setup(transport);
-		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0);
+		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
 	}
 
 	refs = fetch_pack(&args, data->fd, data->conn,
-- 
1.6.0.1.415.g7bb82
