From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Fri, 29 Nov 2013 22:21:04 +0100
Message-ID: <87siuedhvj.fsf@thomasrast.ch>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124432.GJ10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 29 22:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmVWN-0001y9-53
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 22:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab3K2VWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Nov 2013 16:22:39 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:36208 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab3K2VWi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Nov 2013 16:22:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 95A854D64E4;
	Fri, 29 Nov 2013 22:22:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Y5OeIeN2NZah; Fri, 29 Nov 2013 22:22:23 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [89.204.130.229])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 6CE0E4D64DE;
	Fri, 29 Nov 2013 22:22:22 +0100 (CET)
In-Reply-To: <20131114124432.GJ10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:44:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238538>

TLDR: nitpicks.  Thanks for a very nice read.

I do think it's worth fixing the syntax pedantry at the end so that we
can keep supporting arcane compilers, but otherwise, meh.

> +static int open_pack_bitmap_1(struct packed_git *packfile)

This goes somewhat against the naming convention (if you can call it
that) used elsewhere in git.  Usually foo_1() is an implementation
detail of foo(), used because it is convenient to wrap the main part in
another function, e.g. so that it can consistently free resources or
some such.  But this one operates on one pack file, so in the terms of
the rest of git, it should probably be called open_pack_bitmap_one().

> +static void show_object(struct object *object, const struct name_pat=
h *path,
> +			const char *last, void *data)
> +{
> +	struct bitmap *base =3D data;
> +	int bitmap_pos;
> +
> +	bitmap_pos =3D bitmap_position(object->sha1);
> +
> +	if (bitmap_pos < 0) {
> +		char *name =3D path_name(path, last);
> +		bitmap_pos =3D ext_index_add_object(object, name);
> +		free(name);
> +	}
> +
> +	bitmap_set(base, bitmap_pos);
> +}
> +
> +static void show_commit(struct commit *commit, void *data)
> +{
> +}

A bit unfortunate that you inherit the strange show_* naming from
builtin/pack-objects.c, which seems to have stolen some code from
builtin/rev-list.c at some point without worrying about better naming..=
=2E

> +static void show_objects_for_type(
> +	struct bitmap *objects,
> +	struct ewah_bitmap *type_filter,
> +	enum object_type object_type,
> +	show_reachable_fn show_reach)
> +{
[...]
> +	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it))=
 {
> +		eword_t word =3D objects->words[i] & filter;
> +
> +		for (offset =3D 0; offset < BITS_IN_WORD; ++offset) {
> +			const unsigned char *sha1;
> +			struct revindex_entry *entry;
> +			uint32_t hash =3D 0;
> +
> +			if ((word >> offset) =3D=3D 0)
> +				break;
> +
> +			offset +=3D ewah_bit_ctz64(word >> offset);
> +
> +			if (pos + offset < bitmap_git.reuse_objects)
> +				continue;
> +
> +			entry =3D &bitmap_git.reverse_index->revindex[pos + offset];
> +			sha1 =3D nth_packed_object_sha1(bitmap_git.pack, entry->nr);
> +
> +			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->of=
fset);
> +		}

You have a very nice bitmap_each_bit() function in ewah/bitmap.c, why
not use it here?

> +int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
> +				       uint32_t *entries,
> +				       off_t *up_to)
> +{
> +	/*
> +	 * Reuse the packfile content if we need more than
> +	 * 90% of its objects
> +	 */
> +	static const double REUSE_PERCENT =3D 0.9;

Curious: is this based on some measurements or just a guess?


> diff --git a/pack-bitmap.h b/pack-bitmap.h
[...]
> +static const char BITMAP_IDX_SIGNATURE[] =3D {'B', 'I', 'T', 'M'};;

There's a stray ; at the end of the line that is technically not
permitted:

pack-bitmap.h:22:65: warning: ISO C does not allow extra =E2=80=98;=E2=80=
=99 outside of a function [-Wpedantic]

> +enum pack_bitmap_opts {
> +	BITMAP_OPT_FULL_DAG =3D 1,

And I think this trailing comma on the last enum item is also strictly
speaking not allowed, even though it is very nice to have:

pack-bitmap.h:28:27: warning: comma at end of enumerator list [-Wpedant=
ic]

--=20
Thomas Rast
tr@thomasrast.ch
