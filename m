From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Mon, 24 Mar 2014 12:24:12 -0700
Message-ID: <xmqqvbv3pfhf.fsf@gitster.dls.corp.google.com>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
	<1393491610-19476-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSAU0-0003Ln-1K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbaCXTYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 15:24:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbaCXTYV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 15:24:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BA876A12;
	Mon, 24 Mar 2014 15:24:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P7qPqU2cag3z
	uyOl0oaCuXI8I60=; b=gAdE0lK6R0Ct8mHW4T+fDzakQiBh09CTI/DSW6IYRwXh
	yTJbMnxrPpTvggNR7mxof/HkFfVgvX67NB6O7ufSPgAMSQEuKvFIS2wX0Zh4pDsm
	pKn3umSXfgvSyPid62jpdvmIF4HgLchh2Qus9QuiilnsYtchbxhnTYaAFmYTgq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oxc+iH
	genVfexmo1gyeDSbSsl/fqMCZ4tKoOGllhPFOJ6fqcmj+S14sMw0dxCXZIXf3epz
	g4fwNr0QkVRSOs1U1uVsz0uOvJs+/19apOiRnxaQ60DXUFQ+eauvpMRdisXDDnVZ
	/1qdxjaTXQgm8nIvtEXq1Rwv0zXzWzRDC8eKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA5DE76A11;
	Mon, 24 Mar 2014 15:24:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10FAB76A0D;
	Mon, 24 Mar 2014 15:24:14 -0400 (EDT)
In-Reply-To: <1393491610-19476-2-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Thu, 27 Feb 2014 10:00:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E2F40C86-B389-11E3-BF95-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244862>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
>
> We need to consider that a remote-tracking branch may match more than
> one rhs of a fetch refspec. In such a case, it is not enough to stop =
at
> the first match but look at all of the matches in order to determine
> whether a head is stale.
>
> To this goal, introduce a variant of query_refspecs which returns all=
 of
> the matching refspecs and loop over those answers to check for
> staleness.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>
> There is an unfortunate duplication of code here, as
> query_refspecs_multiple is mostly query_refspecs but we only care
> about the other side of matching refspecs and disregard the 'force'
> information which query_refspecs does want.
>
> I thought about putting both together via callbacks and having
> query_refspecs stop at the first one, but I'm not sure that it would
> make it easier to read or manage.

Sorry for a belated review.

I agree with your analysis of the root-cause of the symptom exposed
by new tests in [1/2] and the proposed solution.

> @@ -1954,25 +1981,40 @@ static int get_stale_heads_cb(const char *ref=
name,
>  	const unsigned char *sha1, int flags, void *cb_data)
>  {
>  	struct stale_heads_info *info =3D cb_data;
> +	struct string_list matches =3D STRING_LIST_INIT_DUP;
>  	struct refspec query;
> +	int i, stale =3D 1;
>  	memset(&query, 0, sizeof(struct refspec));
>  	query.dst =3D (char *)refname;
> =20
> -	if (query_refspecs(info->refs, info->ref_count, &query))
> +	query_refspecs_multiple(info->refs, info->ref_count, &query, &match=
es);
> +	if (matches.nr =3D=3D 0)
>  		return 0; /* No matches */
> =20
>  	/*
>  	 * If we did find a suitable refspec and it's not a symref and
>  	 * it's not in the list of refs that currently exist in that
> -	 * remote we consider it to be stale.
> +	 * remote we consider it to be stale. In order to deal with
> +	 * overlapping refspecs, we need to go over all of the
> +	 * matching refs.
>  	 */
> -	if (!((flags & REF_ISSYMREF) ||
> -	      string_list_has_string(info->ref_names, query.src))) {
> +	if (flags & REF_ISSYMREF)
> +		return 0;

Who frees "matches"?  At this point matches.nr !=3D 0 so there must be
something we need to free, no?

> +	for (i =3D 0; i < matches.nr; i++) {
> +		if (string_list_has_string(info->ref_names, matches.items[i].strin=
g)) {
> +			stale =3D 0;
> +			break;
> +		}
> +	}
> +
> +	string_list_clear(&matches, 0);
> +
> +	if (stale) {
>  		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tai=
l);
>  		hashcpy(ref->new_sha1, sha1);
>  	}
> =20
> -	free(query.src);

In the new code, query_refspecs_multiple() uses the result allocated
by match_name_with_pattern() to the results list, taking it out of
query.src without copying, so losing this free() is the right thing
to do---"matches" must be cleared.

And "string_list matches" is initialized as INIT_DUP, so we can rely
on string_list_clear() to free these strings.

>  	return 0;
>  }

Regarding the seemingly duplicated logic in the new function, I
wonder if the callers of non-duplicated variant may benefit if they
notice there are multiple hits, even if they cannot use more than
one in their context.  That is, what would happen if we changed
these callers to instead of calling query-refspecs call the "multi"
variant, and if that call finds multiple matches, do something about
it (e.g. warn if they use "the first hit" because they are not
acting on later hits, possibly losing information)?

Here is a minor clean-ups, both to fix style and plug leaks, that
can be squashed to this patch.  How does it look?

Thanks.

 remote.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/remote.c b/remote.c
index 26140c7..fde7b52 100644
--- a/remote.c
+++ b/remote.c
@@ -839,9 +839,8 @@ static void query_refspecs_multiple(struct refspec =
*refs, int ref_count, struct
 		if (!refspec->dst)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
+			if (match_name_with_pattern(key, needle, value, result))
 				string_list_append_nodup(results, *result);
-			}
 		} else if (!strcmp(needle, key)) {
 			string_list_append(results, value);
 		}
@@ -1989,32 +1988,29 @@ static int get_stale_heads_cb(const char *refna=
me,
=20
 	query_refspecs_multiple(info->refs, info->ref_count, &query, &matches=
);
 	if (matches.nr =3D=3D 0)
-		return 0; /* No matches */
+		goto clean_exit; /* No matches */
=20
 	/*
 	 * If we did find a suitable refspec and it's not a symref and
 	 * it's not in the list of refs that currently exist in that
-	 * remote we consider it to be stale. In order to deal with
+	 * remote, we consider it to be stale. In order to deal with
 	 * overlapping refspecs, we need to go over all of the
 	 * matching refs.
 	 */
 	if (flags & REF_ISSYMREF)
-		return 0;
+		goto clean_exit;
=20
-	for (i =3D 0; i < matches.nr; i++) {
-		if (string_list_has_string(info->ref_names, matches.items[i].string)=
) {
+	for (i =3D 0; stale && i < matches.nr; i++)
+		if (string_list_has_string(info->ref_names, matches.items[i].string)=
)
 			stale =3D 0;
-			break;
-		}
-	}
-
-	string_list_clear(&matches, 0);
=20
 	if (stale) {
 		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tail)=
;
 		hashcpy(ref->new_sha1, sha1);
 	}
=20
+clean_exit:
+	string_list_clear(&matches, 0);
 	return 0;
 }
=20
