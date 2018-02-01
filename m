Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDF01F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBAKeG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:34:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:48119 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeBAKeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:34:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A12AACD3;
        Thu,  1 Feb 2018 10:34:04 +0000 (UTC)
Subject: Re: [PATCH] tag: add --edit option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
 <CAPig+cTFsp60KB+quuytW_nV2crLcjRV-PYN-3bO7tRY0_xu6w@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <fb3387f9-a341-c4dc-fa37-581229fb2c1d@suse.de>
Date:   Thu, 1 Feb 2018 11:34:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTFsp60KB+quuytW_nV2crLcjRV-PYN-3bO7tRY0_xu6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 01/02/2018 à 11:16, Eric Sunshine a écrit :
> On Thu, Feb 1, 2018 at 4:49 AM, Nicolas Morey-Chaisemartin
> <nmoreychaisemartin@suse.com> wrote:
>> Add a --edit option whichs allows modifying the messages provided by -m or -F,
>> the same way git commit --edit does.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
>> ---
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> @@ -224,7 +225,7 @@ static void create_tag(const struct object_id *object, const char *tag,
>> -       if (!opt->message_given) {
>> +       if (!opt->message_given || opt->use_editor) {
>>
>> -               if (!is_null_oid(prev)) {
>> +               if (opt->message_given) {
>> +                       write_or_die(fd, buf->buf, buf->len);
>> +                       strbuf_reset(buf);
>> +               } else if (!is_null_oid(prev)) {
>>                         write_tag_body(fd, prev);
>>                 } else {
> A little below this change is where launch_editor() is actually
> invoked. If it fails for some reason, it prints:
>
>     Please supply the message using either -m or -F option.
>
> which seems a bit counterintuitive if the user *did* specify one of
> those options along with --edit. I wonder if that message needs to be
> adjusted.
>
Yes I'll fix this.

>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> @@ -452,6 +452,23 @@ test_expect_success \
>> +get_tag_header annotated-tag-edit $commit commit $time >expect
>> +echo "An edited message" >>expect
>> +test_expect_success 'set up editor' '
>> +       cat >editor <<-\EOF &&
>> +       #!/bin/sh
>> +       sed -e "s/A message/An edited message/g" <"$1" >"$1-"
>> +       mv "$1-" "$1"
>> +       EOF
>> +       chmod 755 editor
> If you use write_script() to create the fake editor, then it supplies
> the #!/bin/sh line for you and does the 'chmod', so you only need to
> supply the actual script payload. Also, other "editors" in this test
> file are named "fakeeditor", so perhaps follow suit.
>
>     write_script fakeeditor <<-\EOF
>         sed -e "s/A message/An edited message/g" <"$1" >"$1-"
>         mv "$1-" "$1"
>     EOF
>
I dumbly copied the test from commit --edit as it was my reference.
I'll fix the names and switch to write_script.

Thanks

Nicolas
