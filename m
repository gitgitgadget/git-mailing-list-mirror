From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 11:01:03 -0700
Message-ID: <xmqqzj576nts.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
	<xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
	<xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
	<20150514063317.GA22509@peff.net>
	<xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
	<20150514174945.GB7966@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 20:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxRX-0008A9-K3
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370AbbENSBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:01:07 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36534 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933273AbbENSBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:01:05 -0400
Received: by igbpi8 with SMTP id pi8so173963832igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1P7s8Mwz0B5L4CbCHT1EyydNJiaZ+v8tKmFEadWUwrs=;
        b=Txhr0Tf0GS4XsIZLzkF00B2q3rA6dMlQwtLdO/v53tJ/HV8u4u78MJaImzghU/KXCc
         B2/TxjJa6tG6GBNViwj2oDM+TvxpctIUaKJVNuVatNfQwydRxOp2YkXtPXSN8zv01FjI
         bQ+AtzAT+5R6JCo/XzK2kJOs3DSDFD70XfCb/Gpnk5sYeSQBTnur9k9m55e4fjoPgPr3
         +Y9IupsCZj8ETVQeP1LszePAhdE3XMXxAdXzoMyj8a2V0abDLTxaTfod6tOVwrwm/i/6
         ymayo0nn6RtbfWPlx9tVJMAJNDFl3klbyiKXIMgA7rplI7BynzlkaV6tQBSlZorY/Wvj
         pcww==
X-Received: by 10.50.23.105 with SMTP id l9mr37062695igf.13.1431626465335;
        Thu, 14 May 2015 11:01:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id i191sm13349331ioe.0.2015.05.14.11.01.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 11:01:04 -0700 (PDT)
In-Reply-To: <20150514174945.GB7966@peff.net> (Jeff King's message of "Thu, 14
	May 2015 13:49:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269058>

Jeff King <peff@peff.net> writes:

> On Thu, May 14, 2015 at 10:37:39AM -0700, Junio C Hamano wrote:
> ...
>> Wouldn't the hashtable used by decorate.[ch] with the max load
>> factor capped to 66% a better economy?
>
> Good point. A slab would be less memory efficient, but cheaper to look
> up (it is a direct memory reference, with no probing and no hashcmp()).
> But cache effects matter, so it could even be slower.

Yes, that was what I meant by economy.  I do not think memory footprint
is free in that sense.

> On the other hand, the slab makes it easy to actually store the real
> type (struct name_decoration), whereas the decorate hash stores only
> pointers. So we'd save an extra malloc/pointer in each case.
>
> So with your slab_peek() below, I'd guess that the slab would actually
> be faster. But I'd also be unsurprised if it makes no appreciable
> difference to the overall runtime of "git log --decorate". I think we'd
> have to build it and profile (and please feel free to say "eh, not worth
> the time to think about further").

While I think *slabname##_peek() would be worth doing regardless of
this caller, I suspect that the major overhead of decorate code
would come from the for_each_ref() that jumps deep into the history
to parse old commits; it would trigger a lot of unpacking of objects
deep in the delta chain, which would be expensive than table look-up
in either scheme.

>> I notice that there is no API into commit_slab to ask "Does this
>> commit have data in the slab?"  *slabname##_at() may be the closest
>> thing, but that would allocate the space and then says "This is the
>> slot for that commit; go check if there is data there already."
>
> Yes. I think it's not a big deal if your slab is reasonably full (you'll
> extend it to the full size of your commit space eventually either way).
> But for a sparse slab, it does make that query much more expensive than
> it needs to be.

Yes, and I think that commit decoration is such a use case.
