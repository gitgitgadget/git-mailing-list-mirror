Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E3C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B082312C
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 09:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405883AbgLMJex (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 04:34:53 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:19727 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbgLMJev (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 04:34:51 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Ctzqh2Kj0z5tl9;
        Sun, 13 Dec 2020 10:34:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E14FA20C5;
        Sun, 13 Dec 2020 10:34:06 +0100 (CET)
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <20201213010539.544101-2-sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2cc4925f-3661-1dfb-2668-5f56edcb8455@kdbg.org>
Date:   Sun, 13 Dec 2020 10:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201213010539.544101-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.20 um 02:05 schrieb brian m. carlson:
> Many people, through the course of their lives, will change either a
> name or an email address.  For this reason, we have the mailmap, to map
> from a user's former name or email address to their current, canonical
> forms.  Normally, this works well as it is.
> 
> However, sometimes people change a name or an email address and wish to
> wholly disassociate themselves from that former name or email address.
> For example, a person may have left a company which engaged in a deeply
> unethical act with which the person does not want to be associated, or
> they may have changed their name to disassociate themselves from an
> abusive family or partner.  In such a case, using the former name or
> address in any way may be undesirable and the person may wish to replace
> it as completely as possible.
> 
> For projects which wish to support this, introduce hashed forms into the
> mailmap.  These forms, which start with "@sha256:" followed by a SHA-256
> hash of the entry, can be used in place of the form used in the commit
> field.  This form is intentionally designed to be unlikely to conflict
> with legitimate use cases.  For example, this is not a valid email
> address according to RFC 5322.  In the unlikely event that a user has
> put such a form into the actual commit as their name, we will accept it.
> 
> While the form of the data is designed to accept multiple hash
> algorithms, we intentionally do not support SHA-1.  There is little
> reason to support such a weak algorithm in new use cases and no
> backwards compatibility to consider.  Moreover, SHA-256 is faster than
> the SHA1DC implementation we use, so this not only improves performance,
> but simplifies the current implementation somewhat as well.
> 
> Note that it is, of course, possible to perform a lookup on all commit
> objects to determine the actual entry which matches the hashed form of
> the data.  However, a project for which this feature is valuable may
> simply insert entries for many contributors in order to make discovery
> of "interesting" entries significantly less convenient.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

...

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 586c3a86b1..794133ba5d 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -62,6 +62,41 @@ test_expect_success 'check-mailmap --stdin arguments' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'hashed mailmap' '
> +	test_config mailmap.file ./hashed &&
> +	hashed_author_name="@sha256:$(printf "$GIT_AUTHOR_NAME" | test-tool sha256)" &&
> +	hashed_author_email="@sha256:$(printf "$GIT_AUTHOR_EMAIL" | test-tool sha256)" &&
> +	cat >expect <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
> +	EOF
...
> +	cat >hashed <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> <$hashed_author_email>
> +	EOF
> +	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
> +	test_cmp expect actual

I don't understand the concept. A mailmap entry of the form

   A <a@b> <x@y>

tells that the former address <x@y>, which is recorded in old project
history, should be replaced by A <a@b> when a commit is displayed. I am
assuming that the idea is that old <x@y> should be the "banned" address.
How does a hashed entry help when the hashed value appears at the right
side of a mailmap entry and that literal string never appears anywhere
in the history?

-- Hannes
