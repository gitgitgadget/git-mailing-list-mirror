From: Johannes Sixt <j6t@kdbg.org>
Subject: Problem completing remotes when .git/remotes exits
Date: Wed, 19 Sep 2012 21:55:28 +0200
Message-ID: <505A2330.9040800@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQN9-0008G1-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2ISTzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:55:36 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:46976 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751287Ab2ISTzc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:55:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2C8FF2C4004
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 21:55:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 52EFC19F3FB
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 21:55:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205987>

I have an empty .git/remotes directory. Trying to complete the name of
a remote always reports an error:

git@master:1023> git fetch <TAB>ls: invalid option -- ' '
Try `ls --help' for more information.

I have these:

	alias ls='ls $LS_OPTIONS'
and
	LS_OPTIONS='-N --color=tty -T 0'

I instrumented __git_remotes with set -x, which shows:

git@master:1006> git fetch <TAB>+++ __gitdir
+++ '[' -z '' ']'
+++ '[' -n '' ']'
+++ '[' -n '' ']'
+++ '[' -d .git ']'
+++ echo .git
++ local i 'IFS=
' d=.git
++ test -d .git/remotes
++ ls '-N --color=tty -T 0' -1 .git/remotes
ls: invalid option -- ' '
Try `ls --help' for more information.
...

Notice that the expansion of $LS_OPTIONS is not split at the blanks,
obviously, because $IFS does not contain a blank at that moment.

The patch below helps, but it looks like a work-around rather than a
solution. Ideas?

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..824f5b6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -369,8 +369,9 @@ __git_refs_remotes ()
 
 __git_remotes ()
 {
-	local i IFS=$'\n' d="$(__gitdir)"
+	local i d="$(__gitdir)"
 	test -d "$d/remotes" && ls -1 "$d/remotes"
+	local IFS=$'\n'
 	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
 		i="${i#remote.}"
 		echo "${i/.url*/}"
