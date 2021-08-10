Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA3C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367FE60C3F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhHJS0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:26:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51440 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhHJS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:26:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D5A1138E49;
        Tue, 10 Aug 2021 14:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1JSInrD2ETPamZ3bse3S7OekeFgsK8WQrVaTOg
        PFgYw=; b=RuypmScgiOjN/0hR8xseJAIxq3zwJGl25MwBtNjpXMIgpZXoqoAOX3
        Q+Js54Zg2GHUnS8Xe4m6r11XI9iL9pKiycCDjkHz2YvZKH4+7BUYO1bn3RNPkTIN
        MIWqzN2WQm3zh8l7cOdzjUAz1pHaiannZKyMwvb+VK0w3NZdT1J6w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 450E9138E48;
        Tue, 10 Aug 2021 14:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FCFB138E47;
        Tue, 10 Aug 2021 14:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
        <20210809013833.58110-1-carenas@gmail.com>
        <20210809013833.58110-4-carenas@gmail.com>
        <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
        <CAPUEspgh54AywgqMuOXJf5uPZdR2AN9JLrzJwcOtoec7sRnN7w@mail.gmail.com>
        <6fac977d-80c5-d123-d232-2df5e5966c04@gmail.com>
Date:   Tue, 10 Aug 2021 11:25:42 -0700
In-Reply-To: <6fac977d-80c5-d123-d232-2df5e5966c04@gmail.com> (Phillip Wood's
        message of "Tue, 10 Aug 2021 16:24:07 +0100")
Message-ID: <xmqqeeb1dumx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 603A8DEC-FA08-11EB-B4CC-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think there is value in running the CI jobs with -Wpedantic
> otherwise we'll continually fixing patches up after they've been
> merged, I just wonder if we need a separate job to do it.

Seeing https://github.com/git/git/actions/runs/1114402527 for
example, I notice that we run three dockerized jobs and this one
takes about 3 minutes to compile everything.  The other two take
about 9 minutes and compile and run tests.

Shouldn't we be running tests in this job, too?  I know the new
comment in ci/run-build-and-tests.sh says "Don't run the tests; we
only care about ...", but I do not see a reason to declare that we
do not care if the resulting binary passes the tests or not.

It also seems that the environment does not have an access to any
working "git" binary and "save_good_tree" helper seems to fail
because of it.

https://github.com/git/git/runs/3284998605?check_suite_focus=true#step:5:692


I wonder if this untested patch on top of the patch under discussion
is sufficient, if we wanted to also run tests on the fedora image?


diff --git c/ci/install-docker-dependencies.sh w/ci/install-docker-dependencies.sh
index 07a8c6b199..f139c0632b 100755
--- c/ci/install-docker-dependencies.sh
+++ w/ci/install-docker-dependencies.sh
@@ -17,6 +17,8 @@ linux-musl)
 	;;
 pedantic)
 	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install git make gcc findutils diffutils perl python3 \
+		gettext zlib-devel expat-devel openssl-devel \
+		curl-devel pcre2-devel >/dev/null
 	;;
 esac
diff --git c/ci/run-build-and-tests.sh w/ci/run-build-and-tests.sh
index f3aba5d6cb..5b2fcf3428 100755
--- c/ci/run-build-and-tests.sh
+++ w/ci/run-build-and-tests.sh
@@ -40,9 +40,10 @@ linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	make test
 	;;
-linux-gcc-4.8|pedantic)
+linux-gcc-4.8)
 	# Don't run the tests; we only care about whether Git can be
-	# built with GCC 4.8 or with pedantic
+	# built with GCC 4.8, as it errors out on some undesired (C99)
+	# constructs that newer compilers seem to quietly accept.
 	;;
 *)
 	make test



