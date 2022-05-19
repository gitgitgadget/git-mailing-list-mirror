Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD8C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbiESScj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiESSch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:32:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C54B5F99
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:32:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CD4F1934BF;
        Thu, 19 May 2022 14:32:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QGOjY8GTVlWLx25I79VjTghMM8Y9yOtQH0dPht
        jfMRE=; b=V1kp/GjCBL6x0E3wpXdJa9KUYbJVUZtt4nVa6qIU5RvrF9GSeARSfe
        De3S46KrMMKzPmC+5176A34LIidF6nFYZq5+jtLSqJ6pm/fBsTVCTeTwtAvDL+xk
        pQ1HadHjCo6sfFqBFvnlaK51e4sQHRz7PWxQs+3ALLBqaa1flIaP0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 362A01934BE;
        Thu, 19 May 2022 14:32:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6B951934BC;
        Thu, 19 May 2022 14:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge: make restore_state() do as its name says
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <88bdca72a780d70e156e22e1ab96dedd368c761b.1652977582.git.gitgitgadget@gmail.com>
        <xmqq5ym1pgby.fsf@gitster.g>
Date:   Thu, 19 May 2022 11:32:31 -0700
In-Reply-To: <xmqq5ym1pgby.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        19 May 2022 10:44:49 -0700")
Message-ID: <xmqqwnehnzk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C140C48-D7A2-11EC-A435-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'set up custom strategy' '
>> +	test_commit --no-tag "Initial" base base &&
>> +git show-ref &&
>> +
>> +	for b in branch1 branch2 branch3
>> +	do
>> +		git checkout -b $b main &&
>> +		test_commit --no-tag "Change on $b" base $b
>> +	done &&
>> +
>> +	git checkout branch1 &&
>
> Here, perhaps we can make two additional test cases, that try with
> local change that (1) overlaps with the changes branch2 and branch3
> bring in and that (2) does not overlap.  I am worried about the case
> (2) losing the local change due to the call to reset_hard().

We do not need a new test to demonstrate the breakage in the
proposed patch, I think.  Here is one place I found that we already
test that merging in a dirty working tree fails.  We only need to
make sure that we do so without losing local changes.

 t/t6424-merge-unrelated-index-changes.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/t/t6424-merge-unrelated-index-changes.sh w/t/t6424-merge-unrelated-index-changes.sh
index 89dd544f38..88e0b541a0 100755
--- c/t/t6424-merge-unrelated-index-changes.sh
+++ w/t/t6424-merge-unrelated-index-changes.sh
@@ -171,7 +171,8 @@ test_expect_success 'octopus, unrelated file touched' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge C^0 D^0 &&
-	test_path_is_missing .git/MERGE_HEAD
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_path_exists random_file
 '
 
 test_expect_success 'octopus, related file removed' '
