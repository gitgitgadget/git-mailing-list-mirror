Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C628C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E679F22ADC
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgLVC3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 21:29:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63954 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLVC3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 21:29:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B006D8985F;
        Mon, 21 Dec 2020 21:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N74EnqZfew6CL/pgu/czZA9Iq3M=; b=tHLaHR
        Voww6DNHegECGXbbA9RnIWw06gxmtWdNYwjIXa1QgYFv7yTcAsTycoZ+l8vwxgXM
        uHTyFj5cY4WnJdmMSLBvCHGayM7pEkUMrdL8+pORQllU/Rtfsk7/dIT9jTnexNS0
        HH5lkY4PMEk/Av/Q4WDIVZbSz4cZ+BRMf5XHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KpclYLd+tZt53sZflULk9qrV76Lhzp2C
        DY5JH2sEXdgLYvcybdqcxlcgZfv+7fvNCGVei6zld3IohRPRcAfiSx1jVW4lC5Z0
        DJzP7+ieyGvIl0Dg7mwyC7WIrpqS3fx9MsRICK1FpA6eY7dSFQLvm0eZhmJlrxma
        ZEZPlIai5pU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6C318985D;
        Mon, 21 Dec 2020 21:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36DBA8985C;
        Mon, 21 Dec 2020 21:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v4 1/2] negative-refspec: fix segfault on : refspec
References: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
        <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
        <e59ff29bdef9ce6bbdf8fbab307178e3e983cf2c.1608599513.git.gitgitgadget@gmail.com>
        <xmqqk0tak2ym.fsf@gitster.c.googlers.com>
Date:   Mon, 21 Dec 2020 18:28:54 -0800
In-Reply-To: <xmqqk0tak2ym.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 21 Dec 2020 18:08:01 -0800")
Message-ID: <xmqqa6u6k1zt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70287276-43FD-11EB-AE82-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> @@ -196,18 +201,27 @@ test_expect_success "push with matching : and negative refspec" '
>  	# We do not need test_config here as we are updating remote.one.push
>  	# again. The teardown of the first test_config will do --unset-all
>  	git -C two config --add remote.one.push ^refs/heads/master &&
> -	git -C two push one
> +
> +	# With "master" excluded, this push is a no-op.  Nothing gets
> +	# pushed and it succeeds.
> +	git -C two push -v one
>  '

Another obvious thing is that these tests will not work without
tweaking when merged to 'seen', as over there the name given by
default to the initial branch might not be 'master'.  The negative
refspec specification must be written in a way not to depend on
a particular name, I think.

Here is another try (disregard the previous one and squash this one
on top of your 1/2).

Thanks.

 t/t5582-fetch-negative-refspec.sh | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git c/t/t5582-fetch-negative-refspec.sh w/t/t5582-fetch-negative-refspec.sh
index a4960c586b..83a3c58c0c 100755
--- c/t/t5582-fetch-negative-refspec.sh
+++ w/t/t5582-fetch-negative-refspec.sh
@@ -187,27 +187,50 @@ test_expect_success "fetch --prune with negative refspec" '
 '
 
 test_expect_success "push with matching : and negative refspec" '
+	# For convenience, we use "master" to refer to the name of
+	# the branch created by default in the following.
+	#
+	# Repositories two and one have branches other than "master"
+	# but they have no overlap---"master" is the only one that
+	# is shared between them.  And the master branch at two is
+	# behind the master branch at one by one commit.
 	test_config -C two remote.one.push : &&
-	# Fails to push master w/ tip behind counterpart
+
+	# A matching push tries to update master, fails due to non-ff
 	test_must_fail git -C two push one &&
 
+	# "master" may actually not be "master"---find it out.
+	current=$(git symbolic-ref HEAD) &&
+
 	# If master is in negative refspec, then the command will not attempt
 	# to push and succeed.
 	# We do not need test_config here as we are updating remote.one.push
 	# again. The teardown of the first test_config will do --unset-all
-	git -C two config --add remote.one.push ^refs/heads/master &&
-	git -C two push one
+	git -C two config --add remote.one.push "^$current" &&
+
+	# With "master" excluded, this push is a no-op.  Nothing gets
+	# pushed and it succeeds.
+	git -C two push -v one
 '
 
 test_expect_success "push with matching +: and negative refspec" '
+	# The same set-up as above, whose side-effect was a no-op.
 	test_config -C two remote.one.push +: &&
-	# Fails to push master w/ tip behind counterpart
+
+	# The push refuses to update the "master" branch that is checked
+	# out in the "one" repository, even when it is forced with +:
 	test_must_fail git -C two push one &&
 
+	# "master" may actually not be "master"---find it out.
+	current=$(git symbolic-ref HEAD) &&
+
 	# If master is in negative refspec, then the command will not attempt
 	# to push and succeed
-	git -C two config --add remote.one.push ^refs/heads/master &&
-	git -C two push one
+	git -C two config --add remote.one.push "^$current" &&
+
+	# With "master" excluded, this push is a no-op.  Nothing gets
+	# pushed and it succeeds.
+	git -C two push -v one
 '
 
 test_done
