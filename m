Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E2C43461
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BBA61447
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbhELUgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:36:43 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:31879 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhELSHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 14:07:45 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E7F4E24000B;
        Wed, 12 May 2021 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620842778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAVkBRb8z5w4gwPe2DkUE91wMOTFNCPz2vTvfCkcE3w=;
        b=esj3TuH9mCEPX9nFP/wnBlOaUDQNY1taxDuDZK5KF3hlUq6BUBeM2BQZ0JGodlrtPCw3rY
        vMqIVD9Mk4nXm67RukphgQVqkPBfX6eGiTDg6epb3wEoGUJyCsVvCTE8Mtc/lOJNpySgvj
        9yAXGGGKrkanUDcFlv9a4l0PbEo4Gq0gq7xubGPn3avb6xssRRVJ7d5j17Fc8dDz8R6har
        SxpJlL6lf/I+ijEPp5h5CZPTrk+bVnUurbO8mvUru62L69CjziYkPj55t+rp9JTwDdk7Y2
        Gy5VFAG4EZnC83VgkIrMwU/wVb+e56UpUz/KXX2K29bldgDCD+ff0M0fivm0Cw==
Date:   Wed, 12 May 2021 12:06:14 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Message-ID: <YJwZFpxKLTch/N6O@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <609b8a5a65826_6e0fc2084c@natae.notmuch>
 <YJvUMTAVKJqPZF2t@gpanders.com>
 <609c0eaca8d28_71bd120878@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609c0eaca8d28_71bd120878@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 12:21 -0500, Felipe Contreras wrote:
>The sole purpose of software is that it's useful to users. Software 
>that works today but not tomorrow is bad software.
>
>The primary purpose of the testing framework is to ensure that doesn't
>happen; that git keeps working in the same way today than it did
>yesterday.
>
>That's why it's more important that tests excercise the options people
>were using yesterday.
>
>In addition we also want to be testing new functionality, but that's *in
>addition*.
>
>Maybe at some point in the future more people will be using
>--sendmail-cmd, but right now that's not the case. Right now we need to
>be testing the option people are using *today*.

I agree with this completely. Is this requirement satisfied with the 
addition of a test that checks the usage of an absolute path with 
--smtp-server (the behavior that people were using yesterday), while all 
of the existing tests are still converted to the new option? I have such 
a test written (along with a few others) in the forthcoming v2 patch:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..45bc3c0c4c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2148,6 +2148,55 @@ test_expect_success $PREREQ 'leading and trailing 
whitespaces are removed' '
  	test_cmp expected-list actual-list
  '
  
+test_expect_success $PREREQ 'test using absolute path for --smtp-server' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
+test_expect_success $PREREQ 'arguments not supported with --smtp-server' '
+	test_expect_code 127 git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail -f nobody@example.com" \
+		HEAD^
+'
+
+test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
+	clean_fake_sendmail &&
+	PATH="$(pwd):$PATH" \
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd="fake.sendmail" \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
+test_expect_success $PREREQ 'test using arguments with --sendmail-cmd' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd="\"$(pwd)/fake.sendmail\" -f nobody@example.com" \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
+test_expect_success $PREREQ 'test shell expression with --sendmail-cmd' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--sendmail-cmd="[ 1 -eq 1 ] && \"$(pwd)/fake.sendmail\"" \
+		HEAD^ &&
+	test_path_is_file commandline1
+'
+
  test_expect_success $PREREQ 'invoke hook' '
         mkdir -p .git/hooks &&
