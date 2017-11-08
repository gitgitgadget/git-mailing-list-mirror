Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457F81F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 22:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbdKHWex (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 17:34:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:37255 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751245AbdKHWew (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2017 17:34:52 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CYvpe58zpzbmWCYvqe3ISO; Wed, 08 Nov 2017 22:34:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8
 a=swdN5p_dyQG13G2yY1cA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: Test failures on 'pu' branch
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <cf38b57d-1424-0776-b67f-8cfd24e087bb@ramsayjones.plus.com>
 <CAGZ79kb3NpuWW=BpTjF_DrdVhXHh3d_8aF77Jdpi+8yTxtAbVw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e2d10701-2deb-4f03-f4ce-3da7d48effa3@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 22:34:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb3NpuWW=BpTjF_DrdVhXHh3d_8aF77Jdpi+8yTxtAbVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGvU6dzX5TpXFJv/3kNbF/aa3M1tL/OkynWLuOcrERuB1jNUkR7T0HqbO0Mp2ry9x+hhT1zixQu5s2oOQ9vipjNUs6qClUX/2DOB5BcMKJeXYPFZMG8G
 gjM7mUkyYaEOkcumcPKbS9ll6PZlYsT97hZ5wViRGrWcUCogTmtheh61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/11/17 20:36, Stefan Beller wrote:
> On Wed, Nov 8, 2017 at 12:28 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> 
>> t5300-pack-object.sh                             (Wstat: 256 Tests: 40 Failed: 2)
> 
>> t5500-fetch-pack.sh                              (Wstat: 256 Tests: 355 Failed: 6)
> 
> These are series
> 
>> t5601-clone.sh                                   (Wstat: 256 Tests: 102 Failed: 4)
> 
> This one is a spurious test. I had that flake on me once in the last weeks, too.
> But upon investigation I could not reproduce.
> See https://public-inbox.org/git/xmqq376ipdpx.fsf@gitster.mtv.corp.google.com/
> 

No, this is not related to that. In fact several tests start
working if I change the '--filter=blobs:limit=0' to instead
read '--filter=blob:limit=0' (ie. change blob_s_ to blob).

In fact t5601 now works with the following patch:

-- >8 --
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f18d9454a..0074690f7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -630,7 +630,7 @@ partial_clone () {
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
 	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
 
-	git clone --filter=blobs:limit=0 "$URL" client &&
+	git clone --filter=blob:limit=0 "$URL" client &&
 
 	git -C client fsck &&
 
@@ -651,7 +651,7 @@ test_expect_success 'partial clone: warn if server does not support object filte
 		     test_create_repo server &&
 		     test_commit -C server one &&
 
-	git clone --filter=blobs:limit=0 "file://$(pwd)/server" client 2> err &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client 2> err &&
 
 	test_i18ngrep "filtering not recognized by server" err
 '
@@ -673,7 +673,7 @@ test_expect_success 'batch missing blob request during checkout' '
 	test_config -C server uploadpack.allowfilter 1 &&
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
-	git clone --filter=blobs:limit=0 "file://$(pwd)/server" client &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
 
 	# Ensure that there is only one negotiation by checking that there is
 	# only "done" line sent. ("done" marks the end of negotiation.)
@@ -705,7 +705,7 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
 	# Make sure that it succeeds
-	git clone --filter=blobs:limit=0 "file://$(pwd)/server" client
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 8< --

A similar patch to 't/t5300-pack-object.sh' gets one of the two
failing tests working. I haven't looked at 't/t5500-fetch-pack.sh'
yet.

ATB,
Ramsay Jones


