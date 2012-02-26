From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/2] submodules: Use relative paths to gitdir and work
 tree
Date: Sun, 26 Feb 2012 18:38:02 +0100
Message-ID: <4F4A6DFA.5080709@kdbg.org>
References: <4F32F252.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 26 18:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1i34-0006U7-M0
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 18:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2BZRiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 12:38:08 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:6876 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751838Ab2BZRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 12:38:07 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 373BA13004E;
	Sun, 26 Feb 2012 18:35:21 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 006A619F604;
	Sun, 26 Feb 2012 18:38:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <4F32F252.7050105@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191568>

Am 08.02.2012 23:08, schrieb Jens Lehmann:
> This patch series replaces all absolute paths pointing from submodule work
> trees to its gitdir and back with relative paths as discussed in $gmane/187785.
> 
> The motivation is to make superprojects movable again. They lost this ability
> with the move of the git directory of submodules into the .git/modules directory
> of the superproject. While fixing that a bug which would hit when moving the
> submodule inside the superproject was also fixed.
> 
> Jens Lehmann (2):
>   submodules: always use a relative path to gitdir
>   submodules: always use a relative path from gitdir to work tree

This series, with the tip at e3307adaba in Junio's repo causes major
headaches on Windows.

First, a check for an absolute path must be extended to take
Windows-style paths into account.

Second, the a's and b's are filled with different forms of absolute
paths (/c/there vs. c:/there), and as a consequence the subsequent loops
do not find a suitable relative path.

The below is a minimal hack that passes all t/*submod* tests, but it
works only on Windows, where the pwd utility has an option -W that
prints a Windows style absolute path.

How would you have this solved? One option would be to introduce a function

  pwd() { builtin pwd -W "$@"; }

in git-sh-setup conditionally on Windows (but that would affect other
shell scripts, too).

Any other ideas?

diff --git a/git-submodule.sh b/git-submodule.sh
index 3463d6d..f37745e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -139,8 +139,8 @@ module_clone()
 	gitdir="$gitdir/modules/$path"

 	case $gitdir in
-	/*)
-		a="$(cd_to_toplevel && pwd)/"
+	/* | [a-z]:/*)
+		a="$(cd_to_toplevel && pwd -W)/"
 		b=$gitdir
 		while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
 		do
@@ -170,8 +170,8 @@ module_clone()

 	echo "gitdir: $rel_gitdir" >"$path/.git"

-	a=$(cd "$gitdir" && pwd)
-	b=$(cd "$path" && pwd)
+	a=$(cd "$gitdir" && pwd -W)
+	b=$(cd "$path" && pwd -W)
 	while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
 	do
 		a=${a#*/} b=${b#*/};
-- 
1.7.8.216.g2e426
