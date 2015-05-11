From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Mon, 11 May 2015 10:49:09 -0700
Message-ID: <CAGZ79kYc91z5S9j_hpA3b9-TvMBxr9jkdxhqEgHhOCT3mGzH5w@mail.gmail.com>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
	<1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
	<20150501182257.GA27728@peff.net>
	<55445E60.6010205@alum.mit.edu>
	<20150505192110.GD10463@peff.net>
	<555083CF.8010205@alum.mit.edu>
	<20150511164941.GA30541@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 19:49:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrrpN-0000WI-Qi
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbbEKRtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:49:14 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38093 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbEKRtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:49:10 -0400
Received: by igbhj9 with SMTP id hj9so77842397igb.1
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ji5Td5cSVucHKCWNSwDjmrEqcEXLSfNhV93p3v6besU=;
        b=M5HDv3A+g2vfeVvgDek7KtLxsGZ+t1Ez7dSJGqd6z+IY1vHlysruRC8bTN0xGr9fsw
         d7pAp7lzVec65I39GP/UP4qgsdjaGGPwD7pocHTz76O5vqImn8ulupLm3UMyrp9p4Fl1
         /xVXFgMtvlzFzaKoQv0o+RJs3cTU95C8UhqTfe/NpLTh55u6DV1ThABfSsDKErtUeEoX
         w8QRv0svD7tzI3hjpj4fc9Mk5+pEIBYi3fznhFH0kyzg70j+GZLDkpX7dl0E3H/cMuUA
         fqe47DbUKqrjEdgNj6A1qslYSzYOuaxpWMBr/41Pq1tShh2dbbUcLVI0OWEvEsLE5t8h
         /4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ji5Td5cSVucHKCWNSwDjmrEqcEXLSfNhV93p3v6besU=;
        b=jeSLfQqkTeDSkDjbBumFB//ybRr/5efQxaSxSIY5Jqx7RFW12y0FPT+tBf9M61u3qm
         rqGVPIHxFtgbDR4OpSHtnONmv++UJ+3p+veqa47brPPcxCINYb0lJroySYtmWzi6l8sd
         tIasZEjawRatUYpYVEwq9spt9axJAE+N9BzenGFeJkxQvfqGpNYLbbv/YWahi7RXfOdt
         5rByzmXieezYTqwHR7nCmzeux6EN54kkSrqtSPqjavWFAATkt/rghedZlgpZOPu6bCtO
         B0Mh1mqYbxIPU2kOEaUXERpEiLLUTTVGMf7FZ4zWQArlMSG9Ik+W42CCbjq5BkIsLppJ
         z3Rw==
X-Gm-Message-State: ALoCoQlTYnnw/6Y5djnbe3yO1f4GY4UJ7n/ZSXmhh14fW8/dv+sJ6i7DMqAfq1m+h+naKtPvtJVH
X-Received: by 10.107.13.11 with SMTP id 11mr14549231ion.70.1431366550037;
 Mon, 11 May 2015 10:49:10 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 10:49:09 -0700 (PDT)
In-Reply-To: <20150511164941.GA30541@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268803>

On Mon, May 11, 2015 at 9:49 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 11, 2015 at 12:26:23PM +0200, Michael Haggerty wrote:
>
>> > So something like 100ms max backoff makes sense to me, in that it keeps
>> > us in the same order of magnitude as the expected time that the lock is
>> > held. [...]
>>
>> I don't understand your argument. If another process blocks us for on
>> the order of 100 ms, the backoff time (reading from my table) is less
>> than half of that.
>
> I think it is just that I was agreeing with you, but communicated it
> badly. I think your series is fine as-is.

By now I also think your series is fine as is.
I am currently implementing something similar for Gerrit and I realize
testing time based things is a royal pain in the butt. The tests you propose
just take wall clock time and all should is good, though slowing down
the test suite
by another second or three in the worst case.

So for tests in Gerrit I use a dedicated java class which is
specialized to pretend different
times, such that you can write:

    doThings();
    pretendTimePassing(1 second);
    checkResultsFromThreads();

but running the tests takes less than 1 second as it's no real wall
clock time passing.

On my machine there is
/bin/usleep - sleep some number of microseconds
which may be better for running the test suite. I don't know if it's
worth the hassle
of checking if that program is there and selectively running a faster
version of said
test though.

That said, I'm personally fine with the waste of 1 second as I view
running the test suite
as a long waiting game anyway. Maybe Junio as the maintainer (I assume
he runs more tests
than all of us?) dislikes waiting for the second all the time?


>
> -Peff
