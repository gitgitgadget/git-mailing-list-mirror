Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B551F406
	for <e@80x24.org>; Tue, 19 Dec 2017 19:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdLSTWX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 14:22:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751799AbdLSTWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 14:22:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39826D5D81;
        Tue, 19 Dec 2017 14:22:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SUve5wUwML8FnORViMTfjloZMzA=; b=lC3yWv
        /AfBcGwphvfQhRrw8FO272isUaDVsep/SCZM8e7+fhUF8bcnEQ6nai4hovYzTG0t
        +g7SKB0Vw8PS9ltvaPE/3Z4iNeH9kygLf6TLBaVB82MsN1C4sNhwn1ula/0BcbjB
        si+ojec70O9P8mac0M9ocjViuN8qlse8pm8c0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uyj9/a1VYaFLxitmbuJU7NbLo69bQFUb
        ZICtppV5bkJTjxW+fijEmhkt4vaqSkWb5D73gDzBhxhGJUf4PeLfZF/5HKKlmXZY
        r1qPjUq+DJZ7iQkoGzGATUHOMMByaUq05glB7MC6+I5ZVQMwRVjJEorfGsMl39Ss
        yedi3i/5oNU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 304D5D5D80;
        Tue, 19 Dec 2017 14:22:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B4C7D5D7E;
        Tue, 19 Dec 2017 14:22:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
References: <20171116020039.17810-1-sbeller@google.com>
        <20171116020039.17810-8-sbeller@google.com>
Date:   Tue, 19 Dec 2017 11:22:18 -0800
In-Reply-To: <20171116020039.17810-8-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Nov 2017 18:00:39 -0800")
Message-ID: <xmqqy3lyv7yt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF9ED2D4-E4F1-11E7-A76C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had to squash in the following to make 'pu' pass under
gettext-poison build.  Is this ready for 'next' otherwise?

With the "log --find-object" thing, it may be that this no longer is
needed, but then again we haven't done anything with the other
Jonathan's idea to unify the --find-object thing into the --pickaxe
framework.

It seems that we tend to open and then abandon new interests without
seeing them through completion, leaving too many loose ends untied.
This has to stop.

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 4668f0058e..3e3fb462a0 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -341,7 +341,7 @@ test_expect_success 'describe directly tagged blob' '
 test_expect_success 'describe tag object' '
 	git tag test-blob-1 -a -m msg unique-file:file &&
 	test_must_fail git describe test-blob-1 2>actual &&
-	grep "fatal: test-blob-1 is neither a commit nor blob" actual
+	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
