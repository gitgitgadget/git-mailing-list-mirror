Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB835207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 00:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163682AbdDXAO7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 20:14:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53117 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758693AbdDXAO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 20:14:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38E6D7F8E0;
        Sun, 23 Apr 2017 20:14:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7nne0vxVY6rqujsageCn0BmME5o=; b=CnN/WN
        j65/j1Pk5Mq+zm+HeShrYcFAYf7jGhrzBl8SgM2L5SicNSEhkQzLkqSnMTn7VHz6
        /C5cbA1WlxUK6vWaUTiF9oDeFohvdmP4ap8JnhSbfuzVrdP8Bb49iXP+QbRJw5a8
        XX7w1suazuYBVxovnkeGguI1vwjK6BP8HKesI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NBnXBPQhuht5vSjg00Uxy5L7g+7dE0uy
        M3rjRbFZACIlbN3iCSy6L4agFasTwSDetb1BJCAd33vD5+SJ8ONw7NyXhblQe9Rt
        +haMIcln79onONw9JMY8BUVEabECT+9QIfhb9xq893e6ARfPSkUPmqSust9G3bvY
        bR+Aphp//W0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 300257F8DF;
        Sun, 23 Apr 2017 20:14:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C41E7F8DB;
        Sun, 23 Apr 2017 20:14:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
        <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
Date:   Sun, 23 Apr 2017 17:14:54 -0700
In-Reply-To: <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 21 Apr 2017 16:15:28 -0400")
Message-ID: <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B711B42-2883-11E7-9799-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -		test -d "$remove_trash" &&
>> +		test -d "$remove_trash" ||
>> +		error "Tests passed but trash directory already removed before test cleanup; aborting"
>
> I think I found out why this "test -d" was here in the first place:
>
>   $ ./t0000-basic.sh --debug
>   [...]
>   # passed all 77 test(s)
>   1..77
>   error: Tests passed but trash directory already removed before test cleanup; aborting
>
> When --debug is in use, we do not set $remove_trash. The original was
> relying on 'test -d ""' to return false.
>
> I think this whole removal block should probably be moved inside a
> conditional like:
>
>   if test -n "$remove_trash"
>   then
>      ...
>   fi

Thanks for digging.  Yes, checking for non-empty string is
definitely better.

> I also wonder if we should come up with a better name than
> $remove_trash. A script which unknowingly overwrites that variable would
> be disastrous.
>
> Perhaps we should drop it entirely and just do:
>
>   if test -z "$debug"
>   then
>      test -d "$TRASH_DIRECTORY" ||
>      error "Tests passed but..."
>   [and so forth...]
>   fi

OK.  I am wondering why we do not do 

	rm -fr "$TRASH_DIRECTORY"

and do this instead:

	cd "$(dirname "$remove_trash")" &&
	rm -rf "$(basename "$remove_trash")"

in the original.  It feels somewhat unnatural.

	... goes and looks ...

Of course, back when abc5d372 ("Enable parallel tests", 2008-08-08)
was writen, we didn't even have TRASH_DIRECTORY variable; because
the way the test-lib.sh ensured that the trash directory is prestine
was to first do a 'rm -fr "$test"' before the first test_create_repo,
the above makes sort of matches how that initial removal is done.

So perhaps we can simplify and make it more robust by doing this?

 t/test-lib.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cde7fc7fcf..f1ab8f33d9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -760,9 +760,14 @@ test_done () {
 			say "1..$test_count$skip_all"
 		fi
 
-		test -d "$remove_trash" &&
-		cd "$(dirname "$remove_trash")" &&
-		rm -rf "$(basename "$remove_trash")"
+		if test -z "$debug"
+		then
+			test -d "$TRASH_DIRECTORY" ||
+			error "Tests passed but trash directory already removed before test cleanup; aborting"
+
+			rm -fr "$TRASH_DIRECTORY" ||
+			error "Tests passed but test cleanup failed; aborting"
+		fi
 
 		test_at_end_hook_
 
