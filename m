From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 09:25:00 -0700
Message-ID: <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
References: <20160610075043.GA13411@sigill.intra.peff.net> <20160610083102.GA14192@sigill.intra.peff.net>
 <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 18:25:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBPFC-0008PH-OK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 18:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbcFJQZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 12:25:09 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36232 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbcFJQZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 12:25:07 -0400
Received: by mail-qg0-f54.google.com with SMTP id v76so6733998qgv.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nUAkQhk0/8Kbkzo70JwDxZe/WxJEHKpYaiJj8xP4keg=;
        b=X6dt9XvlYjkLmmk7CIop/BlGGFqRPfrxuZb8TitcQ603yY978jfFPMVXZBTRqxAung
         x2xkyJs/JCOvhbiiDxtkp1VrdHSNI85PpyFCMd8ttvoJFpuog2q6PARMGM7z6R9PE6TC
         DMKEqGF876abT0tezceaiwOwD3lZ+xJcnoyauE2y9/El4kRQqfIdmj6XYsng+Un4UCou
         6V13dKlJTFiZF/qxtfKrRyTMjl2YqW3X6tU5eJR3Gkg5kILtg/L2ZNA92XH5gs8Q4nNJ
         AJ/Vu8QD4tagcr60AT7/As2zpr1dDtk/wNf/1iqDiaa6FWY1Ic9Jq0eh9GGZcPbNGW7B
         ixCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nUAkQhk0/8Kbkzo70JwDxZe/WxJEHKpYaiJj8xP4keg=;
        b=hDXkRaTnp7CSj6xiNo6HsWtMPfi8sMDbGXdy9qpvcwBFj0q8BbfWd11xbKGQCmYIHD
         ukORKGgjs1I2Di7EhBg+jhmWphANZWoRVwtnjhzVFtxupqWj4/65or+XPWl2Wp2yH6Gv
         ldab9XWkz3MauJV/QxYT1zK5/DuUmnSlaMgMN04UlsSxNO7LnTxJUgNFL+ehsoV1CS0U
         n+kjiIWN5dMNRxLoXEtn/22MegExvBnxw5YvdmeJTIjVK+s/tpYHwSs/4GJ0wpNVfaNn
         TZG0Yg06eSj6UXYmUVWdS962ph2UWH/kdRE4oCQHckxYbeXskS2uxV6q/2EEwQOfGIC4
         pebA==
X-Gm-Message-State: ALyK8tJ9mF0KDIc03YXj2E/ElmsgN7urtYgxDrYGcx9jclu7YDYPWiEDxeqfJtDFntgb9xRoBR4w6uq8yoaX49St
X-Received: by 10.140.98.38 with SMTP id n35mr2600643qge.22.1465575901389;
 Fri, 10 Jun 2016 09:25:01 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Fri, 10 Jun 2016 09:25:00 -0700 (PDT)
In-Reply-To: <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297010>

On Fri, Jun 10, 2016 at 8:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Jun 10, 2016 at 03:50:43AM -0400, Jeff King wrote:
>>
>>> I found a false positive with the new compaction heuristic in v2.9:
>>> [...]
>>
>> And by the way, this is less "hey neat, I found a case" and more "wow,
>> this is a lot worse than I thought".
>>
>> I diffed the old and new output for the top 10,000 commits in this
>> particular ruby code base. There were 45 commits with changed diffs.
>> Spot-checking them manually, a little over 1/3 of them featured this bad
>> pattern. The others looked like strict improvements.
>>
>> That's a lot worse than the outcomes we saw on other code bases earlier.
>> 1/3 bad is still a net improvement, so I dunno. Is this worth worrying
>> about? Should we bring back the documentation for the knob to disable
>> it? Should we consider making it tunable via gitattributes?
>>
>> I don't think that last one really helps; the good cases _and_ the bad
>> ones are both in ruby code (though certainly the C code we looked at
>> earlier was all good).
>>
>> It may also be possible to make it Just Work by using extra information
>> like indentation. I haven't thought hard enough about that to say.
>>
>> -Peff
>
> I recall saying "we'd end up being better in some and worse in
> others" at the very beginning.  How about toggling the default back
> for the upcoming release, keeping the experimentation knob in the
> code, and try different heuristics like the "indentation" during the
> next cycle?

Sure. I thought about for a while now and by now I agree with Junio.
No matter what kind of heuristic we can come up with it is easy to construct
a counter example.

That said, let's try the indentation thing, though I suspect
one of the early motivating examples (an excerpt from a  kernel config file)
would not do well with it, as it had not an indentation scheme as programming
languages do.

Thanks,
Stefan
