From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/25] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Mon, 08 Feb 2016 13:09:24 -0800
Message-ID: <xmqqvb5y7vuj.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:09:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSt3r-0003bF-P0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbcBHVJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 16:09:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753219AbcBHVJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 16:09:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6775942D23;
	Mon,  8 Feb 2016 16:09:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vuMftmM3ubXB
	+8jFE7ugfl4aSMo=; b=Z6EdA7dyI/9seKnwNw/PytOzH6siIzbHqJulE5qUs5XY
	P+e/9cjm4gWlQwZ4UyD5heMPTGaxpaDKYEWj9BJH5nwUUWdilDyh6610jMP600Eb
	K7zl3st/3IZQeYqYYO8Lr9BJoDiL3W/hPN9VDKp0T5nQCSDvnp0yUyNAQQKu89k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LKOI9r
	KAtwsZXDQRm2X50dnrEjn/xPwtl4uPKEgA3EZW9jrpPMRrG5yTCsQsm29OA49iUv
	cronIYLbcg3TYiMz7ULM6CY1HdP/95gd9z78xTu5ytQZullGoUlwhZIXqN+nlm+9
	n28s94yhXpsCKAbyoxPFot5UYoycTl4YsHAtw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DECE42D22;
	Mon,  8 Feb 2016 16:09:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC1BB42D21;
	Mon,  8 Feb 2016 16:09:25 -0500 (EST)
In-Reply-To: <1454576641-29615-15-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3BCD9378-CEA8-11E5-BB0D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285806>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Instead of a custom commit walker like get_shallow_commits(), this ne=
w
> function uses rev-list to mark NOT_SHALLOW to all reachable commits,
> except borders. The definition of reachable is to be defined by the
> protocol later. This makes it more flexible to define shallow boundar=
y.
>
> Note: if a commit has one NOT_SHALLOW parent and one SHALLOW parent,
> then it's considered the boundary. Which means in the client side, th=
is
> commit has _no_ parents. This could lead to surprising cuts if we're =
not
> careful.
>
> Another option is to include more commits and only mark commits whose
> all parents are SHALLOW as boundary.

The second and third are greek to me at this point ;-) but hopefully
they will become clear as we read on.

> +/*
> + * Given rev-list arguments, run rev-list. All reachable commits
> + * except border ones are marked with not_shallow_flag. Border commi=
ts
> + * are marked with shallow_flag. The list of border/shallow commits
> + * are also returned.
> + */
> +struct commit_list *get_shallow_commits_by_rev_list(int ac, const ch=
ar **av,
> +						    int shallow_flag,
> +						    int not_shallow_flag)
> +{
> +	struct commit_list *result =3D NULL, *p;
> +	struct rev_info revs;
> +	unsigned int i, nr;
> +
> +	/*
> +	 * SHALLOW (excluded) and NOT_SHALLOW (included) should not be
> +	 * set at this point. But better be safe than sorry.
> +	 */
> +	nr =3D get_max_object_index();
> +	for (i =3D 0; i < nr; i++) {
> +		struct object *o =3D get_indexed_object(i);
> +		if (!o || o->type !=3D OBJ_COMMIT)
> +			continue;
> +		o->flags &=3D ~(shallow_flag | not_shallow_flag);
> +	}

This is slightly different from clear_object_flags(), but I cannot
tell if it is intended, or if you forgot that the function exists.

> +	is_repository_shallow(); /* make sure shallows are read */
> +
> +	init_revisions(&revs, NULL);
> +	save_commit_buffer =3D 0;
> +	setup_revisions(ac, av, &revs, NULL);
> +
> +	/* Mark all reachable commits as NOT_SHALLOW */
> +	if (prepare_revision_walk(&revs))
> +		die("revision walk setup failed");
> +	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_flag);
> +
> +	/*
> +	 * mark border commits SHALLOW + NOT_SHALLOW.
> +	 * We cannot clear NOT_SHALLOW right now. Imagine border
> +	 * commit A is processed first, then commit B, whose parent is
> +	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
> +	 * itself is considered border at step 2, which is incorrect.
> +	 */
> +	nr =3D get_max_object_index();
> +	for (i =3D 0; i < nr; i++) {

I'd really like not to see a loop over 0..get_max_object_index().
Are there many codepaths that peek into the in-core entire object
store already?  Would it work equally well to keep track of the
commits discovered in show_commit() to use as the set of commits
you need to visit in this second pass?

> +		struct object *o =3D get_indexed_object(i);
> +		struct commit *c =3D (struct commit *)o;
> +
> +		if (!o || o->type !=3D OBJ_COMMIT ||
> +		    !(o->flags & not_shallow_flag))
> +			continue;
> +
> +		if (parse_commit(c))
> +			die("unable to parse commit %s",
> +			    oid_to_hex(&c->object.oid));
> +
> +		for (p =3D c->parents; p; p =3D p->next)
> +			if (!(p->item->object.flags & not_shallow_flag)) {
> +				o->flags |=3D shallow_flag;
> +				commit_list_insert(c, &result);
> +				break;
> +			}
> +	}
> +
> +	/*
> +	 * Now we can clean up NOT_SHALLOW on border commits. Having
> +	 * both flags set can confuse the caller.
> +	 */
> +	for (p =3D result; p; p =3D p->next) {
> +		struct object *ro =3D &p->item->object;

Why "ro" only in this third pass, unlike the other two passes that
said "o" which is in a sense more descriptive?

> +		if ((ro->flags & not_shallow_flag) &&
> +		    (ro->flags & shallow_flag))

If you introduce a "both_flags =3D shallow_flag | not_shallow_flag"
at the very beginning, this will become

	if (o->flags & both_flags)
        	o->flags &=3D ~not_shallow_flag;

which would probably be easier to read.  You can pass the same to
clear_object_flags() at the first pass.

> +			ro->flags &=3D ~not_shallow_flag;
> +	}
> +	return result;
> +}

Other than that, this step looks quite straight-forward to me.

Thanks.

> +
>  static void check_shallow_file_for_update(void)
>  {
>  	if (is_shallow =3D=3D -1)
