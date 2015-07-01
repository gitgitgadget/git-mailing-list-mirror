From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Wed, 01 Jul 2015 13:49:33 -0700
Message-ID: <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:49:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAOww-0003jk-1G
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 22:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbbGAUth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 16:49:37 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35362 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbbGAUtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 16:49:36 -0400
Received: by iecuq6 with SMTP id uq6so43131568iec.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=W+BuPVGqa/TZwuuvOdTXCEFtB2Vl69H56CTn0L23hSU=;
        b=bH3Ts93C+vg2qTjf5qZwzIPTMzdxAXo33UhqorTB1Wi68OMGINi60B+gh4OKYNkoAz
         wnUHicR6Zn0tVBCzYqTCrnI5daTdwsL6CauqPj1bZVDDjpp8Q0HZprDpg0yl6lpw5yJu
         k7m544mRWmBuAYgMBrqWX2Yn2Kzha1Yu+IEsoyV9jp/X18U7IwhH9ckuvMmoExLTjogi
         w5I69SY+BB14nlgtSTKnOTs4x5ntSmllKMqu8kBmkIbSmHYFG/nRTZtNkK/AhHkYaJI0
         mJfsg18azrIb7jbLEPns+qVJCnusQUIAEDOoDJNUiJsWOowIbXzaKS28sdTaWs2mCcHZ
         I5aw==
X-Received: by 10.50.114.5 with SMTP id jc5mr8449674igb.43.1435783776378;
        Wed, 01 Jul 2015 13:49:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id c41sm2232919iod.8.2015.07.01.13.49.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 13:49:34 -0700 (PDT)
In-Reply-To: <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	(Dave Borowitz's message of "Wed, 1 Jul 2015 13:07:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273198>

Dave Borowitz <dborowitz@google.com> writes:

>> I am moderately negative about this; wouldn't it make the end result
>> cleaner to fix the implementation?
>
> I'm not sure I understand your suggestion. Are you saying, you would
> prefer to make LFs optional in the push cert, for consistency with LFs
> being optional elsewhere?

Absolutely.  It is not "make" it optional, but "even though it is
optional, the receiver has not been following the spec, and it is
not too late to fix it".

The earliest these documentation updates can hit the public is 2.6;
by that time I'd expect the deployed receivers would be fixed with
2.5.1 and 2.4.7 maintenance releases.

If some third-party reimplemented their client not to terminate
with LF, they wouldn't be working correctly with the deployed
servers right now *anyway*.  And with the more lenient receive-pack
in 2.5.1 or 2.4.7, they will start working.

And we will not change our client to drop LF termination.  So
overall I do not see that it is too much a price to pay for
consistency across the protocol.

> If LF is optional, then with that approach you might end up with a
> section of that buffer like:

I think I touched on this in my previous message.  You cannot send
an empty line anywhere, and this is not limited to push-cert section
of the protocol.  Strictly speaking, the wire level allows it, but I
do not think the deployed client APIs easily lets you deal with it.

So you must follow the "SHOULD terminate with LF" for an empty line,
even when you choose to ignore the "SHOULD" in most other places.

I do not think it is such a big loss, as long as it is properly
documented.
