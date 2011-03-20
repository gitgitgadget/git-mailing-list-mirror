From: Maxin john <maxin@maxinbjohn.info>
Subject: [PATCH ] "git bisect visualize" results in an invalid error if "gitk"
 is not installed
Date: Sun, 20 Mar 2011 23:10:55 +0200
Message-ID: <AANLkTi=HJjqrvv-PFO3VjhrHzBsLZmAbN0yU47WScWd_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 22:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ptt-0001iv-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 22:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab1CTVK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 17:10:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43583 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1CTVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 17:10:56 -0400
Received: by gwaa18 with SMTP id a18so2161974gwa.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 14:10:55 -0700 (PDT)
Received: by 10.236.182.97 with SMTP id n61mr4255434yhm.256.1300655455280;
 Sun, 20 Mar 2011 14:10:55 -0700 (PDT)
Received: by 10.236.105.137 with HTTP; Sun, 20 Mar 2011 14:10:55 -0700 (PDT)
X-Originating-IP: [80.186.207.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169527>

Hi,

While using "git bisect visualize" on my PC running Ubuntu 10.10, I
came across this error:

$ git bisect visualize
eval: 1: gitk: not found
git: 'bisect' is not a git command. See 'git --help'.

Did you mean this?
	bisect
$

As this distribution don't keep "gitk" as a dependency for git,we will
have to install "gitk" as a separate package.
However, I found the error message a bit confusing. So,I have prepared
a "quick and dirty" patch to solve it.
Please let me know your comments.

Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
---
diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..fefe212 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -290,7 +290,8 @@ bisect_visualize() {
        then
                case
"${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}"
in
                '')     set git log ;;
-               set*)   set gitk ;;
+               set*)   is_gitk_present
+                       set gitk ;;
                esac
        else
                case "$1" in
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aa16b83..5e78b54 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -132,6 +132,14 @@ is_bare_repository () {
        git rev-parse --is-bare-repository
 }

+is_gitk_present () {
+       GIT_GITK=$(which gitk)
+       test -n "$GIT_GITK" || {
+               echo >&2 "Cannot find 'gitk' in the PATH"
+               exit 1
+       }
+}
+
 cd_to_toplevel () {
        cdup=$(git rev-parse --show-toplevel) &&
        cd "$cdup" || {
