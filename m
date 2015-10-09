From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Fri, 9 Oct 2015 09:40:58 +0800
Message-ID: <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 03:41:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMgE-0005pg-FX
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbbJIBlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:41:01 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34940 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbJIBlA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 21:41:00 -0400
Received: by lbwr8 with SMTP id r8so65163293lbw.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rLJPt3j959NFqZ6Hf3FQdsACGCCqp3WCRezRF9Bod9I=;
        b=WKIwiqUfPlA9FMG86uPuskOyAy161DM+86sLgzn+8q4x/5h6u7N/Ag6kTFe2dMGD+k
         D3cGq0V5cwx2TN6IvKGEdHfsHZ3wCsarQJcwjOCe5rWyo9wsLC3m9JwAqr1/Mgno982M
         pup/yd8pTLmt4k7sRmW7yUJH/MYLK1Ru6KBzWvsBeMW4Hgz9DUTbgakTth3oZwWj6QNv
         dEKarsQJTo5No9XKAeHgpKM2x7AgPLWvarY5boGVb0x0CggOLipLTDf/cK/rpOIwiBe8
         8F/w11YWrqSoRH9vQtBRjyGnd7kcCVKN1Ens41GS5//OyNFv3fvdWtz5io3x9TUESFaA
         PhTQ==
X-Received: by 10.112.130.39 with SMTP id ob7mr5232773lbb.66.1444354858935;
 Thu, 08 Oct 2015 18:40:58 -0700 (PDT)
Received: by 10.112.13.136 with HTTP; Thu, 8 Oct 2015 18:40:58 -0700 (PDT)
In-Reply-To: <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279283>

On Fri, Oct 9, 2015 at 8:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Brendan Forster noticed that we no longer see the helpful message after
>> a failed `git pull --rebase`. It turns out that the builtin `am` calls
>> the recursive merge function directly, not via a separate process.
>>
>> But that function was not really safe to be called that way, as it
>> die()s pretty liberally.

I'm not too familiar with the merge-recursive.c code, but I was under
the impression that it only called die() under fatal conditions. In
common use cases, such as merge conflicts, it just errors out and the
helpful error message does get printed. Is there a reproduction recipe
for this?

That said, I do agree that even if we die(), we could try to be more
helpful by printing additional helpful instructions.

> If that is the case, I'd thinkg that we'd prefer, as a regression
> fix to correct "that", i.e., let recursive-merge die and let the
> caller catch its exit status.

We could do that, but I don't think it would be worth the overhead to
spawn an additional process for every patch just to print an
additional message should merge_recursive() call die().

Instead, stepping back a bit, I wonder if we can extend coverage of
the helpful message to all die() calls when running git-am. We could
just install a die routine with set_die_routine() in builtin/am.c.
Then, should die() be called anywhere, the helpful error message will
be printed as well. fast-import.c and http-backend.c seem to do this.

Regards,
Paul
