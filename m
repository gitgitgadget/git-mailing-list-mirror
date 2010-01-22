From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 20:31:25 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001212025270.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001212131230.1726@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 05:32:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYBCC-0003sH-DF
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 05:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab0AVEc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 23:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061Ab0AVEc2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 23:32:28 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56493 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149Ab0AVEc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 23:32:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M4VQhM019323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 20:31:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M4VPbM016604;
	Thu, 21 Jan 2010 20:31:25 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001212131230.1726@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137738>



On Thu, 21 Jan 2010, Nicolas Pitre wrote:
> 
> So I really think that Linus' patch (which is missing hex.c btw) is a 
> good thing to do, even if only for the cleanup value.

Btw, it looks like the separate hex.c would fix not just git-show-index 
(together with de-xmalloc), but also make git-patch-id shrink down. Except 
git-patch-id for some reason does git_extract_argv0_path(), which brings 
in exec_cmd.o, which brings in strbuf, and xmalloc, and now it's all the 
same old pain again.

So rather than try to solve it all (xmalloc in particular is pretty 
hairy), here's another patch.

		Linus
---
 Makefile                         |    2 +-
 patch-id.c => builtin-patch-id.c |    4 +---
 builtin.h                        |    1 +
 git.c                            |    1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 398b5fb..5b614e4 100644
--- a/Makefile
+++ b/Makefile
@@ -392,7 +392,6 @@ PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-mktag$X
 PROGRAMS += git-pack-redundant$X
-PROGRAMS += git-patch-id$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
@@ -674,6 +673,7 @@ BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
 BUILTIN_OBJS += builtin-pack-refs.o
+BUILTIN_OBJS += builtin-patch-id.o
 BUILTIN_OBJS += builtin-prune-packed.o
 BUILTIN_OBJS += builtin-prune.o
 BUILTIN_OBJS += builtin-push.o
diff --git a/patch-id.c b/builtin-patch-id.c
similarity index 95%
rename from patch-id.c
rename to builtin-patch-id.c
index 0df4cb0..af0911e 100644
--- a/patch-id.c
+++ b/builtin-patch-id.c
@@ -75,13 +75,11 @@ static void generate_id_list(void)
 
 static const char patch_id_usage[] = "git patch-id < patch";
 
-int main(int argc, char **argv)
+int cmd_patch_id(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 1)
 		usage(patch_id_usage);
 
-	git_extract_argv0_path(argv[0]);
-
 	generate_id_list();
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 0c9c396..ab723f8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -76,6 +76,7 @@ extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 09d3272..e38f201 100644
--- a/git.c
+++ b/git.c
@@ -341,6 +341,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+		{ "patch-id", cmd_patch_id },
 		{ "peek-remote", cmd_ls_remote },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
