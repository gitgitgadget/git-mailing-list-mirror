Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE911F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGMTxu (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:53:50 -0400
Received: from avasout08.plus.net ([212.159.14.20]:52869 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbeGMTxu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:53:50 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id e3swfMkd04FpAe3sxfuh0H; Fri, 13 Jul 2018 20:37:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GpFsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=jiJwNmXJWgQWgbQ8M1EA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
 <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
 <20180707013239.GA4687@sigill.intra.peff.net>
 <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
Message-ID: <6b323eff-a0a6-d8d3-1e40-70af8299db5f@ramsayjones.plus.com>
Date:   Fri, 13 Jul 2018 20:37:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOW+/HzdKrQd6ZH+xlMShhZm/RiCUapcBssRQtOcvKDg5den6bhL2r93VVuiyHKNZcxrXYWMs03viCpq5EjarFqG0tNcwh4QOeugxKoZaDe4rOfxBe+M
 vyac1hcAPbP5QMUQAEODc9LSSoeyQFLswmYzzPrDBhxAPkjm1jOShxiP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/07/18 20:31, Ramsay Jones wrote:
> On 07/07/18 02:32, Jeff King wrote:
[snip]
>> Hmm, we seem to have "info" these days, so maybe that would do what I
>> want. I.e., I wonder if the patch below does everything we'd want. It's
>> late here and I probably won't get back to this until Monday, but you
>> may want to play with it in the meantime.
> 
> Sorry, I've been busy with other things and have not had the
> time to try the patch below (still trying to catch up with
> the mailing-list emails!).
> 
>> diff --git a/fsck.c b/fsck.c
>> index 48e7e36869..0b0003055e 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -61,7 +61,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
>>  	FUNC(ZERO_PADDED_DATE, ERROR) \
>>  	FUNC(GITMODULES_MISSING, ERROR) \
>>  	FUNC(GITMODULES_BLOB, ERROR) \
>> -	FUNC(GITMODULES_PARSE, ERROR) \
>>  	FUNC(GITMODULES_NAME, ERROR) \
>>  	FUNC(GITMODULES_SYMLINK, ERROR) \
>>  	/* warnings */ \
>> @@ -76,6 +75,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
>>  	FUNC(NUL_IN_COMMIT, WARN) \
>>  	/* infos (reported as warnings, but ignored by default) */ \
>>  	FUNC(BAD_TAG_NAME, INFO) \
>> +	FUNC(GITMODULES_PARSE, INFO) \
>>  	FUNC(MISSING_TAGGER_ENTRY, INFO)
>>  
>>  #define MSG_ID(id, msg_type) FSCK_MSG_##id,
>>
> 
> So, just squinting at this in my email client, if this allowed
> a push/fetch to succeed (along with an 'info' message), while
> providing an admin the means to configure it to loudly deny
> the push/fetch - then I think we have a winner! ;-)
> 
> Sorry for not testing the patch.

OK, so I found some time to test this tonight. It is not good
news (assuming that I haven't messed up the testing, of course). :(

On top of 'pu' (@9026cfc855), I reverted commit d4c5675233
("fsck: silence stderr when parsing .gitmodules", 2018-06-28) and
added the patch given below.

Unfortunately, the final test fails, thus:

  $ cd t
  $ ./t7415-submodule-names.sh
  ok 1 - check names
  ok 2 - create innocent subrepo
  ok 3 - submodule add refuses invalid names
  ok 4 - add evil submodule
  ok 5 - add other submodule
  ok 6 - clone evil superproject
  ok 7 - fsck detects evil superproject
  ok 8 - transfer.fsckObjects detects evil superproject (unpack)
  ok 9 - transfer.fsckObjects detects evil superproject (index)
  ok 10 - create oddly ordered pack
  ok 11 - transfer.fsckObjects handles odd pack (unpack)
  ok 12 - transfer.fsckObjects handles odd pack (index)
  ok 13 - index-pack --strict works for non-repo pack
  ok 14 - fsck detects symlinked .gitmodules file
  ok 15 - fsck detects non-blob .gitmodules
  ok 16 - fsck detects corrupt .gitmodules
  ok 17 - push warns about corrupt .gitmodules
  not ok 18 - push rejects corrupt .gitmodules (policy)
  #	
  #		rm -rf dst.git &&
  #		git init --bare dst.git &&
  #		git -C dst.git config transfer.fsckObjects true &&
  #		git -C dst.git config fsck.gitmodulesParse error &&
  #		test_must_fail git -C corrupt push ../dst.git HEAD 2>output &&
  #		grep gitmodulesParse output &&
  #		test_i18ngrep ! "bad config" output
  #	
  # failed 1 among 18 test(s)
  1..18
  $ 

i.e. the test_must_fail doesn't! ;-)

I have to go out now, but I will hopefully take a look at
this again tomorrow. (Do the test additions look OK?)

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] WIP: try jeff's last patch

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 fsck.c                     |  2 +-
 t/t7415-submodule-names.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 17b3a51fa..b74856cee 100644
--- a/fsck.c
+++ b/fsck.c
@@ -64,7 +64,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	FUNC(GITMODULES_MISSING, ERROR) \
 	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_PARSE, ERROR) \
 	FUNC(GITMODULES_NAME, ERROR) \
 	FUNC(GITMODULES_SYMLINK, ERROR) \
 	/* warnings */ \
@@ -79,6 +78,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_TAG_NAME, INFO) \
+	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index ba8af785a..ef9535a44 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -185,10 +185,36 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 		git add .gitmodules &&
 		git commit -m "broken gitmodules" &&
 
+		# issues an "info" warning, but does not fail
+		git fsck 2>output &&
+		grep gitmodulesParse output &&
+		test_i18ngrep ! "bad config" output &&
+
+		# up-rate gitmodulesParse to error
+		git config fsck.gitmodulesParse error &&
 		test_must_fail git fsck 2>output &&
 		grep gitmodulesParse output &&
 		test_i18ngrep ! "bad config" output
 	)
 '
 
+test_expect_success 'push warns about corrupt .gitmodules' '
+	rm -rf dst.git &&
+	git init --bare dst.git &&
+	git -C dst.git config transfer.fsckObjects true &&
+	git -C corrupt push ../dst.git HEAD 2>output &&
+	grep gitmodulesParse output &&
+	test_i18ngrep ! "bad config" output
+'
+
+test_expect_success 'push rejects corrupt .gitmodules (policy)' '
+	rm -rf dst.git &&
+	git init --bare dst.git &&
+	git -C dst.git config transfer.fsckObjects true &&
+	git -C dst.git config fsck.gitmodulesParse error &&
+	test_must_fail git -C corrupt push ../dst.git HEAD 2>output &&
+	grep gitmodulesParse output &&
+	test_i18ngrep ! "bad config" output
+'
+
 test_done
-- 
2.18.0
