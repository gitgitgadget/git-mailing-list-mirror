From: Bastien Traverse <bastien@traverse.email>
Subject: [Question] Is it normal for accented characters to be shown as
 decomposed Unicode on GNU/Linux?
Date: Mon, 22 Jun 2015 15:17:40 +0200
Message-ID: <55880AF4.4000206@traverse.email>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z71bg-0000dH-8k
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 15:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbbFVNRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 09:17:44 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43327 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbbFVNRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 09:17:42 -0400
Received: from [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666] (unknown [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666])
	(Authenticated sender: bastien@traverse.email)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3F2171720AC
	for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:17:41 +0200 (CEST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272338>

Hi everybody,

I have a repository where some files and folders contain accented
characters due to being in French. Such names include "r=C3=AAve" (drea=
m),
"r=C3=A9union" (meeting) etc.

Whether already in version control or not, git tools only show their
*decomposed* representation (I use a UTF-8 locale, see below), but don'=
t
accept those representations as input (and auto-completion is broken fo=
r
those), which is a bit misleading (test case follows).

I've seen the threads about accented characters on OSX and the use of
'core.precomposeunicode', but as I'm running on GNU/Linux I thought thi=
s
shouldn't apply.

Since I've already had a problem in git with a weirdly encoded characte=
r
(see http://thread.gmane.org/gmane.comp.version-control.git/269710), I
wanted to get some feedback to determine whether my setup was the cause
of it or if it was normal to see decomposed file names in git. I found
in man git-status:

> If a filename contains whitespace or other nonprintable
> characters, that field will be quoted in the manner of a C string
> literal: surrounded by ASCII double quote (34) characters, and with
> interior special characters backslash-escaped.

So do everybody using accented characters see those in decomposed form
in git? And if so why some softwares built on top of it (like gitit [1]=
)
don't inherit those decomposed representations?

[1] http://gitit.net/

Thanks!

---
test case:
$ mkdir accent-test && cd !$
$ git init
$ touch r=C3=AAve r=C3=A9union
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	"r\303\251union"
	"r\303\252ve"
$ git add .
$ git commit -m "accent test"
[master (root commit) 0d776b7] accent test
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 "r\303\251union"
 create mode 100644 "r\303\252ve"
$ git log --summary
commit 0d776b7a09d5384a76066999431507018e292efe
Author: Bastien Traverse <bastien@traverse.email>
Date:   2015-06-22 14:13:46 +0200

    accent test

 create mode 100644 "r\303\251union"
 create mode 100644 "r\303\252ve"
$ mv r=C3=AAve reve
$ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working direct=
ory)

	deleted:    "r\303\252ve"

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	reve

no changes added to commit (use "git add" and/or "git commit -a")
$ git add [[TAB-TAB]]
"r\303\252ve"  reve
$ git add "[[TAB]] --> git add "\"r\\303\\252ve\""
fatal: pathspec '"r\303\252ve"' did not match any files
$ git add "r\303\252ve"
fatal: pathspec 'r\303\252ve' did not match any files
$ git add r=C3=AAve reve OR git add .
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	renamed:    "r\303\252ve" -> reve

I'm running an up-to-date Arch linux with following software versions
and locale config:

$ uname -a
Linux xxx 4.0.5-1-ARCH #1 SMP PREEMPT Sat Jun 6 18:37:49 CEST 2015
x86_64 GNU/Linux
$ bash --version
GNU bash, version 4.3.39(1)-release (x86_64-unknown-linux-gnu)
$ git --version
git version 2.4.3
$ locale
LANG=3Dfr_FR.utf8
LC_CTYPE=3D"fr_FR.utf8"
LC_NUMERIC=3Dfr_FR.utf8
LC_TIME=3Dfr_FR.utf8
LC_COLLATE=3D"fr_FR.utf8"
LC_MONETARY=3Dfr_FR.utf8
LC_MESSAGES=3D"fr_FR.utf8"
LC_PAPER=3Dfr_FR.utf8
LC_NAME=3D"fr_FR.utf8"
LC_ADDRESS=3D"fr_FR.utf8"
LC_TELEPHONE=3D"fr_FR.utf8"
LC_MEASUREMENT=3Dfr_FR.utf8
LC_IDENTIFICATION=3D"fr_FR.utf8"
LC_ALL=3D
$ localectl
   System Locale: LANG=3Dfr_FR.UTF8
       VC Keymap: fr
      X11 Layout: fr
     X11 Variant: oss

Cheers
