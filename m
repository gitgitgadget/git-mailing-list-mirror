Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6A61F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 04:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfJDEdI (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 00:33:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58774 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbfJDEdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 00:33:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C31B596271;
        Fri,  4 Oct 2019 00:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kZxV4GOxxDcHJes/OtN0gDyxeLQ=; b=NU655l
        qOtSsRbwGAxeMnq/TZw4h/eUZ8sGHIG3rsMPh53JTu1ahac2S1gpxWF3cVRQgLSk
        fd+QtEY0iLRY5AvJaMy8cg/WkklYIA5GE9ey5f5En/fYwuxxPkuDXOK+Klucn0qX
        0VuB42uRpUGt71Bs1hqRBzh9ehgdhSFl7k59M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eGcg9diLz7h9qClogH5SN/47LCAU398T
        cjuKcfzUSqXXaIRhyJKkdhbJuxG24diy5RzxNPLZ+awR9Is/iiqHyOHgy3Wl3CWg
        5uaMWTwF5Bv79lJEmfqKBPF34QO/rldyLDbEg9JUXf21waAooRqpoYezM54j/0K6
        cLh76xfc/mw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBE0496270;
        Fri,  4 Oct 2019 00:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1885C9626F;
        Fri,  4 Oct 2019 00:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] fetch: let --jobs=<n> parallelize --multiple, too
References: <pull.369.git.gitgitgadget@gmail.com>
        <818936f1e0389820fdfa31f36c6f75e8a4bb1a07.1569930816.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 13:33:02 +0900
In-Reply-To: <818936f1e0389820fdfa31f36c6f75e8a4bb1a07.1569930816.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 01 Oct 2019
        04:53:37 -0700 (PDT)")
Message-ID: <xmqqftk9870h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ECE8426-E660-11E9-962C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +test_expect_success 'parallel' '
> +	git remote add one ./bogus1 &&
> +	git remote add two ./bogus2 &&
> +
> +	test_must_fail env GIT_TRACE="$PWD/trace" \
> +		git fetch --jobs=2 --multiple one two 2>err &&
> +	grep "2 tasks" trace &&

I think this one expects to match this in run-command.c:

	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);

> +	grep "one.*128" err &&
> +	grep "two.*128" err

and these expect to match this in fetch.c

		strbuf_addf(out, _("could not fetch '%s' (exit code: %d)\n"),

It would have been nice to fellow contributors, if the grep patterns
were written a bit more tightly.  It would allow people who debug
test failure to more easily identify which message the patterns are
trying to catch.

In any case, the latter two needs to be guarded against
gettext-poison, I would think.  Without addressing the vagueness of
the pattern, at least the following needs to be squashed to help the
CI.

Thanks.

---
 t/t5514-fetch-multiple.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index cce829b989..33f5220a53 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -190,8 +190,8 @@ test_expect_success 'parallel' '
 	test_must_fail env GIT_TRACE="$PWD/trace" \
 		git fetch --jobs=2 --multiple one two 2>err &&
 	grep "2 tasks" trace &&
-	grep "one.*128" err &&
-	grep "two.*128" err
+	test_i18ngrep "one.*128" err &&
+	test_i18ngrep "two.*128" err
 '
 
 test_done
-- 
2.23.0-686-g3bf927a9c0

