From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 1/4] implement submodule config cache for lookup of
 submodule names
Date: Wed, 3 Jun 2015 21:31:26 +0200
Message-ID: <20150603193126.GA94875@book.hvoigt.net>
References: <20150602142436.GA7713@book.hvoigt.net>
 <20150602142538.GB7713@book.hvoigt.net>
 <xmqqbngx3muj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:32:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0ENk-00018x-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbbFCTbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:31:17 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:46150 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbFCTbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 15:31:15 -0400
Received: from [188.108.236.160] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z0ENa-0004aG-QL; Wed, 03 Jun 2015 21:31:11 +0200
Content-Disposition: inline
In-Reply-To: <xmqqbngx3muj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270729>

On Tue, Jun 02, 2015 at 12:57:08PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > This submodule configuration cache allows us to lazily read .gitmodules
> > configurations by commit into a runtime cache which can then be used to
> > easily lookup values from it. Currently only the values for path or name
> > are stored but it can be extended for any value needed.
> >
> > It is expected that .gitmodules files do not change often between
> > commits. Thats why we lookup the .gitmodules sha1 from a commit and then
> > either lookup an already parsed configuration or parse and cache an
> > unknown one for each sha1. The cache is lazily build on demand for each
> > requested commit.
> >
> > This cache can be used for all purposes which need knowledge about
> > submodule configurations. Example use cases are:
> >
> >  * Recursive submodule checkout needs lookup a submodule name from its
> >    path when a submodule first appears. This needs be done before this
> >    configuration exists in the worktree.
> >
> >  * The implementation of submodule support for 'git archive' needs to
> >    lookup the submodule name to generate the archive when given a
> >    revision that is not checked out.
> >
> >  * 'git fetch' when given the --recurse-submodules=on-demand option (or
> >    configuration) needs to lookup submodule names by path from the
> >    database rather than reading from the worktree. For new submodule it
> >    needs to lookup the name from its path to allow cloning new
> >    submodules into the .git folder so they can be checked out without
> >    any network interaction when the user does a checkout of that
> >    revision.
> 
> What is unclear to me after reading the above twice is what this
> thing is meant to achieve.  Is it efficiency by doing lazy lookups
> and caching to avoid asking the same thing more than once from
> either the filesystem or read_sha1_file()?  Is it expected that
> reading through this "cache" will be the _only_ way callers would
> interact with the .gitmodules data, or is it an opt-in feature that
> some callers that do not see the benefit (why they may want to
> ignore is totally unclear, because what the "cache" system wants to
> achieve is) can safely ignore and bypass?

Maybe I should add a paragraph like this on top:

  In a superproject some commands need to interact with submodules. They
  need to query values from the .gitmodules file either from the
  worktree of from certain revisions. At the moment this is quite hard
  since a caller would need to read the .gitmodules file from the
  history and then parse the values. We want to provide an API for this
  so we have one place to get values from .gitmodules from any revision
  (including the worktree).

So yes it will be the only way callers would read .gitmodules data.
Since you abstractly wrote "interact" I realize that I have not thought
about writing values.

> Because the above talks about looking up ".gitmodules from a
> commit", I am guessing that the "commit" used as one of the lookup
> keys throughout the system is a commit in the superproject, not from
> submodules, but you may want to state that more explicitly.

Yes. Well it is a commit in the current project which should be the
superproject to other submodules. Assuming we have the additional
paragraph above. Does that make it more clear?

> What, if anything, should be done for .gitmodules that are not yet
> committed?  Are there cases that the callers that usually interact
> with .gitmodules via this "cache" system need to use .gitmodules
> immediately after adding a new submodule but before committing that
> change to the superproject?  Do they code something like this?
> 
> 	if (cached)
>         	read .gitmodules from the index and fabricate
> 		struct submodule;
> 	else if (worktree)
>         	read .gitmodules from the working tree and fabricate
> 		struct submodule;
> 	else
> 		call submodule_from_name("HEAD", ...) and receive
>                 struct submodule;
> 
> 	use the struct submodule to learn from the module;
> 
> Yes, I am wondering if submodule_from_name() should be extended to
> allow the former two cases, so that the caller can make a single
> call above and then use resulting "struct submodule" throughout its
> code after doing so.

Reading from the worktree is supported by passing in null_sha1 (as
documented). That said it may also contain values from the local
configuration (overlaid in the typical priority).

The index case is the only one that is missing. I am not sure whether we
will need that. The use cases I have described above do not require this
(AFAICS). But you are right maybe it makes sense to keep this open so we
can at least allow it. Since we already use the NULL pointer and the
null_sha1 as special values we could either add another function pair
and a separate internal cache for them or define some special sha1 value
that is very unlikely to collide (e.g. an empty commit sha1 at epoch
with some special author).

Either way I think there is nothing blocking us from extending it but I
would not do it now without any users.

The current use cases are all about interrogating an existing history
and the worktree. I currently see no need to interrogate .gitmodules
directly after adding a submodule in the same process. We also should be
able to add it later in case needed.

> And I also am hoping that the answer to my
> questions above to be "This is not just an opt-in 'cache' API, but
> we want to make it the unified API for C code to learn about what is
> in .gitmodule".

Yes as stated above I am planning to make this the unified API for C
code. If you look at the next two commits you see that I am already
replacing the existing lookups from the worktree to use this cache.
With this series all places that read .gitmodules values use this cache.
Anything else would be a bug in my code :)

> > diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
> > new file mode 100644
> > index 0000000..2ff4907
> > --- /dev/null
> > +++ b/Documentation/technical/api-submodule-config.txt
> > @@ -0,0 +1,46 @@
> > +submodule config cache API
> > +==========================
> > +
> > +The submodule config cache API allows to read submodule
> > +configurations/information from specified revisions. Internally
> > +information is lazily read into a cache that is used to avoid
> > +unnecessary parsing of the same .gitmodule files. Lookups can be done by
> > +submodule path or name.
> > +
> > +Usage
> > +-----
> > +
> > +The caller can look up information about submodules by using the
> > +`submodule_from_path()` or `submodule_from_name()` functions. They return
> > +a `struct submodule` which contains the values. The API automatically
> > +initializes and allocates the needed infrastructure on-demand.
> > +
> > +If the internal cache might grow too big or when the caller is done with
> > +the API, all internally cached values can be freed with submodule_free().
> > +
> > +Data Structures
> > +---------------
> > +
> > +`struct submodule`::
> > +
> > +	This structure is used to return the information about one
> > +	submodule for a certain revision. It is returned by the lookup
> > +	functions.
> 
> Hopefully this will not stay an opaque structure as we read later
> patches ;-).

Ok will add some documentation for the members here :)

> > +Functions
> > +---------
> > +
> > +`void submodule_free()`::
> > +
> > +	Use these to free the internally cached values.
> 
> "These" meaning "this single function", or are there variants of it?

I think I had multiple free routines at some point. This seems like a
leftover. Will change to "this".

> > diff --git a/submodule-config.c b/submodule-config.c
> > new file mode 100644
> > index 0000000..97f4a04
> > --- /dev/null
> > +++ b/submodule-config.c
> > @@ -0,0 +1,445 @@
> > +#include "cache.h"
> > +#include "submodule-config.h"
> > +#include "submodule.h"
> > +#include "strbuf.h"
> > +
> > +/*
> > + * submodule cache lookup structure
> > + * There is one shared set of 'struct submodule' entries which can be
> > + * looked up by their sha1 blob id of the .gitmodule file and either
> > + * using path or name as key.
> > + * for_path stores submodule entries with path as key
> > + * for_name stores submodule entries with name as key
> > + */
> > +struct submodule_cache {
> > +	struct hashmap for_path;
> > +	struct hashmap for_name;
> > +};
> > +
> > +/*
> > + * thin wrapper struct needed to insert 'struct submodule' entries to
> > + * the hashmap
> > + */
> > +struct submodule_entry {
> > +	struct hashmap_entry ent;
> > +	struct submodule *config;
> > +};
> 
> The above, and the singleton-ness of the "cache", implies that we
> can have only one "struct submodule" for a given path (or a name).
> Does that mean the subsystem implicitly is tied to a single commit
> at the superproject level?

No the keys in the hashmap are a combination of the sha1 blob id of the
.gitmodules file and its name or path respectively. I should make that
more clear here.

> What happens when I call submodule_from_path() for a single
> submodule at one commit in the superproject, and then ask about that
> same submodule for another commit in the superproject, which may
> have a different version of .gitmodules, by calling the same
> function again?
> 
> 	Side note: I think I know the answer to these questions,
> 	after reading the hash function.  for_path does not store
> 	submodule entries with path as key.  It uses the commit and
> 	the path as a combined key, so both HEAD:.gitmodules and
> 	HEAD^:.gitmodules can be cached and looked up separatedly if
> 	their contents are different.  The comment and field names
> 	of "struct submodule_cache" may want to be improved.

That is correct.

> When do we evict the cache?  I am wondering what would happen when
> you do "git log --recursive" at the superproject level, which may
> grow the cache in an unbounded way without some eviction policy.

I left this as an exercise for the caller to figure out ;-) I think we
have to leave it to the caller how much of the cache he wants to use.
The only thing I can currently think of, that might help, is that we
could provide the caller with the amount of .gitmodules files read so he
has some simple measure to determine when he wants to call
submodule_free().

All use-cases I currently have in mind are expected to use only a few
.gitmodules. But only in the typical situation. There might be extreme
cases were this is not true anymore. I am not sure how theoretical this
is and thus not sure whether we should take countermeasures now.

What would you expect "git log --recursive" to do?

Cheers Heiko
