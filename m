Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1539CC07E99
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E645161447
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhGHKpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:45:41 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:58088 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhGHKpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 06:45:39 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 06:45:39 EDT
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 31B04C6EAB; Thu,  8 Jul 2021 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1625740428; bh=/AtUkO/+kaB5keGvtTmXAxWLi9zxFPzAUKF9NaPjUQA=;
        h=Subject:To:From:Date;
        b=vIfBJ156msqdQnRDTkMR1SkpGeOcyEKDv/R32p/tMioeKTkfTWnweOKAJg5VHm7OK
         JVuNVmsGCoA4ZK/uLccOAfhj8joKLRzerPyJ96e7ovfTXz9wCPpwBHO1BAfJOEavrS
         /585BCGVQgtBVqhDWn20AicGD4vHCPKYIqEnlizo=
Received: from localhost (arch-vps [128.199.32.197])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1F779C6EA9
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1625740426; bh=/AtUkO/+kaB5keGvtTmXAxWLi9zxFPzAUKF9NaPjUQA=;
        h=Subject:To:From:Date;
        b=JNwuiSIoNp5Z2nK97UHzNZ9S7KePqLdQGb9XfvxrJmhKpujzxMNYxSKak+y1/UX6k
         SQVTHU8uGXciDN8x0AcyjmvJw2QJwFFlLFtAAzR5CRFAy6RRTlSU4NiAxP+iw6Um9M
         mgO6uGBNs3/x7sv+fgbWhqcMJEn96VwEPnNnJ+40=
Content-Type: multipart/mixed;
 boundary=4941ecdd162ba3ab69a2e075b0c3d6f08b0c46511980ea0671430c52a29d
Mime-Version: 1.0
Message-Id: <CCNOOVFJVMLC.7L79PCH59K1C@arch-vps>
Subject: git interpret-trailers: behavior with input without trailing
 newline
To:     <git@vger.kernel.org>
From:   "Luca Weiss" <luca@z3ntu.xyz>
Date:   Thu, 08 Jul 2021 10:33:46 +0000
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--4941ecdd162ba3ab69a2e075b0c3d6f08b0c46511980ea0671430c52a29d
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=utf-8

Hi all,

I'm investigating a behavior with git interpret-trailers where when the inp=
ut does not end with a newline, git appends the trailer directly without a =
newline; and on running the same command again it doesn't detect the previo=
us trailer anymore.=20

I've whipped up a quick PoC in form of a new test case in the existing test=
 cases of git.

Appending the patch here (sorry if it does get corrupted from my editor, bu=
t I hope you get the gist of it).

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 04885d0a5e..602725f939 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -17,6 +17,7 @@ test_expect_success 'setup' '
=20
 		body
 	EOF
+	printf "subject\n\nbody" > basic_message_no_eol &&
 	cat >complex_message_body <<-\EOF &&
 		my subject
=20
@@ -676,6 +677,12 @@ test_expect_success 'with message that has an old styl=
e conflict block' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'bla blub' '
+	git interpret-trailers --trailer "Cc: Peff" basic_message_no_eol > interm=
ediary &&
+	git interpret-trailers --trailer "Cc: Peff" intermediary > actual9 &&
+	test_cmp intermediary actual9
+'
+
 test_expect_success 'with commit complex message and trailer args' '
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&


It doesn't feel like an expected behavior but if it is, please tell me.

Regards
Luca
--4941ecdd162ba3ab69a2e075b0c3d6f08b0c46511980ea0671430c52a29d--
