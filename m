From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 09/16] Read index-v5
Date: Wed, 8 Aug 2012 22:44:35 +0200
Message-ID: <20120808204435.GC25671@tommy-fedora.surfnet.iacbox>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-10-git-send-email-t.gummerer@gmail.com>
 <7v4nog1twd.fsf@alter.siamese.dyndns.org>
 <20120808074138.GD867@tgummerer.surfnet.iacbox>
 <7vr4rhtjkd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:45:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzD8A-0003pS-6g
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241Ab2HHUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:44:40 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40314 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2HHUoj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:44:39 -0400
Received: by wibhq12 with SMTP id hq12so3625343wib.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lrluWKQM+zNYllVny6tKRm5Z3StKu9HRd/fh0jNaBPM=;
        b=GLnFRfOouuSURPwOrqtP9NHF1AwETluhuq5yK1xv2kBQa4vn2ni8TFFlTj0wIyTeOt
         C1+ut9BIPrr/ChfblRXVS5U+/GyA90+w8/NXMt+n55V7Jlf96MGd7ru8XrwchyKZ2EL4
         3nNnYTJ8h2Tpw2gv34vVtfP+HVR80g8eaZAMkf4yOywGMtbspqNYFOXz8vibiWsJL/aC
         XQ/WTwuW4IITjdIec26qJ9NbPrBL+wJlgcoJKdqdnzyltt4xYsg+dyn2Ix3VX2yG03nT
         HsLxCmGM8x4zDfLjMivQkjEJPfamfyMkIURDhSQTyZUsri9fd6O87vHp4z7OQ16WEjTs
         /OyQ==
Received: by 10.180.81.133 with SMTP id a5mr639416wiy.17.1344458677789;
        Wed, 08 Aug 2012 13:44:37 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id j6sm10428283wiy.4.2012.08.08.13.44.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 13:44:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr4rhtjkd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203125>



On 08/08, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> > +	name = (char *)mmap + *dir_offset;
> >> > +	beginning = mmap + *dir_table_offset;
> >> 
> >> Notice how you computed name with pointer arithmetic by first
> >> casting mmap (which is "void *") and when computing beginning, you
> >> forgot to cast mmap and attempted pointer arithmetic with "void *".
> >> The latter does not work and breaks compilation.
> >> 
> >> The pointer-arith with "void *" is not limited to this function.
> > ...
> > I've used the type of the respective assignment for now. e.g. i have
> > struct cache_header *hdr, so I'm using
> > hdr = (struct cache_header *)mmap + x;
> 
> You need to be careful when rewriting the above to choose the right
> value for 'x' if you go that route (which I wouldn't recommend).
> 
> With
> 
>     hdr = ptr_add(mmap, x);
> 
> you are making "hdr" point at x BYTES beyond mmap, but
> 
>     hdr = (struct cache_header *)mmap + x;
> 
> means something entirely different, no?  "hdr" points at x entries
> of "struct cache_header" beyond mmap (in other words, if mmap[] were
> defined as "struct cache_header mmap[]", the above is saying the
> same as "hdr = &mmap[x]").
> 
> I think the way you casted to compute the value for the "name"
> pointer is the (second) right thing to do.  The cast (char *)
> applied to "mmap" is about "mmap is a typeless blob of memory I want
> to count bytes in.  Give me *dir_offset bytes into that blob".  It
> is not tied to the type of LHS (i.e. "name") at all.  The result
> then needs to be casted to the type of LHS (i.e. "name"), and in
> this case the types happen to be the same, so you do not have to
> cast the result of the addition but that is mere luck.
> 
> The next line is not so lucky and you would need to say something
> like:
> 
>     beginning = (uint32_t *)((char *)mmap + *dir_table_offset);
> 
> Again, inner cast is about "mmap is a blob counted in bytes", the
> outer cast is about type mismatch between a byte-address and LHS of
> the assignment.

This is what I tried in v3 of the series, but it didn't seem quiet
right.

> If mmap variable in this function were not "void *" but something
> more sane like "const char *", you wouldn't have to have the inner
> cast to begin with, and that is why I said the way you did "name" is
> the second right thing.  Then you can write them like
> 
>     name = mmap + *dir_offset;
>     beginning = (uint32_t *)(mmap + *dir_offset);
> 
> After thinking about this, the ptr_add() macro might be the best
> solution, even though I originally called it as a band-aid.  We know
> mmap is a blob of memory, byte-offset of each component of which we
> know about, so we can say
> 
>     name = ptr_add(mmap, *dir_offset);
>     beginning = ptr_add(mmap, *dir_offset);
> 
> Hmmm..

I start to think so too. Casting the mmap variable to "const char *"
in the method call doesn't feel right to me, even though it would work.
Unless there are any objections I'll use ptr_add in the next version.
