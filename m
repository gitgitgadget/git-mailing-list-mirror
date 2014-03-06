From: Jeff King <peff@peff.net>
Subject: Re: RFC GSoC idea: git configuration caching (needs co-mentor!)
Date: Thu, 6 Mar 2014 14:46:54 -0500
Message-ID: <20140306194654.GA28203@sigill.intra.peff.net>
References: <53180E40.5050308@alum.mit.edu>
 <xmqqtxbbxh99.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLeFw-00086Z-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbaCFTq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:46:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:34284 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924AbaCFTq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:46:56 -0500
Received: (qmail 26961 invoked by uid 102); 6 Mar 2014 19:46:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 13:46:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 14:46:54 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtxbbxh99.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243542>

On Thu, Mar 06, 2014 at 11:24:18AM -0800, Junio C Hamano wrote:

> > * Add new API calls that allow the cache to be inquired easily and
> >   efficiently.  Rewrite other functions like `git_config_int()` to be
> >   cache-aware.
> 
> Are you sure about the second sentence of this item is what you
> want?
> 
> git_config_<type>(name, value) are all about parsing "value" (string
> or NULL) as <type>, return the parsed value or complain against a
> bad value for "name".  They do not care where these "name" and
> "value" come from right now, and there is no reason for them to
> start caring about caching.  They will still be the underlying
> helper functions the git_config() callbacks will depend on even
> after the second item in your list happens.

Yeah, I agree we want a _new_ set of helpers for retrieving values in a
non-callback way. We could call those helpers "git_config_int" (and
rename the existing pure functions), but I'd rather not, as it simply
invites confusion with the existing ones.

> A set of new API calls would look more like this, I would think:
> 
> 	extern int git_get_config_string_multi(const char *, int *, const char ***);

Not important at this stage, but I was hoping we could keep the names of
the new helpers shorter. :)

> 	const char *git_get_config_string(const char *name)
>         {
> 		const char **values, *result;
>                 int num_values;
> 
> 	        if (git_get_config_string_multi("sample.str", &num_values, &values))
>         		return NULL;
>                 result = num_values ? values[num_values - 1] : NULL;
>                 free(values);
> 		return result;
> 	}
> 
> that implements the "last one wins" semantics.  The real thing would
> need to avoid allocation and free overhead.

One of the things that needs to be figured out by the student is the
format of the internal cache. I had actually envisioned a mapping of
keys to values, where values are represented as a full list of strings.
Then your "string_multi" can just return a pointer to that list, and a
last-one-wins lookup can grab the final value, with no allocation or
ownership complexity. We'd lose the relative order of different config
keys, but those should never be important (only the order of single
keys, but that is reflected in the order of the value list).

Another approach would be to actually represent the syntax tree of the
config file in memory. That would make lookups of individual keys more
expensive, but would enable other manipulation. E.g., if your syntax
tree included nodes for comments and other non-semantic constructs, then
we can use it for a complete rewrite. And "git config" becomes:

  1. Read the tree.

  2. Perform operations on the tree (add nodes, delete nodes, etc).

  3. Write out the tree.

and things like "remove the section header when the last item in the
section is removed" become trivial during step 2.

But comparing those approaches is something for the student to figure
out, I think.

-Peff
