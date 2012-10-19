From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 07:10:46 -0700
Message-ID: <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com> <7vd30fl736.fsf@alter.siamese.dyndns.org>
 <20121019103627.GA29366@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, szager@google.com,
	git@vger.kernel.org, sop@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPDIH-0002Iz-6H
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 16:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758855Ab2JSOLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 10:11:09 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60662 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758234Ab2JSOLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 10:11:08 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so140077qad.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V9vn/OmGxQicML1oQWrjseosW/zU80ArX0Llcmo0K8A=;
        b=QBqUkMZMXhY9hx6B2fzJS6FvNyr9rsorNxjXzdpA39d5Ysni6RF4FVsEejlnFta5O2
         BS1YPSSlVP0T0gke2k5L1/Q9d+a9Q3uKuL7nAxfTtNf0lOP2xiM34jDuTXSVDd6dW2UP
         9HMlkbr3gg9HukAv6iGgcnmwt+JF8GyJFiPTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=V9vn/OmGxQicML1oQWrjseosW/zU80ArX0Llcmo0K8A=;
        b=dUEi8KC41q2sqmfstkJpc+6zIhHL7c6QZVTNwpiiuJuJhRrPP4LR/vltsXlNjNJiif
         xuGBfJGHVLEn0aSxyEdxOgRywjCYWLYnXaXUvufZv2vGTGc2n3xbRegQyTCnFUhII2Kd
         g+tWTSxJ5CJEtKyJ+/s7djNtynErA2u3TTBb/9Jeun4LaRlo2qLbefHU8stS1OahcYRq
         Uu73EUAxb1tj4rbQAlUoafeZzW4z4EcJZsFmQUGfJqmCM1BXdyxRXjLjiVbDcgjiTZy3
         LsIXNpcW7C1MZiRWANil9i5k4IlFowel0lrwDFsOLVKl+lyg/ar5g6fNLfupUVqyX83d
         SFbQ==
Received: by 10.49.63.104 with SMTP id f8mr788716qes.29.1350655866926; Fri, 19
 Oct 2012 07:11:06 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Fri, 19 Oct 2012 07:10:46 -0700 (PDT)
In-Reply-To: <20121019103627.GA29366@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQk+HoYNapfEJEbABitbuopk9PF0cgMUg6AVlq7/Ifhx0KM10gaw9IbdfAs3nr7N7p3bBi73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208048>

On Fri, Oct 19, 2012 at 3:36 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 18, 2012 at 03:59:41PM -0700, Junio C Hamano wrote:
>
>> > It will sometimes happen that curl_multi_fdset() doesn't
>> > return any file descriptors.  In that case, it's recommended
>> > that the application sleep for a short time before running
>> > curl_multi_perform() again.
>> >
>> > http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
>> >
>> > Signed-off-by: Stefan Zager <szager@google.com>
>> > ---
>>
>> Thanks.  Would it be a better idea to "patch up" in problematic
>> case, instead of making this logic too deeply nested, like this
>> instead, I have to wonder...
>>
>>
>>       ... all the existing code above unchanged ...
>>       curl_multi_fdset(..., &max_fd);
>> +     if (max_fd < 0) {
>> +             /* nothing actionable??? */
>> +             select_timeout.tv_sec = 0;
>> +             select_timeout.tv_usec = 50000;
>> +     }
>>
>>       select(max_fd+1, ..., &select_timeout);
>
> But wouldn't that override a potentially shorter timeout that curl gave
> us via curl_multi_timeout, making us unnecessarily slow to hand control
> back to curl?
>
> The current logic is:
>
>   - if curl says there is something to do now (timeout == 0), do it
>     immediately
>
>   - if curl gives us a timeout, use it with select
>
>   - otherwise, feed 50ms to selection
>
> It should not matter what we get from curl_multi_fdset. If there are
> fds, great, we will feed them to select with the timeout, and we may
> break out early if there is work to do. If not, then we are already
> doing this wait.
>
> IOW, it seems like we are _already_ following the advice referenced in
> curl's manpage. Is there some case I am missing? Confused...

The issue with the current code is sometimes when libcurl is opening a
CONNECT style connection through an HTTP proxy it returns a crazy high
timeout (>240 seconds) and no fds. In this case Git waits forever.
Stefan observed that using a timeout of 50 ms in this situation to
poll libcurl is better, as it figures out a lot more quickly that it
is connected to the proxy and can issue the request.
