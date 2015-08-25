From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] apply: make sure check_preimage() does not leave empty file on error
Date: Tue, 25 Aug 2015 10:16:09 -0700
Message-ID: <xmqqd1yb1e7a.fsf@gitster.dls.corp.google.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
	<1440205700-19749-1-git-send-email-pclouds@gmail.com>
	<1440205700-19749-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:16:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUHpd-0004G2-QL
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbbHYRQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 13:16:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36005 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbbHYRQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:16:10 -0400
Received: by padfo6 with SMTP id fo6so13609164pad.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ChwC/wPsVV+xX5TMPNtU9k5MrVge6GWi26LIlWj4slM=;
        b=Eq2GCjFSkuwoqwI0i/JnfudsFHv3ZfHptekSUM7TcvkOxNRBigvYWMXrG971cb7n3g
         b1Vn5rjsFWhl6QI51kELWPHby0tdt82IaIuuBcB/7hvipx/hUcHjJWoZ9vUxdJf8jlGP
         hjeWBDU8lyVpesggElB0i81StGkKT8/8yL86TJjIm011m+qOdnsfcmTHUGCBkSM9rSOG
         B3MP1dxXeSHQh+cf3LGqABiC0mOJvQrPIkSQoF1TCjId6OJF2bEeX7JWG5p2V5ny67rf
         4kFZ19JIjgcr7Uv2K2+7ZT/uyiQXt2KuTJHlbgMiYXCrXukjnxIKE/thcOM6ZhYDEwGm
         23AA==
X-Received: by 10.68.223.229 with SMTP id qx5mr59310979pbc.69.1440522970176;
        Tue, 25 Aug 2015 10:16:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id ts1sm21652615pbc.74.2015.08.25.10.16.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:16:09 -0700 (PDT)
In-Reply-To: <1440205700-19749-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 08:08:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276540>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The test case probably describes the test scenario the best. We have =
a
> patch to modify some file but the base file is gone. Because
> check_preimage() finds an index entry with the same old_name, it trie=
s
> to restore the on-disk base file with cached content with
> checkout_target() and move on.
>
> If this old_name is i-t-a, before this patch "apply -3" will call
> checkout_target() which will write an empty file (i-t-a entries alway=
s
> have "empty blob" SHA-1), then it'll fail at verify_index_match()
> (i-t-a entries are always "modified") and the operation is aborted.
>
> This empty file should not be created. Compare to the case where
> old_name does not exist in index, "apply -3" fails with a different
> error message "...: does not exist" but it does not touch
> worktree. This patch makes sure the same happens to i-t-a entries.

This part (unlike 3/8) is very well explained, and makes sense to
me.

> load_current() shares the same code pattern (look up an index entry,
> if on-disk version is not found, restore using the cached
> version).

The "fall-back to the cached one" is very much deliberate to allow
us to work with an empty working tree as long as the index is
correct, so this perhaps makes sense.  If the user said "add -N F",
and F is involved in the patch application, we do not want to
consider F exists in the index and we would instead want to pretend
that we do not have F ourselves.  It does not even make sense to do
"apply -3" for such a path, and rejecting with "does not exist" is a
good thing to do.

Good.

> Fix it too (even though it's not exercised in any test case)

Hmm, as this is adding new test for the other case, perhaps this
case is covered by another one, too?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/apply.c       |  4 ++--
>  t/t2203-add-intent.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 76b58a1..b185c97 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3348,7 +3348,7 @@ static int load_current(struct image *image, st=
ruct patch *patch)
>  		die("BUG: patch to %s is not a creation", patch->old_name);
> =20
>  	pos =3D cache_name_pos(name, strlen(name));
> -	if (pos < 0)
> +	if (pos < 0 || ce_intent_to_add(active_cache[pos]))
>  		return error(_("%s: does not exist in index"), name);
>  	ce =3D active_cache[pos];
>  	if (lstat(name, &st)) {
> @@ -3501,7 +3501,7 @@ static int check_preimage(struct patch *patch, =
struct cache_entry **ce, struct s
> =20
>  	if (check_index && !previous) {
>  		int pos =3D cache_name_pos(old_name, strlen(old_name));
> -		if (pos < 0) {
> +		if (pos < 0 || ce_intent_to_add(active_cache[pos])) {
>  			if (patch->is_new < 0)
>  				goto is_new;
>  			return error(_("%s: does not exist in index"), old_name);
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index bb5ef2b..96c8755 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -95,5 +95,21 @@ test_expect_success 'apply adds new file on i-t-a =
entry' '
>  	)
>  '
> =20
> +test_expect_success 'apply:check_preimage() not creating empty file'=
 '
> +	git init check-preimage &&
> +	(
> +		cd check-preimage &&
> +		echo oldcontent >newfile &&
> +		git add newfile &&
> +		echo newcontent >newfile &&
> +		git diff >patch &&
> +		rm .git/index &&
> +		git add -N newfile &&
> +		rm newfile &&
> +		test_must_fail git apply -3 patch &&
> +		! test -f newfile
> +	)
> +'
> +
>  test_done
