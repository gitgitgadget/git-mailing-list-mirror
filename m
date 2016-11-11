Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175B12035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbcKKRbx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:31:53 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:7301 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934006AbcKKRbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:31:52 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFn5x2xkVz5tlD;
        Fri, 11 Nov 2016 18:31:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E22DA146;
        Fri, 11 Nov 2016 18:31:48 +0100 (CET)
Subject: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell
 variables
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
 <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
 <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
Date:   Fri, 11 Nov 2016 18:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to use $PWD instead of $(pwd) because on Windows the latter
would add a C: style path to bash's Unix-style $PATH variable, which
becomes confused by the colon after the drive letter. ($PWD is a
Unix-style path.)

In the case of GIT_ALTERNATE_OBJECT_DIRECTORIES, bash on Windows
assembles a Unix-style path list with the colon as separators. It
converts the value to a Windows-style path list with the semicolon as
path separator when it forwards the variable to git.exe. The same
confusion happens when bash's original value is contaminated with
Windows style paths.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 11.11.2016 um 18:11 schrieb Johannes Sixt:
> Am 11.11.2016 um 18:06 schrieb Junio C Hamano:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> That test made the incorrect assumption that the path separator
>>> character
>>> is always a colon. On Windows, it is a semicolon instead.
>>
>> Documentation/git.txt says that GIT_ALTERNATE_OBJECT_DIRECTORIES is
>> separated with ";" on Windows fairly clearly, and we should have
>> caught that.
>>
>> For the upcoming release there is no need for any further tweak on
>> your fix I am responding to, but in the longer term we would want to
>> turn this to path_sep=";" (or ":") and define it in the global
>> t/test-lib.sh, as it is plausible that we may want to prepend or
>> append to $PATH in the tests and that also needs ";" on Windows, no?

When the MSYS program such as bash invokes a non-MSYS program, it
translates the Unix-style paths in arguments and environment variables
to Windows stlye. We only have to ensure that we inject only Unix-style
paths in these places so as not to confuse the conversion algorithm.
Most of the time, we do not have to worry.

On the other hand, when we write a path to a file that git.exe consumes
or receive a path from git.exe, i.e., when the path travels through
stdout and stdin, no automatic translation happens (which is quite
understandable), and we have do the translation explicitly. An example
for such a case is when we write a .git/info/alternates file via the
shell.

> A simpler fix is to use $PWD instead of $(pwd). I'll submit a patch in a
> moment.

Here it is. I had proposed the t0021 part earlier, but it fell through
the cracks during the temporary maintainer change.

 t/t0021-conversion.sh    | 2 +-
 t/t5615-alternate-env.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9ff502773d..b93cd44546 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,7 +4,7 @@ test_description='blob conversion via gitattributes'
 
 . ./test-lib.sh
 
-TEST_ROOT="$(pwd)"
+TEST_ROOT="$PWD"
 PATH=$TEST_ROOT:$PATH
 
 write_script <<\EOF "$TEST_ROOT/rot13.sh"
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 22d9d8178b..eec4137ca5 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -31,14 +31,14 @@ test_expect_success 'objects inaccessible without alternates' '
 '
 
 test_expect_success 'access alternate via absolute path' '
-	check_obj "$(pwd)/one.git/objects" <<-EOF
+	check_obj "$PWD/one.git/objects" <<-EOF
 	$one blob
 	$two missing
 	EOF
 '
 
 test_expect_success 'access multiple alternates' '
-	check_obj "$(pwd)/one.git/objects:$(pwd)/two.git/objects" <<-EOF
+	check_obj "$PWD/one.git/objects:$PWD/two.git/objects" <<-EOF
 	$one blob
 	$two blob
 	EOF
-- 
2.11.0.rc0.55.gd967357


