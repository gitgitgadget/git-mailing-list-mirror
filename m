From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] unpack-trees: add function to update ce_flags
 based on sparse patterns
Date: Mon, 15 Nov 2010 14:19:45 -0600
Message-ID: <20101115201945.GF16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 21:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI5XR-0000GD-Qe
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 21:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933655Ab0KOUUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 15:20:24 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62350 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833Ab0KOUUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 15:20:23 -0500
Received: by wwa36 with SMTP id 36so444298wwa.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 12:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hP8BEoG0ok2rSWfhXZQcVV7btKhbp+MBIXcjI0Bz38I=;
        b=FEwT8mlT5nUlCN5Zec5taQVts+iaPLztGjlQsvwaMWxyAMftN/JZBNwAbJrS4R1Kvi
         nEwqply/tVRKA2Je5Lj8Cgo8aHD2r5tYZfXzp9Mj/xH3jIB/1HMcHd7LCE3gVPehmeGk
         uGDas5ZHv750GDvQIBVSr3O+jp7qleVuENrvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=goBZXoL1kFMbasRYO6Tsym3bCw6PhVI3rVfO+NMnzlNXQDJS7JL+Rt3zcdfzhlMMFl
         6yiGylOgJNOYu1/W6nM056+kO8Fm9FcfXL3Iu4eFAVkIxsMM197JEDaRLPk+BkCswMQf
         lKgVM7ej5aOxFNBiot9NxwKgeJ7UXcoy5NhtI=
Received: by 10.227.68.206 with SMTP id w14mr6594145wbi.144.1289852421874;
        Mon, 15 Nov 2010 12:20:21 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id ga16sm248471wbb.7.2010.11.15.12.20.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 12:20:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161509>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> The function will reconstruct directory structure from index and feed
> excluded_from_list() with proper dtype.

Okay, so I guess what this means is:

 Matching index entries against an excludes file currently has two
 problems.

 First, there's no function to do it.  Code paths (like sparse checkout=
)
 that wanted to try it would iterate over index entries and for each
 index entry pass that path to excluded_from_list().  But that is not
 how excluded_from_list() works; one is supposed to feed in each
 ancester of a path before a given path to find out if it was excluded
 because of some parent or grandparent matching a

	bigsubdirectory/

 pattern despite the path not matching any .gitignore pattern directly.

 Second, it's inefficient.  The excludes mechanism is supposed to let
 us block off vast swaths of the filesystem as uninteresting; separatel=
y
 checking every index entry doesn't fit that model.

 Introduce a new function to take care of both these problems.  This
 traverses the index in depth-first order (well, that's what order the
 index is in) to mark un-excluded entries.

 Maybe some day the in-core index format will be restructured to make
 this sort of operation easier.  Or maybe we will want to try some
 binary search based thing.  The interface is simple enough to allow
 all those things.  Example:

	clear_ce_flags(the_index.cache, the_index.cache_nr,
			CE_CANDIDATE, CE_CLEARME, exclude_list);

 would clear the CE_CLEARME flag on all index entries with
 CE_CANDIDATE flag and not matched by exclude_list.

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -834,6 +834,94 @@ static int unpack_callback(int n, unsigned long =
mask, unsigned long dirmask, str
>  	return mask;
>  }
> =20
> +/*
> + * traverse the index, find every entry that matches according to
> + * o->el. Do "ce_flags &=3D ~clear_mask" on those entries. Return th=
e
> + * number of traversed entries.
> + *
> + * If select_mask is non-zero, only entries whose ce_flags has on of
> + * those bits enabled are traversed.
> + */
> +static int clear_ce_flags_1(struct cache_entry **cache, int nr,
> +			    int prefix_len, int match_all,
> +			    int select_mask, int clear_mask,
> +			    struct unpack_trees_options *o)

o is only used for its excludes list.  Why not cut out the middle man
and take o->el as argument?

State (struct-worthy?):=20
	cache     	pointer to an index entry
	prefix_len	an offset into its path
	match_all 	a boolean telling whether we have some skipping to do

The current path (called the prefix), including trailing '/', is

	cache[0]->name[0] .. cache[0]->name[prefix_len - 1]

> +{
> +	const char *name, *slash;
> +	struct cache_entry *ce =3D cache[0];
> +	const char *prefix =3D ce->name;
> +	int processed, original_nr =3D nr;
> +
> +	if (prefix_len && !match_all) {

Top level gets special handling.  Let's skip to it (see [*] for where w=
e
were).

> +	while (nr) {

=46or each cache entry...

Might be nice to phrase this as a for loop.

	const char *prefix =3D cache[0]->name;
	struct cache_entry ** const cache_end =3D cache + nr;
	struct cache_entry **cep;
	for (cep =3D cache; cep !=3D cache_end; ) {
		struct cache_entry *ce =3D *cep;

> +		if (select_mask && !(ce->ce_flags & select_mask)) {
> +			cache++;
> +			ce =3D *cache;
> +			nr--;
> +			continue;
> +		}

Some index entries are disqualified.

		if (select_mask)
			if (!(ce->ce_cflags & select_mask)) {
				cep++;
				continue;
			}

> +		if (prefix_len && strncmp(ce->name, prefix, prefix_len))
> +			break;

Entries not under prefix are handled by the caller.

		if (prefix_len)
			if (strncmp(ce->name, prefix, prefix_len))
				return cep - cache;	/* number processed */

> +		name =3D ce->name + prefix_len;
> +		slash =3D strchr(name, '/');
> +
> +		/* no slash, this is a file */
> +		if (!slash) {

Leaf!

			/* File or directory?  Check if it's a submodule. */
> +			int dtype =3D ce_to_dtype(ce);
> +			if (match_all ||
> +			    excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, o-=
>el) > 0)
> +				ce->ce_flags &=3D ~clear_mask;
> +			cache++;
> +			ce =3D *cache;
> +			nr--;
> +			continue;
> +		}

			if (excluded_block ||
			    excluded_from_list(...		/* Excluded? */
				ce->ce_flags &=3D ~clear_mask;
			cep++;
			continue;
		}

Putting the loop body in its own function could allow some nice depth
reduction.

> +
> +		/* has slash, this is a directory */
> +		processed =3D clear_ce_flags_1(cache, nr,
> +					     slash + 1 - ce->name, match_all,
> +					     select_mask, clear_mask, o);
> +		cache +=3D processed;
> +		ce =3D *cache;
> +		nr -=3D processed;
> +	}
> +	return original_nr - nr;

		/* Non-leaf.  Recurse. */
		cep +=3D clear_ce_ ...
	}

How about the other case, mentioned before (see [*] above)?

	assert(prefix_len);	/* Not toplevel but a subdirectory. */
	assert(!match_all);	/* Not wholesale excluded. */

> +		int dtype =3D DT_DIR;
> +		static char path[PATH_MAX];
> +		int pathlen =3D prefix_len - 1;
> +		const char *basename;
> +
> +		memcpy(path, prefix, pathlen);
> +		path[pathlen] =3D '\0';
> +		basename =3D strrchr(path, '/');

Use memrchr?

> +		basename =3D basename ? basename+1 : path;
> +		switch (excluded_from_list(path, pathlen, basename, &dtype, o->el)=
) {
> +		case 0:
> +			while (nr && !strncmp(ce->name, prefix, prefix_len)) {
> +				cache++;
> +				ce =3D *cache;
> +				nr--;
> +			}
> +			return original_nr - nr;

		case 0:	/* Included.  Great, no flag to clear. */
			for (; cep !=3D cache_end; cep++)
				if (strncmp((*cep)->name, prefix, prefix_len))
					break;
			return cep - cache;

> +		case 1:
> +			match_all =3D 1;
> +			break;

		case 1:	/* Excluded.  Great, clear them wholesale. */
			match_all =3D 1;
			continue;

> +		default:	/* case -1, undecided */
> +			break;
> +		}

		case -1:	/* Undecided.
			continue;
		}
> +	}
> +	return original_nr - nr;
> +}

	}
	/* Ran off the end. */
	return cep - cache;
 }

That last bit could even longjmp() if expecting deeply nested
directory hierarchies.  (Sorry, joking, you should not do such an
awful thing unless timing it proves it useful.)

That was clean, thanks.

Hope some of my musings are useful anyway.
