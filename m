From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git is not scalable with too many refs/*
Date: Sat, 01 Oct 2011 17:28:47 +0200
Message-ID: <4E8731AF.2040305@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org> <4E8607B6.2040800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 17:29:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA1VS-0007qM-1I
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 17:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab1JAP3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 11:29:20 -0400
Received: from india601.server4you.de ([85.25.151.105]:55602 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab1JAP3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 11:29:02 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id D94122F803A;
	Sat,  1 Oct 2011 17:29:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8607B6.2040800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182555>

Am 30.09.2011 20:17, schrieb Ren=C3=A9 Scharfe:
> Am 30.09.2011 18:52, schrieb Junio C Hamano:
>> It might be a better solution to not bother to clear the marks at
>> all; would it break anything in this codepath?
>=20
> Unfortunately, yes; the cleanup part was added by 5c08dc48 later,
> when it become apparent that it's really needed.
>=20
> However, since the patch only buys us a 5% speedup I'm not sure it's=20
> worth it in its current form.

I found something better: A trick used by bisect and bundle.  They copy
the list of pending objects from rev_info before calling
prepare_revision_walk and then go through it to clean up the commit
marks without going through the refs again.  And I think we can even
improve it a little.

The following patches tighten some orphan/detached head tests a little,
then comes a resend of my first patch on this topic, only split up into
two, then four patches that introduce the trick mentioned above (which
could be squashed together perhaps) and the last one is a bonus
refactoring patch.

 bisect.c                   |   20 +++++++-------
 builtin/checkout.c         |   58 +++++++++++++-----------------------=
-------
 bundle.c                   |   11 +++-----
 commit.c                   |   14 ++++++++++
 commit.h                   |    1 +
 revision.c                 |   14 +++++++---
 revision.h                 |    2 +
 t/t2020-checkout-detach.sh |    7 ++++-
 8 files changed, 64 insertions(+), 63 deletions(-)

Ren=C3=A9
