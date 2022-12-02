Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF7C47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiLBSpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiLBSpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:45:08 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42113D75
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:44:31 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 12421CA1248;
        Fri,  2 Dec 2022 13:44:31 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CB5BECC8320;
        Fri,  2 Dec 2022 13:44:30 -0500 (EST)
Message-ID: <d4a5bd6e-77bd-eb63-5c7f-8f3d46cc0418@jeffhostetler.com>
Date:   Fri, 2 Dec 2022 13:44:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija <doremylover123@gmail.com>
References: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
 <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/22 1:10 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Dec 02 2022, Rose via GitGitGadget wrote:
> 
>> From: Seija <doremylover123@gmail.com>
>>
>> The documentation for pthread_create and pthread_sigmask state that:
>>
>> "On success, pthread_create() returns 0;
>> on error, it returns an error number"
>>
>> As such, we ought to check for an error
>> by seeing if the output is not 0.
>>
>> Checking for "less than" is a mistake
>> as the error code numbers can be greater than 0.
>>
>> Signed-off-by: Seija <doremylover123@gmail.com>
>> ---
>>      maintenance: compare output of pthread functions for inequality with 0
>>      
>>      The documentation for pthread_create and pthread_sigmask state that "On
>>      success, pthread_create() returns 0; on error, it returns an error
>>      number, and the contents of *thread are undefined."
>>      
>>      As such, we ought to check for an error by seeing if the output is not
>>      0, rather than being less than 0, since nothing stops these functions
>>      from returning a positive number.
>>      
>>      Signed-off by: Seija doremylover123@gmail.com
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1389%2FAtariDreams%2Faddress-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1389/AtariDreams/address-v1
>> Pull-Request: https://github.com/git/git/pull/1389
>>
>>   builtin/fsmonitor--daemon.c | 4 ++--
>>   run-command.c               | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
>> index 6f30a4f93a7..52a08bb3b57 100644
>> --- a/builtin/fsmonitor--daemon.c
>> +++ b/builtin/fsmonitor--daemon.c
>> @@ -1209,7 +1209,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
>>   	 * events.
>>   	 */
>>   	if (pthread_create(&state->listener_thread, NULL,
>> -			   fsm_listen__thread_proc, state) < 0) {
>> +			   fsm_listen__thread_proc, state)) {
>>   		ipc_server_stop_async(state->ipc_server_data);
>>   		err = error(_("could not start fsmonitor listener thread"));
>>   		goto cleanup;
>> @@ -1220,7 +1220,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
>>   	 * Start the health thread to watch over our process.
>>   	 */
>>   	if (pthread_create(&state->health_thread, NULL,
>> -			   fsm_health__thread_proc, state) < 0) {
>> +			   fsm_health__thread_proc, state)) {
>>   		ipc_server_stop_async(state->ipc_server_data);
>>   		err = error(_("could not start fsmonitor health thread"));
>>   		goto cleanup;
>> diff --git a/run-command.c b/run-command.c
>> index 48b9ba6d6f0..756f1839aab 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1019,7 +1019,7 @@ static void *run_thread(void *data)
>>   		sigset_t mask;
>>   		sigemptyset(&mask);
>>   		sigaddset(&mask, SIGPIPE);
>> -		if (pthread_sigmask(SIG_BLOCK, &mask, NULL) < 0) {
>> +		if (pthread_sigmask(SIG_BLOCK, &mask, NULL)) {
>>   			ret = error("unable to block SIGPIPE in async thread");
>>   			return (void *)ret;
>>   		}
>>
>> base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
> 
> This looks good to me, and skimming through the rest of the
> pthread_create() it seems the rest of the code in-tree is correct.
> 
> But (and especially if you're interested) we really should follow-up
> here and fix the "error()" etc. part of this. After this we have cases
> in-tree where we on failure:

But to be clear, the pthread_ changes are good by themselves and can
be considered a single task that could be advanced without any
extra stuff.

All of the following, if of interest to you or anyone else, should
be done in one or more separate/later and independent series.

> 
>   * Call die_errno() (good)
>   * Call die(), error() etc., but with a manual strerror() argument,
>     these should just use the *_errno() helper.
>   * Don't report on the errno at all, e.g. in this case shown here.
> 
> It seems to me that all of these should be using die_errno(),
> error_errno() etc.
> 
> Or maybe it's the other way around, and we should not rely on the global
> "errno", but always capture the return value, and give that to
> strerror() (or set "errno = ret", and call {die,error,warning}_errno()).
> 
> In any case, some low-hanging #leftoverbits there...
> 
