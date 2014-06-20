From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v4] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 18:55:11 -0700
Message-ID: <20140620015511.GB2481@hudson.localdomain>
References: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
 <1403165242-16849-2-git-send-email-jmmahler@gmail.com>
 <xmqqionwhj54.fsf@gitster.dls.corp.google.com>
 <CAPc5daW5hsKeJsG8+2nxFzFL9gMnLR2gMBXG5__dhSCLKkBWmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 03:55:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxo32-0004QF-2p
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 03:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbaFTBzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 21:55:16 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33388 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbaFTBzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 21:55:15 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so2518819pbb.36
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DY68S0ErkQDy9GTf294VX9SvxVwxwdv1WxI6CBcb46o=;
        b=pL+XTMKobKMmfwKuh5EMgSXZPuwPjNscu2549N5QSQY9GIJyBJGR17TIlplmA5W2mp
         O/E48D3gxA9cqLJ92969lS8jrCuIZqg2HcKsZz07NqBb4ZZgqA5iH5pawzQmrQO6xAE4
         94TQhoUgPdqwJFYO5zJnURReI93jpfqn62XX6m8C5IEqZ/4YPX0u/suJ6FQG6BVg5wGB
         D+uOvozjxomieUYAugzzvH9TPtUmDO0xWtqso/JT/aCnYP+yRhYqQt0ck5rR2jo0LWuI
         fdevWnx5aXXUIn+6FaeyqIPlQPolulr5WCnEINqWIzbFWRgXhwjhzlu9CmUhjaCXIGaR
         FCYg==
X-Received: by 10.68.173.65 with SMTP id bi1mr440797pbc.130.1403229314572;
        Thu, 19 Jun 2014 18:55:14 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ys1sm35099780pab.7.2014.06.19.18.55.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 18:55:13 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPc5daW5hsKeJsG8+2nxFzFL9gMnLR2gMBXG5__dhSCLKkBWmA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252203>

Junio,

On Thu, Jun 19, 2014 at 11:29:21AM -0700, Junio C Hamano wrote:
> On Thu, Jun 19, 2014 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > You chose to use the one that loses the information by unifying
> > these two into the variant that only returns -1/0/+1.  We know that
> > it does not matter for the current callers, but is it expected that
> > no future callers will benefit by having the magnitude information?
> 
> Heh, I was being silly, partly fooled by your reference to
> "magnitude".
> 
> You are not losing information at all, because the caller cannot
> tell if the return value came from an earlier memcmp(), whose only
> guarantee is that the sign of the returned value is all that
> matters, or from the later subtraction between lengths.
> 
> So unifying to the -1/0/+1 variant is entirely justifiable.  It is
> just your rationale was a bit misleading.
> 
>     We often represent our strings as a counted string, i.e. a pair of
>     the pointer to the beginning of the string and its length, and the
>     string may not be NUL terminated to that length.
> 
>     To compare a pair of such counted strings, unpack-trees.c and
>     read-cache.c implement their own name_compare() functions
>     identically.  In addition, cache_name_compare() function in
>     read-cache.c is nearly identical.  The only difference is when one
>     string is the prefix of the other string, in which case the former
>     returns -1/+1 to show which one is longer and the latter returns the
>     difference of the lengths to show the same information.
> 
>     Unify these three functions by using the implementation from
>     cache_name_compare().  This does not make any difference to the
>     existing and future callers, as they must be paying attention only
>     to the sign of the returned value (and not the magnitude) because
>     the original implementations of these two functions return values
>     returned by memcmp(3) when the one string is not a prefix of the
>     other string, and the only thing memcmp(3) guarantees its callers is
>     the sign of the returned value, not the magnitude.
> 
> or something like that, perhaps?

Yes, that looks good.  It is a bit clearer than my message.  I like how
you used "the prefix of the other string" to describe when the two
functions behave differently.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
