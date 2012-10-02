From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 1 Oct 2012 19:38:41 -0700
Message-ID: <CAJo=hJtxNq_DYNkok7D29G1takRCp6mw85zsa49XetZNVNEm8g@mail.gmail.com>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
 <1349126586-755-1-git-send-email-spearce@spearce.org> <20121001221817.GA12496@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 04:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIsOL-00037s-QW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 04:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab2JBCjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 22:39:05 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60038 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab2JBCjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 22:39:03 -0400
Received: by qaas11 with SMTP id s11so196515qaa.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Iee2nJwNpZtg73e5GLrEHUcVSMB1Lla5h6IP8+L3xkI=;
        b=R1JQl9BI8gtgNj2dW7SmH8xTr+u3gjf7ouqXJb0PU/OPefvSGAhmoDfLnzCqTC0Tu4
         dVsP/DM053OQJcpBBBfHhzP2dAkac2KYZVid/BF3EHKvge2Yb/SxSN64SZozWaIJV0/D
         NIxayEj65NDwiTeCkvzN4SQg7BwND9TFuxVus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=Iee2nJwNpZtg73e5GLrEHUcVSMB1Lla5h6IP8+L3xkI=;
        b=HS7fMb0voY1XyzTfHZfmaEJGRCEgfxxr/Gzhm3NwKlFm18+xqsfCPBbAxN1VlaW/1b
         KpBIxwCI/J9K5/ybY43Aw4YsnpcTN+t4g91FUn2WORZHtnn1qV6Czpp0RewhHlvIBCDW
         I4FpwSfmF/3JMJKAlj+l5ppgH/khaIcmj93vUCcHJlOxtpyZQMTJ/BE3dSZIiafa8RUr
         0UncJ7AXXBca0MOSVlcZJa0Eujyc0PmaTIh7N0jMxYYL9MBWpZZf+tcc6fD5kQwK6GOu
         2wmoZ7rwR7SiCXou1TFrHzv9FjV0U4hOFOtfA4V4b+ktwqsaulpkXeQSwM3gDS9Gnu4k
         rlvg==
Received: by 10.49.96.162 with SMTP id dt2mr2470129qeb.48.1349145541830; Mon,
 01 Oct 2012 19:39:01 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Mon, 1 Oct 2012 19:38:41 -0700 (PDT)
In-Reply-To: <20121001221817.GA12496@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQn8LKkZG7Ogagdw9AqlinR/pwUgvQFV1MrYhV0kpk0q/ldbt7ek9eoIrfvixbemtwarSUQ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206783>

On Mon, Oct 1, 2012 at 3:18 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 01, 2012 at 02:23:06PM -0700, Shawn O. Pearce wrote:
>>
>> When libcurl fails to connect to an SSL server always retry the
>> request once. Since the connection failed before the HTTP headers
>> can be sent, no data has exchanged hands, so the remote side has
>> not learned of the request and will not perform it twice.
>
> I find this a little distasteful just because we haven't figured out the
> actual _reason_ for the failure. That is, I'm not convinced this isn't
> something that curl or the ssl library can't handle internally if we
> would only configure them correctly. Did you ever follow up on tweaking
> the session caching options for curl?

No. I didn't try because I reproduced the issue on the initial "GET
/.../info/refs?service=git-upload-pack" request with no authentication
required. So the very first thing the remote-https process did was
fail on an SSL error. During this run I was using a patched Git that
had a different version of the retry logic, but it immediately retried
and the retry was successful. At that point I decided the SSL session
cache wasn't possibly relevant since the first request failed and the
immediate retry was OK.

> Have you tried running your fails-after-a-few-hours request with other
> clients that don't have the problem and seeing what they do

This is harder to reproduce than you think. It took me about 5 days of
continuous polling to reproduce the error. And I have thus far only
reproduced it against our production servers. This makes it very hard
to test anything. Or to prove that any given patch is better than a
different version.

> (I'm
> thinking a small webkit harness or something would be the most
> feasible)?

So I suspect the contrib/persistent-https proxy thing in Go actually
papers over this problem by having the Go SSL client handle the
connection. But this is only based on a test I ran for several days
through that proxy that did not reproduce the bug. This doesn't mean
it doesn't reproduce with the proxy, it just means _I_ didn't get
lucky with an error in a ~48 hour run.

> which means it shouldn't really be affecting the general populace. So
> even though it feels like a dirty hack, at least it is self-contained,
> and it does fix a real-world problem. If your answer to the above
> questions is "hunting this further is just not worth the effort", I can
> live with that.

I am sort of at that point, but the hack is so ugly... yea, we
shouldn't have to do this. Or pollute our code with it. I'm willing to
go back and iterate on this further, but its going to be a while
before I can provide any more information.

>> diff --git a/remote-curl.c b/remote-curl.c
>> index a269608..04a379c 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -353,6 +353,8 @@ static int run_slot(struct active_request_slot *slot)
>>
>>       slot->results = &results;
>>       slot->curl_result = curl_easy_perform(slot->curl);
>> +     if (slot->curl_result == CURLE_SSL_CONNECT_ERROR)
>> +             slot->curl_result = curl_easy_perform(slot->curl);
>>       finish_active_slot(slot);
>
> How come the first hunk gets a nice for-loop and this one doesn't?

Both hunks retry exactly once after an SSL connect error. I just tried
to pick something reasonably clean to implement. This hunk seemed
simple with the if, the other was uglier and a loop seemed the most
simple way to get a retry in there.

> Also, are these hunks the only two spots where this error can come up?
> The first one does http_request, which handles smart-http GET requests.
> the second does run_slot, which handles smart-http POST requests.

Grrr. I thought I caught all of the curl perform calls but I guess I
missed the dumb transport.

> Some of the dumb http fetches will go through http_request. But some
> will not. And I think almost none of dumb http push will.

Well, don't use those? :-)
