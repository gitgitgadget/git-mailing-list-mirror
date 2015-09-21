From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 54/67] color: add overflow checks for parsing colors
Date: Mon, 21 Sep 2015 09:56:06 -0700
Message-ID: <xmqqlhbzbtjt.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160703.GB29753@sigill.intra.peff.net>
	<CAPig+cQUwsDfL-epJYy+4xoG2-GfDfhb3mH=7WAzYbsea-sXDA@mail.gmail.com>
	<20150918190116.GA3932@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:56:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4Nz-0004s4-1C
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 18:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbbIUQ4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 12:56:10 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36353 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbbIUQ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 12:56:08 -0400
Received: by padbj2 with SMTP id bj2so11727965pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TY+fnM4PBeWwx3vO76yDeifWo4fuZnBHnql337KJSAA=;
        b=xAYteLr/k3s5W0IqgSS5bVSXuketIUPt9Y6VzuAkxN23UURdA+OECG+Y7BvQCyyBhG
         Hn+XAJnO7hNTlfsWQw4nMnBXymiaZvi038zqQe2X+LOit6+chh8v5hjBqCAUhX95vuFS
         jpe9eoNR9SM9EnKMycfsKkuE+02DGUplmaeUrG8LXgLLIfFs8uMMjCh13XYYlNc2Z3yJ
         AAH+L5EqCNRHyFX6bUu2yZ5OpTVj1U+c3gjrbVHYZyhckWFN6cRufJstYpJzYD7xRDtp
         085NQ9gTa+HjqCHK3Yguu+YVjTXvMntUn7DqScLNXlEGFNqXFdby05aRtYdnzp9RQLXw
         El7A==
X-Received: by 10.66.164.132 with SMTP id yq4mr26273621pab.8.1442854568082;
        Mon, 21 Sep 2015 09:56:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id w5sm25486054pbs.31.2015.09.21.09.56.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 09:56:07 -0700 (PDT)
In-Reply-To: <20150918190116.GA3932@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 18 Sep 2015 15:01:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278310>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 18, 2015 at 02:54:11PM -0400, Eric Sunshine wrote:
>
>> > @@ -224,12 +227,18 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>> >                         goto bad;
>> >         }
>> >
>> > +#define OUT(x) do { \
>> > +       if (dst == end) \
>> > +               die("BUG: color parsing ran out of space"); \
>> > +       *dst++ = (x); \
>> > +} while(0)
>> 
>> Hmm, can we have an #undef OUT before the #define OUT(...), or choose
>> a less conflict-likely name? In particular, I'm thinking about
>> preprocessor namespace pollution arising from sources out of our
>> control, such as was the case with 414382f (ewah/bitmap: silence
>> warning about MASK macro redefinition, 2015-06-03).
>
> Sure. I wouldn't think any headers would be dumb enough to define
> something as short and common as OUT. But then I would have said the
> same about MASK. ;)
>
> I added an #undef, and I added an #undef at the end of the function, as
> well (to clean up after ourselves).

A tangent.  quote.c does EMIT semi-carefully, but gets sloppy when
it does a similar thing for EMITBUF.

Perhaps it should go to somebody's low-hanging-fruit list ;-)
