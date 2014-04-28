From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or
 CURLDIR
Date: Mon, 28 Apr 2014 13:50:58 -0700
Message-ID: <20140428205058.GQ9218@google.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
 <20140428200550.GO9218@google.com>
 <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:51:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesWA-00039t-Ez
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928AbaD1UvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:51:04 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:38304 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788AbaD1UvC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:51:02 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6266673pbc.7
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dsGSVPRmPzRVcNgUstjxpGQPfLs4rGIwGQdyTqryWQE=;
        b=xDnbjWRSsixEc7Wj+sIkVmd5X2UIm0RUQkDxIayUs0tN1jEOCCBw7vFiSDRREMXmnz
         b8v+pkkPPdzC4ehdIXMdYifVuCSXGIIGGdKAfNqO4sVjcsAwXuramfZZBFJewkDmJxKE
         3Un5nevt3aa9HMH6SYoXAhlEMuaXQWqFP22GD8AeIulsi2snen57wxDAzC3xF6+6VqsO
         bjHpmkWTixfhuogNna80u6mcjhFKvEknCQDzbzKLsF3ad+i6wB7/oIy2dZsd/vTcUIFd
         5hmLToMqdqCdJUG9zTjdNxrdRXlejDT4am74K5fZs0WeafWJ0IiB1SQeujmDpceI3jwV
         iKYw==
X-Received: by 10.68.198.97 with SMTP id jb1mr31298759pbc.104.1398718261202;
        Mon, 28 Apr 2014 13:51:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk1sm97118828pac.21.2014.04.28.13.51.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 13:51:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247447>

Dave Borowitz wrote:
> On Mon, Apr 28, 2014 at 1:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Dave Borowitz wrote:

>>> +++ b/Makefile
>>> @@ -35,7 +35,9 @@ all::
>>>  # transports (neither smart nor dumb).
>>>  #
>>>  # Define CURL_CONFIG to the path to a curl-config binary other than the
>>> -# default 'curl-config'.
>>> +# default 'curl-config'. If CURL_CONFIG is unset or points to a binary that
>>> +# is not found, defaults to the CURLDIR behavior, or if CURLDIR is not set,
>>> +# uses -lcurl with no additional library detection.
>>
>> I'm having a little trouble parsing this but don't have any better
>> suggestion.
>
> How about:
> "If CURL_CONFIG is unset or points to a binary that is not found,
> defaults to the CURLDIR behavior. If CURLDIR is not set, this means
> using -lcurl with no additional library detection (other than
> NEEDS_*_WITH_CURL).

Yep, that's clearer.

> [...]
>>> -                             $(error libcurl not detected; try setting CURLDIR)
>>> +                                $(error libcurl not detected or not compiled with static support)
>>
>> Whitespace damage.
>
> Yes, but intentional, because Makefile parsing is weird.
>
> $ echo -e 'ifndef FOO\n\t$(error bad things)\nendif\n\nfoo:\n\ttouch
> foo' > mk1 && make -f mk1 foo
> mk1:2: *** commands commence before first target.  Stop.
> $ echo -e 'ifndef FOO\n  $(error bad things)\nendif\n\nfoo:\n\ttouch
> foo' > mk2 && make -f mk2 foo
> mk2:2: *** bad things.  Stop.

Gah.  Maybe it should be left-justified to avoid accentally breaking
it again.

Thanks.
Jonathan
