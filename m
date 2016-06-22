Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1171FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 09:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbcFVJlK (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 05:41:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:54103 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbcFVJlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 05:41:08 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNIAz-1bI6Kj0S6r-006t7e; Wed, 22 Jun 2016 11:34:28
 +0200
Date:	Wed, 22 Jun 2016 11:34:27 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] Make find_commit_subject() more robust
In-Reply-To: <cover.1466587806.git.johannes.schindelin@gmx.de>
Message-ID: <b6a4fa27a997455c7dc4164f2d0414c99a9bf342.1466587806.git.johannes.schindelin@gmx.de>
References: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de> <cover.1466587806.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MtfcBfPQ4xiuXXmQ1weEfK+seneHcdC+4Se1xMkhABIxF2HQz4I
 l1uqtxgpnT1Ht/JD5wLAK2YELAMbdH1KA24LC3gTvHjYyUCJL9MI9B4jDE92ZdilPm59CJR
 WahZPULveQOzou+4XE/Ix3fmk7mfT9D2CkUXrnjYRaxvwlSYsGrK/ht3F+kTrcgYO4l3xzJ
 B62GpGiAl932cQgnqUBSQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Dg8hDSlorwk=:kUItgHo+GxVjNjp9GbMzrc
 XTjD31KnED2URX42NJy8R1BNkm64HOhRpxIamaDR7SlGNO7SFSWwEfYzMqC8sZUafpAOCy3b9
 ogOB3yEbpL8rC/k2iYEemovr7bnv9+aJQrVkWGDcGs8QmabMOZcbz1TnolgR45kqKC5nfQnlz
 DDQJtMdOvk2E/UGAjAbJ6qx5mzV0UsDCtdKIkw0oGiTs1xWlqOP8d6bKpYnx2+cxz7a/7p8fZ
 tu1ZPSp54Gl2cXOFh/pOG+S24KEbL2wmHn22txmYHSpahkzIsQEZS62ED7wXGd6+95KjDt27J
 lx8LyHvvTenbemozoHKMGZMIjtn7SGsFuN7BS2bUYurKM45atLxQMbU4feBVVx7kLZCyUi1C9
 AWV/mXaNVYmOc/2amCxxfakhIBeqHu2DJJVQGG/sm8gO27wvzvmls7zloH0lT7+VOtLFjSrkQ
 zKsD8+4+WPqC7GroAULPnwOK6lv2L9sbLF+oHn6trNt+odBrwhf9l9Msos2bbgsQjNQFxYo5Y
 7fHSLjJWIT8q7149PD/md02GvuZNOIIiHtMnjppmaqjqjW4T5/8fZChJYQ4p8RPKv7EKN3sT2
 uWQLYA+/Rn/czz9s99bm4p6V2MUH6GX4EjMSL4GHM7ExLjh8ey8fLnBg9uHoUvTD8COT2MPZv
 6JBlztlOYUJAWztcLquf1ltr3sXfT/fw0S8lOQcS+0CExQcn22wPzSJrpMNFRzql+H79P0Z5p
 rrgXKcBVMK+vZwVfG9P+Q0W8/RgLer52e2YnUd4oIj1pJBVa5gbq9ib0Vj43q9StFQOt5q9Lt
 SVB8fSq
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
index 3f4f371..0bf868f 100644
--- a/commit.c
+++ b/commit.c
@@ -414,7 +414,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 	while (*p && (*p != '\n' || p[1] != '\n'))
 		p++;
 	if (*p) {
-		p += 2;
+		p = skip_empty_lines(p + 2);
 		for (eol = p; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
 	} else
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index 29f84a6..b98f9a4 100755
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
