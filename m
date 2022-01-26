Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6828BC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 05:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiAZFxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:53:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58318 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiAZFx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 00:53:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4733C171BA7;
        Wed, 26 Jan 2022 00:53:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=b16GysyvPmmmQB2bju1T/UeLv/FN9Uczzh9Xyy4tyXE=; b=EG66
        jEde08n11QM8PLRjmlNdc+PXyooiZyKelqFM8i70hC8CoBc1MauwfjJpbAs9OjSn
        kCuxIO8NAW1pZyuyMbD/aDRINopKzR9qZ6hzcwYTD1k+oSbj1r0QR58ObOVrIiyk
        k/btZQBc7qvqXUWJiQYO7Gt8h7pENUkB5AMoHdc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D5BA171BA6;
        Wed, 26 Jan 2022 00:53:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DDCB171BA5;
        Wed, 26 Jan 2022 00:53:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
References: <xmqqsftc3nd6.fsf@gitster.g>
        <20220125092419.cgtfw32nk2niazfk@carbon> <xmqqa6fjzlm0.fsf@gitster.g>
        <YfBbRca0Rjl59MM0@nand.local>
Date:   Tue, 25 Jan 2022 21:53:25 -0800
Message-ID: <xmqqo83zt54a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47B05052-7E6C-11EC-8004-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Yeah; bisecting dash with your example script pointed me at cbb71a8
> (eval: Add assignment built-in support again, 2018-05-19), which indeed
> appears in v0.5.11 (and all subsequent versions).
>
> cbb71a8 points at release 0.3.8-15, which predates Git (and a tag
> pointing at it was never created, since it's behind the big "initial
> import" commit at the beginning of dash.git's history). But skimming
> ChangeLog.O, we see:
>
>     * Removed assignment builtins since it is at best undefined by the
>       SuS and also can't be implemented consistently.
>
> So this probably didn't work at all between that 0.3.8-15 up until v0.5.11.
>
>> The manual page for recent dash may need an update.
>> Can you perhaps file a bug on their documentation?
>
> Yes, I agree that dash.1 is out-of-date after cbb71a8. Konstantin:
> please feel free to use any of this if it's helpful to you in creating a
> bug report for the dash folks.

I doubt that we can write off dash v0.5.10 as too old to matter, as
the tagger date seems to be mid 2020 at 

https://kernel.googlesource.com/pub/scm/utils/dash/dash/+/refs/tags/v0.5.11


So here is a bit wider "grep" output, looking for

$ git grep '^[ 	]*local[	 ].*=' \*.sh

to reject _any_ assignment on the same line as "local", but I
manually excluded the ones that are not meant to be run with dash.
I obviously excluded the one in t0000 (try_local_xy) that is a
weather-balloon for this exact issue.

According to this thread, these would not work correctly on dash
older than 0.5.11 and needs fixing by splitting declaration of
variables as locals and assignment of their initial values.


contrib/subtree/git-subtree.sh:	local indent=$(($indent + 1))
contrib/subtree/git-subtree.sh:	local indent=$(($indent + 1))
contrib/subtree/git-subtree.sh:	local indent=$(($indent + 1))
contrib/subtree/git-subtree.sh:	local grep_format="^git-subtree-dir: $dir/*\$"
contrib/subtree/git-subtree.sh:	local rev="$1"
contrib/subtree/git-subtree.sh:	local parents="$2"
contrib/subtree/git-subtree.sh:	local indent=$(($indent + 1))
t/lib-parallel-checkout.sh:	local expected_workers=$1 &&
t/lib-parallel-checkout.sh:	local trace_file=trace-test-checkout-workers &&
t/lib-parallel-checkout.sh:	local workers="$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l)" &&
t/t0021-conversion.sh:		local expect_progress=N &&
t/t0021-conversion.sh:		local expect_progress=
t/t3435-rebase-gpg-sign.sh:	local must_fail= will=will fake_editor=
t/t3514-cherry-pick-revert-gpg.sh:	local must_fail= will=will fake_editor=
t/t4011-diff-symlink.sh:	local oid=$(printf "%s" "$1" | git hash-object --stdin) &&
t/t4011-diff-symlink.sh:	local oid=$(git hash-object "$1") &&
t/t4210-log-i18n.sh:	local engine=$1
t/t4210-log-i18n.sh:	local pattern=$1
t/t6006-rev-list-format.sh:	local args=
t/t6006-rev-list-format.sh:	local args=
t/t9902-completion.sh:	local IFS=$'\n'
t/t9902-completion.sh:	local cur="$1" &&
t/t9902-completion.sh:	local cur="$1" &&
t/t9902-completion.sh:	local cur="$1" expected="$2"
t/test-lib-functions.sh:	local op='=' wrong_result=different
t/test-lib-functions.sh:	local test_cmp_a= test_cmp_b=
t/test-lib-functions.sh:	local stdin_for_diff=
t/test-lib-functions.sh:	local algo="${test_hash_algo}" &&
t/test-lib-functions.sh:	local var="test_oid_${algo}_$1" &&
t/test-lib-functions.sh:	local basename=${1#??}
t/test-lib-functions.sh:	local var=$1 port
t/test-lib-functions.sh:	local negate=
t/test-lib-functions.sh:	local expr=$(printf '"%s",' "$@")
t/test-lib-functions.sh:	local negate=
t/test-lib-functions.sh:	local expr=$(printf '"%s".*' "$@")
t/test-lib-functions.sh:	local expect_exit=0
t/test-lib.sh:	local opt="$1"
t/test-lib.sh:	local bail_out="Bail out! "
t/test-lib.sh:	local message="$1"
