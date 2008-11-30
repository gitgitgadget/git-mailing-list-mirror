From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] get_remote_heads(): do not assume that the conversation
 is one-way
Date: Sun, 30 Nov 2008 01:57:31 -0800
Message-ID: <1228039053-31099-4-git-send-email-gitster@pobox.com>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
 <1228039053-31099-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 10:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6j5R-00010i-P2
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 10:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYK3J6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYK3J6P
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:58:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYK3J6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:58:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CE7A417CB9
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5ABA17CB7 for
 <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:03 -0500 (EST)
X-Mailer: git-send-email 1.6.0.4.850.g6bd829
In-Reply-To: <1228039053-31099-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 654CA3EC-BEC5-11DD-BC09-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101955>

This is the first step to extend the fetch-pack protocol so that we can
transfer symref information to accurately clone from a repository whose
HEAD points at a branch that is different from its 'master' branch but
happens to point at the same commit.

The old code assumed that the discovery of remote refs can be done by
receiving side only listening to what the other side said, which makes it
impossible for it to tell the other side to enable the protocol extension.
This passes both ends of the socket to the function to allow the receiving
end to talk back to the sending end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fetch-pack.c |    2 +-
 builtin-send-pack.c  |    7 ++++---
 cache.h              |    2 +-
 connect.c            |    4 ++--
 transport.c          |    4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 372bfa2..6927410 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -735,7 +735,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	conn = git_connect(fd, (char *)dest, args.uploadpack,
 			   args.verbose ? CONNECT_VERBOSE : 0);
 	if (conn) {
-		get_remote_heads(fd[0], &ref, 0, NULL, 0, NULL);
+		get_remote_heads(fd, &ref, 0, NULL, 0, NULL);
 
 		ref = fetch_pack(&args, fd, conn, ref, dest, nr_heads, heads, NULL);
 		close(fd[0]);
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index a9fdbf9..23cdd48 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -386,7 +386,7 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
-static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
+static int do_send_pack(int fd[2], struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -395,6 +395,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int expect_status_report = 0;
 	int flags = MATCH_REFS_NONE;
 	int ret;
+	int in = fd[0], out = fd[1];
 	struct extra_have_objects extra_have;
 
 	memset(&extra_have, 0, sizeof(extra_have));
@@ -404,7 +405,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		flags |= MATCH_REFS_MIRROR;
 
 	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL,
+	remote_tail = get_remote_heads(fd, &remote_refs, 0, NULL, REF_NORMAL,
 				       &extra_have);
 	get_local_heads();
 
@@ -665,7 +666,7 @@ int send_pack(struct send_pack_args *my_args,
 	verify_remote_names(nr_heads, heads);
 
 	conn = git_connect(fd, dest, args.receivepack, args.verbose ? CONNECT_VERBOSE : 0);
-	ret = do_send_pack(fd[0], fd[1], remote, dest, nr_heads, heads);
+	ret = do_send_pack(fd, remote, dest, nr_heads, heads);
 	close(fd[0]);
 	/* do_send_pack always closes fd[1] */
 	ret |= finish_connect(conn);
diff --git a/cache.h b/cache.h
index 487e5e1..2bee869 100644
--- a/cache.h
+++ b/cache.h
@@ -752,7 +752,7 @@ struct extra_have_objects {
 	int nr, alloc;
 	unsigned char (*array)[20];
 };
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
+extern struct ref **get_remote_heads(int fd[2], struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
diff --git a/connect.c b/connect.c
index 584e04c..402fbe6 100644
--- a/connect.c
+++ b/connect.c
@@ -51,7 +51,7 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, struct ref **list,
+struct ref **get_remote_heads(int fd[2], struct ref **list,
 			      int nr_match, char **match,
 			      unsigned int flags,
 			      struct extra_have_objects *extra_have)
@@ -64,7 +64,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read_line(in, buffer, sizeof(buffer));
+		len = packet_read_line(fd[0], buffer, sizeof(buffer));
 		if (!len)
 			break;
 		if (buffer[len-1] == '\n')
diff --git a/transport.c b/transport.c
index 56831c5..72b3a76 100644
--- a/transport.c
+++ b/transport.c
@@ -617,7 +617,7 @@ static struct ref *get_refs_via_connect(struct transport *transport)
 	struct ref *refs;
 
 	connect_setup(transport);
-	get_remote_heads(data->fd[0], &refs, 0, NULL, 0, NULL);
+	get_remote_heads(data->fd, &refs, 0, NULL, 0, NULL);
 
 	return refs;
 }
@@ -650,7 +650,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	if (!data->conn) {
 		connect_setup(transport);
-		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
+		get_remote_heads(data->fd, &refs_tmp, 0, NULL, 0, NULL);
 	}
 
 	refs = fetch_pack(&args, data->fd, data->conn,
-- 
1.6.0.4.850.g6bd829
