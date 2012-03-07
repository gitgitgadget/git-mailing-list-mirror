From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Wed, 07 Mar 2012 22:22:19 +0100
Message-ID: <4F57D18B.5090506@lsrfire.ath.cx>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com> <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com> <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5OJg-0004dh-GI
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 22:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab2CGVWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 16:22:32 -0500
Received: from india601.server4you.de ([85.25.151.105]:39001 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2CGVW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 16:22:29 -0500
Received: from [192.168.2.105] (p4FFDA337.dip.t-dialin.net [79.253.163.55])
	by india601.server4you.de (Postfix) with ESMTPSA id 6BA892F8037;
	Wed,  7 Mar 2012 22:22:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192484>

Am 05.03.2012 22:34, schrieb Junio C Hamano:
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index c81a7fe..b2465b4 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -27,6 +27,8 @@ int fmt_merge_msg_config(const char *key, const cha=
r *value, void *cb)
>  			merge_log_config =3D DEFAULT_MERGE_LOG_LEN;
>  	} else if (!strcmp(key, "merge.branchdesc")) {
>  		use_branch_desc =3D git_config_bool(key, value);
> +	} else {
> +		return git_default_config(key, value, cb);
>  	}
>  	return 0;
>  }
> @@ -180,6 +182,89 @@ static void add_branch_desc(struct strbuf *out, =
const char *name)
>  	strbuf_release(&desc);
>  }
>
> +static void record_person(int which, struct string_list *people,
> +			  struct commit *commit)
> +{
> +	char name_buf[MAX_GITNAME], *name, *name_end;
> +	struct string_list_item *elem;
> +	const char *field =3D (which =3D=3D 'a') ? "\nauthor " : "\ncommitt=
er ";
> +
> +	name =3D strstr(commit->buffer, field);
> +	if (!name)
> +		return;
> +	name +=3D strlen(field);
> +	name_end =3D strchrnul(name, '<');
> +	if (*name_end)
> +		name_end--;
> +	while (isspace(*name_end) && name <=3D name_end)
> +		name_end--;
> +	if (name_end < name || name + MAX_GITNAME <=3D name_end)
> +		return;
> +	memcpy(name_buf, name, name_end - name + 1);
> +	name_buf[name_end - name + 1] =3D '\0';
> +
> +	elem =3D string_list_lookup(people, name_buf);
> +	if (!elem) {
> +		elem =3D string_list_insert(people, name_buf);
> +		elem->util =3D (void *) 0;
> +	}
> +	elem->util =3D (void*)(((intptr_t)elem->util) + 1);
> +}
> +
> +#define util_as_int(elem) ((intptr_t)((elem)->util))

Something that actually returns an int would fit the name better. ;)

> +
> +static int cmp_string_list_util_as_int(const void *a_, const void *b=
_)
> +{
> +	const struct string_list_item *a =3D a_, *b =3D b_;
> +	return util_as_int(b) - util_as_int(a);
> +}
> +
> +static void add_people_count(struct strbuf *out, struct string_list =
*people)
> +{
> +	if (people->nr =3D=3D 1)
> +		strbuf_addf(out, "%s", people->items[0].string);
> +	else if (people->nr =3D=3D 2)
> +		strbuf_addf(out, "%s (%d) and %s (%d)",
> +			    people->items[0].string,
> +			    (int)util_as_int(&people->items[0]),
> +			    people->items[1].string,
> +			    (int)util_as_int(&people->items[1]));
> +	else if (people->nr)
> +		strbuf_addf(out, "%s (%d) and others",
> +			    people->items[0].string,
> +			    (int)util_as_int(&people->items[0]));
> +}
> +
> +static int committer_is_me(const char *name)
> +{
> +	int namelen =3D strlen(name);
> +	const char *me =3D git_committer_info(IDENT_NO_DATE);
> +	return (me && !memcmp(me, name, namelen) &&
> +		!memcmp(me + namelen, " <", 2));
> +}

This looks scary due to the missing length check of me before the=20
memcmp() call, but is actually safe because git_committer_info() return=
s=20
a pointer to a static buffer that is just as long as name can possibly=20
be.  Still, perhaps this is nicer instead:

	const char *me =3D git_committer_info(IDENT_NO_DATE);
	const char *rest =3D skip_prefix(me, name);
	return rest && skip_prefix(rest, " <");

Ren=E9
