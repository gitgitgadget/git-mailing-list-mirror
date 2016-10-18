Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D6B20988
	for <e@80x24.org>; Tue, 18 Oct 2016 20:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbcJRUGM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 16:06:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:19070 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbcJRUGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 16:06:11 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3sz5g44GBYz5tlQ;
        Tue, 18 Oct 2016 22:06:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C733C5349;
        Tue, 18 Oct 2016 22:06:07 +0200 (CEST)
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
To:     Junio C Hamano <gitster@pobox.com>
References: <20161010175611.1058-1-sbeller@google.com>
 <alpine.DEB.2.20.1610121501390.3492@virtualbox>
 <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
 <alpine.DEB.2.20.1610131255001.197091@virtualbox>
 <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
 <2aa41392-a7ed-cd48-2737-bd852757ab35@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2908451e-4273-8826-8989-5572263cc283@kdbg.org>
Date:   Tue, 18 Oct 2016 22:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2aa41392-a7ed-cd48-2737-bd852757ab35@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2016 um 21:32 schrieb Johannes Sixt:
> I think that we could reduce the confusion by converting all $PWD to
> $(pwd) in these test cases. I don't remember why I suggested to use $PWD
> for one of the arguments of the test cases (the second must be $(pwd)),
> but the most likely reason is only that we save a process.

Something like this works for me on Windows. I can update the patch
after the "normalize funny urls" topic settles.

---- 8< ----
t0060: sidestep surprising path mangling results on Windows

When an MSYS program (such as the bash that drives the test suite)
invokes git on Windows, absolute Unix style paths are transformed into
Windows native absolute paths (drive letter form). However, this
transformation also includes some simplifications that are not just
straight-forward textual substitutions:

- When the path ends in "/.", then the dot is stripped, but not the
  directory separator.

- When the path contains "..", then it is optimized away if possible,
  e.g., "/c/dir/foo/../bar" becomes "c:/dir/bar".

These additional transformations violate the assumptions of some
submodule path tests. We can avoid them when the input is already a
Windows native path, because then MSYS leaves the path unmolested.

Convert the uses of $PWD to $(pwd); the latter returns a native Windows
path.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0060-path-utils.sh | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 25b48e5..444b5a4 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -305,8 +305,9 @@ test_git_path GIT_COMMON_DIR=bar config                   bar/config
 test_git_path GIT_COMMON_DIR=bar packed-refs              bar/packed-refs
 test_git_path GIT_COMMON_DIR=bar shallow                  bar/shallow
 
-# In the tests below, the distinction between $PWD and $(pwd) is important:
-# on Windows, $PWD is POSIX style (/c/foo), $(pwd) has drive letter (c:/foo).
+# In the tests below, $(pwd) must be used because it is a native path on
+# Windows and avoids MSYS's path mangling (which simplifies "foo/../bar" and
+# strips the dot from trailing "/.").
 
 test_submodule_relative_url "../" "../foo" "../submodule" "../../submodule"
 test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../foo/submodule"
@@ -314,7 +315,7 @@ test_submodule_relative_url "../" "../foo/submodule" "../submodule" "../../foo/s
 test_submodule_relative_url "../" "./foo" "../submodule" "../submodule"
 test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" "../../../../foo/sub/a/b/c"
-test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$(pwd)/repo"
+test_submodule_relative_url "../" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
@@ -327,16 +328,16 @@ test_submodule_relative_url "(null)" "../foo" "../submodule" "../submodule"
 test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
-test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
-test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
-test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
-test_submodule_relative_url "(null)" "$PWD" "./å äö" "$(pwd)/å äö"
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
-test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
-test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
-test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$(pwd)/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
+test_submodule_relative_url "(null)" "$(pwd)/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
+test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
+test_submodule_relative_url "(null)" "$(pwd)" "./." "$(pwd)/."
+test_submodule_relative_url "(null)" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
+test_submodule_relative_url "(null)" "$(pwd)" "./å äö" "$(pwd)/å äö"
+test_submodule_relative_url "(null)" "$(pwd)/." "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$(pwd)/submodule" "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$(pwd)/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
+test_submodule_relative_url "(null)" "$(pwd)/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
-- 
2.10.0.343.g37bc62b

