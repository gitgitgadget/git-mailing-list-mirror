Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730C31F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755638AbdLOTsc (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:48:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57431 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755419AbdLOTsc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:48:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57425BAA54;
        Fri, 15 Dec 2017 14:48:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4duZRbADiDmun6HFfklztPAWpkk=; b=kxmXxt
        wEYAh5ItpQHttcgXmtvfdw3jntX4zNE/yR1VeUoH3aPS0wtpf2onyGloJ/+1ALFV
        lH+w6UFY4SW6sfArX1TRprsirbdKOKcABgZhEh0M5yzSdBb4OHvFUJs8A7tZwaa+
        V4eHTwQhRJZ0LxzIl/y1dzDsDsyQxbHGMIR2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NARg85XRf4JjlNqSn8t1l2/SOUIZE7AL
        naAeiYjzoAg9iVXdT/ZMWJQ4B4wfrEkaCTdTL40yVqJiJLvVrVP8a4Upp4iPRXLH
        VVtK96dbX2d4efcU0tlpFZvY1nFZ40xtoDyKM2BRUrGH4BlRFTWiOy6Q0wz4bKEl
        WtU5+aZK1iE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F87DBAA53;
        Fri, 15 Dec 2017 14:48:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFBFFBAA51;
        Fri, 15 Dec 2017 14:48:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>
Subject: Re* [PATCH v2 2/2] t: add tests for pull --verify-signatures
References: <20171209090530.6747-1-hji@dyntopia.com>
        <20171210065358.8156-1-hji@dyntopia.com>
        <20171210065358.8156-2-hji@dyntopia.com>
        <xmqqbmj33h0s.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 15 Dec 2017 11:48:29 -0800
In-Reply-To: <xmqqbmj33h0s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 12 Dec 2017 11:03:47 -0800")
Message-ID: <xmqqmv2jpyb6.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED40EE38-E1D0-11E7-93BC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Interestingly, the tests that do expect 'git pull' to succeed
> protect themselves with "when-finished" mechanism correctly [*1*],
> like so:
>
>> +test_expect_success GPG 'pull signed commit with --verify-signatures' '
>> +	test_when_finished "git checkout initial" &&
>> +	git pull --verify-signatures signed >pulloutput &&
>> +	test_i18ngrep "has a good GPG signature" pulloutput
>> +'
>> +
>
> Other than that, looked nicely done.  Thanks.

Here is what I would propose as a follow-up polishing.

-- >8 --
Subject: [PATCH 3/2] t5573: clean up after unexpected success of 'pull', too

The previous step added test_when_finished to tests that run 'git
pull' with expectation of success, so that the test after them can
start from a known state even when their 'git pull' invocation
unexpectedly fails.  However, tests that run 'git pull' expecting
it not to succeed forgot to protect later tests the same way---if
they unexpectedly succeed, the test after them would start from an
unexpected state.

Reset and checkout the initial commit after all these tests, whether
they expect their 'git pull' invocations to succeed or fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5573-pull-verify-signatures.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index 8ae331f40e..9594e891f4 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -43,33 +43,36 @@ test_expect_success GPG 'create repositories with signed commits' '
 '
 
 test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures unsigned 2>pullerror &&
 	test_i18ngrep "does not have a GPG signature" pullerror
 '
 
 test_expect_success GPG 'pull commit with bad signature with --verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &&
 	test_i18ngrep "has a bad GPG signature" pullerror
 '
 
 test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
 	test_i18ngrep "has an untrusted GPG signature" pullerror
 '
 
 test_expect_success GPG 'pull signed commit with --verify-signatures' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	git pull --verify-signatures signed >pulloutput &&
 	test_i18ngrep "has a good GPG signature" pulloutput
 '
 
 test_expect_success GPG 'pull commit with bad signature without verification' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	git pull --ff-only bad 2>pullerror
 '
 
 test_expect_success GPG 'pull commit with bad signature with --no-verify-signatures' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_config pull.verifySignatures true &&
 	git pull --ff-only --no-verify-signatures bad 2>pullerror
-- 
2.15.1-558-ged696bbdd8

