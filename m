From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Fri, 19 Aug 2011 01:36:05 +0530
Message-ID: <CALkWK0nV35gNFM2NW-FrwBLnvFzmWDdARZk0Xy6LT8c2UE0fAw@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com> <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org> <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org> <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
 <20110818191812.GG30436@elie.gateway.2wire.net> <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:06:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8rL-00006L-Rp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 22:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab1HRUG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 16:06:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50193 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab1HRUG0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 16:06:26 -0400
Received: by wyg24 with SMTP id 24so1661533wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6QEr9wMB8Oin1S5Bxm+3co0lvFTc/VDvLuWVIEsIgVI=;
        b=HM6Vo4Zq/yCpyT6XmQSHKkGmZWPDc7MMr8Wq/pllmuhDZ2Tu9gaJAMJKsDrTm/y2z4
         EsHLCvB2MAPANLKgJjLlAAtwiOgRPvgQusM9lN8LlLFKlzbCR/IGbwuPzityGJsUNCxI
         Lo7u8wVu0UVocrxKrrVvxjJ38E37u2DI8p4yE=
Received: by 10.216.175.130 with SMTP id z2mr958003wel.63.1313697985112; Thu,
 18 Aug 2011 13:06:25 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Thu, 18 Aug 2011 13:06:05 -0700 (PDT)
In-Reply-To: <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179623>

HI again,

Ramkumar Ramachandra writes:
> One final resort: Move some code back into cherry-pick, and call into
> a later-function in the sequencer only if it's a many-commit
> operation. =C2=A0The new commands can enjoy the comfort of calling in=
to an
> earlier-function in the sequencer that'll do all the revision walk
> setup and call the later-function. =C2=A0I think this is reasonable.

Er, no.  This would be amazingly ugly too: we'd need two versions of
everything like '--continue'.  And look at this glaring inconsistency:

  git cherry-pick foo..bar
  ..conflict..
  git sequencer --abort
  $? =3D 0

But:

  git cherry-pick foo
  ..conflict..
  git sequencer --abort
  error: No sequencer operation in progress.

In a nutshell, the problem we're facing: We persist part of the
continuation data outside the sequencer's knowledge, and part of it
inside.  For backward compatibility, we can't move the former part
into the sequencer.

-- Ram
