Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5FC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4122B3B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLVCIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 21:08:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54093 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLVCIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 21:08:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FDE0FB560;
        Mon, 21 Dec 2020 21:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fPEYmn4l/pusfDI4jdBfUAFxQfw=; b=ZqebTq
        2YcvsFz9JVaUkqdE/dygNg5KdFSqoLr44x9He+Yq4OZ7D7VgoE+mvSKR9Bc456I0
        Rpu0TKr3hnD3igXKj6Nkgd/i6jIy/HlA4cXCUOdxKXyYacpeU2rRfTfQHVYbQ6Av
        QyLKgKgRqfoRP3C6OKaIGPGwQD3YrFoMVP3OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RYRB8RE1UBiJtKXGvmldNPKcEW+p1sZL
        lZ7pjWEFiMBuMNZqLdgiT6MkMEq3kgWRQry6LNagYh8WhqLAKHGeKBPVjnbI5VVN
        6YqlcmYhFO8bD+wRC0c23Fj1RDafPJa1ufJDCkcnEC1+py+RG9no1NmzTe2tERQs
        i0XwOnoOsx4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77DD4FB55D;
        Mon, 21 Dec 2020 21:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDD76FB55C;
        Mon, 21 Dec 2020 21:08:02 -0500 (EST)
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
Date:   Mon, 21 Dec 2020 18:08:01 -0800
In-Reply-To: <e59ff29bdef9ce6bbdf8fbab307178e3e983cf2c.1608599513.git.gitgitgadget@gmail.com>
        (Nipunn Koorapati via GitGitGadget's message of "Tue, 22 Dec 2020
        01:11:52 +0000")
Message-ID: <xmqqk0tak2ym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85A40F82-43FA-11EB-A6D1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success "push with matching : and negative refspec" '
> +	test_config -C two remote.one.push : &&
> +	# Fails to push master w/ tip behind counterpart
> +	test_must_fail git -C two push one &&

I offhand do not know where the master branch of two and one
repositories are, but I presume that one's master is not an ancestor
of two's master here, and the reason why this fails is because we
would prevent such a non-ff push unless forced?  Are there other
matching refs between one and two that are subject to the push
operation here, or is the 'master' the only thing that exists?

> +	# If master is in negative refspec, then the command will not attempt
> +	# to push and succeed.
> +	# We do not need test_config here as we are updating remote.one.push
> +	# again. The teardown of the first test_config will do --unset-all
> +	git -C two config --add remote.one.push ^refs/heads/master &&
> +	git -C two push one

... and the idea of the test is that by adding a "we do not want to
push out our master" configuration, we no longer attempt to push out
the 'master' branch from two that is not a descendant of the master
branch of one, so "push" would "succeed".  Is there other branches
involved, or this is essentially a no-op as there is only 'master'
branch involved in the operation?

> +'
> +
> +test_expect_success "push with matching +: and negative refspec" '
> +	test_config -C two remote.one.push +: &&
> +	# Fails to push master w/ tip behind counterpart
> +	test_must_fail git -C two push one &&

Assuming that the successful case from the previous test was a
no-op, we start from the same condition from the previous one.  THe
only difference is that the matching push is now configured to force.

So, how would this one fail, exactly?  Aren't we forcing?  Shouldn't
we succeed in such a case?

I think the test still fails to push but for a different reason.  It
is not because the tip being pushed is not ahead of the counterpart
at the receiving repository.  +: (i.e. force-push matching refs)
takes care of the "must fast-forward" requirement that causes the
previous one to fail.

It is because the receiving repository is not a bare repository, and
the push attempts to update its current branch.  It cannot be forced
with + prefix, and that is why it fails.

So, the comment above is wrong.  Perhaps

	# Fail to update the branch currently checked out.

or something.

> +	# If master is in negative refspec, then the command will not attempt
> +	# to push and succeed
> +	git -C two config --add remote.one.push ^refs/heads/master &&
> +	git -C two push one

And this succeeds for the same reason, i.e. it becomes no-op because
there is no other branches involved?

> +'
> +
>  test_done

Ideally, we should make sure that the next person who reads "git
show" output of the commit that would result from the patch would
not have to ask any of the "?" asked in the review above.  Let me
see if I can come up with a suggestion to get us closer to that
goal.

	... goes and hacks ...

Perhaps squash the following into this step?

Thanks.


 t/t5582-fetch-negative-refspec.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git c/t/t5582-fetch-negative-refspec.sh w/t/t5582-fetch-negative-refspec.sh
index a4960c586b..bed67cf92d 100755
--- c/t/t5582-fetch-negative-refspec.sh
+++ w/t/t5582-fetch-negative-refspec.sh
@@ -187,8 +187,13 @@ test_expect_success "fetch --prune with negative refspec" '
 '
 
 test_expect_success "push with matching : and negative refspec" '
+	# Repositories two and one have branches other than master"
+	# but they have no overlap---"master" is the only one that
+	# is shared between them.  And the master branch at two is
+	# behind the master branch at one by one commit.
 	test_config -C two remote.one.push : &&
-	# Fails to push master w/ tip behind counterpart
+
+	# A matching push tries to update master, fails due to non-ff
 	test_must_fail git -C two push one &&
 
 	# If master is in negative refspec, then the command will not attempt
@@ -196,18 +201,27 @@ test_expect_success "push with matching : and negative refspec" '
 	# We do not need test_config here as we are updating remote.one.push
 	# again. The teardown of the first test_config will do --unset-all
 	git -C two config --add remote.one.push ^refs/heads/master &&
-	git -C two push one
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
 
 	# If master is in negative refspec, then the command will not attempt
 	# to push and succeed
 	git -C two config --add remote.one.push ^refs/heads/master &&
-	git -C two push one
+
+	# With "master" excluded, this push is a no-op.  Nothing gets
+	# pushed and it succeeds.
+	git -C two push -v one
 '
 
 test_done
