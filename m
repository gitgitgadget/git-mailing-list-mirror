Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87147C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 07:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiAZHXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:23:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53481 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbiAZHXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 02:23:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 070C3172427;
        Wed, 26 Jan 2022 02:23:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4GCx0KMHTkPLGOHCsNHFvhiBuI5piF4QYqLJfdVt48I=; b=iVzp
        PDzCe1J58WonmWSD4icbqA1Mv/2pImk/6z58z/wDBhYud7I2O+LIXY04PAl5mzxs
        CtuPcr0KikJtcz8QNk9A2tsqC+m59cu8uhZEFx4zkFcDNIAyIBZewSebTOweCZz+
        BeoZanqdYKw++Da70NbPw3FXt0e1AJeeiwySSyE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5A95172426;
        Wed, 26 Jan 2022 02:23:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E906172425;
        Wed, 26 Jan 2022 02:23:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for
 negative bits
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 23:23:28 -0800
Message-ID: <xmqq1r0vt0y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBF970F2-7E78-11EC-8EA3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `--diff-filter=<bits>` option allows to filter the diff by certain
> criteria, for example `R` to only show renamed files. It also supports
> negating a filter via a down-cased letter, i.e. `r` to show _everything
> but_ renamed files.

[jc: Squashable fix-up attached at the end]

>
> However, the code is a bit overzealous when trying to figure out whether
> `git diff` should start with all diff-filters turned on because the user
> provided a lower-case letter: if the `--diff-filter` argument starts
> with an upper-case letter, we must not start with all bits turned on.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c         | 8 +++-----
>  t/t4202-log.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index c862771a589..fc1151b9c73 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4821,17 +4821,15 @@ static int diff_opt_diff_filter(const struct option *option,
>  	prepare_filter_bits();
>  
>  	/*
> -	 * If there is a negation e.g. 'd' in the input, and we haven't
> +	 * If the input starts with a negation e.g. 'd', and we haven't
>  	 * initialized the filter field with another --diff-filter, start
>  	 * from full set of bits, except for AON.
>  	 */
>  	if (!opt->filter) {
> -		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
> -			if (optch < 'a' || 'z' < optch)
> -				continue;
> +		optch = optarg[0];
> +		if (optch >= 'a' && 'z' >= optch) {

Style.  When both sides of && must be satisfied, list these three
things in the order that should appear.  For example,

		if ('z' >= optch && optch >= 'a')

is OK because it makes it clear that optch sits between 'z' and 'a'
for the expression to be true.  The existing one is also OK for the
same reason.  The condition holds when either optch is below
(i.e. comes before) 'a', or it is above (i.e. comes after) 'z', so

		if (optch < 'a' || 'z' < optch)

orders them naturally.  Also

		if ('a' <= optch && optch <= 'z')

is good for the same reason as the first example, but probably is
better because the three things are ordered from smaller to larger,
which is usually how people count things.

I'd usually let this pass if it were new code, but because the patch
breaks the ordering the existing code has, it is a different story.

But more importantly, I do not know if the updated code is correct.

>  			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
>  			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
> -			break;
>  		}
>  	}

While the finding in the cover letter (i.e. "--diff-filter=Dr does
not work as expected") is certainly good, I do not know about this
implementation.  "--diff-filter=rD" and "--diff-filter=Dr" ought to
behave the same way, but if we base our logic on optarg[0], then the
first letter and only the first letter is made special, which does
not smell right.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 50495598619..28f727937dd 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -142,6 +142,14 @@ test_expect_success 'diff-filter=R' '
>  
>  '
>  
> +test_expect_success 'diff-filter=Ra' '
> +
> +	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
> +	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
> +	test_cmp expect actual
> +

In other words, this should work the same way, no?

> +	git log -M --pretty="format:%s" --diff-filter=aR HEAD >actual &&
	
> +'
> +
>  test_expect_success 'diff-filter=C' '
>  
>  	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&



------------------------------------------------------------

 diff.c         | 31 ++++++++++++++++++++++++++++---
 t/t4202-log.sh |  4 +++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index fc1151b9c7..a57e458f63 100644
--- a/diff.c
+++ b/diff.c
@@ -4821,13 +4821,38 @@ static int diff_opt_diff_filter(const struct option *option,
 	prepare_filter_bits();
 
 	/*
-	 * If the input starts with a negation e.g. 'd', and we haven't
+	 * If there is a negation e.g. 'd' in the input, and we haven't
 	 * initialized the filter field with another --diff-filter, start
 	 * from full set of bits, except for AON.
+	 * However, the user can try to limit to selected positive bits,
+	 * in which case we do not have to.
+	 *
+	 * NEEDSWORK: the "we haven't initialied" above is meant to
+	 * address cases where multiple options, e.g. --diff-filter=d
+	 * --diff-filter=a are given.  But this implementation is
+	 * insufficient when we refrain from starting from full set
+	 * when any positive bit is given.  Consider "--diff-filter=D
+	 * --diff-filter=r", which ought to behave the same way as
+	 * "--diff-filter=Dr" and "--diff-filter=rD".  The right fix
+	 * would probably involve two "opt->filter[NP]" fields,
+	 * records positive and negative bits separately in them while
+	 * parsing, and then after processing all options, compute
+	 * opt->filter by subtracting opt->filterN from opt->filterP
+	 * (and when we do so, fill opt->filterP to full bits if it is
+	 * absolutely empty).
 	 */
 	if (!opt->filter) {
-		optch = optarg[0];
-		if (optch >= 'a' && 'z' >= optch) {
+		int has_positive = 0;
+		int has_negative = 0;
+
+		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
+			if (optch < 'a' || 'z' < optch)
+				has_positive++;
+			else
+				has_negative++;
+		}
+
+		if (!has_positive && has_negative) {
 			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
 			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
 		}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 28f727937d..128183e66f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -142,10 +142,12 @@ test_expect_success 'diff-filter=R' '
 
 '
 
-test_expect_success 'diff-filter=Ra' '
+test_expect_success 'diff-filter=Ra and aR' '
 
 	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
 	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
+	test_cmp expect actual &&
+	git log -M --pretty="format:%s" --diff-filter=aR HEAD >actual &&
 	test_cmp expect actual
 
 '
-- 
2.35.0-155-g0eb5153edc

