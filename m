From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] commit: don't count i-t-a entries when checking if the new commit is empty
Date: Mon, 06 Jun 2016 12:58:16 -0700
Message-ID: <xmqqbn3ew0mf.fsf@gitster.mtv.corp.google.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
	<20160606111643.7122-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, thomas.braun@virtuell-zuhause.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:58:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0fJ-0007tF-SB
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbcFFT6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 15:58:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751702AbcFFT6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 15:58:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D15BA23584;
	Mon,  6 Jun 2016 15:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gdULnIgVSuls
	LngUeOrw4JSr2d8=; b=Kzf/MnPF+2YAYT4t5K8j4sSjHArA2gnS56jwmhyG84Z3
	IykwL37YJc8+IoASz19KMNajjR/x/pr0YGwFfDH1zl/sgT09TnNn4nE9Oll6gZkn
	Y806OLHJ3hPmG5dTrsSulCPB7Brm7V6ZexmYzGKe0ZFVnbZTGmghJryjUGIS4QM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SNp/78
	6NxAw253byjN4nizlF14koKz7s4GxdTG4wJr8uy4ir+df2zvQtV2rnWGGrjr7W4b
	1pvAeJhiTHgRF4oPkKZV9SRTKz8c2JDAFm1o0L3OG4rQpg1NzwHOyEayFwgRgg1N
	Nx9rcbIO21gh31UH7Ae1OYVcaGkjzNMhcClJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C78BC23583;
	Mon,  6 Jun 2016 15:58:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 569E423582;
	Mon,  6 Jun 2016 15:58:18 -0400 (EDT)
In-Reply-To: <20160606111643.7122-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Mon, 6 Jun 2016 18:16:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0361A89A-2C21-11E6-89DD-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296559>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> i-t-a entries are excluded from tree building. Relying solely on acti=
ve_nr
> (or diff without --shift-ita) may lead to empty commits sometimes, wh=
en
> i-t-a entries are the only ones "changed" in the index.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/commit.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index fcfaa2b..e98ca8a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -894,9 +894,14 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>  		if (amend)
>  			parent =3D "HEAD^1";
> =20
> -		if (get_sha1(parent, sha1))
> -			commitable =3D !!active_nr;
> -		else {
> +		if (get_sha1(parent, sha1)) {
> +			int i, ita_nr =3D 0;
> +
> +			for (i =3D 0; i < active_nr; i++)
> +				if (ce_intent_to_add(active_cache[i]))
> +					ita_nr++;
> +			commitable =3D active_nr - ita_nr =3D=3D 0;
> +		} else {
>  			/*
>  			 * Unless the user did explicitly request a submodule
>  			 * ignore mode by passing a command line option we do
> @@ -910,6 +915,7 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  			if (ignore_submodule_arg &&
>  			    !strcmp(ignore_submodule_arg, "all"))
>  				diff_flags |=3D DIFF_OPT_IGNORE_SUBMODULES;
> +			diff_flags |=3D DIFF_OPT_SHIFT_INTENT_TO_ADD;
>  			commitable =3D index_differs_from(parent, diff_flags);

This feels like an ugly hack.  Doesn't wt-status do a separate
"diff" that enumerates what's different between the index and the
HEAD?

I am wondering if this "we do not include status and do not ask
run_status() about commitable bit" codepath should share more with
the other side, which you do not touch at all with this series,
which in turn must be doing the right thing already, apparently
without having to know anything about the SHIFT_INTENT_TO_ADD
hackery.

Or does "git commit" that uses run_status() still allow an empty
commit after this patch?
