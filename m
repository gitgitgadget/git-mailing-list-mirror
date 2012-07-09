From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/2] Strip namelen out of ce_flags into a
 ce_namelen field
Date: Sun, 08 Jul 2012 21:59:28 -0700
Message-ID: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
References: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
 <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
 <1341590850-15653-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So656-0005oy-5t
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 07:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab2GIE7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 00:59:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab2GIE7b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 00:59:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FCA386A9;
	Mon,  9 Jul 2012 00:59:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8hAOz/tm9Dk7AXZr9M0GIeMe+Co=; b=hTyNOw
	Ng+BPHH91KVL70x+JCa4JfxG5/Edfk14juLlOcAZ1mH4w1N0wz5tGX/d4/jG24ZZ
	VWj3gyapxiLB0RFR49prostFdXNDqSAUHHSDLFEXhewR4o9oFQXS1lZ0ScaRmO33
	iR6/pW/3fjlT3TiifI4nrrk8HGXOCEIwAzuIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=szgDGWn6LjA+ImgjMCpVLoyTF5ceyc9o
	T5Y6kEyqBBVb9jGl2zmSnsf4IjNP3TVkRDj/bplospSCZQ5cgGm2J33/meblOn3W
	77r06nbTv5B97aYhaClCGycFZ4K6MkYlj92CWEcq9TyiLZFQrpE4U3ApuWGXaCXk
	b6pYJX6ueis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5418286A7;
	Mon,  9 Jul 2012 00:59:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9169786A6; Mon,  9 Jul 2012
 00:59:29 -0400 (EDT)
In-Reply-To: <1341590850-15653-2-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Fri, 6 Jul 2012 18:07:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD7356A6-C982-11E1-BB4F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201192>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Strip the name length from the ce_flags field and move it
> into its own ce_namelen field in struct cache_entry. This
> will both give us a tiny bit of a performance enhancement
> when working with long pathnames and is part of the
> refactoring for the index-v5 file format.

Careful.

I do not mind moving name length out of low bits of ce_flags in
principle, but if you claim this helps performance, you need to
substanticate it.

FYI, the current layout was designed for performance to take
advantage of the fact that most paths are short (among 39k paths in
the kernel tree, the longest seems to be 80 bytes long) and using
strlen() is rarely needed (the code even skips the first 4k bytes
when it has to use strlen()).  It of course also shaves a few
hundred kilobytes of memory necessary to hold the length separately
in cache entries).

> Index-v5 won't store the name length in the on disk index
> file, so storing it in the flags wouldn't make sense for
> index-v5.

I think this split could make sense even without a new on-disk
format.

On the other hand, even if the result of this patch were to prove
undesirable, it is still possible for the read_index code for v5
format to convert from its ondisk_cache_entry (which does not have
length anywhere) to the canonical cache_entry struct (which stores
length for common short path names in lower bits of flags field),
and write_index code could do the reverse.

Because of the above two points, what index-v5 has or does not have
is mostly immaterial when judging this patch, unless such a
conversion has very high cost.

> It also enhances readability, by making it more clear what
> is a flag, and where the length is stored and make it clear
> which functions use stages in comparisions and which only
> use the length.

That can be true, but if we were to go this route, the patch should
be able to make CE_NAMEMASK totally private to the codepath that
reads and writes v2/v3/v4 format and nowhere else.  The ce_flags
field in "struct cache_entry" that is visible to everybody from
cache.h shouldn't need the padding of 12-low bits that is not used
(I think CE_STAGESHIFT could even become 0, even though I do not see
an immediate need for such a change).

Shouldn't "struct ondisk_cache_entry" in read-cache.c the only place
that need to know about this old layout, no?

> diff --git a/builtin/apply.c b/builtin/apply.c
> index dda9ea0..10f83fc 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3502,7 +3502,8 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
>  	ce = xcalloc(1, ce_size);
>  	memcpy(ce->name, path, namelen);
>  	ce->ce_mode = create_ce_mode(mode);
> -	ce->ce_flags = namelen;

I think this should have been create_ce_flags(namelen, 0)
originally, so I would prefer the new code to spell it as
create_ce_flags(0).

> +	ce->ce_flags = 0;
> +	ce->ce_namelen = namelen;

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 24d3dd5..e181368 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2153,7 +2153,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	ce = xcalloc(1, size);
>  	hashcpy(ce->sha1, origin->blob_sha1);
>  	memcpy(ce->name, path, len);
> -	ce->ce_flags = create_ce_flags(len, 0);
> +	ce->ce_flags = 0;

Likewise.  I think it is more in line with your "making it more
clear" if you said create_ce_flags(0) here.  I won't repeat this for
the remainder of the patch where a bare number is stored without
using create_ce_flags(stage).

> +#define ce_namelen(ce) ((ce)->ce_namelen)

Good.

> @@ -448,6 +440,7 @@ extern int discard_index(struct index_state *);
>  extern int unmerged_index(const struct index_state *);
>  extern int verify_path(const char *path);
>  extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
> +extern int index_name_stage_pos(const struct index_state *, const char *name, int stage, int namelen);

The name string and its length form a pair; keep them next to each
other (i.e. swap stage and namelen).

> @@ -857,6 +850,7 @@ extern int validate_headref(const char *ref);
>  extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
>  extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
>  extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
> +extern int cache_name_stage_compare(const char *name1, int stage1, int len1, const char *name2, int stage2, int len2);

Likewise.

> diff --git a/read-cache.c b/read-cache.c
> index ef355cc..ea75c89 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -395,10 +395,8 @@ int df_name_compare(const char *name1, int len1, int mode1,
>  	return c1 - c2;
>  }
>  
> -int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
> +int cache_name_stage_compare(const char *name1, int stage1, int len1, const char *name2, int stage2, int len2)
>  {
> -	int len1 = flags1 & CE_NAMEMASK;
> -	int len2 = flags2 & CE_NAMEMASK;
>  	int len = len1 < len2 ? len1 : len2;
>  	int cmp;

Isn't this a _BUGFIX_?  It appears to me that the original code
would only compare the first 4k bytes and ignore the rest, if two
cache entries, both with overlong names, are compared.  Care to come
up with a test case to demonstrate the breakage and a bugfix without
the remainder of this patch, to be applied to 'master' and older
maintenance releases?  Perpahs something along the lines of this:

 read-cache.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1df6adf..d226e5e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -397,11 +397,15 @@ int df_name_compare(const char *name1, int len1, int mode1,
 
 int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
 {
-	int len1 = flags1 & CE_NAMEMASK;
-	int len2 = flags2 & CE_NAMEMASK;
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
-
+	int len1, len2, len, cmp;
+
+	len1 = flags1 & CE_NAMEMASK;
+	if (len1 >= CE_NAMEMASK)
+		len1 = strlen(name1)
+	len2 = flags2 & CE_NAMEMASK;
+	if (len2 >= CE_NAMEMASK)
+		len2 = strlen(name2);
+	len = len1 < len2 ? len1 : len2;
 	cmp = memcmp(name1, name2, len);
 	if (cmp)
 		return cmp;

Pros and cons of adding a new ce_namelen field can be discussed
separately and built on top of such a bugfix.

> @@ -1319,7 +1324,8 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
>  	ce->ce_uid   = ntoh_l(ondisk->uid);
>  	ce->ce_gid   = ntoh_l(ondisk->gid);
>  	ce->ce_size  = ntoh_l(ondisk->size);
> -	ce->ce_flags = flags;
> +	ce->ce_flags = flags & ~CE_NAMEMASK;
> +	ce->ce_namelen = len;

OK, so this part wants to make (ce->ce_flags & CE_NAMEMASK) MBZ
(must be zero), which is a step in the right direction (provided
that the creation of ce_namelen field is the right thing to do, that
is).

> @@ -1743,7 +1749,7 @@ int write_index(struct index_state *istate, int newfd)
>  {
>  	git_SHA_CTX c;
>  	struct cache_header hdr;
> -	int i, err, removed, extended, hdr_version;
> +	int i, err, removed, extended, hdr_version, len;
>  	struct cache_entry **cache = istate->cache;
>  	int entries = istate->cache_nr;
>  	struct stat st;
> @@ -1759,6 +1765,11 @@ int write_index(struct index_state *istate, int newfd)
>  			extended++;
>  			cache[i]->ce_flags |= CE_EXTENDED;
>  		}
> +		if (cache[i]->ce_namelen >= CE_NAMEMASK)
> +			len = CE_NAMEMASK;
> +		else
> +			len = cache[i]->ce_namelen;
> +		cache[i]->ce_flags |= len;
>  	}

This is extremely dubious.  Didn't the earlier hunk at 1319 declare
that low bits of ce_flags is MBZ?  I would understand it if
something like this is done to ondisk in ce_write_entry(), but I do
not think it is consistent to contaminate the low bits of ce_flags
here while your cache_entry_from_ondisk() clears them.
