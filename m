From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] wt-status: avoid building bogus branch name with detached HEAD
Date: Sun, 01 Nov 2015 09:50:45 -0800
Message-ID: <xmqqbnbdip6y.fsf@gitster.mtv.corp.google.com>
References: <5634FB59.1000506@web.de> <5634FC23.2090703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 18:50:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZswmP-00072P-VC
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbKARuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 12:50:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520AbbKARux convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 12:50:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0394026796;
	Sun,  1 Nov 2015 12:50:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q6/ophovL60K
	4rgOk5EVH1g9Rf4=; b=QkNBuU+lfsh5WOvXjlC//npjgpg3vNBRVEnj0reNEY6l
	8oZunWdkj09kSFlPXkYvGNzngmyzHwpuE8bAK9FhdToBBr26orqKXcWWHaWWfdrD
	6suLYDr8Hn9yQUvGgGoPSq4hZcjTiWq/F9sIh7FGbIEO17K6Ww+1b0fKM4gNy/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pcbkM1
	B5LSsN+gv5vjJlce4z76o7gXZY5/WZq108CakAsrAYzs1LsJUyaLBqhCiKU3BMyM
	6s0Izcho8YPyCGD5DA/1XVjiTKFHMpp+ArfLqXhU7PmjhBuNTMN3jK6bdarWiGb4
	jj9Sjfkd7joRb6m18TN7sjPCYZLeFUiusfZ+k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EED3826793;
	Sun,  1 Nov 2015 12:50:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 588E62678D;
	Sun,  1 Nov 2015 12:50:46 -0500 (EST)
In-Reply-To: <5634FC23.2090703@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 31
	Oct 2015 18:36:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1462F5A6-80C1-11E5-BF4A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280639>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If we're on a detached HEAD then wt_shortstatus_print_tracking() take=
s
> the string "HEAD (no branch)", translates it, skips the first eleven
> characters and passes the result to branch_get(), which returns a bog=
us
> result and accesses memory out of bounds in order to produce it.

The fix is correct, but the above explanation looks "not quite" to
me.

That "HEAD (no branch)" thing is in a separate branch_name variable
that is not involved in the actual computation (i.e. call to
branch_get()).

The function gets "HEAD" in s->branch, uses that and skips the first
eleven characters (i.e. beyond the end of that string), lets
branch_get() to return a garbage and likely missing branch, finds
that nobody tracks that, and does the right thing anyway.  If the
garbage past the end of the "HEAD" happens to have a name of an
existing branch, we would get an incorrect result.

Thanks.

> Somehow stat_tracking_info(), which is passed that result, does the
> right thing anyway, i.e. it finds that there is no base.
>
> Avoid the bogus results and memory accesses by checking for HEAD firs=
t
> and exiting early in that case.  This fixes t7060 with --valgrind.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  t/t7060-wtstatus.sh |  2 +-
>  wt-status.c         | 15 +++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index e6af772..44bf1d8 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -213,7 +213,7 @@ EOF
>  	git checkout master
>  '
> =20
> -test_expect_failure 'status --branch with detached HEAD' '
> +test_expect_success 'status --branch with detached HEAD' '
>  	git reset --hard &&
>  	git checkout master^0 &&
>  	git status --branch --porcelain >actual &&
> diff --git a/wt-status.c b/wt-status.c
> index 083328f..e206cc9 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1644,16 +1644,19 @@ static void wt_shortstatus_print_tracking(str=
uct wt_status *s)
>  		return;
>  	branch_name =3D s->branch;
> =20
> +	if (s->is_initial)
> +		color_fprintf(s->fp, header_color, _("Initial commit on "));
> +
> +	if (!strcmp(s->branch, "HEAD")) {
> +		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
> +			      _("HEAD (no branch)"));
> +		goto conclude;
> +	}
> +
>  	if (starts_with(branch_name, "refs/heads/"))
>  		branch_name +=3D 11;
> -	else if (!strcmp(branch_name, "HEAD")) {
> -		branch_name =3D _("HEAD (no branch)");
> -		branch_color_local =3D color(WT_STATUS_NOBRANCH, s);
> -	}
> =20
>  	branch =3D branch_get(s->branch + 11);
> -	if (s->is_initial)
> -		color_fprintf(s->fp, header_color, _("Initial commit on "));
> =20
>  	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
