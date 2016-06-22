Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3462018C
	for <e@80x24.org>; Wed, 22 Jun 2016 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbcFVUUc (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:20:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:49896 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbcFVUU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:20:29 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M8mCe-1b5tY82eq4-00C8Dy; Wed, 22 Jun 2016 22:20:20
 +0200
Date:	Wed, 22 Jun 2016 22:20:20 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/2] Make find_commit_subject() more robust
In-Reply-To: <cover.1466626795.git.johannes.schindelin@gmx.de>
Message-ID: <40e7a90edbb66b3523e19832e13ee10bc96b0371.1466626795.git.johannes.schindelin@gmx.de>
References: <cover.1466587806.git.johannes.schindelin@gmx.de> <cover.1466626795.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TUl/SUE2A18k5TG3q8j4crMVguA2qusjgeX1O7/H2c0+2LZeL/3
 NMR4cq8+sl9ZB9R4ppD0D54hMh/OMaoXXfLoOqimrRNHYd6tB9TGgt9oviDmilaII/E+Rql
 Rar7nP8nJGa2UwXGlR7S8Jevf3KAAiCKaEG+33rDfbgNxqQISyNDH/UyV5Ev2q+QO9y+7Uq
 pZ5n07zRS92pzr7DIw1XA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3KTfoX2Bm84=:4k98dwnpV10TNBpIcqZpF+
 1fLRA2v8jUbNKHFV9pn/a9VLRClITwHAYmU91lXXDQfYslO85ei51KCO6UAvTZxfIJzr1A06/
 W1aAnN8MkElqPWIYAf/vYUyWnywXnkdimi8pMlIGDyGcuURi4v2uNSfDy7cMXFE12zw1iJxcl
 FWMHbOmBxPDrYfApvp9WA17/gD7ybr9ziiGguLUby80ZLqwxGsHMA/kN9E4jhKsGNbnzNCy9x
 Q76J92tampgVJbzTu/8Ut/YjzO5tkRX9uC63mfaBbvdwiwfJc4F9IYpThponJ5m/ll4Nl8JrE
 LYmPdG1J8e4f+RePpGOocqIlrz9wKzERDef9r3ZgJRm1xJ5FR8hNLxIUPbqxvQrNXMgNXSnuP
 OUuvH2fBxsFjOoPKN5QDIWxXaDWCFViayLNXfnOzRKZJxplNpU+dmREvnxA8RMWoywchyezdh
 G5A28xs5WufqtTLPWjVT24pZw62+VB3wb847/FN6c/pArqpzlAnd9SzQB+w9GeU/v6t/alOI3
 oGw99NzkhlaxufTEysflMjieqF66hv1Jlqi8N40enb8Zg7XOSitEp075cdj+Z6Vb+beAAnLxO
 XR2vZ/c3NPvnAwqu9o9R4mm7u3zSHZVhrho+7c1cFg1I387ZBl3wiYUOjMLyFSayDITJ90p1T
 bdj/tGaRTbgOBZLhlmL9tUeH/dtdGCR5u5WByYBa5pQYnLUWUrG4xlJjv01qS5ffhaluLvg3x
 8GrNczfS6CM5D4zxz1bdUcf7BoUcRC5/LFiBrhYAA9sXjQeDQ+azYraWIeiEMt63BbBE09sa5
 uyu5B64
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Just like the pretty printing machinery, we should simply ignore blank
lines at the beginning of the commit messages.

This discrepancy was noticed when an early version of the rebase--helper
produced commit objects with more than one empty line between the header
and the commit message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c                 |  2 +-
 t/t8008-blame-formats.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 3f4f371..24d4715 100644
--- a/commit.c
+++ b/commit.c
@@ -414,7 +414,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 	while (*p && (*p != '\n' || p[1] != '\n'))
 		p++;
 	if (*p) {
-		p += 2;
+		p = skip_blank_lines(p + 2);
 		for (eol = p; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
 	} else
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index 29f84a6..92c8e79 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -87,4 +87,21 @@ test_expect_success 'blame --line-porcelain output' '
 	test_cmp expect actual
 '
 
+test_expect_success '--porcelain detects first non-blank line as subject' '
+	(
+		GIT_INDEX_FILE=.git/tmp-index &&
+		export GIT_INDEX_FILE &&
+		echo "This is it" >single-file &&
+		git add single-file &&
+		tree=$(git write-tree) &&
+		commit=$(printf "%s\n%s\n%s\n\n\n  \noneline\n\nbody\n" \
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
