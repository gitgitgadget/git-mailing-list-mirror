From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore: fix iteration order of identical files during rename detection
Date: Wed, 30 Mar 2016 13:51:44 -0700
Message-ID: <xmqqtwjnsn8f.fsf@gitster.mtv.corp.google.com>
References: <1459326907-16179-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	Bill Okara <billokara@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:51:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alN5m-00081f-9o
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbcC3Uvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 16:51:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751210AbcC3Uvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 16:51:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5938513DF;
	Wed, 30 Mar 2016 16:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yp0o4Bsxvs1f
	w+Ie493LmIYI6K0=; b=Bl0/9xwSNgChSdxhbevhfjOnIrEHu593z4o7Ppd0jLbh
	MDP3KClfJjk2xTgG/+DwdY4wlMC/6EQxglq88waGGVkKqQXurGLeNc9KcgGECCSB
	Y74+yEQVT2Rm+4/O2B8tH83l2+b3N47VQ0ztRTVlRbLpuR4f/xMxd77/YbpdgtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZqwLfe
	L+jhGPhTdho445xSIBdQ1LRQG2fQ4ujYpehwFQaIAPQP/XZqxNbPC5n1+0uPTjNW
	ovzkMpa7O7qeryw6+RE4UzlGqII/vAUZX8mJ1AnzXBVTtM8zlih09Xgx5QijZAIe
	VsIBMMza0EYM86twR5MOJ26Nl4npgtzfDyVSs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB7B9513DE;
	Wed, 30 Mar 2016 16:51:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D21D513DD;
	Wed, 30 Mar 2016 16:51:46 -0400 (EDT)
In-Reply-To: <1459326907-16179-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 30 Mar 2016 10:35:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 374FB234-F6B9-11E5-9E2F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290345>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Fill the hashmap with source entries in reverse order to restore the
> original exact rename detection behavior.

Thanks for digging out and fixing this unintended regression that
happened long time ago.  Will queue.

>
> Reported-by: Bill Okara <billokara@gmail.com>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>
> Resend of the patch, with a slightly updated commit message, included
> in
>
>   http://thread.gmane.org/gmane.comp.version-control.git/287281/focus=
=3D287570
>
> Being embedded with scissors in an email without Junio among the
> recipients on the day the first -rc was tagged...  no wonder it flew
> below the radar.
>
>  diffcore-rename.c      |  6 ++++--
>  t/t4001-diff-rename.sh | 11 +++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 3b3c1ed535e7..7f03eb5a0404 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -340,9 +340,11 @@ static int find_exact_renames(struct diff_option=
s *options)
>  	int i, renames =3D 0;
>  	struct hashmap file_table;
> =20
> -	/* Add all sources to the hash table */
> +	/* Add all sources to the hash table in reverse order, because
> +	 * later on they will be retrieved in LIFO order.
> +	 */
>  	hashmap_init(&file_table, NULL, rename_src_nr);
> -	for (i =3D 0; i < rename_src_nr; i++)
> +	for (i =3D rename_src_nr-1; i >=3D 0; i--)
>  		insert_file_table(&file_table, i, rename_src[i].p->one);
> =20
>  	/* Walk the destinations and find best source match */
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 2f327b749588..ed90c6c6f984 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -77,6 +77,17 @@ test_expect_success 'favour same basenames even wi=
th minor differences' '
>  	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
>  	git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"'
> =20
> +test_expect_success 'two files with same basename and same content' =
'
> +	git reset --hard &&
> +	mkdir -p dir/A dir/B &&
> +	cp path1 dir/A/file &&
> +	cp path1 dir/B/file &&
> +	git add dir &&
> +	git commit -m 2 &&
> +	git mv dir other-dir &&
> +	git status | test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/fi=
le"
> +'
> +
>  test_expect_success 'setup for many rename source candidates' '
>  	git reset --hard &&
>  	for i in 0 1 2 3 4 5 6 7 8 9;
