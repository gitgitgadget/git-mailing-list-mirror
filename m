From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Fri, 27 Jan 2012 00:54:05 -0500
Message-ID: <20120127055405.GB23633@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <4F223115.3050004@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqelM-0005k8-7a
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab2A0FyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:54:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46323
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab2A0FyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:54:09 -0500
Received: (qmail 2299 invoked by uid 107); 27 Jan 2012 06:01:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 01:01:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 00:54:05 -0500
Content-Disposition: inline
In-Reply-To: <4F223115.3050004@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189195>

On Fri, Jan 27, 2012 at 06:07:33AM +0100, Michael Haggerty wrote:

> > +struct git_config_include_data {
> > +	config_fn_t fn;
> > +	void *data;
> > +};
> > +int git_config_include(const char *name, const char *value, void *vdata);
> > +
> >  extern const char *config_exclusive_filename;
> >  
> >  #define MAX_GITNAME (1000)
> 
> How about a short comment or two?

I had originally planned to document this somewhat non-intuitive
interface in the config API documentation. But then I noticed we didn't
have such a document, and promptly forgot about documenting.

I'd rather have an API document, but I admit that the thought of
describing the config interface frightens me. It has some nasty corners.
But maybe starting one with the non-scary bits would be better, and then
I could add this to it.

> > +int git_config_include(const char *name, const char *value, void *vdata)
> > +{
> > +	const struct git_config_include_data *data = vdata;
> > +	const char *type;
> > +	int ret;
> > +
> > +	/*
> > +	 * Pass along all values, including "include" directives; this makes it
> > +	 * possible to query information on the includes themselves.
> > +	 */
> > +	ret = data->fn(name, value, data->data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (prefixcmp(name, "include."))
> > +		return ret;
> > +	type = strrchr(name, '.') + 1;
> > +
> > +	if (!strcmp(type, "path"))
> > +		ret = handle_path_include(value, vdata);
> > +
> > +	return ret;
> > +}
> > +
> 
> Doesn't this code accept all keys of the form "include\.(.*\.)?path"
> (e.g., "include.foo.path")?  If that is your intention, then the
> documentation should be fixed.  If not, then a single strcmp(name,
> "include.path") would seem sufficient.

It does. I was considering (but haven't yet written) a patch that would
allow for conditional inclusion, like:

  [include "foo"]
          path = /some/file

where "foo" would be the condition. Specifically, I wanted to enable
includes when certain features were available in the parsing version of
git. For example, the pager.* variables were originally bools, but later
learned to take arbitrary strings. So my config with arbitrary strings
works on modern git, but causes earlier versions of git to barf. I'd
like to be able to do something like:

  [include "per-command-pager-strings"]
          path = /path/to/my/pager.config

where "per-command-pager-strings" would be a flag known internally to
git versions that support that feature.

I didn't end up implementing it right away, because of course those same
early versions of git also don't know about "include" at all. So using
any include effectively works as a conditional for that particular
feature. But as new incompatible config semantics are added
post-include, they could take advantage of a similar scheme.

So I wanted to leave the code open to adding such a patch later, if and
when it becomes useful. That being said, the code above is wrong.
For my scheme to work, versions of git that handle includes but don't
have the conditional-include patch (if it ever comes) would want to
explicitly disallow includes with subsections.

I'll fix it in the re-roll.

> > +	struct git_config_include_data inc;
> > +
> > +	inc.fn = fn;
> > +	inc.data = data;
> > +	fn = git_config_include;
> > +	data = &inc;
> >  
> >  	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
> >  	if (config_exclusive_filename)
> 
> The comment just after your addition should be adjusted, since now "the
> given config file and any files that it includes" are read.

Will do.

-Peff
