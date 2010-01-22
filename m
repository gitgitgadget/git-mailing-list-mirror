From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 18:20:14 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211811140.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY98M-0001sx-Bk
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab0AVCUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112Ab0AVCUW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:20:22 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44430 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755560Ab0AVCUV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 21:20:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M2KEe9006821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 18:20:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M2KEOH011278;
	Thu, 21 Jan 2010 18:20:14 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v636vj7c2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137721>



On Thu, 21 Jan 2010, Junio C Hamano wrote:
> 
> We tend to not remove things unless we are absolutely certain nobody uses
> it, so probably making it built-in would be preferrable.  I don't think
> show-index is used very often if ever, but scripts that use hash-object
> would use it really often and would do so via its --stdin interface if it
> knows that it is creating more than a dozen objects, so start-up time
> required to map the whole git is probably not an issue.

git-show-index should certainly be easy to turn into a built-in too. Patch 
appended.

> By the way, do you think anybody still uses "git merge-trees"?

I dunno. I think it has some conceptual advantages, but realistically, I 
doubt anybody is willing to go through the pain to make it grow up enough 
to become a viable alternative to our current situation.

		Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu Jan 21 18:16:49 2010 -0800
Subject: Turn 'show-index' into a builtin

.. rather than being a huge executable just because it sucks in all the
git library code and then does something really trivial.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile                             |    2 +-
 show-index.c => builtin-show-index.c |    2 +-
 builtin.h                            |    1 +
 git.c                                |    3 ++-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ad890ec..3439d2c 100644
--- a/Makefile
+++ b/Makefile
@@ -396,7 +396,6 @@ PROGRAMS += git-mktag$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
 PROGRAMS += git-shell$X
-PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
@@ -693,6 +692,7 @@ BUILTIN_OBJS += builtin-rm.o
 BUILTIN_OBJS += builtin-send-pack.o
 BUILTIN_OBJS += builtin-shortlog.o
 BUILTIN_OBJS += builtin-show-branch.o
+BUILTIN_OBJS += builtin-show-index.o
 BUILTIN_OBJS += builtin-show-ref.o
 BUILTIN_OBJS += builtin-stripspace.o
 BUILTIN_OBJS += builtin-symbolic-ref.o
diff --git a/show-index.c b/builtin-show-index.c
similarity index 96%
rename from show-index.c
rename to builtin-show-index.c
index 63f9da5..92202b8 100644
--- a/show-index.c
+++ b/builtin-show-index.c
@@ -4,7 +4,7 @@
 static const char show_index_usage[] =
 "git show-index < <packed archive index>";
 
-int main(int argc, char **argv)
+int cmd_show_index(int argc, const char **argv, const  char *prefix)
 {
 	int i;
 	unsigned nr;
diff --git a/builtin.h b/builtin.h
index c3f83c0..4d73d7c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -93,6 +93,7 @@ extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 194471f..5fabf18 100644
--- a/git.c
+++ b/git.c
@@ -358,8 +358,9 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "show-branch", cmd_show_branch, RUN_SETUP },
+		{ "show-index", cmd_show_index },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
