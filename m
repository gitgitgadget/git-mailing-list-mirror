From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Fri, 10 Aug 2012 00:54:07 +0200
Message-ID: <20120809225407.GB5127@tommy-fedora.scientificnet.net>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
 <7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:54:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzbcS-0007mC-GK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 00:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929Ab2HIWyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 18:54:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57516 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759874Ab2HIWyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 18:54:14 -0400
Received: by weyx8 with SMTP id x8so623230wey.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sKBG7e/Xd2u4nWBbJ8XVd2/MZQvPr2hY1WLUYojLvzI=;
        b=G5N7NmppAQSbjZ63u/eBtH/5HUCwjWdegbA+Qz0C/4fEFj/LRMop0MR9UcocxUemes
         hID/yYiQo5g1TAEcssJ8Zq3jIFtI8/FBY52G1+SAShZ6M06pp4DONiIAfFivHlGrgCVK
         pyBA6BDEoolKeUwQoxWT8sMezUJB+hH6wW2zDA6vNFcl/TbLT3LZDy/39EOFn1jvzA9R
         98xi7lsaLxN+E0Z0begM4npe9OhSeFp7HMfVMBkAFdzSCOwfpLQd8Ol1fMZmlGo/JfXh
         QT6RpoXSb2KbM2zMRbJLlnSqS+wIC+cxM0zLZoWNliRn8fyoYWpJUY7lgFzIg1cERTsk
         P/dA==
Received: by 10.180.20.204 with SMTP id p12mr450038wie.7.1344552853345;
        Thu, 09 Aug 2012 15:54:13 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id eu4sm4324013wib.2.2012.08.09.15.54.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 15:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203187>

On 08/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >  /* remember to discard_cache() before reading a different cache! */
> >  int read_index_from(struct index_state *istate, const char *path)
> >  {
> > ...
> >  	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> > -	close(fd);
> >  	if (mmap == MAP_FAILED)
> >  		die_errno("unable to map index file");
> >  
> >  	hdr = mmap;
> > -	if (verify_hdr(hdr, mmap_size) < 0)
> > +	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
> >  		goto unmap;
> >  ...
> > +	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
> > +		goto unmap;
> >  
> > +	istate->ops->read_index(istate, mmap, mmap_size, fd);
> > ...
> > +	close(fd);
> 
> This looks utterly wrong.
> 
> You already have mapped the whole thing, so there is nothing to be
> read from fd.  You have everything in-core.  Leaving fd open and
> pass it around looks like it is asking for trouble and confusion.
> 
> If you found that an entry you read halfway has an inconsistent crc,
> and if you suspect that is because somebody else was writing to the
> same index, it is a _sure_ sign that you are not alone, and all the
> entries you read so far to the core, even if they weren't touched by
> that sombody else when you read them, may be stale, and worse yet,
> what you are going to read may be inconsistent with what you've read
> and have in-core (e.g. you may have read "f" before somebody else
> that is racing with you have turned it into a directory, and your
> next read may find "f/d" in the index without crc error).
> 
> One sane way to avoid reading such an inconsistent state may be to
> redo this whole function, starting from the part that calls mmap().
> IOW,
> 
> 	do {
> 		fd = open()
> 		mmap = xmmap(fd);
> 		close(fd);
>                 verify_various_fields(mmap);
>                 status = istate->ops->read_index(istate, mmap, mmap_size));
> 	} while (status == READ_AGAIN);
> 
> I do not think the "pass fd around so that we can redo the mapping
> deep inside the callchain" is either a good idea or necessary.

Thanks, that looks better.  I'll change it for the re-roll.
