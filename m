From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix recursive-merge of empty files with different
 permissions
Date: Thu, 13 Mar 2008 22:28:45 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803132227510.4174@racer.site>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <7vabl2xxun.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 22:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZv0V-0004qY-Be
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 22:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbYCMV2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757561AbYCMV2l
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 17:28:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:43938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757546AbYCMV2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 17:28:40 -0400
Received: (qmail invoked by alias); 13 Mar 2008 21:28:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp008) with SMTP; 13 Mar 2008 22:28:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ARMQvnTpAsHeCcadqbv1eDOX/YEnXBvAssX9TgK
	kVpD6MEGYZQVY4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabl2xxun.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77140>

Hi,

On Thu, 13 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/builtin-merge-file.c b/builtin-merge-file.c
> > index adce6d4..cde4b2c 100644
> > --- a/builtin-merge-file.c
> > +++ b/builtin-merge-file.c
> > @@ -57,7 +57,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
> >  
> >  		if (!f)
> >  			ret = error("Could not open %s for writing", filename);
> > -		else if (fwrite(result.ptr, result.size, 1, f) != 1)
> > +		else if (result.size &&
> > +				fwrite(result.ptr, result.size, 1, f) != 1)
> >  			ret = error("Could not write to %s", filename);
> >  		else if (fclose(f))
> >  			ret = error("Could not close %s", filename);
> 
> Lol.  We are dealing with N-byte quantity so we send one record of length
> N and make sure we processed one record, and it does not work when N is
> zero.
> 
> We could instead send N records of size 1 and make sure we processed N
> records to lose the conditional instead, but the patch avoids unnecessary
> call to fread/fwrite so that is good.  Thanks.
> 
> It felt funny because my current bedtime reading happens to be "Zero: The
> Biography of a Dangerous Idea (ISBN 0140296476)".

Heh.

> > diff --git a/xdiff-interface.c b/xdiff-interface.c
> > index bba2364..61dc5c5 100644
> > --- a/xdiff-interface.c
> > +++ b/xdiff-interface.c
> > @@ -152,8 +152,8 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
> >  	if ((f = fopen(filename, "rb")) == NULL)
> >  		return error("Could not open %s", filename);
> >  	sz = xsize_t(st.st_size);
> > -	ptr->ptr = xmalloc(sz);
> > -	if (fread(ptr->ptr, sz, 1, f) != 1)
> > +	ptr->ptr = xmalloc(sz ? sz : 1);
> > +	if (sz && fread(ptr->ptr, sz, 1, f) != 1)
> >  		return error("Could not read %s", filename);
> >  	fclose(f);
> >  	ptr->size = sz;
> 
> Do you need to actually allocate ptr->ptr when sz is zero, instead of
> setting it to NULL, like:
> 
> 	sz = xsize_t(st.st_size);
> 	ptr->size = sz;
>         if (!sz)
>         	ptr->ptr = NULL;
> 	else {
>         	ptr->ptr = xmalloc(sz);
> 		if (fread(ptr->ptr, 1, sz, f) != sz)
> 			return error("Could not read %s", filename);
> 	}
> 	fclose(f);

I was going for the safe option.  In theory, you are right, but I cannot 
really be sure that e.g. a memcpy() with size 0 will not access the source 
pointer at all.

Ciao,
Dscho
