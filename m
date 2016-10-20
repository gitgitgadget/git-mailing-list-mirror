Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55EA1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935494AbcJTSyi (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:54:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934197AbcJTSyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:54:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8C0947C64;
        Thu, 20 Oct 2016 14:54:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DzWDrkQJEFbxZ/REdWTT6mKjKdM=; b=fEvFH7
        GFr5FbLY1vHZL+kjhFiYj8Rj0MJjn/v3wXjcJzYQq5SEdouqx169Oy5He8jTeC1M
        uNqCr8FUj2nTsLn67vYIdVuVxVJuZo/+v5j4ZQobYRPLfKdJxPB7cTG1fsxRgYqK
        MvnrgqnqQj2UZNd5zhqhcVABsFJ3JSBhlMbQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nGAhnH60HgdXcFuH7PJsHN0VmZX1vrrO
        BSxFxoukG7+duXG56uEJkaojUtfZhN/Z07PpMaozAulR1AaLClRwoglnSTPAzFef
        /6aVAwuztru9m2UJ9Hzm0qTQ3QR7c04MgXPuI8rNNrbo+3kaJXi/1yqeXcAi+YJy
        MPpAawj1QWI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEA2A47C63;
        Thu, 20 Oct 2016 14:54:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33CF347C61;
        Thu, 20 Oct 2016 14:54:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] rev-list: use hdr_termination instead of a always using a newline
References: <20161020181930.21084-1-jacob.e.keller@intel.com>
Date:   Thu, 20 Oct 2016 11:54:33 -0700
In-Reply-To: <20161020181930.21084-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 20 Oct 2016 11:19:30 -0700")
Message-ID: <xmqq4m46hmvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4CB2842-96F6-11E6-9CEB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index 3e752ce03280..e8c6979baf59 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -4,6 +4,12 @@ test_description='miscellaneous rev-list tests'
>  
>  . ./test-lib.sh
>  
> +test_ends_with_nul() {
> +	printf "\0" >nul
> +	sed '$!d' "$@" >contents
> +	test_cmp_bin nul contents
> +}
> +
>  test_expect_success setup '
>  	echo content1 >wanted_file &&
>  	echo content2 >unwanted_file &&
> @@ -100,4 +106,9 @@ test_expect_success '--bisect and --first-parent can not be combined' '
>  	test_must_fail git rev-list --bisect --first-parent HEAD
>  '
>  
> +test_expect_success '--header shows a NUL after each commit' '
> +	git rev-list --header --max-count=1 HEAD | sed \$!d >actual &&
> +	test_ends_with_nul actual
> +'
> +
>  test_done

Thanks.

The main part of the patch looks good.  For "passing NUL to sed",
I'd probably work it around like so:

 t/t6000-rev-list-misc.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index e8c6979baf..737026c34f 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -4,12 +4,6 @@ test_description='miscellaneous rev-list tests'
 
 . ./test-lib.sh
 
-test_ends_with_nul() {
-	printf "\0" >nul
-	sed '$!d' "$@" >contents
-	test_cmp_bin nul contents
-}
-
 test_expect_success setup '
 	echo content1 >wanted_file &&
 	echo content2 >unwanted_file &&
@@ -107,8 +101,17 @@ test_expect_success '--bisect and --first-parent can not be combined' '
 '
 
 test_expect_success '--header shows a NUL after each commit' '
-	git rev-list --header --max-count=1 HEAD | sed \$!d >actual &&
-	test_ends_with_nul actual
+	# We know there is no Q in the true payload; names and
+	# addresses of the authors and the committers do not have
+	# any, and object names or header names do not, either.
+	git rev-list --header --max-count=2 HEAD |
+	nul_to_q |
+	grep "^Q" >actual &&
+	cat >expect <<-EOF &&
+	Q$(git rev-parse HEAD~1)
+	Q
+	EOF
+	test_cmp expect actual
 '
 
 test_done
