Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A121FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 12:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbcFUMo6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:44:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:64422 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbcFUMo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 08:44:58 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M5tU1-1bZ3pt1sbJ-00xpzB; Tue, 21 Jun 2016 14:43:24
 +0200
Date:	Tue, 21 Jun 2016 14:43:22 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Make find_commit_subject() more robust
In-Reply-To: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
Message-ID: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de>
References: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eLC5UU7XJHAgMJJDOuvYyrABm9n6/zsILbfSSaUIdVqKrGHQGSo
 1S1MPSTSRFZGm10XpuATPt9QYX8ccocdkMWUgoEMopGltTAf22dd/WsjSDl7FV2vMjLwlA1
 ehUpSS9Hb17Ixp9CSyM2p5nu6GPrY/4qR9FjCckLIjtpoZZm3uwmMs6wSqUd6eTt6teDReB
 wbBxQLRsun3brUKFZARcw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:PsWt0DzjYeU=:oopXVeNd84jGLL1LAomHtA
 ZKgNjUIrp5kZY6wyThC5lcxOcDEv+QNEuaRM6eXjBwmeM3FeSj1mB4wy3ouxrljTVftVO5MzS
 hc73zBmeiEjYuwovgWDcfcuM/bT6QSX1D3VtJEohn7AsQrSqwegmvRv9XVmdh076wJTx6wNbs
 cAv+SpJc3UjZtNBHsxC8tnYB+hJ48jvJjTj8SLBscmCUpShUlXikOZYT0UDv1JtxempoEfVEl
 +LEfRWT0Xk1jLCZo8rafIIaKgvUymyK57Ger+mWUJEpN2Qrg3VdbaYkKQUx2jk4wvpjAvaKhD
 qhzkvivEkyfhKfQmCGaO/JIdNit/1sDLfwFksx8wprJjeSpm+06eE0G+6OWkthq8WiAvbEpds
 vCXMqJb7qB1AaZmyrvmC/WjsT3K6XONZiozBVx9iXkWp9S2GmDPJVnQ3f63QjUZ9LEu5f118Z
 RoN9e7OX86GX0KfetfUQczfRgfUjMZe93M6ju+WQAXxu390HumCien30jgGojmMZeP39SBF4t
 fn0spCwkEcGTeRh+qR0kX7/G3BNRe20h3CXkT6l+OQZdnipDEy6by+vFPhMKvhg/R+29/kqwg
 C2l+i1p3F1hQk/ov3uWNDS6OB0CFKom3a3wed1ZprQEZlENaOaQJE58kPAvvHI7Yp5x3DSnC/
 wgsufMD8SAgh70QopZ2slvWBvsXJ3bzQI8lxuv90Uwxdsj4pPvrxCkqtfAA0dpl/CSol1w5RR
 ZsFxPx0QHNgzGQINe5Wbk2jR7A7qkutOBmu0dVDscngu6IeYHSSbxamkfDGxtCMG84FvspXs9
 UUk/lqT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Just like the pretty printing machinery, we should simply ignore empty
lines at the beginning of the commit messages.

This discrepancy was noticed when an early version of the rebase--helper
produced commit objects with more than one empty line between the header
and the commit message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v2

	git blame seemed to be the most accessible user of
	find_commit_subject()...

 commit.c                 |  2 ++
 t/t8008-blame-formats.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
Interdiff vs v1:

 diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
 index 29f84a6..03bd313 100755
 --- a/t/t8008-blame-formats.sh
 +++ b/t/t8008-blame-formats.sh
 @@ -87,4 +87,21 @@ test_expect_success 'blame --line-porcelain output' '
  	test_cmp expect actual
  '
  
 +test_expect_success '--porcelain detects first non-empty line as subject' '
 +	(
 +		GIT_INDEX_FILE=.git/tmp-index &&
 +		export GIT_INDEX_FILE &&
 +		echo "This is it" >single-file &&
 +		git add single-file &&
 +		tree=$(git write-tree) &&
 +		commit=$(printf "%s\n%s\n%s\n\n\noneline\n\nbody\n" \
 +			"tree $tree" \
 +			"author A <a@b.c> 123456789 +0000" \
 +			"committer C <c@d.e> 123456789 +0000" |
 +		git hash-object -w -t commit --stdin) &&
 +		git blame --porcelain $commit -- single-file >output &&
 +		grep "^summary oneline$" output
 +	)
 +'
 +
  test_done


diff --git a/commit.c b/commit.c
index 3f4f371..7b00989 100644
--- a/commit.c
+++ b/commit.c
@@ -415,6 +415,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p += 2;
+		while (*p == '\n')
+			p++;
 		for (eol = p; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
 	} else
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index 29f84a6..03bd313 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -87,4 +87,21 @@ test_expect_success 'blame --line-porcelain output' '
 	test_cmp expect actual
 '
 
+test_expect_success '--porcelain detects first non-empty line as subject' '
+	(
+		GIT_INDEX_FILE=.git/tmp-index &&
+		export GIT_INDEX_FILE &&
+		echo "This is it" >single-file &&
+		git add single-file &&
+		tree=$(git write-tree) &&
+		commit=$(printf "%s\n%s\n%s\n\n\noneline\n\nbody\n" \
+			"tree $tree" \
+			"author A <a@b.c> 123456789 +0000" \
+			"committer C <c@d.e> 123456789 +0000" |
+		git hash-object -w -t commit --stdin) &&
+		git blame --porcelain $commit -- single-file >output &&
+		grep "^summary oneline$" output
+	)
+'
+
 test_done
-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
