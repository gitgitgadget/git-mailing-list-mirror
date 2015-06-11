From: Bernd Naumann <bernd@kr217.de>
Subject: Looking for feedback and help with a git-mirror for local usage
Date: Thu, 11 Jun 2015 22:44:08 +0200
Message-ID: <5579F318.7050503@kr217.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 22:51:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z39S6-0004MF-2N
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbbFKUvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 16:51:49 -0400
Received: from zero.kr217.de ([88.198.92.197]:42883 "EHLO zero.kr217.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbbFKUvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 16:51:48 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jun 2015 16:51:48 EDT
Received: from localhost (localhost [127.0.0.1])
	by zero.kr217.de (Postfix) with ESMTP id 6EB2C294111
	for <git@vger.kernel.org>; Thu, 11 Jun 2015 22:44:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at zero.kr217.de
Received: from zero.kr217.de ([127.0.0.1])
	by localhost (zero.kr217.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rxKrXWPEfRt for <git@vger.kernel.org>;
	Thu, 11 Jun 2015 22:44:08 +0200 (CEST)
Received: from [192.168.255.236] (ping01.stura.uni-weimar.de [141.54.160.24])
	(Authenticated sender: bernd@kr217.de)
	by zero.kr217.de (Postfix) with ESMTPSA id BF4D92940E7
	for <git@vger.kernel.org>; Thu, 11 Jun 2015 22:44:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271463>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have came up with an idea
# Yep I know, exactly that kind of e-mail everyone wants to read ;)
and I'm working currently on a shell-prototype to face the following
situation and problem and need some feedback/advise:


I often build in example 'openwrt' with various build-scripts which
depends heavily on a fresh or clean environment and they omit many
sources via `git clone`, which results sometimes in over 100 MB of
traffic just for one build. /* Later needed .tar.gz source archives
are stored in a symlinked download directory which is supported by
'openwrt/.config' since a few months... to reduce network traffic. */

My connection to the internet is not the fastest in world and
sometimes unstable, so I wanted to have some kind of local bare
repository mirror, which is possible with `git clone --mirror`.

- From these repositories I can later clone from, by calling `git clone
- --reference /path/to.git <url>`, but I do not wish to edit all the
build-scripts and Makefiles.


So I wrote a git wrapper script (`$HOME/bin/git`), which checks if
`git` was called with 'clone', and if so, then it will first clones
the repository as a mirror and then clones from that local mirror. If
the mirror already exists, then it will only be updated (`git remote
update`). This works for now.

/*
  To be able to have multiple identical named repositories,
  the script builds paths like:

  ~/var/cache/gitmirror $ find . -name "*.git"

  ./github.com/openwrt-management/packages.git
  ./github.com/openwrt/packages.git
  ./github.com/openwrt-routing/packages.git
  ./nbd.name/packages.git
  ./git.openwrt.org/packages.git
  ./git.openwrt.org/openwrt.git

It strips the schema from the url and replaces ":" with "/" in case a
port is specified or a svn link is provided. The remaining should be a
valid linux file and directory structure, if I guess correctly!?
*/

Ok, so far, so good, but the implementation of the current
shell-prototype looks way too hacky [0] and I have found some edge
cases on which my script will fail:
  The script depends on the fact that the last, or at least the second
last argument is a valid git-url, but the following is a valid call, too
:

  `git --no-pager \
   clone git@github.com:openwrt/packages.git openwrt-packages --depth 1`

But this is not valid:

`git clone https://github.com/openwrt/packages.git --reference
packages.git packages-2`
or
`git clone --verbose https://github.com/openwrt/packages.git
packages-2 --reference packages.git`


I found out that git-clone actually also can only make a guess what is
the url and what not.



However, now I'm looking for a way to write something like a submodul
for git which will check for a *new* git-config value like
"user.mirror" (or something...) which points to a directory, and will
be used to clone from, and in case of 'fetch', 'pull' or 'remote
update' update the mirror first, and then the update of the current
working directory is gotten from that mirror. (And in case of 'push'
the mirror would be updated from the working dir, of course.)


I would like to hear some toughs on that, and how I could start to
build this submodul, or if someone more talented, then I am, is willed
to spent some time on that. If requested/wished I could send a link to
the shell-prototype.


[0] For a reason I have to do ugly things like
`$( eval exec /usr/bin/git clone --mirror $REPO_URL ) 2>&1 >/dev/null`
cause otherwise in case of just `eval exec` the script stops after
execution, and without `eval exec` arguments with spaces will
interpreted as seperated arguments, which is no good, because of failing
.


Thanks for your time!
Yours faithfully, Bernd
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJVefMYAAoJEEYW3OihUKBPJkAP/iiFBoHnJXloX0SRQHjEUBDf
C5PQ/42IZTB5ghM959IBA0QZ4p4BEFcwu8q7xKKE2FtiUzAAb1hRiXZOV7S7DZ1s
iPDCOk8hTp9eqSLgfDL6WX7ztGByFoT9GodwpTFBLU31RvooWO1BYc/jrd3lMA4k
4lk+8SM1dOffJm0g+A4YCsE59P7Rn/t0iJYepaN7cXVMdgKvuZ0iVi9CvHAipPUG
xuCwNYCM6tcOvnjZH/Nqa57+l5LfQ7qIA6YBlG77wOwDHgX+GPkYAqq+xOq28aP0
+W7duf32SgkQBwSTnfntYd4G+QZqIktP30Ik0e8hCcU37ECcEP2s28CebY2825/n
FaZEutK3sE+lk47j89ndvPdtpHybchUi/0zNftPY0ngU6Yc/0YMMq9KeYM6kt6+s
8coSvt5AQLhgR+NMQhXF4nKtfcvt9B+xZtag6Re/zA8AwIrBFFvu7dGkvG9aydDe
Zwvt4/ddYxEouEPhwr4+KmmM2ll8tHoBcJJYr+xoqQlE/nSPfF/gvsQVqciijp4b
afyStwFYGHPo68pMvEZx+xXYaAhkKSAvaN5vupy1e5765E0F5DWOV5P026L45D7V
yKFVa/eYZc/iJjQcjzpch9mq/Jiblht6XXR1YDlHg5PoKE3Chs8EjYp0wyPWqGS0
lrCPzhwrMLVmmksF0wcN
=P4eQ
-----END PGP SIGNATURE-----
