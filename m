From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Mon, 13 Apr 2009 11:51:55 -0700
Message-ID: <7v4owsfktw.fsf@gitster.siamese.dyndns.org>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 20:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtRHo-0002rZ-8b
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbZDMSwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 14:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbZDMSwF
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:52:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZDMSwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 14:52:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69376AA53D;
	Mon, 13 Apr 2009 14:52:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 289D2AA538; Mon,
 13 Apr 2009 14:51:57 -0400 (EDT)
In-Reply-To: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?Micha=C5=82?= Kiedrowicz's message of "Sat, 11 Apr 2009 21:31:00
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C5CAC84-285C-11DE-AA2C-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116477>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 1926cd8..6f6bf85 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2271,6 +2271,16 @@ static struct patch *in_fn_table(const char *n=
ame)
>  	return NULL;
>  }
> =20
> +static int to_be_deleted(struct patch *patch)
> +{
> +	return patch =3D=3D (struct patch *) -2;
> +}
> +
> +static int was_deleted(struct patch *patch)
> +{
> +	return patch =3D=3D (struct patch *) -1;
> +}

Please use more descriptive symbolic constants, and add a comment.
Perhaps:

    /*
     * item->util in the filename table records the status of the path.
     * Usually it points at a patch (whose result records the contents
     * of it after applying it), but it could be PATH_WAS_DELETED for a
     * path that a previously applied patch has already removed.
     */
    #define PATH_TO_BE_DELETED ((struct patch *) -2)
    #define PATH_WAS_DELETED ((struct patch *) -1)

> @@ -2295,6 +2305,24 @@ static void add_to_fn_table(struct patch *patc=
h)
> ...
> +static void prepare_fn_table(struct patch *patch)
> +{
> +	/*
> +	 * store information about incoming file deletion
> +	 */
> +	while (patch) {
> +		if ((patch->new_name =3D=3D NULL) || (patch->is_rename)) {
> +			struct string_list_item *item =3D
> +				string_list_insert(patch->old_name, &fn_table);
> +			item->util =3D (struct patch *) -2;
> +		}
> +		patch =3D patch->next;
> +	}
> +}

This PATH_TO_BE_DELETED logic should be Ok for the normal case, but it
seems a bit fragile.  In a sequence of patches, if you have even one pa=
tch
that makes the path disappear, you initialize it as PATH_TO_BE_DELETED,
and special case the "creation should not clobber existing path" rule t=
o
allow it to be present in the tree.

That may make this sequence work, I presume, with your change:

	patch #1	renames frotz.c to hello.c
        patch #2	renames hello.c to frotz.c

because of patch #2, hello.c is marked as PATH_TO_BE_DELETED initially =
and
then when patch #1 is handled, frotz.c is allowed to replace it.

But if you have further patches that do the following (the "file table"
mechanism was added to handle concatenated patches that affect the same
path more than once), I thing PATH_TO_BE_DELETED logic would break down=
:

        patch #3	renames alpha.c to hello.c
	patch #4	renames hello.c to alpha.c

When patch #3 is handled, the PATH_TO_BE_DELETED mark is long gone from
hello.c, and we will see the same failure you addressed in your patch,
won't we?

The prepare_fn_table() may be a good place to diagnose such a situation
and warn or error out if the user feeds such an input we cannot handle
sanely.

> @@ -2410,6 +2438,8 @@ static int check_preimage(struct patch *patch, =
struct cache_entry **ce, struct s
>  			return error("%s: %s", old_name, strerror(errno));
>  	}
> =20
> +	if(to_be_deleted(tpatch)) tpatch =3D NULL;
> +

Style;

	if (to_be_deleted(tpatch))
        	tpatch =3D NULL;

Other than that, I think it is a sensible approach.
