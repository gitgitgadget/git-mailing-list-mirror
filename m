Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F50C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67B1611BE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhFPEOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:14:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63006 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFPEOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:14:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93079144815;
        Wed, 16 Jun 2021 00:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8WrwG8OYwmfe
        wJcpBL9eYFecR4uowWH19xNiElvwrP0=; b=owMekrsvqP83Y6iyPdzxUyhuBDRD
        jfxs3kNqXyfjZCt9HpDjQWWN+SVOuV+lrf7/A0igF6X4xTe9JA3gIC4Scu/8AOAR
        BJRD/X/cKhgVhPWWUWCmwTt7GaFqXSDnQ+USTitOtLtFGN7QGYcQlaxO2iXVV43B
        /pcx/Frw1GC/NNo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B9D5144814;
        Wed, 16 Jun 2021 00:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A2C9144813;
        Wed, 16 Jun 2021 00:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] range expressions in GIT_SKIP_TESTS are broken in master
 (was [BUG] question mark in GIT_SKIP_TESTS is broken in master)
References: <1d003cac-83fa-0b63-f60e-55513ac45cf9@gmail.com>
        <6980e906-8076-1436-ecdb-6775eff55d39@gmail.com>
        <xmqqa6nqsd2i.fsf@gitster.g>
Date:   Wed, 16 Jun 2021 13:12:09 +0900
In-Reply-To: <xmqqa6nqsd2i.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Jun 2021 12:28:21 +0900")
Message-ID: <xmqq4kdysb1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05DAE21E-CE59-11EB-9873-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Interestingly enough, edc23840b0 (test-lib: bring $remove_trash out
> of retirement, 2021-05-10) cleanly reverts without being depended on
> by anything else in the series.
>
> =C3=86var?

With the crude debugging aid patch (attached at the end) applied,
running

    $ GIT_SKIP_TESTS=3D't?000' sh -x t0000-basic.sh -v

will show something interesting in the trace.

    ++ this_test=3Dt0000
    ++ _s_k_i_p_=3D't?000'
    ++ match_pattern_list t0000 t5000

The variable $GIT_SKIP_TESTS on this line:

    if match_pattern_list "$this_test" $GIT_SKIP_TESTS

globs to t5000.  We don't quote the variable because we want them
separated at $IFS boundaries, but we didn't want the glob specials
in its value to take any effect.  Sigh.

The reason why edc23840b0 appears to break this is probably because
we are still in $TEST_DIRECTORY when this match_pattern_list is
executed; before that change, we've created $TRASH_DIRECTORY and
chdir'd there already, and when we check "do we want to skip all?",
there is nothing for the glob to match.

That also explains why GIT_SKIP_TESTS=3D"t000?" appears to work.
There is no such filesystem entity directly in $TEST_DIRECTORY.

    $ echo t000? t00?0 t0?00 t?000
    t000? t00?0 t0200 t5000



diff --git i/t/test-lib.sh w/t/test-lib.sh
index 54938c6427..8ee0540532 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1346,13 +1346,17 @@ fi
 remove_trash=3D
 this_test=3D${0##*/}
 this_test=3D${this_test%%-*}
+_s_k_i_p_=3D$GIT_SKIP_TESTS
+
 if match_pattern_list "$this_test" $GIT_SKIP_TESTS
 then
 	say_color info >&3 "skipping test $this_test altogether"
 	skip_all=3D"skip all tests in $this_test"
 	test_done
 fi
=20
+exit
+
 # Last-minute variable setup
 HOME=3D"$TRASH_DIRECTORY"
 GNUPGHOME=3D"$HOME/gnupg-home-not-used"
