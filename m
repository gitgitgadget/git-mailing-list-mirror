From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 19:50:11 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211949250.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211811140.13231@localhost.localdomain> <alpine.LFD.2.00.1001211823590.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYAYY-0000c5-0q
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab0AVDvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 22:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979Ab0AVDu7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:50:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43902 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab0AVDu6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 22:50:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M3oBGh016888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 19:50:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M3oBI2014882;
	Thu, 21 Jan 2010 19:50:11 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001211823590.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137732>



On Thu, 21 Jan 2010, Linus Torvalds wrote:
> 
> This makes it a built-in, at least, so it doesn't waste the diskspace.

.. and here's 'git hash-object' as a built-in.

		Linus

---
 Makefile                               |    2 +-
 hash-object.c => builtin-hash-object.c |    5 +----
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 35aea16..f9e4aa3 100644
--- a/Makefile
+++ b/Makefile
@@ -387,7 +387,6 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
-PROGRAMS += git-hash-object$X
 PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
@@ -656,6 +655,7 @@ BUILTIN_OBJS += builtin-for-each-ref.o
 BUILTIN_OBJS += builtin-fsck.o
 BUILTIN_OBJS += builtin-gc.o
 BUILTIN_OBJS += builtin-grep.o
+BUILTIN_OBJS += builtin-hash-object.o
 BUILTIN_OBJS += builtin-help.o
 BUILTIN_OBJS += builtin-init-db.o
 BUILTIN_OBJS += builtin-log.o
diff --git a/hash-object.c b/builtin-hash-object.c
similarity index 97%
rename from hash-object.c
rename to builtin-hash-object.c
index 9455dd0..6a5f5b5 100644
--- a/hash-object.c
+++ b/builtin-hash-object.c
@@ -73,17 +73,14 @@ static const struct option hash_object_options[] = {
 	OPT_END()
 };
 
-int main(int argc, const char **argv)
+int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	const char *prefix = NULL;
 	int prefix_length = -1;
 	const char *errstr = NULL;
 
 	type = blob_type;
 
-	git_extract_argv0_path(argv[0]);
-
 	argc = parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
 
diff --git a/builtin.h b/builtin.h
index 06bf04e..3aa6b6c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -55,6 +55,7 @@ extern int cmd_fsck(int argc, const char **argv, const char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
+extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index e5964a8..a952663 100644
--- a/git.c
+++ b/git.c
@@ -318,6 +318,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, USE_PAGER },
+		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
