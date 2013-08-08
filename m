From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] read-cache: save index entry updates in ILOG index extension
Date: Thu, 08 Aug 2013 11:46:18 -0700
Message-ID: <7veha49g1x.fsf@alter.siamese.dyndns.org>
References: <1375597720-13236-1-git-send-email-pclouds@gmail.com>
	<1375966270-10968-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 20:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7VED-0004rD-51
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966110Ab3HHSqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 14:46:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966093Ab3HHSqY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 14:46:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A5DD37ECF;
	Thu,  8 Aug 2013 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ngIbKczWYMsD
	3ceReOXqIFtea+M=; b=dF9ZD0AFvLyYjcIVoYL1v0ASkisXgm6lUc1Gp/5qlV31
	JsLG3eCihPV6KvocLkqHChK6v+kNQSTyt43kasnDrQ0uf5VBzW4O/5VtAWsHQfjh
	/aeXCk9+rVZAgVQ05lWB/09aK3xTVLwbp0JAiApv20GjNCUpHppcHn7W94IgFOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sj5mPG
	fo2guso+oaLs913DynNbaU4zIin+6ZziArqbeKTrkP1ebB4AoPW5t7Q2afh1hGZ7
	wriUjUj8lsAJShXg4nKEAHM7MVO0S+sl6g0XC1dfHTP4pYLjhnBc1QzWOjBOiDbK
	i028/0e9uzYo+i45ygn3MChSpJAhiUOxUlB+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE2337ECD;
	Thu,  8 Aug 2013 18:46:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 963FC37EC1;
	Thu,  8 Aug 2013 18:46:20 +0000 (UTC)
In-Reply-To: <1375966270-10968-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 8 Aug
 2013 19:51:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D13F546A-005A-11E3-82C2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231917>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Old operation's updates are removed as new ones are added to keep the
> size under 1 MB. ILOG keeps minimum 10 operations regardless of its
> size. These contansts should be configurable later one. ILOG content
> will be compressed later on so that it leaves minimum
> footprint.

List of <sha-1, pathname> tuples would not compress well, I suspect.

> Because it's only needed at index writing time, read-only
> operations won't pay the cost for decompressing and compressing ILOG.

Another idea is to lazily read existing ILOG by (1) keeping just an
offset in the originating index file at read_index() time and (2)
reading it on demand when ":-4:Makefile" was asked for.

> diff --git a/cache.h b/cache.h
> index 85b544f..a2156bf 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -168,6 +168,7 @@ struct cache_entry {
> =20
>  /* used to temporarily mark paths matched by pathspecs */
>  #define CE_MATCHED           (1 << 26)
> +#define CE_BASE              (1 << 27)

As this is not about pathspec match, please have its own comment
line (or a blank line, if this goes without comment) above this new
line.

> @@ -277,6 +278,7 @@ struct index_state {
>  		 initialized : 1;
>  	struct hash_table name_hash;
>  	struct hash_table dir_hash;
> +	struct strbuf *index_log;
>  };

Sane to have this as a per-index_state variable.

> +extern void log_index_changes(const char *prefix, const char **argv)=
;

Not sane to name this function _index_anything and not to have index_st=
ate
as its first parameter, breaking the naming convention.

> diff --git a/read-cache.c b/read-cache.c
> index c3d5e35..4021667 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -14,6 +14,7 @@
>  #include "resolve-undo.h"
>  #include "strbuf.h"
>  #include "varint.h"
> +#include "quote.h"
> =20
>  static struct cache_entry *refresh_cache_entry(struct cache_entry *c=
e, int really);
> =20
> @@ -33,8 +34,10 @@ static struct cache_entry *refresh_cache_entry(str=
uct cache_entry *ce, int reall
>  #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
>  #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
>  #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
> +#define CACHE_EXT_INDEX_LOG 0x494C4F47 /* "ILOG" */
> =20
>  struct index_state the_index;
> +static struct strbuf log_message =3D STRBUF_INIT;

Not sane to have a single global here.  Give the callers a helper
function to prepare a ilog message into a strbuf they prepare before
they muck with argc/argv with parse_options(), and have them pass
that strbuf to

	log_index_changes(struct index_state *, struct strbuf *);

and supply the usual

	#define log_cache_changes(logmsg) log_index_changes(&the_index, (logms=
g))

macro, inside "#ifndef NO_THE_INDEX_COMPATIBILITY_MACROS" section.

> @@ -1509,6 +1520,14 @@ int read_index_from(struct index_state *istate=
, const char *path)
>  		src_offset +=3D extsize;
>  	}
>  	munmap(mmap, mmap_size);
> +	if (istate =3D=3D &the_index) {

Yuck.  Why can't the callers operate on their own copies of the
in-core index and get the same benefit?

> +		for (i =3D 0; i < istate->cache_nr; i++) {
> +			struct cache_entry *ce =3D istate->cache[i];
> +			if (ce_stage(ce))
> +				continue;
> +			ce->ce_flags |=3D CE_BASE;
> +		}
> +	}
>  	return istate->cache_nr;

> +static void get_updated_entries(struct index_state *istate,
> +				struct cache_entry ***cache_out,
> +				unsigned int *cache_nr_out)
> +{
> +	struct cache_entry **cache;
> +	unsigned int i, nr, cache_nr =3D 0;
> +
> +	*cache_nr_out =3D 0;
> +	*cache_out =3D NULL;
> +	for (i =3D 0; i < istate->cache_nr; i++) {
> +		if (istate->cache[i]->ce_flags & CE_BASE)
> +			continue;
> +		cache_nr++;
> +	}
> +	if (!cache_nr)
> +		return;
> +	cache =3D xmalloc(cache_nr * sizeof(*istate->cache));
> +	for (i =3D nr =3D 0; i < istate->cache_nr; i++) {
> +		struct cache_entry *ce =3D istate->cache[i];
> +		if (ce->ce_flags & CE_BASE)
> +			continue;
> +		cache[nr++] =3D ce;
> +	}
> +	*cache_out =3D cache;
> +	*cache_nr_out =3D cache_nr;
> +}

I can read what the function does, but I do not understand the
assumption this code makes.

Is this assuming that any newly created cache_entry that goes to
the_index via add_index_entry() will not have CE_BASE bit set?  Some
codepaths try to preserve the flags bit they do not care and/or
understand (e.g. rename_index_entry_at() creates a new ce with a new
name, and keeps most of the flags bit except for the name-hash state
bits), so CE_BASE will be propagated from the original to the new
one, I think.

You seem to be recording the state _after_ the change---that can be
read without the extension, can't it?  I thought we care more about
the state that was _lost_ by the change.

Recording the state after the change misses deleted entries, doesn't
it?

> +static void write_index_log(struct strbuf *sb,
> +			    const struct strbuf *old_log,
> +			    const struct strbuf *msg,
> +			    struct cache_entry **cache,
> +			    unsigned int cache_nr)
> +{
> +	struct strbuf body =3D STRBUF_INIT;
> +	unsigned int i, size, nr, body_len, hdr_len;
> +	const char *end, *p;
> +	strbuf_addf(&body, "%s%c", msg->buf, '\0');
> +	for (i =3D 0; i < cache_nr; i++)
> +		strbuf_addf(&body, "%s %s%c", sha1_to_hex(cache[i]->sha1),
> +			    cache[i]->name, '\0');

We do not care about file modes (e.g. "update-index --chmod")?

> +	strbuf_addf(sb, "%u %u%c", (unsigned int)cache_nr, (unsigned int)bo=
dy.len, '\0');

OK, so the header records how many entries there are and how big the
record is, followed by a list of tuples that describe what got
changed.

> +	strbuf_addbuf(sb, &body);
> +	strbuf_release(&body);
> +
> +	if (!old_log)
> +		return;
> +
> +	size =3D sb->len;
> +	nr =3D cache_nr;
> +	end =3D old_log->buf + old_log->len;
> +	p =3D old_log->buf;
> +	while (p < end && (size < 1024 * 1024 || nr < 10)) {
> +		if (sscanf(p, "%u %u", &cache_nr, &body_len) !=3D 2) {
> +			error("fail to parse old index log at %u", (unsigned int)(p - old=
_log->buf));
> +			break;
> +		}

And that header is used to determine how much to bulk copy from the
stack of old records.

>  int write_index(struct index_state *istate, int newfd)
>  {
>  	git_SHA_CTX c;
> @@ -1780,6 +1879,11 @@ int write_index(struct index_state *istate, in=
t newfd)
>  	int entries =3D istate->cache_nr;
>  	struct stat st;
>  	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
> +	unsigned int index_log_nr =3D 0;
> +	struct cache_entry **index_log_entries =3D NULL;
> +
> +	if (istate =3D=3D &the_index && log_message.len)
> +		get_updated_entries(istate, &index_log_entries, &index_log_nr);

Yuck about "istate =3D=3D &the_index" again.

>  	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
>  		if (cache[i]->ce_flags & CE_REMOVE)
> @@ -1846,6 +1950,23 @@ int write_index(struct index_state *istate, in=
t newfd)
>  		if (err)
>  			return -1;
>  	}
> +	if (index_log_entries && log_message.len) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		write_index_log(&sb, istate->index_log, &log_message,
> +				index_log_entries, index_log_nr);
> +		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_INDEX_LOG,
> +					     sb.len) < 0
> +			|| ce_write(&c, newfd, sb.buf,
> +				    sb.len) < 0;
> +		if (istate->index_log)
> +			strbuf_release(istate->index_log);
> +		else
> +			istate->index_log =3D xmalloc(sizeof(*istate->index_log));
> +		*istate->index_log =3D sb;
> +		if (err)
> +			return -1;
> +	}
> +	free(index_log_entries);
> =20
>  	if (ce_flush(&c, newfd) || fstat(newfd, &st))
>  		return -1;
