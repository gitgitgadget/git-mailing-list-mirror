From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 4/5] get_sha1: speed up ambiguous 40-hex test
Date: Wed, 08 Jan 2014 17:09:25 +0100
Message-ID: <52CD7835.2020708@alum.mit.edu>
References: <20140107235631.GA10503@sigill.intra.peff.net> <20140107235953.GD10657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 17:09:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0vhJ-00028N-4X
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 17:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbaAHQJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 11:09:33 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63139 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755850AbaAHQJb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 11:09:31 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-e1-52cd783ac405
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.C1.19161.A387DC25; Wed,  8 Jan 2014 11:09:31 -0500 (EST)
Received: from [192.168.69.148] (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08G9PcA026277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jan 2014 11:09:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140107235953.GD10657@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqGtdcTbIYP9tJosDL5+yWHRd6Way
	aOi9wmzRPeUto8WPlh5mB1aPnbPusns8693D6HHxkrLHswM32Tw+b5ILYI3itklKLCkLzkzP
	07dL4M6YfeAHY8E124rNXycxNjDONOhi5OCQEDCReLYzt4uRE8gUk7hwbz1bFyMXh5DAZUaJ
	TTvOQTnnmCQmXexnBqniFdCW2H/wCSOIzSKgKjHn4C0wm01AV2JRTzMTiC0qECyx+vIDFoh6
	QYmTM5+A2SICshLfD29kBBnKLLCBUeLUn3tgzcICLhJXX65mBbGFBDIl9txpAxvEKWAtMeHn
	OmaIS8UlehqDQExmAXWJ9fOEQCqYBeQltr+dwzyBUXAWkm2zEKpmIalawMi8ilEuMac0Vzc3
	MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMk7Pl2MLavlznEKMDBqMTDy1B2NkiINbGsuDL3
	EKMkB5OSKO/hEqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7rxUA53pTEyqrUonyYlDQHi5I4
	r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb0Y5UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpq
	UWJpSUY8KHrji4HxC5LiAdpbD9LOW1yQmAsUhWg9xajLMe/Lh2+MQix5+XmpUuK8DSBFAiBF
	GaV5cCtgSe4VozjQx8K8fSBVPMAECTfpFdASJqAloXGnQJaUJCKkpBoYUz3kLj/lyH87MWNj
	H+fc2ec26P7ZkzHLb/ccZoV38r08kbGT+aeWvJ9S0MDQkZYoVhOckT3T9+WkOZWn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240218>

On 01/08/2014 12:59 AM, Jeff King wrote:
> Since 798c35f (get_sha1: warn about full or short object
> names that look like refs, 2013-05-29), a 40-hex sha1 causes
> us to call dwim_ref on the result, on the off chance that we
> have a matching ref. This can cause a noticeable slow-down
> when there are a large number of objects.  E.g., on
> linux.git:
> 
>   [baseline timing]
>   $ best-of-five git rev-list --all --pretty=raw
>   real    0m3.996s
>   user    0m3.900s
>   sys     0m0.100s
> 
>   [same thing, but calling get_sha1 on each commit from stdin]
>   $ git rev-list --all >commits
>   $ best-of-five -i commits git rev-list --stdin --pretty=raw
>   real    0m7.862s
>   user    0m6.108s
>   sys     0m1.760s
> 
> The problem is that each call to dwim_ref individually stats
> the possible refs in refs/heads, refs/tags, etc. In the
> common case, there are no refs that look like sha1s at all.
> We can therefore do the same check much faster by loading
> all ambiguous-looking candidates once, and then checking our
> index for each object.
> 
> This is technically more racy (somebody might create such a
> ref after we build our index), but that's OK, as it's just a
> warning (and we provide no guarantees about whether a
> simultaneous process ran before or after the ref was created
> anyway).

It's not only racy WRT other processes.  If the current git process
would create a new reference, it wouldn't be reflected in the cache.

It's true that the main ref_cache doesn't invalidate itself
automatically either when a new reference is created, so it's not really
a fair complaint.  However, as we add places where the cache is
invalidated, it is easy to overlook this cache that is stuck in static
variables within a function definition and it is impossible to
invalidate it.  Might it not be better to attach the cache to the
ref_cache structure instead, and couple its lifetime to that object?

Alternatively, the cache could be created and managed on the caller
side, since the caller would know when the cache would have to be
invalidated.  Also, different callers are likely to have different
performance characteristics.  It is unlikely that the time to initialize
the cache will be amortized in most cases; in fact, "rev-list --stdin"
might be the *only* plausible use case.

Regarding the overall strategy: you gather all refnames that could be
confused with an SHA-1 into a sha1_array, then later look up SHA-1s in
the array to see if they are ambiguous.  This is a very special-case
optimization for SHA-1s.

I wonder whether another approach would gain almost the same amount of
performance but be more general.  We could change dwim_ref() (or a
version of it?) to read its data out of a ref_cache instead of going to
disk every time.  Then, at the cost of populating the relevant parts of
the ref_cache once, we would have fast dwim_ref() calls for all strings.

It's true that the lookups wouldn't be quite so fast--they would require
a few bisects per refname lookup (one for each level in the refname
hierarchy) and several refname lookups (one for each ref_rev_parse_rule)
for every dwim_ref() call, vs. a single bisect in your current design.
But this approach it would bring us most of the gain, it might
nevertheless be preferable.

> Here is the time after this patch, which implements the
> strategy described above:
> 
>   $ best-of-five -i commits git rev-list --stdin --pretty=raw
>   real    0m4.966s
>   user    0m4.776s
>   sys     0m0.192s
> 
> We still pay some price to read the commits from stdin, but
> notice the system time is much lower, as we are avoiding
> hundreds of thousands of stat() calls.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I wanted to make the ref traversal as cheap as possible, hence the
> NO_RECURSE flag I added. I thought INCLUDE_BROKEN used to not open up
> the refs at all, but it looks like it does these days. I wonder if that
> is worth changing or not.

What do you mean by "open up the refs"?  The loose reference files are
read when populating the cache.  (Was that ever different?)  But the
call to ref_resolves_to_object() in do_one_ref() is skipped when the
INCLUDE_BROKEN flag is used.

> 
>  refs.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h      |  2 ++
>  sha1_name.c |  4 +---
>  3 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index ca854d6..cddd871 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4,6 +4,7 @@
>  #include "tag.h"
>  #include "dir.h"
>  #include "string-list.h"
> +#include "sha1-array.h"
>  
>  /*
>   * Make sure "ref" is something reasonable to have under ".git/refs/";
> @@ -2042,6 +2043,52 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>  	return logs_found;
>  }
>  
> +static int check_ambiguous_sha1_ref(const char *refname,
> +				    const unsigned char *sha1,
> +				    int flags,
> +				    void *data)
> +{
> +	unsigned char tmp_sha1[20];
> +	if (strlen(refname) == 40 && !get_sha1_hex(refname, tmp_sha1))
> +		sha1_array_append(data, tmp_sha1);
> +	return 0;
> +}
> +
> +static void build_ambiguous_sha1_ref_index(struct sha1_array *idx)
> +{
> +	const char **rule;
> +
> +	for (rule = ref_rev_parse_rules; *rule; rule++) {
> +		const char *prefix = *rule;
> +		const char *end = strstr(prefix, "%.*s");
> +		char *buf;
> +
> +		if (!end)
> +			continue;
> +
> +		buf = xmemdupz(prefix, end - prefix);
> +		do_for_each_ref(&ref_cache, buf, check_ambiguous_sha1_ref,
> +				end - prefix,
> +				DO_FOR_EACH_INCLUDE_BROKEN |
> +				DO_FOR_EACH_NO_RECURSE,
> +				idx);

This doesn't correctly handle the rule

	"refs/remotes/%.*s/HEAD"

We might be willing to accept this limitation, but it should at least be
mentioned somewhere.  OTOH if we want to handle this pattern as well, we
could do use a technique like that of shorten_unambiguous_ref().

> +		free(buf);
> +	}
> +}
> +
> +int sha1_is_ambiguous_with_ref(const unsigned char *sha1)
> +{
> +	struct sha1_array idx = SHA1_ARRAY_INIT;
> +	static int loaded;
> +
> +	if (!loaded) {
> +		build_ambiguous_sha1_ref_index(&idx);
> +		loaded = 1;
> +	}
> +
> +	return sha1_array_lookup(&idx, sha1) >= 0;
> +}
> +
>  static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  					    const unsigned char *old_sha1,
>  					    int flags, int *type_p)
> diff --git a/refs.h b/refs.h
> index 87a1a79..c7d5f89 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -229,4 +229,6 @@ int update_refs(const char *action, const struct ref_update **updates,
>  extern int parse_hide_refs_config(const char *var, const char *value, const char *);
>  extern int ref_is_hidden(const char *);
>  
> +int sha1_is_ambiguous_with_ref(const unsigned char *sha1);
> +
>  #endif /* REFS_H */

Could we have a docstring, please?

> diff --git a/sha1_name.c b/sha1_name.c
> index a5578f7..f83ecb7 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -452,13 +452,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  
>  	if (len == 40 && !get_sha1_hex(str, sha1)) {
>  		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
> -			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
> -			if (refs_found > 0) {
> +			if (sha1_is_ambiguous_with_ref(sha1)) {
>  				warning(warn_msg, len, str);
>  				if (advice_object_name_warning)
>  					fprintf(stderr, "%s\n", _(object_name_msg));
>  			}
> -			free(real_ref);
>  		}
>  		return 0;
>  	}
> 

Despite all my bellyaching, I think that your optimizing of these
lookups gives a nice speedup and I think that the approach that you took
is also OK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
