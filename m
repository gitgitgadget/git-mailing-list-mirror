From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 19:48:50 +0100
Message-ID: <49382612.3010207@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8JH8-0007Wi-DQ
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 19:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbYLDSsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 13:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbYLDSsy
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 13:48:54 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:47229 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbYLDSsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 13:48:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 3836A1C25E
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 19:48:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zG7QayGGuVrr for <git@vger.kernel.org>;
	Thu,  4 Dec 2008 19:48:51 +0100 (CET)
Received: from [192.168.10.11] (dyn.144-85-212-018.dsl.vtx.ch [144.85.212.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 0C2951C0F1
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 19:48:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (X11/20081021)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102355>

We need to play some shell tricks to be able to pass directory names
which contain spaces and/or quotes.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---

Boyd Stephen Smith Jr. wrote:
 > I'm thinking your sed line doesn't do what you think it does.  You 
probably
 > want something like:
 > bss@monster:~$ echo "don't" | sed -e "s/'/'\\\\''/g"
 > don'\''t

Thanks, I clearly did not test this well enough.

  git-am.sh |    8 +++++---
  1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index aa60261..3baff4e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit 
message
  u,utf8          recode into utf8 (default)
  k,keep          pass -k flag to git-mailinfo
  whitespace=     pass it through git-apply
+directory=      pass it through git-apply
  C=              pass it through git-apply
  p=              pass it through git-apply
  resolvemsg=     override error message when patch failure occurs
@@ -155,8 +156,9 @@ do
  		;;
  	--resolvemsg)
  		shift; resolvemsg=$1 ;;
-	--whitespace)
-		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+	--whitespace|--directory)
+		quot=$(echo "$2" | sed -e "s/'/'\\\''/g")
+		git_apply_opt="$git_apply_opt $1='$quot'"; shift ;;
  	-C|-p)
  		git_apply_opt="$git_apply_opt $1$2"; shift ;;
  	--)
@@ -454,7 +456,7 @@ do

  	case "$resolved" in
  	'')
-		git apply $git_apply_opt --index "$dotest/patch"
+		eval git apply $git_apply_opt --index '"$dotest/patch"'
  		apply_status=$?
  		;;
  	t)
-- 
1.6.1.rc1.45.g123ed.dirty
