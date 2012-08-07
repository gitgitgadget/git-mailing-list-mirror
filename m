From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 01/16] Modify cache_header to prepare for other
 index formats
Date: Tue, 7 Aug 2012 14:41:05 +0200
Message-ID: <20120807124105.GA913@tgummerer>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-2-git-send-email-t.gummerer@gmail.com>
 <7v8vds3jkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 14:41:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syj64-0002xq-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 14:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2HGMlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 08:41:10 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33400 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab2HGMlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 08:41:09 -0400
Received: by weyx8 with SMTP id x8so2643846wey.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NUIDhPAFW6qJ7DQrSJ13WRuQPlQc9LoLww0xxlkb1Ak=;
        b=BCcYQltST/9iGHHKpI/ARY1C0k4b6aRXolg0NV8Lr9NFjr38OOER6MU0yebpDal/f7
         ad6bR4Kdgldjpt/mt1Be+wSZyfIVs/W5KAIC7g4Vljpk93VW70jqac3azCzHCu9Xivk/
         VnaSVfGYyuY+dxQrrwBpCXyliwwuV3t9eEiT7UkDQoxIE8PLvgAHl6BV7AyIjuB3Tb22
         BD+Qvm1Znn3GlfOi4pjfRUsb0LQs6olWXh6NWG0KMomFn3gntc/2gUzr/rB0rXIsGKxQ
         nX+r5BlW/I4pl3Dn1uQ+9fpt1YKfCHWTUK6wPl2+zV6I16vInEXvAtdySM7p4zMrB0C0
         tDig==
Received: by 10.217.1.79 with SMTP id m57mr7179052wes.121.1344343268358;
        Tue, 07 Aug 2012 05:41:08 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id k20sm21173685wiv.11.2012.08.07.05.41.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 05:41:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8vds3jkj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203027>

On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > diff --git a/read-cache.c b/read-cache.c
> > index 2f8159f..5d61d92 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1433,7 +1446,7 @@ int read_index_from(struct index_state *istate, const char *path)
> >  
> >  	errno = EINVAL;
> >  	mmap_size = xsize_t(st.st_size);
> > -	if (mmap_size < sizeof(struct cache_header) + 20)
> > +	if (mmap_size < sizeof(struct cache_version_header) + 20)
> >  		die("index file smaller than expected");
> 
> At the design level, I have a large problem with this change.  I
> understand that you wanted to make sure that some versions can lack
> the num-entries word in the header, but then what is the point of
> keeping that "+20" here?  Are all versions of the file format still
> required to have the 20-byte trailing SHA-1 sum over the whole file?

No, index-v5 doesn't have the trailing SHA-1 over the whole file.

> 	Side note: I am actually fine with that "sum at the end"
> 	requirement, but then it needs to be documented what are
> 	assumed to be unomittable and why.
> 
>         I also do not see why v5 *needs* to drop the num-entries
>         word from the header in the first place.

v5 still has the num-entries word, but at a different position.
The +20 however would still be wrong, because of the missing
SHA-1 over the file.

> At the practical level, we used to error out, upon seeing a file
> that claims to be v2 in the header but is too small to hold the
> version header, the number of entries word and the trailing SHA-1
> sum.  We no longer do this and happily call verify_hdr() in the
> following code even when the file is too small, no?

This part is called even before we know what version of the index
we will read, and before the file is mmaped.  The best solution
i think is to drop the check and just call verify_hdr, since it will 
check the checksum anyway and detect the error, while not having
a big cost on a index file that is very small.

> > @@ -1442,11 +1455,13 @@ int read_index_from(struct index_state *istate, const char *path)
> >  		die_errno("unable to map index file");
> >  
> >  	hdr = mmap;
> > +	hdr_v2 =  mmap + sizeof(*hdr);
> >  	if (verify_hdr(hdr, mmap_size) < 0)
> >  		goto unmap;
