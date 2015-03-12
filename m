From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] list-files: add tag to each entry, filter duplicate tags
Date: Thu, 12 Mar 2015 14:48:51 -0700
Message-ID: <xmqqk2yl28fw.fsf@gitster.dls.corp.google.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 22:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWAyR-0004ow-ND
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 22:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbbCLVsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2015 17:48:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750963AbbCLVsy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 17:48:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5EC940A80;
	Thu, 12 Mar 2015 17:48:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c7j+TSbVaJVB
	DN/P6A3GS+fuN1U=; b=SrWisjfDtRx6pWzP1nOwx9mIm7hiKMnIuI3Jd5R/T+CO
	YUzNAC/wtkjcZeRf974CzjuVy4m3sIpL4oooXkabE7fbB7dqr4xVmQS18cB+dMOe
	6v0vPFx8yHWpGgg0ihjoIYSQ7ddtiy52dv2M4RMnq+Lvs1T+4sTha4IYSnDY3DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KyQjy6
	PsmZ7Nb4AhwPBH/XJGnQbWGqT5d9Mk0+XMX0j23AMlrikTZuD+TJ/7CeZTipj+yR
	GU6vWmO42xlWXWOa+H8dW/Ci+NA0YWPDj7nLWoCmAT4KWYqDUvfCG0J4BmkiqVcb
	R5hfG9VOg7AmP7ZRD3KTq7F28UJrLPyJgnO/8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEC2B40A7F;
	Thu, 12 Mar 2015 17:48:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E37BE40A7C;
	Thu, 12 Mar 2015 17:48:52 -0400 (EDT)
In-Reply-To: <1425896314-10941-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Mar
 2015 17:18:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 932F1842-C901-11E4-B61E-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265374>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> All entry strings start with two-letter tag and a space. If all
> entries have the same tags, tags are not displayed.
>
> The outcome before and after this patch is the same. But it will be
> useful in future when there are more than one type of entry.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/list-files.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index c444a53..18af65c 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -18,12 +18,16 @@ struct option ls_options[] =3D {
>  	OPT_END()
>  };
> =20
> -static void add_one(struct string_list *result, const char *name)
> +static void add_one(struct string_list *result, const char *name,
> +		    const char *tag)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
>  	struct string_list_item *item;
> =20
>  	quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
> +	strbuf_insert(&sb, 0, "   ", 3);
> +	sb.buf[0] =3D tag[0];
> +	sb.buf[1] =3D tag[1];
>  	item =3D string_list_append(result, strbuf_detach(&sb, NULL));
>  	item->util =3D (char *)name;
>  }
> @@ -42,7 +46,38 @@ static void populate_cached_entries(struct string_=
list *result,
>  				    S_ISGITLINK(ce->ce_mode)))
>  			continue;
> =20
> -		add_one(result, ce->name);
> +		add_one(result, ce->name, "  ");
> +	}
> +}
> +
> +static void cleanup_tags(struct string_list *result)
> +{
> +	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
> +
> +	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
> +		const char *s0 =3D result->items[i - 1].string;
> +		const char *s1 =3D result->items[i].string;
> +
> +		same_1 =3D same_1 && s0[0] =3D=3D s1[0];
> +		same_2 =3D same_2 && s0[1] =3D=3D s1[1];
> +	}
> +
> +	if (same_1 && same_2) {
> +		pos =3D 0;
> +		len =3D 3;
> +	} else if (same_1) {
> +		pos =3D 0;
> +		len =3D 1;
> +	} else if (same_2) {
> +		pos =3D 1;
> +		len =3D 1;
> +	} else
> +		return;
> +
> +	for (i =3D 0; i < result->nr; i++) {
> +		char *s =3D result->items[i].string;
> +		int length =3D strlen(s);
> +		memmove(s + pos, s + pos + len, length - len + 1);
>  	}
>  }

Hmm, I wonder if a different implementation strategy would produce a
code that is better for longer term maintenance and readability.
=46or example, how much pain would be involved if we later find that
we would want three "tag" letters per entry and wanted to add
support for that third tag by modifying this code?

Instead of half-formatted result in item->string and then inspect
and update the already formatted string at the textual level, why
not invert the keys and values of the table and arrange things this
way instead:

 * the "table" is expressed as a string-list, as this series does;

 * the keys to the table, item->string, is the original pathname;

 * the values in the table, item->util, is a pointer to a structure
   that allows implementation of list-files a more meaningful access
   to the information (as opposed to "the first column of formatted
   text output means X, the second column means Y"), perhaps like

    struct list_item {
	enum {
            LS_IS_FILE, LS_IS_DIRECTORY, LS_IS_SYMLINK,	LS_IS_SUBMODULE
	} kind;
	unsigned changed_from_index:1,
                 changed_from_HEAD:1;
	struct cache_time mtime;
    };

 * Internal processing is done to the value found in item->util, and
   the textual output is created by formatting what is in the
   *((struct list_item *)item->util) at the output phase.

A hypothetical "we need more tags" case would then involve adding a
new field (could be a bitfield "breaks_build:1") to the list_item
structure with a reasonable default, keeping the existing codepath
that does not care about the new field intact and updating only the
output phase, which would be a lot less painful, no?

> @@ -93,6 +128,7 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
>  		      &pathspec, NULL, NULL);
> =20
>  	populate_cached_entries(&result, &the_index);
> +	cleanup_tags(&result);
>  	display(&result);
>  	string_list_clear(&result, 0);
>  	return 0;
