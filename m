Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A371F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfHTTyI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:54:08 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:54582 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfHTTyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:54:07 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 69A4980A51B0; Tue, 20 Aug 2019 21:54:05 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id C76B880A51A1;
        Tue, 20 Aug 2019 21:54:00 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:44680 helo=[192.168.1.10])
        by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i0ACc-0003L5-S0; Tue, 20 Aug 2019 21:53:58 +0200
Subject: Re: [PATCH 2/2] rebase.c: make sure current branch isn't moved when
 autostashing
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <20190818095349.3218-1-ben@wijen.net>
 <20190818095349.3218-3-ben@wijen.net>
 <ff239cf8-f46e-82c5-788a-3484deff51cd@gmail.com>
From:   Ben <ben@wijen.net>
Message-ID: <dd1008fc-fdc6-8783-b9db-30a5c7e0a373@wijen.net>
Date:   Tue, 20 Aug 2019 21:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ff239cf8-f46e-82c5-788a-3484deff51cd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i0ACc-0003L5-S0
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

'git stash create autostash' does not clear the workarea (like 'git stash' does)
That's the reason for the 'git reset --hard'

The difference you see in the test between the legacy rebase and the builtin rebase is because
the legacy 'git reset --hard' emits the 'HEAD is now at ...' which was also included in the builtin rebase
I saw no reason to keep that message as - with my patch - we have concluded the HEAD must not change.


Ben...

On 20-08-2019 11:00, Phillip Wood wrote:
> Hi Ben
> 
> I need to have a longer look at this (I don't understand why we're calling reset --hard after we've stashed the changes) but I notice that the test lines you're changing predate the switch to the builtin rebase so those changes are not related to the branch switching problem.
> 
> Best Wishes
> 
> Phillip
> 
> On 18/08/2019 10:53, Ben Wijen wrote:
>> The rebase --autostash incorrectly moved the current branch to orig_head, where
>> orig_head -- commit object name of tip of the branch before rebasing
>>
>> It seems this was incorrectly taken over from git-legacy-rebase.sh
>>
>> Signed-off-by: Ben Wijen <ben@wijen.net>
>> ---
>>   builtin/rebase.c            | 18 ++++++------------
>>   t/t3420-rebase-autostash.sh |  4 ----
>>   2 files changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 670096c065..a928f44941 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1968,9 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>                   state_dir_path("autostash", &options);
>>               struct child_process stash = CHILD_PROCESS_INIT;
>>               struct object_id oid;
>> -            struct commit *head =
>> -                lookup_commit_reference(the_repository,
>> -                            &options.orig_head);
>>                 argv_array_pushl(&stash.args,
>>                        "stash", "create", "autostash", NULL);
>> @@ -1991,17 +1988,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>                       options.state_dir);
>>               write_file(autostash, "%s", oid_to_hex(&oid));
>>               printf(_("Created autostash: %s\n"), buf.buf);
>> -            if (reset_head(&head->object.oid, "reset --hard",
>> +
>> +            /*
>> +             * We might not be on orig_head yet:
>> +             * Make sure to reset w/o switching branches...
>> +             */
>> +            if (reset_head(NULL, "reset --hard",
>>                          NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
>>                   die(_("could not reset --hard"));
>> -            printf(_("HEAD is now at %s"),
>> -                   find_unique_abbrev(&head->object.oid,
>> -                          DEFAULT_ABBREV));
>> -            strbuf_reset(&buf);
>> -            pp_commit_easy(CMIT_FMT_ONELINE, head, &buf);
>> -            if (buf.len > 0)
>> -                printf(" %s", buf.buf);
>> -            putchar('\n');
>>                 if (discard_index(the_repository->index) < 0 ||
>>                   repo_read_index(the_repository) < 0)
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index 867e4e0b17..2ea1909881 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -37,7 +37,6 @@ test_expect_success setup '
>>   create_expected_success_am () {
>>       cat >expected <<-EOF
>>       $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>> -    HEAD is now at $(git rev-parse --short feature-branch) third commit
>>       First, rewinding head to replay your work on top of it...
>>       Applying: second commit
>>       Applying: third commit
>> @@ -48,7 +47,6 @@ create_expected_success_am () {
>>   create_expected_success_interactive () {
>>       q_to_cr >expected <<-EOF
>>       $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>> -    HEAD is now at $(git rev-parse --short feature-branch) third commit
>>       Applied autostash.
>>       Successfully rebased and updated refs/heads/rebased-feature-branch.
>>       EOF
>> @@ -57,7 +55,6 @@ create_expected_success_interactive () {
>>   create_expected_failure_am () {
>>       cat >expected <<-EOF
>>       $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>> -    HEAD is now at $(git rev-parse --short feature-branch) third commit
>>       First, rewinding head to replay your work on top of it...
>>       Applying: second commit
>>       Applying: third commit
>> @@ -70,7 +67,6 @@ create_expected_failure_am () {
>>   create_expected_failure_interactive () {
>>       cat >expected <<-EOF
>>       $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>> -    HEAD is now at $(git rev-parse --short feature-branch) third commit
>>       Applying autostash resulted in conflicts.
>>       Your changes are safe in the stash.
>>       You can run "git stash pop" or "git stash drop" at any time.
>>
> 
