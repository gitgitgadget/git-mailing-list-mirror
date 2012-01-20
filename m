From: Brian Foster <brian.foster@maxim-ic.com>
Subject: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 14:33:29 +0100
Message-ID: <201201201433.30267.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 14:45:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoElw-0003t6-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 14:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab2ATNop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 08:44:45 -0500
Received: from antispam02.maxim-ic.com ([205.153.101.183]:36365 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab2ATNoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 08:44:44 -0500
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jan 2012 08:44:44 EST
X-ASG-Debug-ID: 1327066429-02256b3e053e76c0001-QuoKaX
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal [10.16.15.104]) by antispam02.maxim-ic.com with ESMTP id 60RejBZyNHjNvUxf for <git@vger.kernel.org>; Fri, 20 Jan 2012 07:33:49 -0600 (CST)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex02.maxim-ic.internal (10.16.15.104) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Fri, 20 Jan 2012 07:33:48 -0600
Received: from bfoster-57.localnet (10.201.0.19) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Fri, 20 Jan 2012 05:33:47 -0800
X-ASG-Orig-Subj: [Q] Determing if a commit is reachable from the HEAD ?
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
X-Barracuda-Connect: maxdalex02.maxim-ic.internal[10.16.15.104]
X-Barracuda-Start-Time: 1327066429
X-Barracuda-URL: http://192.168.10.183:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.86379
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188877>


Hello,

 Whilst I have found answers to my question on the Web,
 only one seems to do exactly what I want ....

                         x---Y---y---y---y  HEAD
                        /
  ...--o---o---C---o---S
                        \
                         n---n---N---*---*  other

 In a script, how can I determine commit Y is reachable
 from the current HEAD ?   And, much more importantly
 for my purposes, that commit N is _not_-reachable from
 the current HEAD ?  "A is reachable from B" meaning B
 is an ancestor of A (B could possibly part of a merge
 (not shown in the above diagram)):

  =E2=9C=93 Commits o(all), C, S, x, y(all), and Y: YES  (reachable).
  =E2=9C=97 Commits n(all), N, and *(all): NO  (not-reachable).

 The only readily script-able answer I've found is to use
 `git branch --contains=3DY' and check to see if the current
 branch (conveniently marked `*') is/isn't included in the
 output.  That is probably Ok, but I'm wondering if there
 is some "better" method (with the IMPORTANT caveat it must
 work with GIT 1.5.x or later  ;-\ ).

 git-rev-list(1) may be a answer (see script below), but ....
 `git rev-list ^Y HEAD' lists all the y commits, which is Ok
 (correct for my purposes).  However, `git rev-list ^N HEAD'
 lists commits x, Y, and y(all) on branch "other", which is
 not-Ok:  As per above, the answer I want is "NO".

 Apologies if I've overlooked something totally obvious !

cheers,
	-blf-

=3D=3D=3D=3D=3D(cut here and below)=3D=3D=3D=3D=3Dreach02.sh=3D=3D=3D=3D=
=3D
#!/bin/bash
#
#                         x---Y---y---y---y  HEAD
#                        /
#  ...--o---o---C---o---S
#                        \
#                         n---n---N---*---*  other
#

: ${GIT:=3Dgit}	# Allow use of different installed GIT versions.

update_file() {
	date +"%c: $*" >>file
	$GIT add file  &&  $GIT commit -m "$*" file
}

set -e		# Terminate if problem creating diagrammed situation.

rm -rf -- reachable
mkdir  -- reachable
cd reachable

$GIT version
$GIT init

update_file     o1
update_file     o2
update_file "C (o3)";	$GIT tag C
update_file     o4
update_file "S (o5)";	$GIT tag S

$GIT checkout -b other
update_file     n1
update_file     n2
update_file "N (n3)";	$GIT tag N
update_file    "*1"
update_file    "*2"

$GIT checkout master
update_file     x
update_file "Y (y1)";	$GIT tag Y
update_file     y2
update_file     y3
update_file     y4

declare -i wrong=3D0

echo "Is Y reachable from HEAD?  Wanted answer: Yes."
$GIT log --oneline ^Y HEAD
if $GIT rev-list --quiet ^Y HEAD; then
	echo "rev-list: YES (wanted answer)!"
else
	echo "rev-list: No! *** not-wanted, oops... ***"
	wrong=3D$(( wrong + 1 ))
fi
if $GIT branch --contains=3DY | grep -q -e '^\*'; then
	echo "contains: YES (wanted answer)!"
else
	echo "contains: No! *** not-wanted, oops... ***"
	wrong=3D$(( wrong + 1 ))
fi

echo "Is N reachable from HEAD?  Wanted answer: No."
$GIT log --oneline ^N HEAD
if $GIT rev-list --quiet ^N HEAD; then
	echo "rev-list: YES? *** not-wanted, oops... ***"
	wrong=3D$(( wrong + 1 ))
else
	echo "rev-list: No (wanted answer)!"
fi
if $GIT branch --contains=3DN | grep -q -e '^\*'; then
	echo "contains: YES? *** not-wanted, oops... ***"
	wrong=3D$(( wrong + 1 ))
else
	echo "contains: No (wanted answer)!"
fi

exit $wrong
=3D=3D=3D=3D=3D(cut here and above)=3D=3D=3D=3D=3Dreach02.sh=3D=3D=3D=3D=
=3D

--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
