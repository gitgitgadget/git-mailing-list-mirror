Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2791F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbcGKUH5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:07:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbcGKUH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2016 16:07:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5CCC2CA28;
	Mon, 11 Jul 2016 16:07:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VWPS4u6GejSM
	4vPoB6Ie9qZEMJ4=; b=vFJZ2rzwHGN1RqjpssttTdynWEsYKN07ERuZYv4q+Cjp
	/GXBHAOHtLZSD7fEyThY0SWBAqs135cZayGRqFMGV2kmgKrsc7aaUAM0DN5NA1/B
	Zkp2DXaTZjbxs5y1mZUg0VttfzMzg0GBViGZuKb/wYBKgkTf+NnLqMq53T9WI/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fSMXMu
	ErzVQrrne9Qf3+uiUWtoyFPXIO7f2aLRmWBAWPc1fBzh6zjxq0E5tfEEwazTrliz
	uRhk/9wD/ZEXdZUWLVYZUzpNZcdBjuoqFclS5LLfxlvehZqQj+NH0Jj3L+gL77BT
	1hg2XhIIYkQ/FCfaQce14sYVKqyuwi/e9IW2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCAF42CA27;
	Mon, 11 Jul 2016 16:07:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41A862CA26;
	Mon, 11 Jul 2016 16:07:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
	<xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
	<2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
	<xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
	<f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de>
	<xmqqoa68kl7n.fsf@gitster.mtv.corp.google.com>
	<xmqqk2gvlur5.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 11 Jul 2016 13:07:52 -0700
In-Reply-To: <xmqqk2gvlur5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Jul 2016 13:50:22 -0700")
Message-ID: <xmqqinwc7xbb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 271CAD8C-47A3-11E6-93DF-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Subject: [PATCH] merge: avoid "safer crlf" during recording of merge results
> ...
> We can work this around by not refreshing the new cache entry in
> make_cache_entry() called by add_cacheinfo().  After add_cacheinfo()
> adds the new entry, we can call refresh_cache_entry() on that,
> knowing that addition of this new cache entry would have removed the
> stale cache entries that had CRLF in stage #2 that were carried over
> before the renormalizing merge started and will not interfere with
> the correct recording of the result.
>
> The test update was taken from a series by Torsten Bögershausen
> that attempted to fix this with a different approach (which was a
> lot more intrusive).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

How do things look at this point?  This version is what I ended up
queuing in 'pu', but I took your "Thanks" in $gmane/299120 to only
mean "Thanks for feeding some ideas to help me move forward", not
necessarily "Tnanks that looks like the right approach." yet, so
right now both topics are stalled and waiting for an action from
you.

Thanks.

>  cache.h                    |  1 +
>  merge-recursive.c          | 17 ++++++++++++----
>  read-cache.c               |  5 +----
>  t/t6038-merge-text-auto.sh | 51 +++++++++++++++++++++++++---------------------
>  4 files changed, 43 insertions(+), 31 deletions(-)

[no comment below this line; the contents kept as reference]

> diff --git a/cache.h b/cache.h
> index b829410..b33cb54 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -632,6 +632,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
>  #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
>  #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
>  extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
> +extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsigned int);
>  
>  extern void update_index_if_able(struct index_state *, struct lock_file *);
>  
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b880ae5..de37e51 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -202,12 +202,21 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
>  		const char *path, int stage, int refresh, int options)
>  {
>  	struct cache_entry *ce;
> -	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
> -			      (refresh ? (CE_MATCH_REFRESH |
> -					  CE_MATCH_IGNORE_MISSING) : 0 ));
> +	int ret;
> +
> +	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, 0);
>  	if (!ce)
>  		return error(_("addinfo_cache failed for path '%s'"), path);
> -	return add_cache_entry(ce, options);
> +
> +	ret = add_cache_entry(ce, options);
> +	if (refresh) {
> +		struct cache_entry *nce;
> +
> +		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
> +		if (nce != ce)
> +			ret = add_cache_entry(nce, options);
> +	}
> +	return ret;
>  }
>  
>  static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
> diff --git a/read-cache.c b/read-cache.c
> index d9fb78b..6af409a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -19,9 +19,6 @@
>  #include "split-index.h"
>  #include "utf8.h"
>  
> -static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
> -					       unsigned int options);
> -
>  /* Mask for the name length in ce_flags in the on-disk index */
>  
>  #define CE_NAMEMASK  (0x0fff)
> @@ -1254,7 +1251,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	return has_errors;
>  }
>  
> -static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
> +struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
>  					       unsigned int options)
>  {
>  	return refresh_cache_ent(&the_index, ce, options, NULL, NULL);
> diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
> index 33b77ee..5e8d5fa 100755
> --- a/t/t6038-merge-text-auto.sh
> +++ b/t/t6038-merge-text-auto.sh
> @@ -91,16 +91,13 @@ test_expect_success 'Merge after setting text=auto' '
>  	compare_files expected file
>  '
>  
> -test_expect_success 'Merge addition of text=auto' '
> +test_expect_success 'Merge addition of text=auto eol=LF' '
> +	git config core.eol lf &&
>  	cat <<-\EOF >expected &&
>  	first line
>  	same line
>  	EOF
>  
> -	if test_have_prereq NATIVE_CRLF; then
> -		append_cr <expected >expected.temp &&
> -		mv expected.temp expected
> -	fi &&
>  	git config merge.renormalize true &&
>  	git rm -fr . &&
>  	rm -f .gitattributes &&
> @@ -109,17 +106,31 @@ test_expect_success 'Merge addition of text=auto' '
>  	compare_files  expected file
>  '
>  
> +test_expect_success 'Merge addition of text=auto eol=CRLF' '
> +	git config core.eol crlf &&
> +	cat <<-\EOF >expected &&
> +	first line
> +	same line
> +	EOF
> +
> +	append_cr <expected >expected.temp &&
> +	mv expected.temp expected &&
> +	git config merge.renormalize true &&
> +	git rm -fr . &&
> +	rm -f .gitattributes &&
> +	git reset --hard b &&
> +	echo >&2 "After git reset --hard b" &&
> +	git ls-files -s --eol >&2 &&
> +	git merge a &&
> +	compare_files  expected file
> +'
> +
>  test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
> +	git config core.eol native &&
>  	echo "<<<<<<<" >expected &&
> -	if test_have_prereq NATIVE_CRLF; then
> -		echo first line | append_cr >>expected &&
> -		echo same line | append_cr >>expected &&
> -		echo ======= | append_cr >>expected
> -	else
> -		echo first line >>expected &&
> -		echo same line >>expected &&
> -		echo ======= >>expected
> -	fi &&
> +	echo first line >>expected &&
> +	echo same line >>expected &&
> +	echo ======= >>expected &&
>  	echo first line | append_cr >>expected &&
>  	echo same line | append_cr >>expected &&
>  	echo ">>>>>>>" >>expected &&
> @@ -135,15 +146,9 @@ test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
>  	echo "<<<<<<<" >expected &&
>  	echo first line | append_cr >>expected &&
>  	echo same line | append_cr >>expected &&
> -	if test_have_prereq NATIVE_CRLF; then
> -		echo ======= | append_cr >>expected &&
> -		echo first line | append_cr >>expected &&
> -		echo same line | append_cr >>expected
> -	else
> -		echo ======= >>expected &&
> -		echo first line >>expected &&
> -		echo same line >>expected
> -	fi &&
> +	echo ======= >>expected &&
> +	echo first line >>expected &&
> +	echo same line >>expected &&
>  	echo ">>>>>>>" >>expected &&
>  	git config merge.renormalize false &&
>  	rm -f .gitattributes &&
