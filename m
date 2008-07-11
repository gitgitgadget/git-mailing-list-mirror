From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Fri, 11 Jul 2008 07:58:20 -0700
Message-ID: <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
	 <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
	 <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
	 <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
	 <alpine.DEB.1.00.0807101526380.18205@racer>
	 <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
	 <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHK5g-0007Xi-OK
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 16:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYGKO6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 10:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbYGKO6W
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 10:58:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:44250 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbYGKO6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 10:58:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4447192rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=zGSNiQQmZRNwIpQX/jnls16wAiX2OOu6applgoj2jnw=;
        b=N+tw+EeIh3tS2JYJNQJLas/VQce/9P8da4i6yL2cYBHMXBgS3c/Ua7iRSef7I4FjkZ
         /bg9ep9qzvgpOhEeJuh7UCgtfFHrLNoYkzyowneQ85ATmrzz2OxMLZbNBGoP68Oq1Ca0
         RyLAaoGE7EWfWBTYwvXrddclPuCfe2mw/1djM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=fzLUUiDVLh9dCUm/IdMoB+qZiFKSLjFHhDRLXpWQ2IYR9CTC2KG2CWfgM/P8fGhE46
         3TtDzVEpqVuQv30/cPWdkaBN3Q/0f6+GerthEKLHC8BrqjOeQy9mm1MjfT4WMfM5XfDR
         BAZhlXQ4mYbreBh96E6GFZ8uGTkuCHyBos+34=
Received: by 10.114.179.1 with SMTP id b1mr912810waf.1.1215788300761;
        Fri, 11 Jul 2008 07:58:20 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Fri, 11 Jul 2008 07:58:20 -0700 (PDT)
In-Reply-To: <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: b536aa0269573f1e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88125>

On Thu, Jul 10, 2008 at 11:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Geoffrey Irving" <irving@naml.us> writes:
>
>>>> Oops: avoiding the infinite loop only requires reading expected O(1)
>>>> entries on load, so I can fix that if you like.  It would only be all of
>>>> them if it actually did detect the infinite loop.
>>>
>>> I have to admit that you lost me there.  AFAIR the patch-id cache is a
>>> simple commit->patch_id store, right?  Then there should be no way to get
>>> an infinite loop.
>>
>> If every entry is nonnull, find_helper loops forever.
>
> Isn't it sufficient to make this part check the condition as well?
>
> +       if (cache->count >= cache->size)
> +       {
> +               warning("%s is corrupt: count %"PRIu32" >= size %"PRIu32,
> +                       filename, cache->count, cache->size);
> +               goto empty;
> +       }
>
> At runtime you keep the invariants that hashtable always has at most 3/4
> full and whoever wrote the file you are reading must have honored that as
> well, or there is something fishy going on.

Good point.  There's no reason not to check the 3/4 condition.  It
isn't sufficient to avoid the infinite loop, though, since we don't
verify that count is accurate.

Another route would to eliminate the count field entirely, and replace
the count >= size/4*3 check with a statistical one based on the
entries seen so far.  The main advantage of that would be to make
incremental writes simpler by avoiding the need to update the header.
The disadvantage is that there would be a small chance that the map
would grow in size despite being almost empty.  Thoughts on whether we
should do that?

>>> Besides, this is a purely local cache, no?  Never to be transmitted...  So
>>> not much chance of a malicious attack, except if you allow write access to
>>> your local repository, in which case you are endangered no matter what.
>>
>> Yep, that's why it's only a hole in quotes, and why I didn't fix it.
>
> You might want to protect yourself against file corruption, though.
> Checksumming the whole file and checking it at opening defeats the point
> of mmap'ed access, but at least the header may want to be checksummed?

Okay.  I imagine I should use sha1 as the sum?

Geoffrey
