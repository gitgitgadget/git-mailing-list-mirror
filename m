From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Tue, 2 Oct 2012 09:57:29 -0400
Message-ID: <CAM9Z-nmWdM1g5B+M7sSV3jkAJsUEkHUGPxbUi-r4x7zAwD29qA@mail.gmail.com>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
	<1349126586-755-1-git-send-email-spearce@spearce.org>
	<20121001221817.GA12496@sigill.intra.peff.net>
	<CAJo=hJtxNq_DYNkok7D29G1takRCp6mw85zsa49XetZNVNEm8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 15:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ2yn-0007iv-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 15:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab2JBN5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 09:57:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37187 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2JBN5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 09:57:30 -0400
Received: by bkcjk13 with SMTP id jk13so5519772bkc.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W3UaPVo2JOACSUb3Yy+CKL/bTqs5vqyhCee3hD9k/CM=;
        b=XNLG4d5sz+eaaD9/T6zW2VJQwaj711Zf3Jtwkh9jFAws5+b1vOBrN/6E3UZAzQtdK4
         kjvX0AulvYcaFFiEYgyE/7wW2xx9UHgXyy922ckFlClB6homjbbK5CgI3OsaB/EJQDJc
         JD6fNqSKwW7N43dgu195fQxGSN0L/8enVLlgzXHJ6WsMJoNv7Tpfe/oWovgTRo/yrkbA
         w3yt8IsdiPJM2AsAkNSlg4E/q8K6MZXImz3PhwAb6VM/Lcx/M6LlytfjawoaYRgEf8fE
         HDrt/FrmGMUWTZGQhsKVYBoRFkw/HuWz4pzzmxejHWTfq1pvvkiW+wawNUnqgYoQ0yIE
         tpYw==
Received: by 10.204.11.210 with SMTP id u18mr6890293bku.123.1349186249485;
 Tue, 02 Oct 2012 06:57:29 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Tue, 2 Oct 2012 06:57:29 -0700 (PDT)
In-Reply-To: <CAJo=hJtxNq_DYNkok7D29G1takRCp6mw85zsa49XetZNVNEm8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206796>

On Mon, Oct 1, 2012 at 10:38 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Oct 1, 2012 at 3:18 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Oct 01, 2012 at 02:23:06PM -0700, Shawn O. Pearce wrote:
>>>
>>> When libcurl fails to connect to an SSL server always retry the
>>> request once. Since the connection failed before the HTTP headers
>>> can be sent, no data has exchanged hands, so the remote side has
>>> not learned of the request and will not perform it twice.
>>
>> I find this a little distasteful just because we haven't figured out the
>> actual _reason_ for the failure.
>
> No. I didn't try because I reproduced the issue on the initial "GET
> /.../info/refs?service=git-upload-pack" request with no authentication
> required. So the very first thing the remote-https process did was
> fail on an SSL error. During this run I was using a patched Git that
> had a different version of the retry logic, but it immediately retried
> and the retry was successful. At that point I decided the SSL session
> cache wasn't possibly relevant since the first request failed and the
> immediate retry was OK.
>
>> Have you tried running your fails-after-a-few-hours request with other
>> clients that don't have the problem and seeing what they do
>
> This is harder to reproduce than you think. It took me about 5 days of
> continuous polling to reproduce the error. And I have thus far only
> reproduced it against our production servers. This makes it very hard
> to test anything. Or to prove that any given patch is better than a
> different version.

The only sure way to make sure your patch works is to get your load
balancers Slashdotted first (reason noted in my previous mail on this
subject). For the sake of your relationship with your networking crew
I'd not advise doing that intentionally.


>> which means it shouldn't really be affecting the general populace. So
>> even though it feels like a dirty hack, at least it is self-contained,
>> and it does fix a real-world problem. If your answer to the above
>> questions is "hunting this further is just not worth the effort", I can
>> live with that.
>
> I am sort of at that point, but the hack is so ugly... yea, we
> shouldn't have to do this. Or pollute our code with it. I'm willing to
> go back and iterate on this further, but its going to be a while
> before I can provide any more information.

>> How come the first hunk gets a nice for-loop and this one doesn't?
>
> Both hunks retry exactly once after an SSL connect error. I just tried
> to pick something reasonably clean to implement. This hunk seemed
> simple with the if, the other was uglier and a loop seemed the most
> simple way to get a retry in there.

If indeed the problem you are having is with a load balanced setup
then applying TCP/IP like back-off semantics is the right way to go.
The only reason the network stack isn't doing it for you is because
the load balancers wait for the SSL/TLS start before dumping the
"excess" (exceeding of license) SSL connections.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
