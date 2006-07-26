From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 11:23:59 -0700
Message-ID: <7virlkrzr4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 20:24:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5o3D-0005hQ-CX
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWGZSYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWGZSYD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:24:03 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42955 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751748AbWGZSYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 14:24:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726182400.QULW27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 14:24:00 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
	(Jon Smirl's message of "Wed, 26 Jul 2006 13:50:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24231>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> An exact test case:
>
> git clone git foo
> git clone git foo1
> cd foo
> mkdir zzz
> git mv gitweb zzz
> cg diff >patch
> cd ../foo1
> cg patch <../foo/patch
>
> This patch won't apply because zzz does not exist in foo1

A short and sweet reproduction recipe is essential for a problem
report like this, and I appreciate it very much.  "git mv" in
"master" should do the right thing and I see Johannes fixing (or
fixed) the problem of "git mv" failing in his version.

We should correctly handle cases that fit your general
description (the test t/t4112-apply-renames.sh has a file in
"klibc/arch/x86_64" which is renamed and copied to two different
locations under "include/arch").  The above does not reproduce
for me if I used "git diff HEAD >patch" in place of "cg diff" (I
cannot make cg behave on my machine).

$ mkdir zzz
$ ~/git-master/bin/git-mv gitweb zzz/
$ LANG=C LC_ALL=C find gitweb zzz -type f -print
find: gitweb: No such file or directory
zzz/gitweb/README
zzz/gitweb/gitweb.cgi
zzz/gitweb/gitweb.css
zzz/gitweb/test/M??rchen
zzz/gitweb/test/file with spaces
zzz/gitweb/test/file+plus+sign
$ git diff HEAD >patch
$ git checkout -f HEAD
$ LANG=C LC_ALL=C find gitweb zzz -type f -print
gitweb/README
gitweb/gitweb.cgi
gitweb/gitweb.css
gitweb/test/M??rchen
gitweb/test/file with spaces
gitweb/test/file+plus+sign
find: zzz: No such file or directory
$ git apply --index <patch
$ LANG=C LC_ALL=C find gitweb zzz -type f -print
zzz/gitweb/README
zzz/gitweb/gitweb.cgi
zzz/gitweb/gitweb.css
zzz/gitweb/test/M??rchen
zzz/gitweb/test/file with spaces
zzz/gitweb/test/file+plus+sign

A couple of weeks ago test t/t4114-apply-typechange.sh was added
by Eric Wong, and it caught cases where git-apply was assuming
that leading directories of a new file already exists or was
complaining when you create file "foo" and remove a file
"foo/bar" (that is, you used to have directory at "foo").  The
problems that test found were all fixed as far as I recall.
