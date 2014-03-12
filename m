From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] implement submodule config cache for lookup of
 submodule names
Date: Wed, 12 Mar 2014 18:07:06 +0100
Message-ID: <20140312170706.GA3817@sandbox-ub>
References: <20140310212412.GA8693@sandbox-ub>
 <20140311215808.GB32129@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 18:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNmcn-0003gG-1q
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 18:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbaCLRHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 13:07:20 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:37173 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbaCLRHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 13:07:18 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WNmcY-0008NS-In; Wed, 12 Mar 2014 18:07:10 +0100
Content-Disposition: inline
In-Reply-To: <20140311215808.GB32129@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243946>

On Tue, Mar 11, 2014 at 05:58:08PM -0400, Jeff King wrote:
> On Mon, Mar 10, 2014 at 10:24:12PM +0100, Heiko Voigt wrote:
> 
> > I have also moved all functions into the new submodule-config-cache
> > module. I am not completely satisfied with the naming since it is quite
> > long. If someone comes up with some different naming I am open for it.
> > Maybe simply submodule-config (submodule_config prefix for functions)?
> 
> Since the cache is totally internal to the submodule-config code, I do
> not know that you even need to have a nice submodule-config-cache API.
> Can it just be a singleton?
> 
> That is bad design in a sense (it becomes harder later if you ever want
> to pull submodule config from two sources simultaneously), but it
> matches many other subsystems in git which cache behind the scenes.
> 
> I also suspect you could call submodule_config simply "submodule", and
> let it be a stand-in for the submodule (for now, only data from the
> config, but potentially you could keep other data on it, too).
> 
> So with all that, the entry point into your code is just:
> 
>   const struct submodule *submodule_from_path(const char *path);
> 
> and the caching magically happens behind-the-scenes.

Actually since we also need to define the revision from which we request
these submodule values that would become:

   const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
   					const char *path);

Since the configuration for submodules for a submodule are identified by
a unique commit sha1 and its unique path (or unique name) I think it is
feasible to make it a singleton. That would also simplify using it from
the existing config parsing code.

To be future proof I can internally keep the object oriented approach
always passing on the submodule_config_cache pointer. That way it would
be easy to expose to the outside in case we later need multiple caches.

So I currently I do not see any downside of making it a singleton to the
outside and would go with that.

> > +/* one submodule_config_cache entry */
> > +struct submodule_config {
> > +	struct strbuf path;
> > +	struct strbuf name;
> > +	unsigned char gitmodule_sha1[20];
> > +};
> 
> Do these strings need changed after they are written once? If not, you
> may want to just make these bare pointers (you can still use strbufs to
> create them, and then strbuf_detach at the end). That may just be a matter of
> taste, though.

No they do not need to be changed after parsing, since every path,
name mapping should be unique in one .gitmodule file. And I think it
actually would make the code more clear in one instance where I directly
set the buf pointer which Jonathan mentioned. There it is needed only
for the hashmap lookup.

Cheers Heiko
