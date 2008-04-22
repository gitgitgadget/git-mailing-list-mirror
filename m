From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: showing conflicting merges
Date: Tue, 22 Apr 2008 11:12:33 +0200
Message-ID: <20080422091233.GA12091@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:13:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoEZS-0006wc-2n
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbYDVJNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 05:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755469AbYDVJND
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:13:03 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:42113 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755366AbYDVJNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:13:00 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-5.tower-29.messagelabs.com!1208855565!9892893!2
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.14]
Received: (qmail 28208 invoked from network); 22 Apr 2008 09:12:59 -0000
Received: from mail.mx2.digi.com (HELO mcl-sms-ns2.DIGI.COM) (66.77.174.14)
  by server-5.tower-29.messagelabs.com with RC4-SHA encrypted SMTP; 22 Apr 2008 09:12:59 -0000
Received: from mcl-sms-exch01.digi.com (10.5.8.50) by mail.mx2.digi.com
 (172.16.1.14) with Microsoft SMTP Server (TLS) id 8.1.263.0; Tue, 22 Apr 2008
 04:11:50 -0500
Received: from mtk-sms-mail01.digi.com (10.10.8.120) by
 mcl-sms-exch01.digi.com (10.5.8.50) with Microsoft SMTP Server id 8.1.263.0;
 Tue, 22 Apr 2008 04:12:44 -0500
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by
 mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 22 Apr
 2008 04:12:35 -0500
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 22 Apr 2008 11:12:33 +0200
Received: by zentaur.digi.com (Postfix, from userid 1080)	id 767302AB07; Tue,
 22 Apr 2008 11:12:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 22 Apr 2008 09:12:33.0808 (UTC) FILETIME=[FFF06100:01C8A458]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15864.006
X-TM-AS-Result: No--17.413000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80086>

Hello,

There is a thread on the linux-arm-kernel ML that discusses handling of
merge conflicts with git.[1]

I played around a bit with that and wondered about a few things:

	ukleinek@zentaur:~/gsrc/linux-2.6$ git checkout -b test adf6d34e460387=
ee3e8f1e1875d
	Switched to a new branch "test"

	ukleinek@zentaur:~/gsrc/linux-2.6$ git merge v2.6.25
	Auto-merged MAINTAINERS
	CONFLICT (delete/modify): drivers/leds/leds-tosa.c deleted in HEAD and=
 modified in v2.6.25. Version v2.6.25 of drivers/leds/leds-tosa.c left =
in tree.
	Auto-merged drivers/serial/imx.c
	Automatic merge failed; fix conflicts and then commit the result.

Now "git diff --merge" shows:

	diff --cc drivers/leds/leds-tosa.c
	index 7ebecc4,0000000..9e0a188
	...

Shouldn't that better be reversed, i.e. 9e0a188..7ebecc4,0000000?

The resolution was to delete drivers/leds/leds-tosa.c:

	ukleinek@zentaur:~/gsrc/linux-2.6$ git rm drivers/leds/leds-tosa.c
	rm 'drivers/leds/leds-tosa.c'
	rm 'drivers/leds/leds-tosa.c'

	ukleinek@zentaur:~/gsrc/linux-2.6$ git commit
	Created commit 99a64ab: Merge commit 'v2.6.25' into test

Now "git show" doesn't show the conflict resolution as it does for othe=
r
conflicting merges.
Adding -p and/or --cc didn't help either.  Looking at the source I thin=
k
the problem is that diff_tree_combined only shows diffs for paths that
are touched by every parent.  I'm not sure how I want to have the diff
shown, but showing nothing seems wrong.  Ideas?

Another thing is that rerere don't record my resolution.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/40654/focus=3D=
40656

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
