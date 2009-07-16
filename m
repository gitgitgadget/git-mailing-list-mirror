From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Fri, 17 Jul 2009 01:18:14 +0200
Message-ID: <adf1fd3d0907161618o61ee4b58of25659f8c36420f7@mail.gmail.com>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
	 <1247731921-2290-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
	 <7vhbxc8inp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 01:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRaDY-0004OC-Jd
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 01:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562AbZGPXSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 19:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933556AbZGPXSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 19:18:16 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:55372 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933555AbZGPXSQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 19:18:16 -0400
Received: by bwz28 with SMTP id 28so424431bwz.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 16:18:14 -0700 (PDT)
Received: by 10.204.118.70 with SMTP id u6mr245881bkq.198.1247786294268; Thu, 
	16 Jul 2009 16:18:14 -0700 (PDT)
In-Reply-To: <7vhbxc8inp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123435>

2009/7/16 Junio C Hamano <gitster@pobox.com>:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> How about
>>
>> =A0 =A0 =A0 oldremoteref=3D"$(git rev-list --boundary HEAD --not \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(git rev-list -g $remot=
eref | sed 's/$/^@/') |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sed -e '/^[^-]/d' -e q)"
>>
>> Explanation: the "git rev-list -g $remoteref" lists the previous com=
mits
>> the remote ref pointed to, and the ^@ appended to them means all the=
ir
>> parents. =A0Now, the outer rev-list says to take everything in HEAD =
but
>> _not_ in those parents, showing the boundary commits. =A0The "sed" c=
all
>> lists the first such boundary commit (which must, by construction, b=
e one
>> of the commits shown by the first rev-list).
>
> Hmm, I am not sure about that "(which must..." part. =A0When you have
>
> =A0 =A0 =A0 =A0 =A0Y---X
> =A0 =A0 =A0 =A0 /
> =A0 =A0 =A0 =A0B---o---o---o---H
>
> wouldn't "rev-list --boundary H --not X^@" give B, not X nor Y?
>

$git rev-list --boundary H --not X
and
$git rev-list --boundary H --not X^@

return the same output in this case:
o
o
o
-B

In this case the correct command is without ^@, because you want the
commits in the reflog as boundary commits.

In the simpler and usual case, without a rebased upstream:

 =A0 =A0z---B---o---o---o---H

B=3Dupstream@{0}

$git rev-list --boundary H --not B^@
o
o
o
B
-z

and:

$git rev-list --boundary H --not B
o
o
o
-B

Also in the rebased upstream case:

 =A0 =A0 =A0Y---X
 =A0 =A0 /
 =A0 =A0z---B---o---o---o---H


X=3Dupstream@{0}
B=3Dupstream@{1}

$git rev-list --boundary H --not X^@ B^@
o
o
o
B
-z

and:

$git rev-list --boundary H --not X B
o
o
o
-B

HTH,
Santi
