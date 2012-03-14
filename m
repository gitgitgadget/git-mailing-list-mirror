From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Wed, 14 Mar 2012 12:05:34 -0700
Message-ID: <7v4ntrq9z5.fsf@alter.siamese.dyndns.org>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
 <1331736055-21019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:05:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7tW4-0002sd-II
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517Ab2CNTFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 15:05:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757383Ab2CNTFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 15:05:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32F246434;
	Wed, 14 Mar 2012 15:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oBOJfH2BfeMe
	uvKUG39sAkOkXnM=; b=uMl1ZXqmQqTRaQGjCOCwOeGYQuCGS+4OIGTA9omFwtX0
	sZSu8RqIa/CM65+cbsu7FfrW4GJK42GEpdtbVg+rSjc+Joi2z26+j6nEUhNWXIkV
	7ElIt65DB3O7g0mP6cxClmVEpnrsuISnGb7e3c/Io5lDglta6cbdcM/DUa2LNMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rXHib4
	fx+GU2sbBPq3dhO5gplTKgTgYPX+gP/7mwKTPbHZeAay14WVzWvRP1UtTixmLqQA
	c+BoPFn5V56LS4cdMATkuvQAfMzDr/Me/eF/lnyOlOJUrwsRkjvuW4Nhb1voeeJr
	H5YKD4cnE1SlezNXzROW+rxdr6T9xmG+1lSiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287A96433;
	Wed, 14 Mar 2012 15:05:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52F4E6432; Wed, 14 Mar 2012
 15:05:36 -0400 (EDT)
In-Reply-To: <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 14 Mar
 2012 21:40:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE7914BA-6E08-11E1-A602-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193148>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  Another try. Exclude all objects reachable from refs and the new pac=
k
>  from --verify-objects tests.

Thanks.  Looks much nicer in general.

>  I keep CHECK_CONNECT_QUIET change because it seems a good change
>  anyway.

It appears that you lost the "one int for a single boolean to flag"
conversion that was the point of CHECK_CONNECT_QUIET symbol.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 4c4d404..21d714b 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -180,8 +180,24 @@ static void finish_object(struct object *obj,
>  	struct rev_list_info *info =3D cb_data;
>  	if (obj->type =3D=3D OBJ_BLOB && !has_sha1_file(obj->sha1))
>  		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
> -	if (info->revs->verify_objects && !obj->parsed && obj->type !=3D OB=
J_COMMIT)
> -		parse_object(obj->sha1);
> +	if (info->revs->verify_objects &&
> +	    !obj->parsed && obj->type !=3D OBJ_COMMIT) {
> +		const char *safe_pack =3D info->revs->safe_pack;
> +		struct object_info oi;
> +		int safe =3D 0;
> +		memset(&oi, 0, sizeof(oi));
> +		if (*safe_pack &&
> +		    sha1_object_info_extended(obj->sha1, &oi) >=3D 0 &&
> +		    oi.whence =3D=3D OI_PACKED) {
> +			const char *pack =3D oi.u.packed.pack->pack_name;
> +			int len =3D strlen(pack);
> +			assert(strncmp(pack + len - 51, "/pack-", 6) =3D=3D 0);
> +			assert(strcmp(pack + len - 5, ".pack") =3D=3D 0);
> +			safe =3D !memcmp(safe_pack, pack + len - 45, 40);
> +		}
> +		if (!safe)
> +			parse_object(obj->sha1);
> +	}
>  }

This looks unnecessarily complex, and I think the complexity comes only
because the new info->revs->safe_pack is a hextual packfile ID.  Wouldn=
't
it make more sense to store a pointer to "struct packed_git" there, so
that oi.u.packed.pack can be compared with it?

The caller may need a new API in sha1_file.c to let it find a packed gi=
t
with a given packfile ID.

> diff --git a/connected.c b/connected.c
> index d762423..af81049 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -14,28 +14,43 @@
>   *
>   * Returns 0 if everything is connected, non-zero otherwise.
>   */
> -int check_everything_connected(sha1_iterate_fn fn, int quiet, void *=
cb_data)
> +int check_everything_connected(sha1_iterate_fn fn, unsigned int flag=
s,
> +			       const char *pack_lockfile, void *cb_data)
>  {
> ...
> +	if (pack_lockfile) {
> +		strbuf_addstr(&packfile, pack_lockfile);
> +		/* xxx/pack-%40s.keep */
> +		assert(strcmp(packfile.buf + packfile.len - 5, ".keep") =3D=3D 0);
> +		assert(strncmp(packfile.buf + packfile.len - 51, "/pack-", 6) =3D=3D=
 0);
> +		strbuf_setlen(&packfile, packfile.len - 5);
> +		strbuf_remove(&packfile, 0, packfile.len - 40);
> +		argv[ac++] =3D "--safe-pack";
> +		argv[ac++] =3D packfile.buf;
> +	}

That looks like a very round-about way.  Why not check the ".keep" and
"/pack-" substrings in pack_lockfile (as a side effect of doing so, you
will learn the offset of the 40-byte substring you want to put in the
packfile strbuf) and strbuf_add(&packfile, pack_lockfile + offset, 40)?

> +	assert(ac < ARRAY_SIZE(argv) && argv[ac] =3D=3D NULL);

Perhaps you want to use argv_list API instead of adding an assert() her=
e.

> diff --git a/revision.c b/revision.c
> index 819ff01..1c2d017 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1451,6 +1451,11 @@ static int handle_revision_opt(struct rev_info=
 *revs, int argc, const char **arg
>  		revs->tree_objects =3D 1;
>  		revs->blob_objects =3D 1;
>  		revs->verify_objects =3D 1;
> +	} else if (!strcmp(arg, "--safe-pack")) {
> +		if (strlen(argv[1]) !=3D 40)
> +			die("--safe-pack requires an SHA-1 as pack id, not %s", argv[1]);
> +		strcpy(revs->safe_pack, argv[1]);
> +		return 2;

The condition for the above "die()" does not check if that random 40-by=
te
string is an SHA-1, let alone it names an existing packfile.  It would =
be
solved automatically if you change the type of revs.safe_pack to a poin=
ter
to "struct packed_git", though.
