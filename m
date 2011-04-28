From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 14:18:51 +0200
Message-ID: <BANLkTikq=oZ4uk-MN_zOXmdKNq7O3XtJhQ@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <20110428101902.GA17257@elte.hu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQBh-0006LA-6h
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab1D1MTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 08:19:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42663 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab1D1MTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 08:19:11 -0400
Received: by pzk9 with SMTP id 9so1631429pzk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=IdsGx6dGz01vj+1wJiJFRf6FJ0GbYzJg4JEJPfuXuoc=;
        b=ST2nRxWLHsX4VU06VVlrGZzB0sUbOlX6ETuKmRG0crtYnwdbDGuquY/4vTMOrcdt6l
         GvYYHtpzVA4TCBCbEv+xWkeeZ03jDjsz4gyzOKByKrGFppxd95rwPPBlvtAH8aFVD1I7
         cEm7Ouf8YSthe9RbmZoUxJ9UWQQoZniWAr/y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=xtO6ZHAJzae1NZU/nmSOUSUNNvjeuj9ImUFBYlFbCztYsga1BxJHZWYPJMg8XeP2EV
         xO60LZeoRXmnc1WazP1ITmZ32vegx7MAwmwEBRbBlA52biFuMeteNsQRgQfm9n61JjOW
         1efZ/18tIo/8OCf3nfnG2/EuQrbsPIe4P6CHs=
Received: by 10.68.51.98 with SMTP id j2mr3460131pbo.288.1303993151064; Thu,
 28 Apr 2011 05:19:11 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Thu, 28 Apr 2011 05:18:51 -0700 (PDT)
In-Reply-To: <20110428101902.GA17257@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172360>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
>
> * Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
>> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
>> >
>> > * Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> >
>> >> > Secondly, the combined speedup of the cached case with my two patches
>> >> > appears to be more than 30% on my testbox so it's a very nifty win from two
>> >> > relatively simple changes.
>> >>
>> >> That speed-up was on ONE test vector, no? There are a lot of other uses of
>> >> hash-comparisons in Git, did you measure those?
>> >
>> > I picked this hash function because it showed up in the profile (see the
>> > profile i posted). There's one other hash that mattered as well in the profile,
>> > see the lookup_object() patch i sent yesterday.
>>
>> My point was that the 30% improvement was in "git gc", which is not
>> the only important use-case. How does this affect other git commands?
>
> In a followup mail i measured git fsck, which showed a speedup too. (despite
> being mostly dependent on external libraries to do most of the processing)
>
> If you'd like to see other things tested please suggest a testcase that you
> think uses these hashes extensively, i don't really know what the slowest (and
> affected) Git commands are - git gc is the one *i* notice as being pretty slow
> (for good reasons).
>

You only seem to test cases that iterate through the entire repo, and
I suspect that they might not be representative for all affected
use-cases.

So I'd love to see something like just timing of something like "git
diff > /dev/null" (and some other goodies) in a hot-cache repo with
and without your patch. Perhaps even timing of running the test-suite,
as this touches most git-commands...

>> We can't. The compiler decides the alignment of variables on the stack. Some
>> compilers / compiler-setting pairs might align char-arrays, while others
>> might not.
>
> Even if that were true it can be solved: you'd need to declare the sha1 not as
> a char array but as a u32 * array or so. We do have control over the alignment
> of data structures, obviously.

True, but that's a very intrusive change. And it's not a bug-fix as
you indicated :)

>> Like I said above, it can happen when allocated on the stack. But it can also
>> happen in malloc'ed structs, or in global variables. An array is aligned to
>> the size of it's base member type. But malloc does worst-case-allignment,
>> because it happens at run-time without type-information.
>
> Well, should we ready be ready to throw up our hands as if we didnt have
> control over the alignment of objects and have to accept suboptimal code as a
> result? We do have control over that.

Yes, but it's better to pick low-hanging fruits and see if we can get
99% of the performance increase without having to change all of the
code. See my previous e-mail (Message-ID:
<BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>) for what I
suspect will do the trick without causing problems.

> In any case, i'll retract the null case as it really isnt called that often in
> the tests i've done - updated patch below - it simply falls back on to hashcmp.

Nice, I think this makes sense. I already stole that hunk and
incorporated that in the diff I posted ;)
