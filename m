From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] push: receiver end advertises refs from alternate
 repositories
Date: Tue,  9 Sep 2008 01:27:10 -0700
Message-ID: <1220948830-3275-5-git-send-email-gitster@pobox.com>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com>
 <1220948830-3275-2-git-send-email-gitster@pobox.com>
 <1220948830-3275-3-git-send-email-gitster@pobox.com>
 <1220948830-3275-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 10:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyaY-0005P5-2r
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbYIII13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbYIII13
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:27:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbYIII12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:27:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E75755F890
	for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1370F5F88F for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:25
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.415.g7bb82
In-Reply-To: <1220948830-3275-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 229BF96A-7E49-11DD-8AAA-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95353>

Earlier, when pushing into a repository that borrows from alternate object
stores, we followed the longstanding design decision not to trust refs in
the alternate repository that houses the object store we are borrowing
from.  If your public repository is borrowing from Linus's public
repository, you pushed into it long time ago, and now when you try to push
your updated history that is in sync with more recent history from Linus,
you will end up sending not just your own development, but also the
changes you acquired through Linus's tree, even though the objects needed
for the latter already exists at the receiving end.  This is because the
receiving end does not advertise that the objects only reachable from the
borrowed repository (i.e. Linus's) are already available there.

This solves the issue by making the receiving end advertise refs from
borrowed repositories.  They are not sent with their true names but with a
phoney name ".have" to make sure that the old senders will safely ignore
them (otherwise, the old senders will misbehave, trying to push matching
refs, and mirror push that deletes refs that only exist at the receiving
end).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-receive-pack.c |   38 ++++++++++++++++++++++++++++++++++++++
 cache.h                |    2 ++
 sha1_file.c            |   10 ++++++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6d6027e..45e3cd9 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -6,6 +6,8 @@
 #include "exec_cmd.h"
 #include "commit.h"
 #include "object.h"
+#include "remote.h"
+#include "transport.h"
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
@@ -462,6 +464,40 @@ static int delete_only(struct command *cmd)
 	return 1;
 }
 
+static int add_refs_from_alternate(struct alternate_object_database *e, void *unused)
+{
+	char *other = xstrdup(make_absolute_path(e->base));
+	size_t len = strlen(other);
+	struct remote *remote;
+	struct transport *transport;
+	const struct ref *extra;
+
+	while (other[len-1] == '/')
+		other[--len] = '\0';
+	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
+		return 0;
+	/* Is this a git repository with refs? */
+	memcpy(other + len - 8, "/refs", 6);
+	if (!is_directory(other))
+		return 0;
+	other[len - 8] = '\0';
+	remote = remote_get(other);
+	transport = transport_get(remote, other);
+	for (extra = transport_get_remote_refs(transport);
+	     extra;
+	     extra = extra->next) {
+		add_extra_ref(".have", extra->old_sha1, 0);
+	}
+	transport_disconnect(transport);
+	free(other);
+	return 0;
+}
+
+static void add_alternate_refs(void)
+{
+	foreach_alt_odb(add_refs_from_alternate, NULL);
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -497,7 +533,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
+	add_alternate_refs();
 	write_head_info();
+	clear_extra_refs();
 
 	/* EOF */
 	packet_flush(1);
diff --git a/cache.h b/cache.h
index 98a7421..99af83a 100644
--- a/cache.h
+++ b/cache.h
@@ -641,6 +641,8 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void add_to_alternates_file(const char *reference);
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+extern void foreach_alt_odb(alt_odb_fn, void*);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index ae550e8..12be17b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -393,6 +393,16 @@ void add_to_alternates_file(const char *reference)
 		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
 }
 
+void foreach_alt_odb(alt_odb_fn fn, void *cb)
+{
+	struct alternate_object_database *ent;
+
+	prepare_alt_odb();
+	for (ent = alt_odb_list; ent; ent = ent->next)
+		if (fn(ent, cb))
+			return;
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
-- 
1.6.0.1.415.g7bb82
