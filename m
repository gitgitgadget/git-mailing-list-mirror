From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: [PATCH] Teach git submodule update to use distributed repositories
Date: Thu, 17 Jul 2008 13:08:19 +0100
Message-ID: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJSIY-00061P-BN
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbYGQMIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbYGQMIW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:08:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:1839 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbYGQMIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:08:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1942619yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ckR5FltNWQ0Bf5dgLxoC8NI/fzqrKZPENKVxtsIa5JU=;
        b=R4QP1h1OhlkBEcZeiFY509voM3BTUuIEBUTWR6Xxo5weC+R/jSL8HtInRzYTlMXOFs
         K0jyzb+PVd/fO7hVKr44DUEnxDv+0eQIyWfp4CjVXC/7zD534cnckCKaPTkXmmL/+Tst
         +0NqyrCDxanAI8e+IMey8ZV98QZpSnuyDxLXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SV7I05xp+mSJXznazX/0Nq7TDgSO8/EFp2MCkBw/ASxXa1BWKxrbJIZCIxNOJCIyVI
         ucWXkrRKKL7apMRXy77rB1INWv6uNDirFSkAD/EJuKgLEDTMBsQk+0G8UOp0S2uFJAYX
         Ydvtf77bBrMaTqsTB/ZYbA2PyoPqGaHaqaPu4=
Received: by 10.103.249.7 with SMTP id b7mr1873437mus.2.1216296499720;
        Thu, 17 Jul 2008 05:08:19 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Thu, 17 Jul 2008 05:08:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88836>

When doing a git submodule update, it fetches any missing submodule
commits from the repository specified in .gitmodules. If you instead
want to pull from another repository, you currently need to do a fetch
in each submodule by hand.

Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>
---
This is my first attempt at adding things to help everyday usage of
git submodule.

I don't usually write much shell script; and it's my first patch, so
it's possible there are better ways to do these things..

 git-submodule.sh |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9228f56..40e1aa1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli

 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] <path>]|[status|init|update
[-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] <path>]|[status|init|update [-i|--init]
[-o|--origin <repository>] [-r|-refspec <refspec>]|summary
[-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -15,6 +15,8 @@ command=
 branch=
 quiet=
 cached=
+repository=
+refspec=

 #
 # print stuff on stdout unless -q was specified
@@ -270,6 +272,14 @@ cmd_update()
 			shift
 			cmd_init "$@" || return
 			;;
+		-o|--origin)
+			shift
+			repository=$1
+			;;
+		-r|--refspec)
+			shift
+			refspec=$1
+			;;
 		--)
 			shift
 			break
@@ -311,7 +321,9 @@ cmd_update()

 		if test "$subsha1" != "$sha1"
 		then
-			(unset GIT_DIR; cd "$path" && git-fetch &&
+			set_submodule_repository "$repository" "$path"
+
+			(unset GIT_DIR; cd "$path" && git-fetch "$subrepo" "$refspec" &&
 				git-checkout -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"

@@ -320,6 +332,23 @@ cmd_update()
 	done
 }

+#
+# If we asked for a repository such as 'origin', just pass this through
+# otherwise, try to calculate what the repository URL might be by
+# adding the submodule path to the url, subtracting any /.git first
+#
+set_submodule_repository() {
+
+	if [ -z `echo "$1" | grep '/'` ]
+	then
+		# This is not a URL - just use the name
+		subrepo="$1"
+	else
+		# This is a URL. Chop off /.git if it's there, and add submodule path
+		subrepo="${1/%\/.git/}/$2"
+	fi
+}
+
 set_name_rev () {
 	revname=$( (
 		unset GIT_DIR
-- 
1.5.6.2
