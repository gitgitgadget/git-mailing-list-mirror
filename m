From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] apply: fix adding new files on i-t-a entries
Date: Sun, 27 Dec 2015 19:01:05 -0800
Message-ID: <xmqqpoxr9szy.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 04:01:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDO4C-0002Mo-SH
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 04:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbbL1DBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2015 22:01:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750844AbbL1DBI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2015 22:01:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36D6936481;
	Sun, 27 Dec 2015 22:01:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gsP4g516TsDD
	+kbWhr3tVKqRNRM=; b=GklB0vOs7q4frmY4F3JGGMLQHF00i0leknZmlLBYaMgW
	jKrHWEhYzjtwZxuIL3iJXBJzGmHj+EmtBtw7IfSIgVfJOdauBtOr8E/E8SOqXiYD
	h+oitQI5ZtBGVesjyC4yNurs1/cmArgazdHVA6hesf0tLSMybBw/xcVmKrULhRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aFK+LL
	s2AtKpr+3cVIN2hl76+0DtL1ehAMtDsHGIRTvGwYunz5RgMiYoUJZqKUldj/nXfx
	3spYSWIvxjLlxN3kh8oZsfkFtmKSDBV66I/Z9TL1qvl7oF2p29RMvG/0EKlARiz0
	ERnTGmLcec5ADq0xwKIpptmr5KwLG/ntR85gY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DA3536480;
	Sun, 27 Dec 2015 22:01:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A48463647F;
	Sun, 27 Dec 2015 22:01:06 -0500 (EST)
In-Reply-To: <1451181092-26054-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:51:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D287F22-AD0F-11E5-809E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283027>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Suppose that you came up with some contents to register at path F in
> your working tree, told Git about your intention with "add -N F", and
> then tried to apply a patch that wants to _create_ F:
>
> Without this patch, we would say "F already exists so a patch to
> create is incompatible with our current state".
>
> With this patch, i-t-a entries are ignored and we do not say that, bu=
t
> instead we'll hopefully trigger "does it exist in the working tree"
> check, unless you are running under "--cached".
>
> Which means that this change will not lead to data loss in the
> "untracked" file F in the working tree that was merely added to the
> index with i-t-a bit.
>
> (commit message mostly from Junio)

Hmm, I do not quite recall.  The above looks under-explained anyway;
we should stress the fact that it is a designed behaviour of this
change to allow only "apply --cached" and continue rejecting other
forms of "apply", but the above makes it sound like it is merely a
coincidence.

It might make sense, from purely mechanistic point of view, to allow
"git apply --cached" to create in the above scenario, but it does
not make any sense to allow "git apply" or "git apply --index", both
of which modifies the working tree (and I do not think the patch
allows the former; I think the latter would fail correctly, but it
may leave the index in a weird state--I didn't check).

"git add -N F" is like saying "I am telling you that F _exists_; I
am just not telling you what its exact contents are yet".  It's like
reserving a table in a restaurant.  The diner might not have arrived
yet, but that does not mean you can give the table to somebody else.

You need to wait for the reservation to be canceled (which you would
do by "git rm --cached F") before you give the table to somebody
else (i.e. creation by the patch).

So from that point of view, I am not convinced "git apply --cached"
should be allowed in such a case, though.

"I thought I told you to that I'll add to this path, but you chose
not to notice that the patch I tried to apply would create the path
with totally different contents and now I am getting from 'git diff'
nonsensical comparison" would be a plausible complaint if we took
this patch.  What is the practical benefit of automatically and
silently canceling the reservation made by an earlier "add -N"?
What workflow benefits from this change, and is this the best
solution to help that workflow?


> Reported-by: Patrick Higgins <phiggins@google.com>
> Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/apply.c       |  9 +++++----
>  t/t2203-add-intent.sh | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0769b09..315fce8 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3550,10 +3550,11 @@ static int check_to_create(const char *new_na=
me, int ok_if_exists)
>  {
>  	struct stat nst;
> =20
> -	if (check_index &&
> -	    cache_name_pos(new_name, strlen(new_name)) >=3D 0 &&
> -	    !ok_if_exists)
> -		return EXISTS_IN_INDEX;
> +	if (check_index && !ok_if_exists) {
> +		int pos =3D cache_name_pos(new_name, strlen(new_name));
> +		if (pos >=3D 0 && !ce_intent_to_add(active_cache[pos]))
> +			return EXISTS_IN_INDEX;
> +	}
>  	if (cached)
>  		return 0;
> =20
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 2a4a749..bb5ef2b 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -82,5 +82,18 @@ test_expect_success 'cache-tree invalidates i-t-a =
paths' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'apply adds new file on i-t-a entry' '
> +	git init apply &&
> +	(
> +		cd apply &&
> +		echo newcontent >newfile &&
> +		git add newfile &&
> +		git diff --cached >patch &&
> +		rm .git/index &&
> +		git add -N newfile &&
> +		git apply --cached patch
> +	)
> +'
> +
>  test_done
