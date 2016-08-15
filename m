Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E541F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbcHOVDH (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:03:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932266AbcHOVDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 992D034B74;
	Mon, 15 Aug 2016 17:03:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BXaO1G/RVbaNaZLizjNjC6Dg8Ak=; b=wDvh0l
	mancU5WQRKhowzogAvoAHLI/Ml609VdZaC0GQQd+FJGSbPAJVqTno+qACvZZRN/s
	b1v5mH77bOtCRX7ILmzwDAKOlu9y6aOf41owSOegHEKRaLAKlcro2Ge7T/sXcnFu
	mKvO3ouBBwuU+uht86skam7mUKLWsfT9n+Z60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnYQXiH1MWMmXEaQsUUBL/FCAdxqEfVo
	dgyGVqURrRlqOrkblRqkjqq8DkMRvAH3zuDyqToj9Y5FRsKgvP40hxLdgC/PJBnD
	y8ik8wS+zF+olrT3maXGOUtMxzH4za8y0v4/oqAfUIilhfCPMk8Y9+viRv5LwB3s
	kSTcY4lR0Xk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E05034B73;
	Mon, 15 Aug 2016 17:03:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E28FF34B72;
	Mon, 15 Aug 2016 17:03:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly platform-independent
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
	<xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 15 Aug 2016 14:03:01 -0700
In-Reply-To: <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Aug 2016 09:06:35 -0700")
Message-ID: <xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A847F602-632B-11E6-B4BB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Good thinking.
>
> Some tests may have to be skipped on platforms that cannot express
> certain paths, but even then they shouldn't ship a file with
> pathname that cannot even be checked out (they should instead create
> and use such a path, protected behind filesystem specific test
> prerequisite).
>
>> +test-lint-filenames:
>> +	@illegal="$$(git ls-files | grep '["*:<>?\\|]')"; \
>
> This pattern must exclude questionables on either NTFS or HFS+; it
> is ironic that it is not even sufficient to limit ourselves to the
> Portable Character Set [*1*], but such is life.
>
> By the way, doesn't ls-files take pathspec glob, saving one extra
> process to run grep?
>
>     master$ git ls-files '*["*:<>?\\|]*'
>     pu$ git ls-files '*["*:<>?\\|]*'
>     t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side

One more thing you may want to exclude is HT.  Here is a suggested
reroll.  I reworded to avoid a subjective "truly platform-independent",
which is not what we intend to aim for anyway (we only try to support
the platforms we care about).

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 15 Aug 2016 16:08:41 +0200
Subject: [PATCH] t/Makefile: make sure that paths can be checked out on
 platforms we care

Some pathnames that are okay on ext4 and on HFS+ cannot be checked
out on Windows.  Tests that want to see operations on such paths on
filesystems that support them must do so behind appropriate test
prerequisites, and must not include them in the source tree (instead
they should create them when they run).  Otherwise, the source tree
cannot be even checked out.

Make sure that double-quotes, asterisk, colon, greater/less-than,
question-mark, backslash, tab and vertical-bar never appears in the
pathnames with a new test-lint-* target as part of a `make test`.

Noticed when a topic wanted to add a pathname with '>' in it.  A
check like this will prevent a similar problems from happening.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 18e2b28..d4b2a50 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -52,7 +52,8 @@ clean-except-prove-cache:
 clean: clean-except-prove-cache
 	$(RM) .prove
 
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
+	test-lint-filenames
 
 test-lint-duplicates:
 	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
@@ -67,6 +68,11 @@ test-lint-executable:
 test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
 
+test-lint-filenames:
+	@bad=$$(git ls-files '*[	"*:<>?\\|]*'); \
+		test -z "$$bad" || { \
+		echo >&2 "do not use non-portable file name(s): $$bad"; exit 1; }
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
-- 
2.10.0-rc0-132-gce76bc9

