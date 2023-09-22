Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA6CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 20:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIVUiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIVUiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 16:38:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866FCA
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 13:38:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so2655707f8f.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695415091; x=1696019891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqW+dJ9n3XjypUGmS5NkosFhC0izgNTnI2b+xP7UMB4=;
        b=iPVVJIPguOF/ODGZBte2gcIVQoO3KEQmbIom0eb1m2adgGMckmZXBTOHOmXDiD686q
         1NuTvJemf5VUUjbMclXGBjMegE/D/JUM1r2tvh9G9EFWwZfzXGBza6DgNT7e3pN02oAz
         +vjs4ldQ9TLzWta6TuDq6g/NUelri63RAghBAHBgBl4/VLiqhJlTF+sGfwrYJxe5WZ7g
         M/9tYzDchES9/UcFl8k3W3+zukJbmE3OaUtiaOrxuE6I9VcuvGWRPqePHaqSKF8mFw4R
         uopR5huKY3W1cARhwR0QK2KYOAft8jvDOYUDtrHxuvs0/pJDCAxJ+yszh9WpCJ5Y90Vz
         DOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695415091; x=1696019891;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqW+dJ9n3XjypUGmS5NkosFhC0izgNTnI2b+xP7UMB4=;
        b=sX6IM3CgPMoZWS4vQ6NQ4xr4NyolgPbMau7S8Q3pbzROU/QCt+AnzYTibKD41WYGRl
         JEW7LSpsGGzMvKxOir78jtWudTmTinljKbvn0VycuEI6ZUUkfzKMstV1jyQHdd0wAF2B
         pSyfG+VI0AheKMsMrFpa1zMU/oLadtmtVfjulDw9N2s6XrG/SKXNJ2TZd++GigGyu7R+
         74+NgB8avReLQpD5IcndHdrBjpqVoJoGersYkWfUHJ14C0SMaHAKBN3d83oWjNqSKReO
         D4tZ/qA/e4ikybIyHujDS5qE5xR+HTZU+GSY233MTK4dSzOMvafLpmZbpZYc97zw9LEI
         h3ug==
X-Gm-Message-State: AOJu0YxQAyrjmqHwk0EagVtyamArhp8OEc1oTgjkXXFHYiqtMG9xYNun
        7zIQJ6IrKB7MKJICsEjO2iQ=
X-Google-Smtp-Source: AGHT+IGMhA+nbHG6qpwYk+AhL3wNWfKMeoUlwH9pTbBGRnl7cPR26W7eosCpNfvNAakEYLurZKbKog==
X-Received: by 2002:a5d:6945:0:b0:317:5747:b955 with SMTP id r5-20020a5d6945000000b003175747b955mr624310wrw.17.1695415090550;
        Fri, 22 Sep 2023 13:38:10 -0700 (PDT)
Received: from [192.168.2.52] (203.red-88-14-40.dynamicip.rima-tde.net. [88.14.40.203])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b003143b14848dsm5201788wru.102.2023.09.22.13.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 13:38:10 -0700 (PDT)
Subject: [PATCH v2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Message-ID: <54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail.com>
Date:   Fri, 22 Sep 2023 22:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the if-elses chain we have in "check_test_results_san_file_", we
consider three variables: $passes_sanitize_leak, $sanitize_leak_check
and lastly, implicitly, GIT_TEST_SANITIZE_LEAK_LOG (always set to "true"
at that point).

For the first two variables we have different considerations depending
on the value of $test_failure, which make sense.  However, for the
third, GIT_TEST_SANITIZE_LEAK_LOG, we don't;  regardless of
$test_failure, we use "invert_exit_code=t" to produce a non-zero
return value.

That assumes "$test_failure = 0" is always true at that point.  But it
is not:

   $ git checkout v2.40.1
   $ make SANITIZE=leak
   $ make -C t GIT_TEST_SANITIZE_LEAK_LOG=true t3200-branch.sh
   ...
   With GIT_TEST_SANITIZE_LEAK_LOG=true, our logs revealed a memory leak, exiting with a non-zero status!
   # Simulated failures as TODO & now exiting with 0 due to --invert-exit-code

We need to use "invert_exit_code=t" only when "$test_failure = 0".

Probably we have missed this because GIT_TEST_SANITIZE_LEAK_LOG is
commonly used in combination with GIT_TEST_PASSING_SANITIZE_LEAK=check,
the second variable noted above, for which we have, as already said,
different considerations depending on the value of $test_failure.

However GIT_TEST_SANITIZE_LEAK_LOG has value used on its own, as it was
documented in faececa53f (test-lib: have the "check" mode for
SANITIZE=leak consider leak logs, 2022-07-28).

Let's add the missing conditions in the if-elses chain to make it work
as expected.

Note that we're not resetting the value of "invert_exit_code" when
$test_failure is non-zero.  Doing that is only needed when
GIT_TEST_PASSING_SANITIZE_LEAK=check, the second variable noted above.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Changes since v1:
- dropped 1/1 as it was erroneously included
- reworded the message to better capture the situation and the goal
- show a message also when $test_failure is non-zero


It is probably worth revisiting the use of "invert_exit_code=t"
in this SANITIZE_LEAK machinery.  But I'll stop here.

---
 t/test-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5ea5d1d62a..945ede50ac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1264,9 +1264,12 @@ check_test_results_san_file_ () {
 	then
 		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
 		invert_exit_code=t
-	else
+	elif test "$test_failure" = 0
+	then
 		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
 		invert_exit_code=t
+	else
+		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
 	fi
 }
 
-- 
2.34.1
