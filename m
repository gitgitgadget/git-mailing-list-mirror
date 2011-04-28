From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 04:31:21 -0500
Message-ID: <20110428093120.GA377@elie>
References: <20110427225114.GA16765@elte.hu>
 <20110427231748.GA26632@elie>
 <20110428063625.GB952@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:31:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNZP-0004Ee-OB
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab1D1Jb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:31:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64498 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab1D1Jb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:31:27 -0400
Received: by iwn34 with SMTP id 34so2059604iwn.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dtFj/MdjPmO24ETImTU/mf4smssiGGHlvJ0X/SbaEUA=;
        b=o4B/q7PcBzmUuXKU1CqXXBDE6SSA2n0isOrSKIkzQDwUwzGwiT0cnFfaafVr/jm9OC
         CJ6GCWJ2Wtf/IFj+t85KOPvfmK1H7t7HpgD59lNbFRnhmjsOGbOR85cXI9ivI9xP3Y4V
         uNA6QCIdZ94BNHNDO2xQ2E7GryVvoDifhP/aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V6oNoURwg9MNMYU4GVkW2PQ3u6QDeynrfHQJwbo4h33X7AfdF12un0dNuAxNeFp7Al
         A5AVcTAMXqjck5+G3hRIB/eQl2xc3dCQHcqg85t3pI0BQxnYurOLcCqLPDfc2O4QwDQu
         zy5Jb0WYxue9Rc39qAMePsqYRga3zMSNlTyiA=
Received: by 10.42.157.7 with SMTP id b7mr3959619icx.427.1303983086679;
        Thu, 28 Apr 2011 02:31:26 -0700 (PDT)
Received: from elie (adsl-68-255-106-84.dsl.chcgil.ameritech.net [68.255.106.84])
        by mx.google.com with ESMTPS id 19sm652652ibx.52.2011.04.28.02.31.24
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 02:31:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110428063625.GB952@elte.hu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172331>

Ingo Molnar wrote:
> * Jonathan Nieder <jrnieder@gmail.com> wrote:

>> E.g., how would something like
>>
>> 	const unsigned int *start1 = (const unsigned int *) sha1;
>> 	const unsigned int *start2 = (const unsigned int *) sha2;
>>
>> 	if (likely(*start1 != *start2)) {
>> 		if (*start1 < *start2)
>> 			return -1;
>> 		return +1;
>> 	}
>> 	return memcmp(sha1 + 4, sha2 + 4, 16);
>>
>> perform?
>
> Note that this function wont work on like 99% of the systems out there due to 
> endianness assumptions in Git.

Yes, I was greedy and broke the semantics, and my suggestion was
nonsensical for other reasons (e.g., alignment), too.  I should have
written something like:

	if (likely(*sha1 != *sha2)) {
		if (*sha1 < *sha2)
			return -1;
		return +1;
	}
	return memcmp(sha1, sha2, 20);

since speeding it up 255/256 times seems good enough already.

> Also, your hypothetical smart compiler would recognize the above as equivalent 
> to memcmp(sha1, sha2, 20) and could rewrite it again - so we'd be back to 
> square 1.

True.  The real point is a "likely" to explain to human readers what
is happening.

> Having said that, it would be nice if someone could test these two patches on a 
> modern AMD box, using the perf stat from here:
>
>   http://people.redhat.com/mingo/tip.git/README
>
>   cd tools/perf/
>   make -j install
>
> and do something like this to test git gc's performance:
>
>   $ perf stat --sync --repeat 10 ./git gc
>
> ... to see whether these speedups are generic, or somehow Intel CPU specific.

Sounds like fun.  Will try to find time to play around with this in
the next few days.

> Well i messed up endianness in an early version of this patch and 'git gc' was
> eminently unhappy about it! I have not figured out which part of Git relies on
> the comparison result though - most places seem to use the result as a boolean.

I think hashcmp is used to run binary searches within a packfile
index.  Thanks for explaining.

Regards,
Jonathan
