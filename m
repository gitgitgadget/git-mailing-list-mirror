Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8096B20D0A
	for <e@80x24.org>; Mon, 29 May 2017 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdE2UZa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 16:25:30 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:52161 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdE2UZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 16:25:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wc7XR2J6Vz5tlJ;
        Mon, 29 May 2017 22:25:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DD7824332;
        Mon, 29 May 2017 22:25:25 +0200 (CEST)
Subject: [PATCH 1/2] mingw: verify that paths are not mistaken for remote
 nicknames
To:     Junio C Hamano <gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
 <20170526033510.1793-14-gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
Date:   Mon, 29 May 2017 22:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170526033510.1793-14-gitster@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.2017 um 05:35 schrieb Junio C Hamano:
> When asked to open/fopen a path, e.g. "a/b:/c", which does not exist
> on the filesystem, Windows (correctly) fails to open it but sets
> EINVAL to errno because the pathname has characters that cannot be
> stored in its filesystem.
> 
> As this is an expected failure, teach is_missing_file_error() helper
> about this case.
> 
> This is RFC, as there may be a case where we get EINVAL from
> open/fopen for reasons other than "the filesystem does not like this
> pathname" that may be worth reporting to the user, and this change
> is sweeping such an error under the rug.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   wrapper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/wrapper.c b/wrapper.c
> index f1c87ec7ea..74aa3b7803 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -434,6 +434,10 @@ static void warn_on_inaccessible(const char *path)
>    * see if the errno indicates a missing file that we can safely ignore.
>    */
>   static int is_missing_file_error(int errno_) {
> +#ifdef GIT_WINDOWS_NATIVE
> +	if (errno_ == EINVAL)
> +		return 1;
> +#endif
>   	return (errno_ == ENOENT || errno_ == ENOTDIR);
>   }

I would prefer to catch the case in the compatibility layer. Here is
a two patch series that would replace your 12/13 and 13/13.

---- 8< ----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: mingw: verify that paths are not mistaken for remote nicknames

This added test case simply verifies that users will not be bothered
with bogus complaints à la

	warning: unable to access '.git/remotes/D:\repo': Invalid argument

when fetching from a Windows path (in this case, D:\repo).

[j6t: mark the new test as test_expect_failure]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5580-clone-push-unc.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index b195f71ea9..fd719a209e 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -1,13 +1,19 @@
 #!/bin/sh
 
-test_description='various UNC path tests (Windows-only)'
+test_description='various Windows-only path tests'
 . ./test-lib.sh
 
 if ! test_have_prereq MINGW; then
-	skip_all='skipping UNC path tests, requires Windows'
+	skip_all='skipping Windows-only path tests'
 	test_done
 fi
 
+test_expect_failure 'remote nick cannot contain backslashes' '
+	BACKSLASHED="$(pwd | tr / \\\\)" &&
+	git ls-remote "$BACKSLASHED" >out 2>err &&
+	! grep "unable to access" err
+'
+
 UNCPATH="$(pwd)"
 case "$UNCPATH" in
 [A-Z]:*)
-- 
2.13.0.55.g17b7d13330
