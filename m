Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40A7C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CFF61260
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhELNNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:13:32 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45819 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhELNNb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:13:31 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 232C5240007;
        Wed, 12 May 2021 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620825139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xv6mc7rQx35XRTO4x03sq5rtOP+n/K9Ml59Ep3EKuF8=;
        b=R9hznLYmaoVYig0RHdZD1Y29hBVzPtfPWcgSl1zq2M4X7TPlqkIx/78mSyJ9cPcTKR7lJs
        XlA6WcdcvchSmSxzBU+oDbDKFuTGcaycm7qOn22KNhjpu0OHrvyx0a3IKxHgYRL21/4/Ve
        sVpRwYPe9srx1RILwxujrpP3CBtxPLo8gysPXQf3hAgy/8GSTf9BTIIGtkwe43OJXSEumF
        HO5CDYG2i++a7SEwvsBh+/C0KoF4KP12e0pSouY/sBLwZxd4gDmkb1Mw5iAdeoiURnnzLJ
        Xvos0Wx32ix1K1v2ynzWry1I47+GWCGLPk/B629EF06m1WLI+uUH58Mze5bz4Q==
Date:   Wed, 12 May 2021 07:12:17 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Message-ID: <YJvUMTAVKJqPZF2t@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <609b8a5a65826_6e0fc2084c@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609b8a5a65826_6e0fc2084c@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 02:57 -0500, Felipe Contreras wrote:
>Gregory Anders wrote:
>I'm not against these kinds of changes but it took me one minute to
>figure out all you did was change the format.
>
>This belongs in a separate patch.

Yes this was pointed out by the other reviewers as well, I'll omit it in 
subsequent revisions.

>
>> +--sendmail-cmd=<command>::
>
>Oh no no no. Don't do shortcuts.
>
>If you think --sendmail-command is too long, then address that problem
>head on, don't try to hide it.
>
>I do think it's too long, which is why I suggested --command (especially
>since it's obvious which command we are talking about), but I wouldn't
>suggest --sdm-command, or something of that sort. We have to own our
>decisions.
>
>  1. --command
>  2. --sendmail
>  3. --sendmail-command
>
>We have to pick one. I suggest #1.
>
>To try to make #3 shorter is just shoving the problem under the rug.

The intention behind `--sendmail-cmd` was consistency with `--to-cmd` 
and `--cc-cmd`. Though both of those options also use the condensed 
'cmd' form in their configuration options as well, so I suppose I should 
also change this one to 'sendemail.sendmailcmd'.

I'm not opposed to just '--sendmail' and 'sendemail.sendmail' either. I 
personally believe --sendmail-cmd is the clearest, even if it's verbose, 
but I'll concede to whatever consensus we arrive at.

>
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -70,6 +70,7 @@ sub usage {
>>
>>    Sending:
>>      --envelope-sender       <str>  * Email envelope sender.
>> +    --sendmail-cmd          <str>  * Shell command to run to send email.
>>      --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
>>                                       is optional. Default 'localhost'.
>>      --smtp-server-option    <str>  * Outgoing SMTP server option to use.
>> @@ -252,6 +253,7 @@ sub do_edit {
>>  my (@suppress_cc);
>>  my ($auto_8bit_encoding);
>>  my ($compose_encoding);
>> +my ($sendmail_command);
>>  # Variables with corresponding config settings & hardcoded defaults
>>  my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
>>  my $thread = 1;
>> @@ -299,6 +301,7 @@ sub do_edit {
>>      "assume8bitencoding" => \$auto_8bit_encoding,
>>      "composeencoding" => \$compose_encoding,
>>      "transferencoding" => \$target_xfer_encoding,
>> +    "sendmailcommand" => \$sendmail_command,
>>  );
>>
>>  my %config_path_settings = (
>> @@ -432,6 +435,7 @@ sub read_config {
>>  		    "no-bcc" => \$no_bcc,
>>  		    "chain-reply-to!" => \$chain_reply_to,
>>  		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
>> +		    "sendmail-cmd=s" => \$sendmail_command,
>
>Isn't it interesting that to make the code readable you picked
>$sendmail_command, but you don't want users to type so much, even if
>it's more readable?

See my note above.

>
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
>> @@ -57,7 +57,7 @@ test_no_confirm () {
>>  		git send-email \
>>  		--from="Example <from@example.com>" \
>>  		--to=nobody@example.com \
>> -		--smtp-server="$(pwd)/fake.sendmail" \
>> +		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
>
>People are already using --smpt-server=$cmd, we need to keep testing
>that.
>
>Yes, eventually we would want them to move to --sendmail-cmd (or
>--command, or whatever), but that won't happen tomorrow. Therefore our
>primary tests need to be focused on --smtp-server.
>
>We need new *additional* tests for --sendmail-cmd, but those should not
>override the current tests. At least not right now.

I will add a test case for the absolute path form of --smtp-server; 
however, if we are introducing an option for specifying a sendmail-like 
command, surely that is the one to use when using "fake.sendmail", no?

If we leave the test cases as-is for now, we introduce a split that 
someone will eventually need to come back and update anyway. Instead of 
kicking that can down the road, I thought it best to go ahead and do it 
now.

Thanks for your feedback.

Greg
