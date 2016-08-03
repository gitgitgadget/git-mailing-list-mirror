Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEBE20226
	for <e@80x24.org>; Wed,  3 Aug 2016 06:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbcHCGPo (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 02:15:44 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:12459 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677AbcHCGPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 02:15:37 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s42qD4B0Yz5tlM;
	Wed,  3 Aug 2016 08:15:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8F0D452B1;
	Wed,  3 Aug 2016 08:15:03 +0200 (CEST)
Subject: [PATCH v2] t4130: work around Windows limitation
To:	Junio C Hamano <gitster@pobox.com>
References: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de>
 <9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org>
 <CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com>
 <alpine.DEB.2.20.1607301011140.11824@virtualbox>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <244e3458-4a41-49bf-fba2-71da872e7f66@kdbg.org>
Date:	Wed, 3 Aug 2016 08:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607301011140.11824@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Windows, it is already pretty expensive to try to recreate the stat()
data that Git assumes is cheap to obtain. To make things halfway decent
in performance, we even have to skip emulating the inode and to
determine the number of hard links.

This is not a huge problem, usually, as either the size or the mtime or
the ctime are tell-tale enough to say when a file has changed, and even
if not, those changes are typically made after the index file was
written, triggering a rehashing of the files' contents.

The t4130-apply-criss-cross-rename test case, however, requires the
inode to determine that files of equal size were swapped, as renaming
files does not update their mtime. Every once in a while, t4130 fails
on Windows because of this missing piece.

Equal file sizes are not crucial for the test cases, however. Hence,
generate files with different sizes so that there is some property that
the swapped files can be discovered reliably even on Windows.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This fell through the cracks, I think. I marked it as v2 because
 there is a minor fixup in the commit message.

 t/t4130-apply-criss-cross-rename.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index d173acd..f8a313b 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -13,9 +13,13 @@ create_file() {
 }
  test_expect_success 'setup' '
-	create_file file1 "File1 contents" &&
-	create_file file2 "File2 contents" &&
-	create_file file3 "File3 contents" &&
+	# Ensure that file sizes are different, because on Windows
+	# lstat() does not discover inode numbers, and we need
+	# other properties to discover swapped files
+	# (mtime is not always different, either).
+	create_file file1 "some content" &&
+	create_file file2 "some other content" &&
+	create_file file3 "again something else" &&
 	git add file1 file2 file3 &&
 	git commit -m 1
 '
-- 
2.9.0.443.ga8520ad

