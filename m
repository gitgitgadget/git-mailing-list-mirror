From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 4 Nov 2015 13:56:38 -0600
Message-ID: <CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
	<CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
	<xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:56:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4Al-0004A5-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365AbbKDT4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:56:39 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36641 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbbKDT4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:56:38 -0500
Received: by ioll68 with SMTP id l68so66929093iol.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y5XkSsX9B0SNbwLCYVafv3fwUIfGm2AOU1PmRVW8pGA=;
        b=s6Zpd6MoWX13KktRML5Tt1++b8jMFnmv98mLQE48jHDI2UHx2B3ifPIXb749MFRJV5
         oSK1VVlnwbRmY2HG23cRhclkIQzsftA7B5Kvvc5AkJh/OwZFgGFQDZxv2uDZ7TY3T/Lr
         Id+E3N5r+y1/78FaHP15HFaq2gIa9WqZufuZveneC+uMunDHmaPtbUz5OtqdoKC6bVF7
         rw7TMHxCOuzfepJJ5C4MEp2YHzmzhGDDVyeyGOeRl2YocAbRplvnnv5oDIALj9vqAFrb
         OGdcZ6/OlfbuhSvF3Tq7eoqnMJCvCTqHGfCiaNNnlNtOVuHxkzePuVzzLptp0pBOZrqo
         PhAg==
X-Received: by 10.107.138.84 with SMTP id m81mr5361729iod.40.1446666998075;
 Wed, 04 Nov 2015 11:56:38 -0800 (PST)
Received: by 10.79.38.129 with HTTP; Wed, 4 Nov 2015 11:56:38 -0800 (PST)
In-Reply-To: <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280873>

On Wed, Nov 4, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Doug Kelly <dougk.ff7@gmail.com> writes:
>
>> I think the patches I sent (a bit prematurely) address the
>> remaining comments... I did find there was a relevant test in
>> t5304 already, so I added a new test in the same section (and
>> cleaned up some of the garbage it wasn't removing before).  I'm
>> not sure if it's poor form to move tests around like this, but I
>> figured it might be best to keep them logically grouped.
>
> OK, will queue as I didn't spot anything glaringly wrong ;-)
>
> I did wonder if we want to say anything about .bitmap files, though.
> If there is one without matching .idx and .pack, shouldn't we report
> just like we report .idx without .pack (or vice versa)?
>
> Thanks.

I think you're right -- this would be something worth following up on.
At least, t5304 doesn't cover this case explicitly, but when I tried
adding an empty bitmap with a bogus name, I did see a "no
corresponding .idx or .pack" error, similar to the stale .keep file.

I'd trust your (and Jeff's) knowledge on this far more than my own,
but would it be a bad idea to clean up .keep and .bitmap files if the
.idx/.pack pair are missing?  I think we may have had a discussion
previously on how things along these lines might be racey -- but I
don't know what order the .keep file is created in relation to the
.idx/.pack.
