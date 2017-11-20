Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8FDF2036D
	for <e@80x24.org>; Mon, 20 Nov 2017 11:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdKTLlS (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 06:41:18 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45858 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdKTLlR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 06:41:17 -0500
Received: by mail-wr0-f180.google.com with SMTP id a63so7772059wrc.12
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 03:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ba0Ok4Lg2HrUnfwc5LJL7hnnrCiVDngsDKXX0//vMkw=;
        b=Of/AtJqA4rpPtKxPFLConp4Um7s/sy8yvM8dcmXZOreIAUW9tJjFZrhDhbQZrIgQKc
         M+4sQ+AvHh0vm5YmLrCxq8kRftJMcQB6A2ir11ya4e1/TZeox4cF22CaSuFt4Fld3QWq
         1kWG97zn6Lia647fEVdvHpD+2X3NyGp4gzzJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ba0Ok4Lg2HrUnfwc5LJL7hnnrCiVDngsDKXX0//vMkw=;
        b=b8Nnh9l/fWWtT40hubuOZgAbi+S6j/zJTqUya1+voZ4LZz3hESXW0ndh3B9POjZjkP
         3BcuWNjIhXpxWTGDeah7tvpJ6yU5Zwc2NZcFE/hVrcVN9fKKUEtENUh+hl6xYBtDKVpo
         lF4QxsQBGTF7VV9FOj+g42PTfD2vZwM1y/k1rI4W28ouq4eHuXZ4rv1wV0YYocS+Vrn5
         nLlOHL6Hbkg13DP2UejTVddPcdU3t3FdXGTCVjg1+UfarRAHxReg32HzK9aBAXokRe90
         c6533R16FpoeBsvaw2c//fO3hI6TO49Ou5G90xKl4g4pIg2qS4SXHC0bXSJrzKwUfjXV
         XF7Q==
X-Gm-Message-State: AJaThX5zcTHNadfWWSQ2/yH9uDW65qf2d/r/mkMWVVFE6NQKZl4ar8El
        j33XazL4dQ2Piq3DHWg3NdAzig==
X-Google-Smtp-Source: AGs4zMYb7nxbTs3JQcysFN5CS0y2vuNxeO5kFX1U37HGi43+FcXz+Yw6lqMumSWlXgTPDhqZbLaRDA==
X-Received: by 10.223.128.4 with SMTP id 4mr12193110wrk.9.1511178076357;
        Mon, 20 Nov 2017 03:41:16 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id y15sm24885216wrc.96.2017.11.20.03.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 03:41:15 -0800 (PST)
Received: from zen.linaroharston (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTP id ECE5A3E01B1;
        Mon, 20 Nov 2017 11:41:14 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-send-email: fix --cc-cmd get_maintainer.pl regression
Date:   Mon, 20 Nov 2017 11:41:01 +0000
Message-Id: <20171120114101.16508-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the removal of Mail::Address from git-send-email certain address
patterns returned by common get_maintainer.pl scripts now fail to get
correctly parsed by the built-in Git::parse_mailboxes. Specifically
the patterns with embedded parenthesis fail. For example from the
Linux kernel MAINTAINERS:

  KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
  L:	kvmarm@lists.cs.columbia.edu

Which is returned by get_maintainers.pl as:

  linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm))
  kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm))

However Git::parse_mailboxes code mangles the address, appending the
trailing parenthesis to the email address to the address part causing
it to fail validation:

   error: unable to extract a valid address from: linux-arm-kernel@lists.infradead.org) (moderated list:KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
   error: unable to extract a valid address from: kvmarm@lists.cs.columbia.edu) (open list:KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)

As this is a common pattern which was handled by Mail::Address I've
fixed the regression by explicitly capturing a trailing bracket and
appending it to the comment token.

NB: the t9001.sh test doesn't explicitly wrap the call to the --cc-cmd
in a "$(pwd)/expected-cc-script.sh" which fails due to the space to
the full-path of the test. It is currently ambiguous as to if --cc-cmd
needs to handle this. I suspect it is not an edge case that has come
up in real-world usage as git-send-email is usually run directly from
a git directory with scripts generally in a ./script/get_maintainer.pl
path.

Fixes: cc9075067776ebd34cc08f31bf78bb05f12fd879
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>
---
 perl/Git.pm           |  3 +++
 t/t9000/test.pl       |  3 ++-
 t/t9001-send-email.sh | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ace9..9b17de1cc 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -936,6 +936,9 @@ sub parse_mailboxes {
 			$end_of_addr_seen = 0;
 		} elsif ($token =~ /^\(/) {
 			push @comment, $token;
+		} elsif ($token =~ /^\)/) {
+		        my $nested_comment = pop @comment;
+			push @comment, "$nested_comment$token";
 		} elsif ($token eq "<") {
 			push @phrase, (splice @address), (splice @buffer);
 		} elsif ($token eq ">") {
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
index dfeaa9c65..b01642a0d 100755
--- a/t/t9000/test.pl
+++ b/t/t9000/test.pl
@@ -35,7 +35,8 @@ my @success_list = (q[Jane],
 	q['Jane 'Doe' <jdoe@example.com>],
 	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
 	q[Jane <jdoe@example.com> Doe],
-	q[<jdoe@example.com> Jane Doe]);
+	q[<jdoe@example.com> Jane Doe],
+	q[jdoe@example.com (open list:for thing (foo/bar))]);
 
 my @known_failure_list = (q[Jane\ Doe <jdoe@example.com>],
 	q["Doe, Ja"ne <jdoe@example.com>],
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4d261c2a9..fa783eb87 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -172,6 +172,22 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
+        write_script expected-cc-script.sh <<-EOF &&
+echo "One Person <one@example.com> (supporter:THIS (FOO/bar))"
+echo "Two Person <two@example.com> (maintainer:THIS THING)"
+echo "Third List <three@example.com> (moderated list:THIS THING (FOO/bar))"
+echo "<four@example.com> (moderated list:FOR THING)"
+echo "five@example.com (open list:FOR THING (FOO/bar))"
+echo "six@example.com (open list)"
+EOF
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--cc-cmd=./expected-cc-script.sh \
+		--smtp-server="$(pwd)/fake.sendmail" &&
+	test_cmp expected-cc commandline1
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.15.0

