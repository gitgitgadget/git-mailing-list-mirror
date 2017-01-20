Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF33420756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbdATWTP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:19:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52757 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752239AbdATWTP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:19:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB98D628C4;
        Fri, 20 Jan 2017 17:19:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=16zx9ueskQh4wasvxFMZbkCJKPo=; b=T7GWQBscNpmTWAoy7Q3M
        51Y+jeivs6+nBpOEG4X+8qWkbEdakfHyLwDKgIISyn+cmW0dP+Rfn/SA4W8XKFPW
        WAD0cMInKvCgwUOZmzefsfucEiVdn+GzyJAqAieX2f5yohgyRBTQRkom0/oIzSWh
        aLefv/VBc0h8XBilPFrxdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JV2Be8lFFIztKe3W1KLwHimg6zF0k/WjQMoAWGv1zjqQqn
        V6SiDsL2EjMmt8OXi1Jvx2F59DFVKcVkh7DmL4fZ9T5ySg9eSwZQXVRVH6MFHcIV
        Tbh2dyqvDx8fWrEcAywMqbfFiwvK4Xbp2JNpWHNY9+7yyH7ivIFgb+OPSiJQA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E356C628C3;
        Fri, 20 Jan 2017 17:19:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56312628BF;
        Fri, 20 Jan 2017 17:19:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 1/2] grep: only add delimiter if there isn't one already
References: <20170120171126.16269-1-stefanha@redhat.com>
        <20170120171126.16269-2-stefanha@redhat.com>
Date:   Fri, 20 Jan 2017 14:19:11 -0800
Message-ID: <xmqqinp9wf1c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79237DB0-DF5E-11E6-9FD8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> git-grep(1) output does not follow git's own syntax:
>
>   $ git grep malloc v2.9.3:t/
>   v2.9.3:t/:test-lib.sh:  setup_malloc_check () {
>   $ git show v2.9.3:t/:test-lib.sh
>   fatal: Path 't/:test-lib.sh' does not exist in 'v2.9.3'
>
> This patch avoids emitting the unnecessary ':' delimiter if the name
> already ends with ':' or '/':
>
>   $ git grep malloc v2.9.3:
>   v2.9.3:t/test-lib.sh:   setup_malloc_check () {
>   $ git show v2.9.3:t/test-lib.sh
>   (succeeds)

>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  builtin/grep.c  |  6 +++++-
>  t/t7810-grep.sh | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8887b6a..90a4f3d 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -491,7 +491,11 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
>  		strbuf_init(&base, PATH_MAX + len + 1);
>  		if (len) {
>  			strbuf_add(&base, name, len);
> -			strbuf_addch(&base, ':');
> +
> +			/* Add a delimiter if there isn't one already */
> +			if (name[len - 1] != '/' && name[len - 1] != ':') {
> +				strbuf_addch(&base, ':');
> +			}

I agree with peff and Brandon that checking treeness is the right
way to make the decision, and you seem to have done that in the
updated 2/2, but why doesn't it apply here as well?


>  		}
>  		init_tree_desc(&tree, data, size);
>  		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
