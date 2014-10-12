From: "Crabtree, Andrew" <andrew.crabtree@hp.com>
Subject: Performance Issues with Git Rebase
Date: Sun, 12 Oct 2014 01:29:32 +0000
Message-ID: <B82B660D4887C042850326C2BC65FE035D56CA14@G4W3227.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 03:32:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd81O-0007Kf-Ey
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 03:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbaJLBcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Oct 2014 21:32:16 -0400
Received: from g4t3425.houston.hp.com ([15.201.208.53]:40995 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaJLBcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 21:32:16 -0400
Received: from G9W0364.americas.hpqcorp.net (g9w0364.houston.hp.com [16.216.193.45])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3425.houston.hp.com (Postfix) with ESMTPS id 9BCCBD7
	for <git@vger.kernel.org>; Sun, 12 Oct 2014 01:32:15 +0000 (UTC)
Received: from G4W6301.americas.hpqcorp.net (16.210.26.226) by
 G9W0364.americas.hpqcorp.net (16.216.193.45) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Sun, 12 Oct 2014 01:29:33 +0000
Received: from G4W3227.americas.hpqcorp.net ([169.254.8.47]) by
 G4W6301.americas.hpqcorp.net ([16.210.26.226]) with mapi id 14.03.0169.001;
 Sun, 12 Oct 2014 01:29:33 +0000
Thread-Topic: Performance Issues with Git Rebase
Thread-Index: Ac/luPkE0ej5ZSZWTB2ZiCVGSSGHAA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.210.48.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have what appears to be a fairly straightforward rebase operation and=
 I can't figure out why it seems to effectively hang 'git rebase'.

I have a handful of commits that I made last summer and haven't touched=
 since.  I'm trying to rebase them against latest on upstream.

git status
On branch git_enhancements
Your branch and 'origin/smb' have diverged,
and have 4 and 4665 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

If at this moment I type "git rebase" it will print out=20

=46irst, rewinding head to replay your work on top of it...

And then nothing will happen for approximately 30 minutes, and then it =
will complete.
 =20
If I instead type "git rebase --onto @{u} HEAD~4" it completes immediat=
ely.

I've narrowed it down to this line in git-rebase--am (approx. line 65)

	git format-patch -k --stdout --full-index --cherry-pick --right-only \
		--src-prefix=3Da/ --dst-prefix=3Db/ --no-renames --no-cover-letter \
		"$revisions" ${restrict_revision+^$restrict_revision} \
		>"$GIT_DIR/rebased-patches"

Which is turned into this in my particular case

git format-patch -k --stdout --full-index --cherry-pick --right-only --=
src-prefix=3Da/ --dst-prefix=3Db/ --no-renames --no-cover-letter 451da4=
975b25797fe54cd11e4796bbd3ee0911ce...ea3cf673d0e76504738bf130d48148d5b9=
6cc406

If I time just that command I get=20

real=A0=A0=A0=A0=A0=A0=A0 32m10.324s
user=A0=A0=A0=A0=A0=A0 26m21.296s
sys=A0=A0=A0=A0=A0=A0=A0=A0=A0 0m28.994s


If I change the triple do to a double dot I get=20

real=A0=A0=A0=A0=A0=A0=A0 0m4.276s
user=A0=A0=A0=A0=A0=A0 0m0.096s
sys=A0=A0=A0=A0=A0=A0=A0=A0=A0 0m0.022s

Which is much more in line with how long I think the command should tak=
e.

The triple dot is coming from just earlier in the file here=20

if test -z "$rebase_root"
	# this is now equivalent to ! -z "$upstream"
then
	revisions=3D$upstream...$orig_head
else
	revisions=3D$onto...$orig_head
fi

which seems to have been in place for 2+ years. =20

I'm getting the same output with both the triple and double dot for my =
specific case, but I have no idea if that change makes sense for all ca=
ses or not.  Any guidance?=20

Thanks much,
-Andrew
