Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D5C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 11:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiEZLqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbiEZLo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 07:44:58 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDE1D808E
        for <git@vger.kernel.org>; Thu, 26 May 2022 04:44:51 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuBv8-000COw-4S;
        Thu, 26 May 2022 12:44:50 +0100
Message-ID: <00229772-f075-0b0c-7810-7debf6b971bc@iee.email>
Date:   Thu, 26 May 2022 12:44:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] rebase: help users when dying with `preserve-merges`
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
 <220526.867d687hd5.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220526.867d687hd5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2022 10:43, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Git will die if a "rebase --preserve-merges" is in progress.
>> Users cannot --quit, --abort or --continue the rebase.
>>
>> Make the `rebase --abort` option available to allow users to remove
>> traces of any preserve-merges rebase, even if they had upgraded
>> during a rebase.
>>
>> One trigger was an unexpectedly difficult to resolve conflict, as
>> reported on the `git-users` group.
>> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>>
>> Tell the user the options to resolve the problem manually.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  builtin/rebase.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 6ce7e98a6f1..aada25a8870 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1182,8 +1182,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  	} else if (is_directory(merge_dir())) {
>>  		strbuf_reset(&buf);
>>  		strbuf_addf(&buf, "%s/rewritten", merge_dir());
>> -		if (is_directory(buf.buf)) {
>> -			die("`rebase -p` is no longer supported");
>> +		if (is_directory(buf.buf) && !(action == ACTION_ABORT)) {
>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>> +			"Use `git rebase --abort` to terminate current rebase.\n"
>> +			"Or downgrade to v2.33, or earlier, to complete the rebase.\n");
>>  		} else {
>>  			strbuf_reset(&buf);
>>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
> Existing issue: No _(), shouldn't we add it?
This `strbuf_addf` is forming a path for internal use. It just happens
to look like legible English ;-)
>
> I wonder if we should use die_message() + advise() in these cases,
> i.e. stick to why we died in die_message() and have the advise() make
> suggestions, as e4921d877ab (tracking branches: add advice to ambiguous
> refspec error, 2022-04-01) does.

Ah, maybe it's my message.. that needs translating.
>
> But then again adding new advice is currently a bit of an excercise in
> boilerplate, and this seems fine for a transitory option.
I can go with that ;-)
>
> I think you don't need to add a trailing \n though...
Oops, just a little extra line spacing for emphasis maybe ?

