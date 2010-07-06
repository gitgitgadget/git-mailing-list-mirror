From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 2/4] teach ref iteration module about submodules
Date: Tue, 6 Jul 2010 16:40:19 +0200
Message-ID: <20100706144010.GA50570@book.hvoigt.net>
References: <cover.1277923843.git.hvoigt@hvoigt.net> <26d63936d5a71de6a8e8aa823a69ddda8b999e4b.1277923844.git.hvoigt@hvoigt.net> <7vvd9045q3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 16:40:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9K5-0002uy-L1
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0GFOkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 10:40:22 -0400
Received: from darksea.de ([83.133.111.250]:33702 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751126Ab0GFOkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 10:40:21 -0400
Received: (qmail 12781 invoked from network); 6 Jul 2010 16:40:18 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jul 2010 16:40:18 +0200
Content-Disposition: inline
In-Reply-To: <7vvd9045q3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150356>

Hi,

On Wed, Jun 30, 2010 at 01:37:24PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > +char *git_path_submodule(const char *path, const char *fmt, ...)
> > +{
> > +...
> > +	strbuf_addch(&buf, '/');
> > +
> > +	strncpy(pathname, buf.buf, PATH_MAX);
> > +	if (pathname[PATH_MAX-1] != '\0')
> > +		return bad_path;
> 
> This may not be wrong per-se, but having strncpy() NUL-pad the remainder
> of the buffer only because you want to check overlong path by inspecting
> pathname[PATH_MAX-1] sounds somewhat stupid, no?  Your buf.len knows how
> long the path is already at this point, doesn't it?

Well I needed to copy it to pathname anyway so I thought this would be
the simplest check. But you are right about the unnecessary padding. What
do you think about rephrasing this as


	if (buf.len >= PATH_MAX)
		return bad_path;

	memcpy(pathname, buf.buf, buf.len);

?

> > @@ -322,11 +352,12 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
> >  	for_each_rawref(warn_if_dangling_symref, &data);
> >  }
> >  
> > -static struct ref_list *get_loose_refs(void)
> > +static struct ref_list *get_loose_refs(const char *submodule)
> >  {
> > -	if (!cached_refs.did_loose) {
> > -		cached_refs.loose = get_ref_dir("refs", NULL);
> > +	if (!cached_refs.did_loose || cached_refs.submodule != submodule) {
> 
> Do you really mean "!=" here?  I do not see anywhere that you are
> "intern"-ing (a la Lisp implementations) names of submodules to make
> address comparison work as a cheap equality check.

Well it was a quick and dirty way of getting the cache overwritten in case the
pointer is different. See further below for the correction.

> 
> > +		cached_refs.loose = get_ref_dir(submodule, "refs", NULL);
> 
> What happened to the old ref_list that had the refs from the toplevel
> project (or the last submodule you visited) if your "did_loose" is true?
> Leakage?
> 
> >  		cached_refs.did_loose = 1;
> > +		cached_refs.submodule = submodule;
> >  	}
> >  	return cached_refs.loose;
> >  }
> 
> Once you grabbed loose refs for _any_ repository, you will have did_loose
> set, so the flag has now became pretty much useless.
> 
> More importantly, I wonder if you would instead want to have cached_refs
> structure for each submodule separately, or at least not nuke the
> cached_refs structure for the top-level project, only because you wanted
> to peek into one submodule.  While your for_each_ref() is walking the refs
> of top-level project, its callback may stomp on the cached_refs by asking
> about submodule refs, and there is nothing in this code structure to help
> catching such a bug, is there?

Thanks for spotting this. I forgot that this part which was still pretty much
in its quick and dirty state from the first implementation. I think currently
it does not make much sense to apply the caching logic for submodule refs. In
the merge case we iterate over them once so caching does not gain us anything
here. I will drop it and write it like this:

> static struct ref_list *get_loose_refs(const char *submodule)
> {
> 	if (submodule) {
> 		free_ref_list(submodule_refs.loose);
> 		submodule_refs.loose = get_ref_dir(submodule, "refs", NULL);
> 		return submodule_refs.loose;
> 	}
> 
> 	if (!cached_refs.did_loose) {
> 		cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
> 		cached_refs.did_loose = 1;
> 	}
> 	return cached_refs.loose;
> }

I think the same applies to the caching of packed refs:

> static struct ref_list *get_packed_refs(const char *submodule)
> {
> 	const char *packed_refs_file;
> 	struct cached_refs *refs;
> 
> 	if (submodule) {
> 		packed_refs_file = git_path_submodule(submodule, "packed-refs");
> 		refs = &submodule_refs;
> 		free_ref_list(refs->packed);
> 	} else {
> 		packed_refs_file = git_path("packed-refs");
> 		refs = &cached_refs;
> 	}
> 
> 	if (!refs->did_packed || submodule) {
> 		FILE *f = fopen(packed_refs_file, "r");
> 		refs->packed = NULL;
> 		if (f) {
> 			read_packed_refs(f, refs);
> 			fclose(f);
> 		}
> 		refs->did_packed = 1;
> 	}
> 	return refs->packed;
> }

I also realized that I forgot to use the --ancestry-path option for
setup_revisions() in this series. It will be added in the next one.

Anything else? I will send another iteration with corrected patches
shortly.

cheers Heiko
