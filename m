From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] strtoul_ui: actually report error in case of negative
 input
Date: Wed, 16 Sep 2015 07:20:38 +0300
Message-ID: <20150916042037.GB7806@wheezy.local>
References: <1442181636-27821-1-git-send-email-max@max630.net>
 <vpqr3m1seap.fsf@anie.imag.fr>
 <20150914202647.GA7806@wheezy.local>
 <vpq4miwfa78.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc4DA-0001Z5-P9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 06:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbbIPEUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 00:20:44 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:55896
	"EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750825AbbIPEUn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 00:20:43 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-06.prod.phx3.secureserver.net with 
	id HgLe1r0045B68XE01gLgcU; Tue, 15 Sep 2015 21:20:43 -0700
Content-Disposition: inline
In-Reply-To: <vpq4miwfa78.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277999>

On Tue, Sep 15, 2015 at 08:50:03AM +0200, Matthieu Moy wrote:
> I think it would be better to just return a long to avoid needless
> limitations, but changing the argument to "long" would interfer with
> in-flight topics. Not worth the trouble.

Sure.

> 
> One potential issue with your patch is that you're forbidding the
> interval [2^31, 2^32[ which was previously allowed, both on 32 and 64
> bits. I'm not sure whether we have a use for this in the codebase.

As far as I could see it was used only for file modes. Which
does not need that big numbers.

> This alternative patch is rather ugly to, but I think it is less
> limiting and does not have the "large negative wrapped to positive"
> issue:
> 
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>         char *p;
>  
>         errno = 0;
> +       /* negative values would be accepted by strtoul */
> +       if (strchr(s, '-'))
> +               return -1;
>         ul = strtoul(s, &p, base);
>         if (errno || *p || p == s || (unsigned int) ul != ul)
>                 return -1;
> 
> What do you think?

Explicit rejection of '-' is of course useful addition.

I still find "(unsigned int) ul != ul" bad. As far as I
understand it makes no sense for i386. And even for 64-bit
it's too obscure. In form of "(ul & 0xffffffffL) == 0" it
would be more clear. Or just make explicit comparison with
intended limit, like I did.

Well, actually I don't have strong preferences as long as
"make -C t" does not alarm me with things I did not break.
Maybe somebody else will comment more.

-- 
Max
