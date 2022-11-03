Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE5C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 19:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiKCTux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCTuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 15:50:51 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5E11838
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 12:50:51 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oqgEj-0003du-EE;
        Thu, 03 Nov 2022 19:50:49 +0000
Message-ID: <d8072985-95cb-724b-c21f-cde3b2f6945a@iee.email>
Date:   Thu, 3 Nov 2022 19:50:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC/PoC 3/5] test-lib: add GIT_BUNDLE_DIR setup
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-4-philipoakley@iee.email>
 <221103.86v8nw1jpi.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <221103.86v8nw1jpi.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/2022 09:14, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Nov 02 2022, Philip Oakley wrote:
>
>> The test system may output a number of documentation bundles containing
>> test repositories of interest to users, including those explicitly
>> documented.
>>
>> Provide a default location for holding those bundles.
>> As build artefact's this location, along with `.bndl` files, was
>> ignored in an earlier commit.
>>
>> This may need further refinement.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  t/test-lib.sh | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 4e45bc7c4f..b18cd8a34e 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -56,6 +56,20 @@ then
>>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>>  	exit 1
>>  fi
>> +if test -z "$GIT_BUNDLE_DIR"
>> +then
>> +	# Similarly, override this to store the documentation bundles subdir
>> +	# elsewhere
>> +	GIT_BUNDLE_DIR=$TEST_DIRECTORY/GIT_BUNDLE_DIR
>> +	if test ! -d "$GIT_BUNDLE_DIR"
>> +	then
>> +		mkdir -p "$GIT_BUNDLE_DIR"
> Okey, so "mkdir -p", not "mkdir" once one thinks about it for a second:
> Because we might be testing in parallel, so this will be racy.
>
>> +	fi
>> +elif test ! -d "$GIT_BUNDLE_DIR"
>> +then
>> +	echo "PANIC: Your "$GIT_BUNDLE_DIR" doesn't exist!" >&2
>> +	exit 1
>> +fi
> I think it's better just to put these in the "test-results" dir.
>
> For leak testing I have local patches to e.g. create test-results/<test
> number>.leak, and then after a run I slurp that up and process it.
>
> So, same idea, you could just add stuff there, and afterwards grab it
> there. No need for specifying the dir etc., you just need a test-lib.sh
> flag to say "yes, write these out".
Ok, I suppose it depends on the choice between pre-slurp and
post-slurping these delivery artefact bundles.

Taylor and Junio maybe able to suggest ideas about approaches that would
fit the documentation delivery pipeline.

Philip
