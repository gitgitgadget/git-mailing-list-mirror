From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v6 1/4] config: add support for http.<url>.* settings
Date: Fri, 19 Jul 2013 16:40:27 -0700
Message-ID: <7C9C0DA4-9334-4870-95FD-CF32396753A5@gmail.com>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79> <296e6ff588bb131a7e8274738d4378c@f74d39fa044aa309eaea14b9f57fe79> <7va9liuxbv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 01:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0KHr-0000tv-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab3GSXkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:40:32 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59833 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab3GSXkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:40:31 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so4955049pbc.32
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=x2Xw+WR2Uq1tmqX18HWE5muNrWstvpk1sM5x+SnHYuc=;
        b=pUGe9UEu+m7e/lxRDLpQISfY5isV6eFZyvyTiRb0x8E1DH+Fs+UNaBlO23f68irwHk
         WR4ol6WiePsvSKAqXDoFntowMJ8LpHL+huTsjeVGX8iTPAAyAVG4n/jaEw2pdpZIpMo3
         YLF0NNQ/J0vj2DMBCWGc8LKcdpas2km4ui7G89rfHGuhivPcdefv5iX6uV3u7/QZyIWn
         +TVbvuo+37vA0X6JB9ou9nj1aUjTNlMFhoz747yrhLYDfsrm4ORrsv1O5UV6BSEpm8iK
         nq8KG/TUIMyFRt5DfYxvtyE/dO7OrDJkoowBe1h94ZPWhi49Xssh5t0LafuJLRx/WIur
         OCEA==
X-Received: by 10.66.249.202 with SMTP id yw10mr20339253pac.145.1374277230386;
        Fri, 19 Jul 2013 16:40:30 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qu10sm21837865pbb.12.2013.07.19.16.40.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:40:29 -0700 (PDT)
In-Reply-To: <7va9liuxbv.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230866>

On Jul 19, 2013, at 13:08, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> @@ -337,7 +472,7 @@ void http_init(struct remote *remote, const  
>> char *url, int proactive_auth)
>>
>> 	http_is_verbose = 0;
>>
>> -	git_config(http_options, NULL);
>> +	git_config(http_options, (void *)url);
>
> Can http_init() be called more than once?  max-matched-len (and
> leter user-matched as well) is initialized to zero at the link time,
> and never reset after it is used for matching the configuration file
> entries with a single URL.
>
> If this function is called more than once, the code needs to
> memset(0) the array(s), don't it?

The http_init() function is never called more than once.  It's called  
from http_fetch.c, http_push.c, and remote-curl.c exactly once in the  
main() function, so no worries.  However, I do like your idea of  
bundling them all up into an on-stack variable, I just didn't want to  
stick those arrays on the stack if it's not necessary it and it seems  
like it isn't.

I think I will just go ahead and add the memset to http_init to avoid  
unexpected breakage if something in the future actually does make  
multiple http_init()/http_cleanup() calls during its lifetime.

> [...] In any case, you no longer have to cast the second
> parameter of git_config to (void *) only to defeat constness ;-)

That goes away in part 4/4 anyhow. :)
