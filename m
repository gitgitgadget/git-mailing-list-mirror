From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Windows: Always normalize paths to Windows-style
Date: Mon, 28 Apr 2014 16:29:31 +0200
Organization: <)><
Message-ID: <20140428142931.GA12056@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz> <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WemZ1-0005zr-F0
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbaD1O3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:29:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55153 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375AbaD1O3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:29:34 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 75F931C00AF;
	Mon, 28 Apr 2014 16:29:33 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3SETX7m012094;
	Mon, 28 Apr 2014 16:29:33 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3SETVik012093;
	Mon, 28 Apr 2014 16:29:31 +0200
Content-Disposition: inline
In-Reply-To: <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247343>

From: Heiko Voigt <hvoigt@hvoigt.net>
Date: Thu, 22 Mar 2012 19:17:03 +0100

It appears that `pwd` returns the POSIX-style or the DOS-style path
depending which style the previous `cd` used. To normalize, enforce `pwd
-W` in scripts.

>From the original e-mail exchange:

On Thu, Mar 22, 2012 at 11:13:37AM +0100, Sebastian Schuberth wrote:
> On Wed, Mar 21, 2012 at 22:21, Johannes Sixt <j6t@kdbg.org> wrote:
>
> > I build git and run its tests outside the msysgit environment. Does that
> > explain the difference? (And I use CMD.)
>
> It does not make a difference for me. I started cmd.exe at
> c:\msysgit\git\t, added c:\msysgit\bin temporarily to PATH, and ran
> "sh t5526-fetch-submodules.sh -i -v", and the test still fails.

Yes it probably does. Johannes said that he runs the tests outside of
the msysgit folder. That way there is only one path the submodule script
gets reported and not two like '/c/msysgit/git' and '/git'.

That would explain to me why it is passing.

I am afraid that the only solution is to patch msys itself to report the
long absolute path when passing window style paths to cd. Currently when
I do

	cd c:/msysgit/git

I will end up in '/git' instead of the long path.

I found that there is a -W option to pwd in msys bash which makes it
always return the real windows path. A normalization in that direction
is unique and thus might be more robust. Have a look at the attached
patch. With this at least t5526 passes. I was not able to run the whole
testsuite properly at the moment. I can have a look at that tomorrow.

What do you think?

Cheers Heiko

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Hello,
this is another patch that lives in msysGit for a long time.
Originally, it had two parts:
(Cf https://github.com/msysgit/git/commit/64a8a03 )

1) adding alias pwd='pwd -W' to git-sh-setup.sh
   This one went upstream, though as a shell function.

2) revert of commit 4dce7d9b by Johannes Sixt <j6t@kdbg.org>
This mingw-specific commit was created less than 3 weeks before
it was reverted.  And it stayed reverted for two years.

Could you please either accept this patch, or revert 4dce7d9b ?
(Both alternatives are exactly the same.)

Have a nice day,
	Stepan Kasal

 git-submodule.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4a30087..247273e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -285,9 +285,6 @@ module_clone()
 	# resolve any symlinks that might be present in $PWD
 	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
 	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
-	# normalize Windows-style absolute paths to POSIX-style absolute paths
-	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
-	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
 	# Remove all common leading directories after a sanity check
 	if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
 		die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
-- 
1.9.2.msysgit.0.158.g6070cee
