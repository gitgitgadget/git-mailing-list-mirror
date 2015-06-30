From: Thomas Vieten <tvie@ivision.de>
Subject: end-of-line diff checkout direction dependence problem
Date: Tue, 30 Jun 2015 16:12:41 +0200
Message-ID: <5592A3D9.3080706@ivision.de>
Reply-To: tvie@ivision.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 16:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9wNE-0002sC-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 16:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbbF3OSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 10:18:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:64686 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbbF3OSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 10:18:50 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2015 10:18:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1435673928; l=2299;
	s=domk; d=ivision.de;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:
	Reply-To:From:Date;
	bh=86mHq3f/kfnI8PZpAzX1uc4dwZoLmhzBSvgTMFMmJV0=;
	b=AkTgHkd6QSmpg4yNBxxKUaQ/3qBUbTeu5LHgtvrAHSh96UjoSTTmcuQKlDDrn51K7Ws
	TRoMvEgbLCY3cJMrlHs0EuaaA5HBiFynC0k1h8tTWh3Xcs7XUnGvcczFJz6xwhZwTqkFK
	WG8pbU0LkI/KL0oD9RLt8udR1MwR9em6WCs=
X-RZG-AUTH: :OHoNcGChbfbkF0MiFdPmE/cAQnRWOxNPsUpfO0vBMLQStzWaZbQFXDrmmA7YKok=
X-RZG-CLASS-ID: mo00
Received: from firewall.ivision.de (pd95bcd7c.dip0.t-ipconnect.de [217.91.205.124])
	by smtp.strato.de (RZmta 37.8 AUTH)
	with ESMTPA id 6057c7r5UECgHB7
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2015 16:12:42 +0200 (CEST)
Received: from ivision.de (unknown [192.168.0.1])
	by firewall.ivision.de (Postfix) with ESMTP id 15C7632648
	for <git@vger.kernel.org>; Tue, 30 Jun 2015 16:12:42 +0200 (CEST)
Received: from [127.0.0.1] (192.168.0.122:37788)
	by ivision.de with [XMail 1.20 ESMTP Server]
	id <S2E584> for <git@vger.kernel.org> from <tvie@ivision.de>;
	Tue, 30 Jun 2015 16:12:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273064>

We face a very inconvenient problem with end-of-line diffs which are no=
t=20
"real".
We know the end-of-line problem very well as we thought.
But now we found a new phenomenon and nobody mentioning it.

Consider the following repository structure:

           -----------|----|------------->branch1
         /
master
         \
----------|-------|---------|--------------->branch2

The branches are based on master/head.
We just consider one branch here, e.g. branch1 .

Working with the head of branch1 gives no problems. No end-of-line diff=
s.
Also going back in the direction of master - no problems.
Only in the case if we do a checkout from branch1 to master, then
all of a sudden end-of-line diffs appear.
The files might be changed, but the end-of-line attributes in=20
gitattributes are not changed in the branch.

It seems to be the case that since the last change to the files which=20
pop up with eol differences, gittattributes where changed and touch=20
their extensions.

With the operation

git ls-files -z | xargs -0 rm -f  # delete all the files of this versio=
n=20
- here master/head
git reset --hard                  # force checkout of master/head and=20
reset index

The problem disappears! No eol problems anymore. Something like a brute=
=20
force checkout.

Also checking out versions in the direction of branch1 give never=20
end-of-line diffs.

What has changed somewhen are the gitattributes.

We estimate that this becomes a problem when applying the diffs from=20
branch1 in the direction of
the master. Finally then the diffs result in a different state from the=
=20
master.

But when the master is checked out freshly, this difference does not ap=
pear.

Very, very annoying.

We check now every time when these end-of-line diffs appear, if they ar=
e=20
really end of line diffs

git diff --ignore-space-at-eol

and then try the procedure above.

But to have a dependence from the direction of the checkout is somewhat=
=20
irritating.

If this is not a bug - then how to avoid it ?

bye for now

Thomas

--=20
++++++++++++++++++++++++++++++++++++++++++++++++++++++
iVISION GmbH		|Industrial Inspection Systems
J=FClicherstr. 336 B	|
D-52070 Aachen		|
Tel: +49-(0)241-961233	|
=46AX: +49-(0)241-980 2064|
www.ivision.de
tvie@ivision.de
++++++++++++++++++++++++++++++++++++++++++++++++++++++
