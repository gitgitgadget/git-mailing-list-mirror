From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] implement submodule config cache for lookup of
 submodule names
Date: Thu, 13 Mar 2014 00:58:33 +0100
Message-ID: <20140312235833.GA5300@sandbox-ub>
References: <20140310212412.GA8693@sandbox-ub>
 <20140312022852.GA15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNt2y-00051X-TL
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 00:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbaCLX6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 19:58:48 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:48298 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaCLX6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 19:58:48 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WNt2k-0002Sn-Ai; Thu, 13 Mar 2014 00:58:38 +0100
Content-Disposition: inline
In-Reply-To: <20140312022852.GA15625@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244013>

Hi,

On Tue, Mar 11, 2014 at 07:28:52PM -0700, Jonathan Nieder wrote:
> Heiko Voigt wrote:
> 
> > This submodule configuration cache allows us to lazily read .gitmodules
> > configurations by commit into a runtime cache which can then be used to
> > easily lookup values from it. Currently only the values for path or name
> > are stored but it can be extended for any value needed.
> 
> Makes sense.
> 
> [...]
> > Next I am planning to extend this so configuration cache so it will
> > return the local configuration (with the usual .gitmodules,
> > /etc/gitconfig, .git/config, ... overlay of variables) when you pass it
> > null_sha1 for gitmodule or commit sha1. That way we can give this
> > configuration cache some use and implement its usage for the current
> > configuration variables in submodule.c.
> 
> Yay!
> 
> I wonder whether local configuration should also override information
> from commits at times.

Yeah but for that I plan a different code path that solves conflicts
and/or extend missing values. I think its best to keep the submodule
configurations by commit as simple as possible. But we will see once I
get to the point where we need this.

> [...]
> > --- /dev/null
> > +++ b/Documentation/technical/api-submodule-config-cache.txt
> > @@ -0,0 +1,39 @@
> > +submodule config cache API
> > +==========================
> 
> Most API documents in Documentation/technical have a section explaining
> general usage --- e.g. (from api-revision-walking),
> 
> 	Calling sequence
> 	----------------
> 
> 	The walking API has a given calling sequence: first you need to
> 	initialize a rev_info structure, then add revisions to control what kind
> 	of revision list do you want to get, finally you can iterate over the
> 	revision list.
> 
> Or (from api-string-list):
> 
> 	The caller:
> 
> 	. Allocates and clears a `struct string_list` variable.
> 
> 	. Initializes the members. You might want to set the flag `strdup_strings`
> 	  if the strings should be strdup()ed. For example, this is necessary
> [...]
> 	. Can remove items not matching a criterion from a sorted or unsorted
> 	  list using `filter_string_list`, or remove empty strings using
> 	  `string_list_remove_empty_items`.
> 
> 	. Finally it should free the list using `string_list_clear`.
> 
> This makes it easier to get started by looking at the documentation alone
> without having to mimic an example.

True, will extend that in the next iteration.

> Another thought: it's tempting to call this the 'submodule config API' and
> treat the (optional?) memoization as an implementation detail instead of
> reminding the caller of it too much.  But I haven't thought that through
> completely.

Thats the same point Jeff mentioned and I think that will simplify many
things. As I mentioned in the answer to Jeff I will keep passing around
the cache pointer internally but expose only functions without it to the
outside to be future proof but also easy to use for the current use
case.

> [...]
> > +`struct submodule_config *get_submodule_config_from_path(
> > +			struct submodule_config_cache *cache,
> > +			const unsigned char *commit_sha1,
> > +			const char *path)::
> > +
> > +	Lookup a submodules configuration by its commit_sha1 and path.
> 
> The cache just always grows until it's freed, right?  Would it make
> sense to allow cached configurations to be explicitly evicted when the
> caller is done with them some day?  (Just curious, not a complaint.
> Might be worth mentioning in the overview how the cache is expected to
> be used, though.)

Yes it only grows at the moment. Not sure whether we need to remove
configurations. Currently the only use case that comes to my mind would
be if it grows to big to be kept in memory, but at the moment that seems
far away for me, so I would leave that for a future extension. It will
be hard to know whether someone is done with a certain .gitmodule file
since we cache it by its sha1 expecting it to be the same over many
revisions.

> [...]
> > --- /dev/null
> > +++ b/submodule-config-cache.h
> > @@ -0,0 +1,26 @@
> > +#ifndef SUBMODULE_CONFIG_CACHE_H
> > +#define SUBMODULE_CONFIG_CACHE_H
> > +
> > +#include "hashmap.h"
> > +#include "strbuf.h"
> > +
> > +struct submodule_config_cache {
> > +	struct hashmap for_path;
> > +	struct hashmap for_name;
> > +};
> 
> Could use comments (e.g., saying what keys each maps to what values).
> Would callers ever look at the hashmaps directly or are they only
> supposed to be accessed using helper functions that take a whole
> struct?

Users should only use the helper functions, but I will hide this in the
submodule-config module. Will add some comment as well.

> [...]
> > +
> > +/* one submodule_config_cache entry */
> > +struct submodule_config {
> > +	struct strbuf path;
> > +	struct strbuf name;
> > +	unsigned char gitmodule_sha1[20];
> 
> Could also use comments.  What does the gitmodule_sha1 field represent?

Thats the sha1 of the parsed .gitmodule file blob.

> [...]
> > --- /dev/null
> > +++ b/submodule-config-cache.c
> > @@ -0,0 +1,256 @@
> > +#include "cache.h"
> > +#include "submodule-config-cache.h"
> > +#include "strbuf.h"
> > +
> > +struct submodule_config_entry {
> > +	struct hashmap_entry ent;
> > +	struct submodule_config *config;
> > +};
> > +
> > +static int submodule_config_path_cmp(const struct submodule_config_entry *a,
> > +				     const struct submodule_config_entry *b,
> > +				     const void *unused)
> > +{
> > +	int ret;
> > +	if ((ret = strcmp(a->config->path.buf, b->config->path.buf)))
> > +		return ret;
> 
> Style: avoid assignments in conditionals:
> 
> 	ret = strcmp(...);
> 	if (ret)
> 		return ret;
> 
> 	return hashcmp(...);
> 
> The actual return value from strcmp isn't important since
> hashmap_cmp_fn is only used to check for equality.

I know but since its so similar I used the return value anyway.

> Perhaps as a
> separate change it would make sense to make it a hashmap_equality_fn
> some day:
> 
> 	return !strcmp(...) && !hashcmp(...);
> 
> This checks both the path and gitmodule_sha1, so I guess it's for
> looking up submodule names.

Yes, will change it that way.

> [...]
> > +static int submodule_config_name_cmp(const struct submodule_config_entry *a,
> > +				     const struct submodule_config_entry *b,
> > +				     const void *unused)
> 
> Likewise.

Ok

> [...]
> > +void submodule_config_cache_init(struct submodule_config_cache *cache)
> > +{
> > +	hashmap_init(&cache->for_path, (hashmap_cmp_fn) submodule_config_path_cmp, 0);
> > +	hashmap_init(&cache->for_name, (hashmap_cmp_fn) submodule_config_name_cmp, 0);
> 
> Long lines.
> 
> I don't like the casts (they make it hard to catch if e.g. the number
> of arguments expected for a hashmap_cmp_fn changes) but it's the style
> used elsewhere.   Ok.

Me neither but we got to cast somewhere, either in the cmp functions or
here. I don't know what better, so I used the style suggested in the
documentation.

> [...]
> > +void submodule_config_cache_free(struct submodule_config_cache *cache)
> > +{
> > +	struct hashmap_iter iter;
> > +	struct submodule_config_entry *entry;
> > +
> > +	/*
> > +	 * NOTE: we iterate over the name hash here since
> > +	 * submodule_config entries are allocated by their gitmodule
> > +	 * sha1 and submodule name.
> > +	 */
> 
> No need to say 'NOTE' --- it's just as clear without that word that
> this is a comment.

Now looking at it from that perspective, you are right: Yes its a note
why does it also have to us that :-)

> Not sure I understand the comment.  Is the point that you only have
> to iterate over one of the hashmaps, or is there something more
> subtle going on?

No its only purpose is to explain why we only need to iterate over one
hashmap. In case thats clear to everyone I can also delete it.

> [...]
> > +	hashmap_free(&cache->for_path, 1);
> > +	hashmap_free(&cache->for_name, 1);
> 
> Not your fault: this contextless '1' is unhelpful.  hashmap_free could
> take a flag HASHMAP_FREE_ENTRIES.

We have a similar int in other places as well. See for example
string_list_clear().

> [...]
> > +static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
> > +{
> > +	return memhash(sha1, 20) + strhash(string);
> > +}
> 
> Feels a bit unconventional.  I can't find a strong reason to mind.

Well I did not think much about this. I simply thought: hash -> kind of
random value. Adding the two together is as good as anything (even
overflow does not matter).

> When Boost's
> 
> 	size_t seed = 0;
> 	hash_combine(seed, x);
> 	hash_combine(seed, y);
> 
> does
> 
> 	hash = hash_value(x) + 0x9e3779b9
> 	hash ^= hash_value(y) + 0x9e3779b9 + (seed<<6) + (seed>>2);
> 
> I suspect some of the complication is because they expect to be mixing
> more values in a loop.

I am fine with a switch to something different. We could use classic XOR
in case that feels better.

> > +
> > +static void submodule_config_cache_update_path(struct submodule_config_cache *cache,
> > +		struct submodule_config *config)
> > +{
> > +	unsigned int hash = hash_sha1_string(config->gitmodule_sha1,
> > +					     config->path.buf);
> > +	struct submodule_config_entry *e = xmalloc(sizeof(*e));
> > +	hashmap_entry_init(e, hash);
> > +	e->config = config;
> > +	hashmap_put(&cache->for_path, e);
> > +}
> 
> Naming nit: maybe ..._put for consistency with the hashmap API?

Fine with me, will change.

> [...]
> > +static void submodule_config_cache_insert(struct submodule_config_cache *cache, struct submodule_config *config)
> 
> Likewise, maybe _add?

Thats fine by me as well. The _insert I got from string_list I think.

> [...]
> > +static struct submodule_config *submodule_config_cache_lookup_path(struct submodule_config_cache *cache,
> > +	const unsigned char *gitmodule_sha1, const char *path)
> > +{
> > +	struct submodule_config_entry *entry;
> > +	unsigned int hash = hash_sha1_string(gitmodule_sha1, path);
> > +	struct submodule_config_entry key;
> > +	struct submodule_config key_config;
> > +
> > +	hashcpy(key_config.gitmodule_sha1, gitmodule_sha1);
> > +	key_config.path.buf = (char *) path;
> 
> An odd use of strbuf.

Yeah, I first designed the struct submodule_config when the old hashmap
implementation was around. In the implementation I found that I have to
pass in the complete key somehow. When I ported to hashmap this was the
"hack" so we do not do an unnecessary copying of strings. But as Jeff
also pointed out that the entries in submodule_config can be simple
const char *'s I will change to that and here we can simply set the
pointer.

> My first reaction was "Shouldn't this use strbuf_addstr?".  That way
> it would be clear who has responsibility to free it and the alloc and
> len fields would be right.
> 
> But looking more closely, it seems that key_config.path.buf is just
> being used to transmit a \0-terminated string.  Would making struct
> submodule_config::path a plain "const char *" work?  Or perhaps struct
> submodule_config_entry should be a tagged union or similar to make
> both the variant that owns its name and path and the variant that
> borrows buffers possible and comparable.

Yep "const char *" it will be.

> [...]
> > +struct parse_submodule_config_parameter {
> > +	unsigned char *gitmodule_sha1;
> > +	struct submodule_config_cache *cache;
> > +};
> 
> What is this struct used for?  A comment or moving it closer to where
> it is used could help.

This is used to pass these parameters into the git_config_from_buf
infrastructure. Will move it directly above the callback where it is
used.

> [...]
> > +static void warn_multiple_config(struct submodule_config *config, const char *option)
> > +{
> > +	warning("%s:.gitmodules, multiple configurations found for submodule.%s.%s. "
> > +			"Skipping second one!", sha1_to_hex(config->gitmodule_sha1),
> > +			option, config->name.buf);
> 
> Ah, so gitmodule_sha1 is a commit id?

No, this output is a bug. gitmodule_sha1 is actually the sha1 of the
.gitmodule blob we read. Thanks for noticing will fix. Should I also add
a comment to the gitmodule_sha1 field to explain what it is?

> I think a name like "commit" for the field would have left me less
> confused (and a comment could explain that what the hash values store
> is information gleaned from .gitmodules in that commit).

I understand your confusion because of the misleading output. But with
the clarification does the name make sense now?

Thanks and Cheers Heiko
