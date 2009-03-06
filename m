From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Keep '*' in pattern refspecs
Date: Fri, 6 Mar 2009 12:21:47 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903061157540.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052355480.19665@iabervon.org> <7vsklrt66z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfdlZ-000370-Lq
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 18:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZCFRVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbZCFRVu
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 12:21:50 -0500
Received: from iabervon.org ([66.92.72.58]:56944 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbZCFRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 12:21:49 -0500
Received: (qmail 16677 invoked by uid 1000); 6 Mar 2009 17:21:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 17:21:47 -0000
In-Reply-To: <7vsklrt66z.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112472>

On Fri, 6 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > In order to do anything more capable with refspecs, the first step is
> > to keep the entire input. Additionally, validate patterns by checking
> > for the ref matching the rules for a pattern as given by
> > check_ref_format(). This requires a slight change to make it require
> > the '*' to be at the beginning of a path component.
> 
> I had a brief "Huh?" moment wondering about this "slight change", but at
> this stage it does not change the rule at all ("/*" still must happen at
> the end of the string), so there actually is no change.

Ah, yes. A slight change to the code in refs.c to enforce the rule that 
was enforced previously in remote.c.

> > diff --git a/remote.c b/remote.c
> > index 93fd03d..d0ce4c6 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -722,10 +716,10 @@ int remote_has_url(struct remote *remote, const char *url)
> >  static int name_fits_pattern(const char *key, const char *name,
> >  			     const char *value, char **result)
> >  {
> > -	size_t klen = strlen(key);
> > -	int ret = !strncmp(key, name, klen);
> > +	size_t klen = strchr(key, '*') - key;
> > +	int ret = !strncmp(name, key, klen);
> 
> Any particular reason why the first parameters to strncmp() were swapped?

An artifact of how I cleaned up the series that I didn't notice; I 
originally wrote it from scratch with strncmp, with an arbitrary argument 
order. Then I split out 2/5 using prefixcmp, and 3/5 keeping prefixcmp's 
order, and didn't notice I didn't need the line of diff. So not really.

> >  	if (ret && value) {
> > -		size_t vlen = strlen(value);
> > +		size_t vlen = strchr(value, '*') - value;
> 
> We would want protection from programming error here, to catch keys and
> values without any asterisk.  This comment also applies to [5/5].

Good idea.

> >  		*result = xmalloc(vlen +
> >  				  strlen(name) -
> >  				  klen + 1);
> 

	-Daniel
*This .sig left intentionally blank*
