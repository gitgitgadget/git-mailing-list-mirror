From: Junio C Hamano <junkio@cox.net>
Subject: send-pack question.
Date: Sat, 30 Jul 2005 22:47:51 -0700
Message-ID: <7v1x5fwmpk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 07:48:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz6gY-0006tg-8c
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 07:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVGaFsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGaFsZ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 01:48:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25002 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261685AbVGaFrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 01:47:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731054751.XLIS8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 01:47:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been looking at send-pack because some people seem to
want to push into a remote repository that names heads
differently from local.  I have some questions that do not have
to do with anything about their request, but about what
the current code intends to do.

 * Right now, "send-pack --all" into an empty repository does
   not do anything, but "send-pack --all master" into an empty
   repository pushes all local heads.  This is because we do not
   check "send_all" when deciding if we want to call try_match
   on local references.  I am assuming this is an oversight; am
   I correct?  If so, does the attached patch look OK?

 * It appears to me that you can say "send-pack net", and
   depending on how the remote lists its refs, you can end up
   updating their refs/heads/net or refs/tags/net.  More
   confusingly, you could say "send-pack net net" to update
   both.  More realistically, you could get confused with a
   remote that has refs/heads/jgarzik/net and
   refs/heads/dsmiller/net in this way.  I think it should
   detect, stop and warn about the ambiguity and require the
   user to be more explicit.  Am I reading the current code
   correctly?

   I've always _hated_ the interface to path_match() which
   pretends to be just a boolean function but actually has a
   grave side effect, by the way.

---
# - pu: git-fetch-script http fix.
# + (working tree)
diff --git a/send-pack.c b/send-pack.c
--- a/send-pack.c
+++ b/send-pack.c
@@ -4,7 +4,8 @@
 #include "pkt-line.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--exec=git-receive-pack] [host:]directory [heads]*";
+"git-send-pack [--all] [--exec=git-receive-pack] <remote> [<head>...]\n"
+"  --all and explicit <head> specification are mutually exclusive.";
 static const char *exec = "git-receive-pack";
 static int send_all = 0;
 static int force_update = 0;
@@ -214,7 +215,7 @@ static int send_pack(int in, int out, in
 	/*
 	 * See if we have any refs that the other end didn't have
 	 */
-	if (nr_match) {
+	if (nr_match || send_all) {
 		local_ref_nr_match = nr_match;
 		local_ref_match = match;
 		local_ref_list = ref_list;
@@ -281,6 +282,8 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(send_pack_usage);
+	if (heads && send_all)
+		usage(send_pack_usage);
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;


   
