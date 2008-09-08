From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates and push
Date: Sun, 07 Sep 2008 22:07:37 -0700
Message-ID: <7v4p4ri5t2.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
 <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
 <20080907234118.GA8161@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 08 07:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcYzf-0000uY-97
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 07:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbYIHFHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 01:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYIHFHs
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 01:07:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYIHFHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 01:07:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D69C5F19E;
	Mon,  8 Sep 2008 01:07:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2B8775F19D; Mon,  8 Sep 2008 01:07:40 -0400 (EDT)
In-Reply-To: <20080907234118.GA8161@mit.edu> (Theodore Tso's message of "Sun,
 7 Sep 2008 19:41:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1226156A-7D64-11DD-A3DC-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95216>

Theodore Tso <tytso@MIT.EDU> writes:

> One way that wouldn't break backwards compatibility would be to use
> $D/refs if it exists, but if it isn't, fall back to existing behavior
> (which is to say, only use the refs in the repository, not in the
> borrowed repository/object store).  Is there a reason why this would
> be problematic?

This does not answer "is this safe enough change?" question, but the code
to implement this should look like this (Area expert Daniel CC'ed).

 Makefile                                 |    2 +-
 receive-pack.c => builtin-receive-pack.c |   60 ++++++++++++++++++++++++++++-
 builtin.h                                |    1 +
 cache.h                                  |    2 +
 git.c                                    |    1 +
 sha1_file.c                              |   10 +++++
 6 files changed, 72 insertions(+), 4 deletions(-)

diff --git c/Makefile w/Makefile
index dfed7ba..badf27a 100644
--- c/Makefile
+++ w/Makefile
@@ -294,7 +294,6 @@ PROGRAMS += git-mktag$X
 PROGRAMS += git-mktree$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
-PROGRAMS += git-receive-pack$X
 PROGRAMS += git-send-pack$X
 PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
@@ -543,6 +542,7 @@ BUILTIN_OBJS += builtin-prune-packed.o
 BUILTIN_OBJS += builtin-prune.o
 BUILTIN_OBJS += builtin-push.o
 BUILTIN_OBJS += builtin-read-tree.o
+BUILTIN_OBJS += builtin-receive-pack.o
 BUILTIN_OBJS += builtin-reflog.o
 BUILTIN_OBJS += builtin-remote.o
 BUILTIN_OBJS += builtin-rerere.o
diff --git c/receive-pack.c w/builtin-receive-pack.c
similarity index 88%
rename from receive-pack.c
rename to builtin-receive-pack.c
index b81678a..c9bb722 100644
--- c/receive-pack.c
+++ w/builtin-receive-pack.c
@@ -6,6 +6,8 @@
 #include "exec_cmd.h"
 #include "commit.h"
 #include "object.h"
+#include "remote.h"
+#include "transport.h"
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
@@ -462,14 +464,64 @@ static int delete_only(struct command *cmd)
 	return 1;
 }
 
-int main(int argc, char **argv)
+/* Need to move this to path.c or somewhere, and remove the same from builtin-clone.c */
+static int is_directory(const char *path)
+{
+	struct stat buf;
+
+	return !stat(path, &buf) && S_ISDIR(buf.st_mode);
+}
+
+static int add_refs_from_alternate(struct alternate_object_database *e, void *unused)
+{
+	char *other = xstrdup(make_absolute_path(e->base));
+	size_t len = strlen(other);
+	struct remote *remote;
+	struct transport *transport;
+	const struct ref *extra;
+	struct strbuf buf = STRBUF_INIT;
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
+		/*
+		 * Make sure this is named uniquely but with invalid name, so
+		 * that we can catch the other end trying to do anything funky
+		 * with it.
+		 */
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/borrowed-ref/%s", extra->name);
+		add_extra_ref(buf.buf, extra->old_sha1, 0);
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
+int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	char *dir = NULL;
 
 	argv++;
 	for (i = 1; i < argc; i++) {
-		char *arg = *argv++;
+		const char *arg = *argv++;
 
 		if (*arg == '-') {
 			/* Do flag handling here */
@@ -477,7 +529,7 @@ int main(int argc, char **argv)
 		}
 		if (dir)
 			usage(receive_pack_usage);
-		dir = arg;
+		dir = xstrdup(arg);
 	}
 	if (!dir)
 		usage(receive_pack_usage);
@@ -497,7 +549,9 @@ int main(int argc, char **argv)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
+	add_alternate_refs();
 	write_head_info();
+	clear_extra_refs();
 
 	/* EOF */
 	packet_flush(1);
diff --git c/builtin.h w/builtin.h
index f3502d3..ade9a12 100644
--- c/builtin.h
+++ w/builtin.h
@@ -78,6 +78,7 @@ extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
diff --git c/cache.h w/cache.h
index de8c2b6..ddea8d1 100644
--- c/cache.h
+++ w/cache.h
@@ -640,6 +640,8 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void add_to_alternates_file(const char *reference);
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+extern void foreach_alt_odb(alt_odb_fn, void*);
 
 struct pack_window {
 	struct pack_window *next;
diff --git c/git.c w/git.c
index fdb0f71..bf1ac1b 100644
--- c/git.c
+++ w/git.c
@@ -328,6 +328,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "repo-config", cmd_config },
diff --git c/sha1_file.c w/sha1_file.c
index 9ee1ed1..6bd0ef0 100644
--- c/sha1_file.c
+++ w/sha1_file.c
@@ -394,6 +394,16 @@ void add_to_alternates_file(const char *reference)
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
