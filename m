From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: git quiltimport and git apply fail importing the PREEMPT_RT patches
Date: Fri, 20 Mar 2009 20:06:17 +0100
Message-ID: <20090320190617.GA28784@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Nicholson <dbn.lists@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:07:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkk4R-0002fe-CL
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759770AbZCTTGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 15:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759451AbZCTTGY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:06:24 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36215 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758974AbZCTTGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 15:06:23 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lkk2v-0003KI-Dq; Fri, 20 Mar 2009 20:06:21 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lkk2r-0007bW-1k; Fri, 20 Mar 2009 20:06:17 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113990>

Hello,

	~/gsrc/linux-2.6$ git version
	git version 1.5.6.5

(but with newer git I get the same)

	~/gsrc/linux-2.6$ git checkout v2.6.29-rc8
	Note: moving to "v2.6.29-rc8" which isn't a local branch
	If you want to create a new branch from this checkout, you may do so
	(now or later) by using -b with the checkout command again. Example:
	  git checkout -b <new_branch_name>

	~/gsrc/linux-2.6$ wget -O - http://www.kernel.org/pub/linux/kernel/pro=
jects/rt/patch-2.6.29-rc8-rt2-broken-out.tar.bz2 | tar xjf -

	~/gsrc/linux-2.6$ git quiltimport --author=3D"do <nt@kn.ow>"
	origin.patch.bz2
	Patch is empty.  Was it split wrong?

hhmmm, quilt seems to support packed patches.

After bunzip2 origin.patch.bz2 and editing series accordingly I get:

	~/gsrc/linux-2.6$ git quiltimport --author=3D"do <nt@kn.ow>"
	origin.patch
	.dotest/patch:12188: space before tab in indent.
			.platform_data  =3D &markeins_flash_data,
	.dotest/patch:19521: trailing whitespace.
	=09
	.dotest/patch:20778: trailing whitespace.
		[PERF_COUNT_BRANCH_INSTRUCTIONS] =3D 0x230e4,	/* BR_ISSUED */=20
	.dotest/patch:21259: trailing whitespace.
		[PERF_COUNT_BRANCH_INSTRUCTIONS] =3D 0x230e4,	/* BR_ISSUED */=20
	.dotest/patch:21548: trailing whitespace.
		[PERF_COUNT_BRANCH_INSTRUCTIONS] =3D 0x410a0,	/* BR_PRED */=20
	error: cannot apply binary patch to 'Documentation/logo.gif' without f=
ull index line
	error: Documentation/logo.gif: patch does not apply

The hunk for Documentation/logo.gif looks as follows:

	diff --git a/Documentation/logo.gif b/Documentation/logo.gif
	deleted file mode 100644
	index 2eae75f..0000000
	Binary files a/Documentation/logo.gif and /dev/null differ

=46or me this looks complete enough to be applicable:

	~/gsrc/linux-2.6$ git ls-tree HEAD:Documentation | grep logo.gif
	100644 blob 2eae75fecfb965f49065c680063a40c594736ee5	logo.gif

(For these who want to look into the 2nd issue, here is an easier
reproduction recipe:

	~/gsrc/linux-2.6$ git apply --index -C1 - << EOF
	> diff --git a/Documentation/logo.gif b/Documentation/logo.gif
	> deleted file mode 100644
	> index 2eae75f..0000000
	> Binary files a/Documentation/logo.gif and /dev/null differ
	> EOF
	error: cannot apply binary patch to 'Documentation/logo.gif' without f=
ull index line
	error: Documentation/logo.gif: patch does not apply

)

=46or the first issue I have a patch that I'll send as a reply to this
mail.  Luckily this works around the second problem, too :-)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
