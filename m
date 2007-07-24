From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 02:23:53 +0200
Message-ID: <200707240223.54228.robin.rosenberg.lists@dewire.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <7vd4yjoi2w.fsf@assigned-by-dhcp.cox.net> <46A45EF4.9090305@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 02:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID8Ay-000611-5F
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 02:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbXGXAWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Jul 2007 20:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbXGXAWq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 20:22:46 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4034 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752893AbXGXAWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 20:22:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0A9AD802669;
	Tue, 24 Jul 2007 02:15:27 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20924-01; Tue, 24 Jul 2007 02:15:26 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6798D80264F;
	Tue, 24 Jul 2007 02:15:26 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46A45EF4.9090305@fs.ei.tum.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53514>

m=C3=A5ndag 23 juli 2007 skrev Simon 'corecode' Schubert:
> Junio C Hamano wrote:
> > It may be that we may want to fix this inside cvsexportcommit
> > itself, instead of working it around in the tests.  If somebody
> > tries to push more than one commit from git using two
> > cvsexportcommit in a row, he would need to make sure that the
> > second run happens one or more seconds after the first run,
> > otherwise he will see the exact corruption in real life.
>=20
> Ah, now I see the problem.  The timestamp in the CVS/Entries is the s=
ame (because it only has second granularity),=20
> so cvs commit won't consider it as changed.=20
>=20
> That's the reason why CVS usually waits until the second turns after =
a "update" (obviously not after a "commit").=20
> So we could either turn back the timestamp in the Entries file (ugly)=
 or simply wait until the second turns.  Given=20
> the overall cvs performance, this won't be a big issue, I guess.=20
>=20
> cheers
>   simon
>=20

CVS sleeps after commit here. Can we bisect it? I have 1.12.3 (mandriva=
). The patch below I think
would work around the problem, rather than trying to fix the test. but =
I'd like to have the last CVS=20
revision where it does not work for the patch comment=20

Since the sleep is per invocation of cvsexportcommit it won't hurt too =
much since it is rarely invoked
on a huge number of git commits.

-- robin

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d6ae99b..6377408 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -277,6 +277,10 @@ if ($opt_c) {
 # clean up
 unlink(".cvsexportcommit.diff");

+# timestamp problems. Invoking this command on a machine that is too f=
ast may result in
+# CVS not recognizing changed because the timestamp is unchanged
+sleep(1);
+
 sub usage {
        print STDERR <<END;
 Usage: GIT_DIR=3D/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [-f=
] [-m msgprefix] [ parent ] commit
