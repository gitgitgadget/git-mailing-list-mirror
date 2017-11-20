Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0873D2036D
	for <e@80x24.org>; Mon, 20 Nov 2017 11:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdKTLoo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 06:44:44 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:42754 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdKTLon (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 06:44:43 -0500
Received: by mail-wr0-f177.google.com with SMTP id o14so7796760wrf.9
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 03:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ba0Ok4Lg2HrUnfwc5LJL7hnnrCiVDngsDKXX0//vMkw=;
        b=G9d+AzdUDvmM2njOCy2mSrIGm4pyDV1khz/bzsPtIqLJm0VZ39WzsAYVZdkWIUtKMu
         2M0l5rfHwnMpr/fe/GfCzt1elM3GWx+HdLtdB5/jNhtDlJQfheS5sjHET/BAn1NrPNyX
         CCfo41WI0F4bSAUFnnWjSIF+p9FCRYZBFW4vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ba0Ok4Lg2HrUnfwc5LJL7hnnrCiVDngsDKXX0//vMkw=;
        b=QoEE6jl38wFK94u04XFZ3CtlRHxGAgwFyBjLQt8bLrX3nf/+rqhmNobnSZ+rCDCpnT
         c7DZyRc15cTITjG4nBt3J6zuEHp47eKLryS8ZdXQPAnwW1bNv2M+lZBWw2MZBf6p5G3f
         2wYF6XAURNAXrdCb9R9AkYdI33BwEVIwP+v+aaCqbeVp8fBxzIJ4iPEuQn7lZiV0BjTL
         Ha3nWIsjz62gzeA1VjYHrTORjpALJGgNQW0vcpPGuBPMfa8pi1a1B1tk0b9XR36OHrpk
         ALhylE2Qnz+hez70u7+zN/k/3YuzRArHJFN9jZ6d6Z+MxQlcnnQ987grCgD4X6qtwZYa
         KQ+Q==
X-Gm-Message-State: AJaThX6pAY1JioFS8+/88zQ8GZOSpAyKb+TxurUtWuOlnIUZwpKYkjNG
        2LWE4Ff9mFJ0YHQXITNVrkEbsQ==
X-Google-Smtp-Source: AGs4zMZuCUnXKN7m21wmh9fPRNbK+TTSiw8J5++mR8PzjCDzMgDQr06MZPQNxwfEq+z5d4DfZd+tsA==
X-Received: by 10.223.166.235 with SMTP id t98mr10937995wrc.251.1511178282366;
        Mon, 20 Nov 2017 03:44:42 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id o88sm4270878wrc.10.2017.11.20.03.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 03:44:41 -0800 (PST)
Received: from zen.linaroharston (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTP id C5A353E01B1;
        Mon, 20 Nov 2017 11:44:40 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] git-send-email: fix --cc-cmd get_maintainer.pl regression
Date:   Mon, 20 Nov 2017 11:44:35 +0000
Message-Id: <20171120114435.17989-1-alex.bennee@linaro.org>
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

