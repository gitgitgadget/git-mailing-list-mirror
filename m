From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] count-objects: report garbage files in pack
 directory too
Date: Tue, 12 Feb 2013 09:23:17 -0800
Message-ID: <7va9r9igze.fsf@alter.siamese.dyndns.org>
References: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
 <1360661277-17273-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:23:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Ja5-0005K6-Hf
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 18:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915Ab3BLRXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 12:23:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933304Ab3BLRXU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2013 12:23:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B58CAC1DC;
	Tue, 12 Feb 2013 12:23:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WvHryJ5lYxHY
	VB6+DGCYHz2aFOY=; b=oNir7/8kvmZXqey0txb8y/GSf7ycJPkhGAsi1n+ArQww
	r6TBcRr8UOURxJwwvxp1OkuOcOUV9y/triNIl1L7srUdbPHpJ4nvp8YjYAsnEip4
	ZTBH2V+bDstsIzDA8mKXpd/ntAAmf+TMEaXzFbKY5D6+TSOXrZVeZ2pAQFRIZwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MM6/TZ
	QS0DIvR0qowNlLqr7nDEMZ0HiIEI+9e19tBMlauknBSTKVol8xYKPg3LJzlppeKp
	/q4oiXuqb3crN5iNnJhYYqUelfVP7cN87NCYoLgw9QZ2bwFL5f+I87WydwvLP2iS
	RG2ffRKUUwgKdUPcG47jM0vfBTaasFjlE1OO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8C53C1DB;
	Tue, 12 Feb 2013 12:23:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE5CDC1D7; Tue, 12 Feb 2013
 12:23:18 -0500 (EST)
In-Reply-To: <1360661277-17273-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 12 Feb
 2013 16:27:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E49144F4-7538-11E2-9A7A-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216163>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +/* A hook for count-objects to report invalid files in pack director=
y */
> +extern void (*report_garbage)(const char *desc, const char *path, in=
t len, const char *name);

We may want to document the strange way the last three parameters
are used somewhere.  e.g.

	shows "path" (if "name" is NULL), or prepends "path" in
	front of name (otherwise); only for the latter, "path" can
	be a string that is not NUL-terminated but its length
	specified with "len" and in that case a slash is inserted
	between the path and the "name".

When described clearly, it sounds somewhat ugly and incoherent API,
even though it covers the immediate need X-<.

> +	sort_string_list(list);
> +
> +	for (p =3D packed_git; p; p =3D p->next) {
> +		struct string_list_item *item;
> +		if (!p->pack_local)
> +			continue;
> +		strbuf_reset(&sb);
> +		strbuf_add(&sb, p->pack_name,
> +			   strlen(p->pack_name) - 5); /* ".pack" */
> +		item =3D string_list_lookup(list, sb.buf);
> +		if (!item)
> +			continue;
> +		/*
> +		 * string_list_lookup does not guarantee to return the
> +		 * first matched string if it's duplicated.
> +		 */

Do we need to even allow duplication?  Why does prepare_packed_git_one(=
)
below have to split the pathname into the base and extension in the fir=
st
place?

If you collect all pathnames that end with known extensions (".idx",
".pack" and ".keep") in the sorted "garbage" list as separate entries i=
n
prepare_packed_git_one(), report_pack_garbage() can do the right thing
without trusting or iterating over packed_git list at all, I think.  As
the entries are sorted, .pack, .idx and all other valid .ext are groupe=
d
together for the same basename.  If you see a group that have both .pac=
k
and .idx, the group is good.  Otherwise, everybody in the group is bad
(e.g. a lonely .pack file without .idx is an unusable garbage).

How about doing it something along this line, perhaps?

	int i;
	int beginning_of_this_name =3D -1;
        int seen_bits =3D 0; /* 01 for .idx, 02 for .pack */
	for (i =3D 0; i < list->nr; i++) {
        	if (beginning_of_this_name < 0)
                	beginning_of_this_name =3D i;
		else if (list->items[i] and list->items[beginning_of_this_name]
                	 share the same basename)
			; /* keep scanning */
		else {
                	/* one name ended at (i-1) */
			if (seen_bits =3D=3D 3)
				; /* both .idx and .pack exist; good */
			else
			        report_garbage_for_one_name(list, beginning_of_this_name, i,
                                		seen_bits);
			seen_bits =3D 0;
                        beginning_of_this_name =3D i;
		}
                if (list->items[i] is ".idx")
			seen_bits |=3D 1;
                if (list->items[i] is ".pack")
			seen_bits |=3D 2;

	}
	if (0 <=3D beginning_of_this_name && seen_bits !=3D 3)
	        report_garbages_for_one_name(list, beginning_of_this_name, lis=
t->nr, seen_bits);

with a helper function report_garbage_for_one_name() that would look li=
ke this:

	report_garbage_for_one_name(...) {
                int j;
                const char *msg;
                switch (seen_bits) {
                case 0: msg =3D "no corresponding .idx nor .pack"; brea=
k;
                case 1: msg =3D "no corresponding .pack"; break;
                case 2: msg =3D "no corresponding .idx; break;
                }
                for (j =3D beginning_of_this_name; j < i; j++)
                        report_garbage(msg, list->items[j]);
	}

=46or the above to work, prepare_packed_git_one() needs to retain only =
the
paths with known extensions in garbage list. "pack-deadbeef.unk" can an=
d
should be reported as a garbage immediately when it is seen without bei=
ng
placed in the list.

> @@ -1045,9 +1100,33 @@ static void prepare_packed_git_one(char *objdi=
r, int local)
>  			if (!p)
>  				continue;
>  			install_packed_git(p);
> -		}
> +		} else if (!report_garbage) {
> +			/*
> +			 * the rest of this if-chain requires
> +			 * report_garbage !=3D NULL. Stop the chain if
> +			 * report_garbage is NULL.
> +			 */
> +			;
> +		} else if (has_extension(de->d_name, ".pack")) {
> +			struct string_list_item *item;
> +			int n =3D strlen(path) - 5;
> +			item =3D string_list_append_nodup(&garbage,
> +							 xstrndup(path, n));
> +			item->util =3D ".pack";
> +			continue;
> +		} else if (has_extension(de->d_name, ".idx")) {
> +			struct string_list_item *item;
> +			int n =3D strlen(path) - 4;
> +			item =3D string_list_append_nodup(&garbage,
> +							xstrndup(path, n));
> +			item->util =3D ".idx";
> +			continue;
> +		} else
> +			report_garbage("garbage found", path, 0, NULL);

Hmm, where is a ".keep" file handled in this flow?

The structure of the if/else cascade is much nicer than the earlier
iterations, but wouldn't it be even more clear to do this?

	if (is .idx file) {
		... do that .idx thing ...
	}

	if (!report_garbage)
        	continue; /* it does not matter what the file is */

	if (is .pack) {
		... remember that we saw this .pack ...
	} else if (is .idx) {
		... remember that we saw this .idx ...
	} else if (is .keep) {
		... remember that we saw this .keep ...
        } else {
        	... all else --- report as garbage immediately ...
	}
