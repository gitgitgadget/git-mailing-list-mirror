Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868001F829
	for <e@80x24.org>; Sun, 30 Apr 2017 17:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427429AbdD3R3e (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 13:29:34 -0400
Received: from avasout08.plus.net ([212.159.14.20]:58634 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427425AbdD3R3d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 13:29:33 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id EhVW1v0021keHif01hVX3W; Sun, 30 Apr 2017 18:29:31 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=aNcZtGQ49kGEJB3Qu08A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] t7400: add !CYGWIN prerequisite to 'add with \\ in path'
Message-ID: <bd5e3dc3-14f2-da03-4487-a52d3c0b52fe@ramsayjones.plus.com>
Date:   Sun, 30 Apr 2017 18:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit cf9e55f494 ("submodule: prevent backslash expantion in submodule
names", 07-04-2017) added a test which creates a git repository with
some backslash characters in the name. On windows, where the backslash
character is a directory separator, it is not possible to create a
repository with the name 'sub\with\backslash'. (The NTFS filesystem would
probably allow it, but the win32 api does not). The MinGW and Git for
Windows versions of git actually create a repository called 'backslash'
in the sub-directory 'sub/with'.

On cygwin, however, due to the slightly schizophrenic treatment of the
backslash character by cygwin-git, this test fails at the 'git init'
stage. The git-init command does not recognise the directory separators
in the input path (eg. is_dir_sep('\\') is false), so it does not
attempt to create the leading directories 'sub/with'. (The call to
mkdir('sub\\with\\backslash') actually does recognise the directory
separators, but fails because the 'sub/with' directory doesn't exist).

In order to suppress the test failure (for now), add the !CYGWIN test
prerequisite.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This is the 'v2' re-roll of the 'BSLASHPSEC' patch. :-D

ATB,
Ramsay Jones

 t/t7400-submodule-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c2706fe47..d0357f1d8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -273,7 +273,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
-test_expect_success 'submodule add with \\ in path' '
+test_expect_success !CYGWIN 'submodule add with \\ in path' '
 	test_when_finished "rm -rf parent sub\\with\\backslash" &&
 
 	# Initialize a repo with a backslash in its name
-- 
2.12.0
