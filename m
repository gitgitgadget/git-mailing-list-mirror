From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 23:47:52 -0700
Message-ID: <CAGZ79kaD3kyWdbT-PhR9XPV_qmYpQipZwvfYYcVvwk62+x5qnw@mail.gmail.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 08:48:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asPS1-0007nn-UK
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 08:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbcDSGry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 02:47:54 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34673 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbcDSGrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 02:47:53 -0400
Received: by mail-io0-f171.google.com with SMTP id 2so9093975ioy.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=o3WUOaEZhMiIVd+mG9WEDPddNTaJFIHvAUcBVR26X4A=;
        b=NartEvNBmq6iHcLjONzh/cd4LBA02Ti4OxXEshUWilMEMvjN7sZstJpqhH3R0NbNpV
         DqYvlMZIXO5FeStsIwNxRANrj2I+mF2Q8tG9n2Qz+p8ygmLGyc/bA/NHedCiGAuey49D
         qSs5rTAEOSFXzBKcO0FZwrUydRxmkCfn/Wzy+LEf6+1NjQ8gtwPmsdaUt6FTetnulPAq
         wJKTTqtHCPr5Dm7/dVzz14LpxSeDezi3BXfigPbwcuRRp29VKPw6Idsy0vcfHgKpv7ph
         5izINMPVxOXtVPj0jU3urGtcG6vgYcgKkCIJa2EUyH3LtOjMD8d8/Jb8JX5aOI773IEx
         PLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o3WUOaEZhMiIVd+mG9WEDPddNTaJFIHvAUcBVR26X4A=;
        b=kCxtg5xD53YTcxTb9Tqhttan7VGAXjXO3N8H5Xhi/CnRmiHIE6eWsVaHHwKYqCTzaN
         ZwUdkDiA+4gf2PYcMQR8dgW2ln4ArGNSFT/alARsT4kSixlBEn5zdLMsdu/NXFlpXWy6
         Zcqc/GByzQYi1WvkmwGaiUeRA9DYkN1D3P7UMkPl52hURr83yRTVmOcqTHSdvtFmtjIY
         UUNVXQABfDaO5xVjR0VJ9vts3xXsk2MefGB9+Es6faIJ1QGEBfJ75WH7Xro0/v+gYtbl
         7o7f7QWhCV75g5VsWBaQXig+xjZfugUSQbltAD3rG5HLODc2iD/4K3zMhYyFGBIobRpL
         kTmw==
X-Gm-Message-State: AOPr4FX+c5+lPlW1NrKAFDwb6xJejec4CXcaCbhaOCBitjEekOadCQ0AM492Ww0vYvmYSkyy+9crxJNAi5e1dN4t
X-Received: by 10.107.184.8 with SMTP id i8mr1830715iof.96.1461048472165; Mon,
 18 Apr 2016 23:47:52 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Mon, 18 Apr 2016 23:47:52 -0700 (PDT)
In-Reply-To: <20160419050342.GA19439@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291845>

On Mon, Apr 18, 2016 at 10:03 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 18, 2016 at 02:12:30PM -0700, Stefan Beller wrote:
>
>> +
>> +             /*
>> +              * If a group can be moved back and forth, see if there is an
>> +              * blank line in the moving space. If there is a blank line,
>> +              * make sure the last blank line is the end of the group.
>
> s/an/a/ on the first line

So it looks like I'll be resending another version for this series tomorrow.
Thanks for pointing this out!

>
>> +              * As we shifted the group forward as far as possible, we only
>> +              * need to shift it back if at all.
>
> Maybe because I'm reading it as a diff that only contains this hunk and
> not the whole rest of the function, but the "we" here confused me. You
> mean the earlier, existing loop in xdl_change_compact, right?
>
> Maybe something like:
>
>   As we already shifted the group forward as far as possible in the
>   earlier loop...
>
> would help.

I'll see to get rid of the 'we', otherwise I'll stick with your suggestion.

>
>> +             if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
>> +                     while (ixs > 0 &&
>> +                            !is_blank_line(recs, ix - 1, flags) &&
>> +                            recs_match(recs, ixs - 1, ix - 1, flags)) {
>> +                             rchg[--ixs] = 1;
>> +                             rchg[--ix] = 0;
>> +                     }
>> +             }
>
> This turned out to be delightfully simple (especially compared to the
> perl monstrosity).
>
> I tried comparing the output to the perl one, but it's not quite the
> same. In that one we had to work with the existing hunks and context
> lines, so any hunk that got shifted ended up with extra context on one
> side, and too little on the other. But here, we can actually bump the
> context lines to give the correct amount on both sides, which is good.
>
> I guess this will invalidate old patch-ids, but there's not much to be
> done about that.

For the record:
I thought about "optimal hunk separation" for a while, specially during my
bike commute. And while this heuristic seems to be a good fit for most of
the cases inspected, we can do better (in the future).

I am convinced the better way to do it is like this:

    Calculate the entropy for each line and take the last line with the
    lowest entropy as the last line of the hunk.

That heuristic requires more compute though as it will be hard to compute
the entropy for the line. To do that I would imagine, we'd need to loop over
the whole file and count the occurrences for each char (byte) and then
take the negative log of (#number of that byte / #number of bytes in file) [1].

This would model our actual goal a bit more closely to split at parts, where
there is low information density (the definition of entropy).

One example Jacob pointed out was a thing like

/**
 * Comment here. Over
 * more lines.
 *
+ *  Add line here with a blank line
+ *
+ * in between and a trailing blank after.
+ *
 */

I think we had cases like this in the kernel tree and else where,
and for a human it is clear to break after the last "empty line"
(which for comments starts with " * "). To detect those we can use
the entropy as it doesn't convey lots of information.
(git show e1f7037167323461c0415447676262dcb)

It also keeps the false positives out, Jacob pointed at
85ed2f32064b82e541fc7dcf2b0049a05 IIRC, which was bad with
the shortest lines only, but I'd imagine the entropy based
heuristic will do better there.

[1] https://en.wikipedia.org/wiki/Entropy_(information_theory)

Thanks for the review,
Stefan

>
> -Peff
