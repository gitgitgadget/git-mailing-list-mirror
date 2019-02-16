Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8A61F453
	for <e@80x24.org>; Sat, 16 Feb 2019 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfBPQvl (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 11:51:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44599 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbfBPQvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 11:51:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1GGpVev011092
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 16 Feb 2019 11:51:31 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>
Cc:     "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Date:   Sat, 16 Feb 2019 11:51:25 -0500
Message-ID: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdTGF7G45MU+cyGrT/mSSjg0mHHeOg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 16, 2019 3:27, Max Kirillov wrote:
> On Fri, Feb 15, 2019 at 04:13:15PM -0500, Randall S. Becker wrote:
> > Sadly, the fix does not change the results. In fact, it makes the hang
> > far more likely. Subtest 6,7,8 fails here, at close()
> 
> Correct, I did not expect it to help, it was for the other issue.
> 
> As for the hang issue, from your another message it seems to me that perl
> waiting correctly, there are really child process which do not exit.
> 
> What you could try is
> https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/
> (I'm not sure it would not conflict by now), this would remove dependency
> between tests. If it helps it would be very valuable information.

Good news. This patch does seem to do the trick. I wonder whether this fixes
the Azure build also.

I have run the test under the following conditions:
Run 1 (system idle): Pass
Run 2 (system idle): Pass
Run 3 (system idle): Pass
Run 4 (system idle): Pass
Run 5 (system idle): Pass
Run 6 (system mild load, heavy file system): Pass
Run 7 (system mild load, moderate file system load - git fetch): Pass
Run 8 (heavy system load, heavy file system load): Pass
Run 9 (--verbose, heavy system load, heavy file system load): Pass
Run 10 (GIT_TRACE=true, --verbose, heavy system load, heavy file system
load): Pass
Run 11 (very heavy system load, very heavy file system load): Pass

The current condition of the code is (the generate_zero_bytes delete was
previously removed so can be ignored for the patch):

diff --git a/t/t5562-http-backend-content-length.sh
b/t/t5562-http-backend-content-length.sh
index bbadde2c6e..f0f425b2cf 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -8,12 +8,12 @@ test_lazy_prereq GZIP 'gzip --version'
 verify_http_result() {
        # some fatal errors still produce status 200
        # so check if there is the error message
-       if grep 'fatal:' act.err
+       if grep 'fatal:' act.err.$test_count
        then
                return 1
        fi

-       if ! grep "Status" act.out >act
+       if ! grep "Status" act.out.$test_count >act
        then
                printf "Status: 200 OK\r\n" >act
        fi
@@ -33,7 +33,7 @@ test_http_env() {
                REQUEST_METHOD=POST \
                "$PERL_PATH" \
                "$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl \
-                   "$request_body" git http-backend >act.out 2>act.err
+                   "$request_body" git http-backend >act.out.$test_count
2>act.err.$test_count
 }

 ssize_b100dots() {
@@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '

 test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
        NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
-       generate_zero_bytes infinity  | env \
+       env \
                CONTENT_TYPE=application/x-git-upload-pack-request \
                QUERY_STRING=/repo.git/git-upload-pack \
                PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
                GIT_HTTP_EXPORT_ALL=TRUE \
                REQUEST_METHOD=POST \
                CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
-               git http-backend >/dev/null 2>err &&
+               git http-backend </dev/null >/dev/null 2>err &&
        grep "fatal:.*CONTENT_LENGTH" err
 '

@@ -161,7 +161,7 @@ test_expect_success 'empty CONTENT_LENGTH' '
                GIT_HTTP_EXPORT_ALL=TRUE \
                REQUEST_METHOD=GET \
                CONTENT_LENGTH="" \
-               git http-backend <empty_body >act.out 2>act.err &&
+               git http-backend <empty_body >act.out.$test_count
2>act.err.$test_count &&
        verify_http_result "200 OK"
 '



