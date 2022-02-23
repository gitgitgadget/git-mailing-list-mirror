Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B494AC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiBWW7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBWW7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:59:41 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F350048
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:59:12 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFED718BE5E;
        Wed, 23 Feb 2022 17:59:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4fFk1r/T/3wGn6I/XtVRW8K7K0COg4VHyKYxaw
        Ke3dY=; b=RsaJ6jRpO3NXy+zjN5DpPOmiYObxe5r2gEfutPFnGEa89gLfQOLHXr
        XQJut+KkvygM1mMPVlH7/zezfV9vIeEwe87f2ADpEZZS24nxrME7wq9/xYgVbrua
        aimBFyx9PLu1Q2JDGzc+6uaBnOeZXnZCZ9FMCKzhkcbYnS2hWatRU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7F1318BE5D;
        Wed, 23 Feb 2022 17:59:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F76918BE5C;
        Wed, 23 Feb 2022 17:59:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     avarab@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: Re: [PATCH v3 0/3] replace test [-f|-d] with more verbose functions
References: <xmqqbkz4105s.fsf@gitster.g>
        <20220222215430.605254-1-cogoni.guillaume@gmail.com>
Date:   Wed, 23 Feb 2022 14:59:09 -0800
In-Reply-To: <20220222215430.605254-1-cogoni.guillaume@gmail.com> (COGONI
        Guillaume's message of "Tue, 22 Feb 2022 22:54:27 +0100")
Message-ID: <xmqq35k9qjeq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 361220AE-94FC-11EC-89AA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

COGONI Guillaume <cogoni.guillaume@gmail.com> writes:

> Make the code more readable in t/t3903-stash.sh and give more 
> friendly error message by replacing test [-f|-d] by the right 
> test_path_is_* functions.
> Add new functions like test_path_is_* to cover more specifics 
> cases like symbolic link or file that we explicitly refuse
> to be symbolic link.

All three look good to me.

Will queue.

As a possible #leftoverbits material, I suspect that we would
eventually want to be able to say

	test_path_is_file ! "$error_if_I_am_a_file"
	test_path_is_dir ! "$error_if_I_am_a_dir"
	test_path_is_symlink ! "$error_if_I_am_a_symlink"

so that we do not have to have the two ugly-looking special-case
combination "test_path_is_X_not_symlink" but just express what we
want with

	test_path_is_file "$path" && test_path_is_symlink ! "$path"

Once that happens, the two helpers introduced with 2/3 of this
series would become

	test_path_is_file_not_symlink () {
		test $# = 1 || BUG "1 param"
		test_path_is_file "$1" &&
		test_path_is_symlink ! "$1"
	}

But I do not want to see that as part of this series.  Let's
conclude this series and declare a success.

Thanks.



