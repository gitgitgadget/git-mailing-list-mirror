From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/5] Use the matching function to generate the match
 results
Date: Fri, 6 Mar 2009 12:21:31 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903061151130.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052355240.19665@iabervon.org> <7vy6vjt679.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfdlI-0002zp-CV
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 18:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbZCFRVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 12:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbZCFRVe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 12:21:34 -0500
Received: from iabervon.org ([66.92.72.58]:56942 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbZCFRVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 12:21:33 -0500
Received: (qmail 16658 invoked by uid 1000); 6 Mar 2009 17:21:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 17:21:31 -0000
In-Reply-To: <7vy6vjt679.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112471>

On Fri, 6 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This puts all of the interpretation of the pattern representation in a
> > single function for easy manipulation.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> I think this makes sense, but the helper function is not about "does this
> name match the pattern?" boolean anymore, and may want to be renamed to
> e.g. map_name_with_pattern().

I'll just make it "match_name_with_pattern" from the beginning, which 
describes what it does whether or not the later arguments are NULL.

> > -static int name_fits_pattern(const char *key, const char *name)
> > +static int name_fits_pattern(const char *key, const char *name,
> > +			     const char *value, char **result)
> >  {
> > -	int ret = !prefixcmp(key, name);
> > +	size_t klen = strlen(key);
> > +	int ret = !strncmp(key, name, klen);
> > +	if (ret && value) {
> > +		size_t vlen = strlen(value);
> > +		*result = xmalloc(vlen +
> > +				  strlen(name) -
> > +				  klen + 1);
> > +		strcpy(*result, value);
> > +		strcpy(*result + vlen, name + klen);
> > +	}
> 
> > @@ -1080,11 +1085,9 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
> >  
> >  		} else {
> >  			const char *dst_side = pat->dst ? pat->dst : pat->src;
> > -			dst_name = xmalloc(strlen(dst_side) +
> > -					   strlen(src->name) -
> > -					   strlen(pat->src) + 2);
> > -			strcpy(dst_name, dst_side);
> > -			strcat(dst_name, src->name + strlen(pat->src));
> > +			if (!name_fits_pattern(pat->src, src->name,
> > +					       dst_side, &dst_name))
> > +				die("Didn't think it matches any more");
> >  		}
> 
> Hmm, we have been overallocating and nobody noticed so far?

Probably. I suspect that we're making sure to have room for the '\0's at 
the end of both the base and the part that matches the star. Looks like 
it's still how Alex Riesen wrote it, sort of arbitrarily one byte longer 
than the similar allocation.

	-Daniel
*This .sig left intentionally blank*
