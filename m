From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 15:33:13 -0700
Message-ID: <CAGZ79kYNR6JNU=vVL_Pp0axFX_cpu1Bi5x226GUbeFdum9wkZg@mail.gmail.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
	<20150501195017.GA3493@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 02 00:34:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJVQ-0005Gh-UY
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbbEAWdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:33:15 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36409 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbEAWdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:33:14 -0400
Received: by iebrs15 with SMTP id rs15so98124198ieb.3
        for <git@vger.kernel.org>; Fri, 01 May 2015 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q0FZTc91Gd3k9mHKwMyUFouvJTTVF71s8AfG9fQ/VGw=;
        b=XBUEI9J/FgLoZL2QWm7qBHg2nij7RgWubdjTYH6rtSa94jLLV9JxNysxNfhUY0TYlG
         TRccx/7uNH7O994BOABAIWc9HdKrIiex2cMyN+ooce4Z2XTAq/TsqEhEjg8Ith7VsRw4
         B8sKE7w1ctevPWxpTix+KpVw+oTtyvgEo3tXsHbWtUbmLR5f2MRXTVOWo+kfKo9mBP7q
         7Y21MP6AHznbsFd1+WwCbPbbXKjhPwUz3PgSL3deoyeFDqAvGkcn08v5gY3XQb1yeuoX
         lrzzFeVpwkFyiXJiBbzTfOYa+bgMnLZBho03n3TAO1Loe8eExb601bKTFuNgOA/mwfK1
         VcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q0FZTc91Gd3k9mHKwMyUFouvJTTVF71s8AfG9fQ/VGw=;
        b=bmTdM/1MfNmQkHBFeK7TKngow0UMopCNBLChUAt5NrA06ztHEISG1ImbubtQDCbw19
         QoUPKpMO6T/jNsxRK/L53/kTYHcU8erRPEu0sIM4UnFQK/NLFEnB2JxCIpnvX0kLwTb8
         9TfxfpzzUdRFaiYuLB7lH2G7y5+us8NTpGcC1Id+9AOSRFKgFcR7V/m8iaPlyc4CNlqt
         bezPy0DSnQq6+vJ2ptOglWasu+5LFpwcTJRutR4yBg1oD+A1ABA8H2/mP7Pd8X/MCXp6
         3lWg14kAMGDGqmlPTe4SUKBvh+zdRc4xo0Q21N8fX2/BIe/hNoEho6pNcGj60mxbyy61
         94cA==
X-Gm-Message-State: ALoCoQn1I+H/QBkGp2r7jRHtWYFcaqFi9xGMMD8R8kCBDxtqYGoOMiA8IBlgM8E7ox62tcr+ih5h
X-Received: by 10.50.50.209 with SMTP id e17mr328787igo.37.1430519593659; Fri,
 01 May 2015 15:33:13 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 15:33:13 -0700 (PDT)
In-Reply-To: <20150501195017.GA3493@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268181>

On Fri, May 1, 2015 at 12:50 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 01, 2015 at 12:28:27PM -0700, Stefan Beller wrote:
>
>> It's safe to free the char pointer `p` unconditionally.
>>
>> The pointer is assigned just 2 lines earlier as a return from
>> prefix_path, which allocates new memory for its return value.
>>
>> Then it is used in checkout_file, which passes the pointer on to
>> cache_name_pos and write_tempfile_record, both of which do not store
>> the pointer in any permanent record.
>>
>> So the condition on when to free the pointer is just "always".
>
> That of course makes me wonder why somebody would write this in the
> first place. :)
>
> It looks like it comes from be65e7d (Fix users of prefix_path() to
> free() only when necessary, 2006-05-07), which claims that prefix_path
> sometimes does not allocate. When did that change? Looks like maybe
> d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
> 2008-01-28), but it certainly is the case now.
>
> Probably all of the other sites touched by be65e7d could use the same
> treatment.

I looked around, just as Eric suggested as well and found those too.
I don't think I'll track down the history of when this change became possible,
but I'd rather point to (f5114a40c0d0, 2011-08-04, git-check-attr:
Normalize paths),
where the result of prefix_path is freed unconditionally already.

>
> -Peff
