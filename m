Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9546020D0A
	for <e@80x24.org>; Mon, 29 May 2017 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbdE2U1i (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 16:27:38 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:44558 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdE2U1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 16:27:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wc7Zw2NS2z5tlM;
        Mon, 29 May 2017 22:27:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D9BFF4332;
        Mon, 29 May 2017 22:27:35 +0200 (CEST)
Subject: [PATCH 2/2] mingw_fopen: report ENOENT for invalid file names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
 <20170526033510.1793-14-gitster@pobox.com>
 <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <bbdda290-d634-14c6-91ed-c8245ae50a54@kdbg.org>
Date:   Mon, 29 May 2017 22:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, certain characters are prohibited in file names, most
prominently the colon. When fopen() is called with such an invalid file
name, the underlying Windows API actually reports a particular error,
but since there is no suitable errno value, this error is translated
to EINVAL. Detect the case and report ENOENT instead.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  compat/mingw.c            | 2 ++
  t/t5580-clone-push-unc.sh | 2 +-
  2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 62109cc4e6..ce6fe8f46b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -423,6 +423,8 @@ FILE *mingw_fopen (const char *filename, const char 
*otype)
  		return NULL;
  	}
  	file = _wfopen(wfilename, wotype);
+	if (!file && GetLastError() == ERROR_INVALID_NAME)
+		errno = ENOENT;
  	if (file && hide && set_hidden_flag(wfilename, 1))
  		warning("could not mark '%s' as hidden.", filename);
  	return file;
diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index fd719a209e..93ce99ba3c 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -8,7 +8,7 @@ if ! test_have_prereq MINGW; then
  	test_done
  fi

-test_expect_failure 'remote nick cannot contain backslashes' '
+test_expect_success 'remote nick cannot contain backslashes' '
  	BACKSLASHED="$(pwd | tr / \\\\)" &&
  	git ls-remote "$BACKSLASHED" >out 2>err &&
  	! grep "unable to access" err
-- 
2.13.0.55.g17b7d13330
