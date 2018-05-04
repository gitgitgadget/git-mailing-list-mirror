Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4EB2023D
	for <e@80x24.org>; Fri,  4 May 2018 08:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeEDITi (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 04:19:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59760 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeEDITh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 04:19:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 147111F42E;
        Fri,  4 May 2018 08:19:37 +0000 (UTC)
Date:   Fri, 4 May 2018 08:19:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, Simon Ser <contact@emersion.fr>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: allow re-editing of message
Message-ID: <20180504081936.GA9133@dcvr>
References: <20180502143200.9371-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502143200.9371-1-sir@cmpwn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> wrote:
> When shown the email summary, an opportunity is presented for the user
> to edit the email as if they had specified --annotate. This also permits
> them to edit it multiple times.

Thanks, this seems like a good idea for the cover letter, especially.
I prefer to get the commit messages right in the git history, first,
but I more often screw up the cover letter.

I haven't looked at the code to send-email in a while,
so some thinking out loud below :>

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1330,9 +1330,14 @@ sub file_name_is_absolute {
>  	return File::Spec::Functions::file_name_is_absolute($path);
>  }
>  
> -# Returns 1 if the message was sent, and 0 otherwise.
> -# In actuality, the whole program dies when there
> -# is an error sending a message.
> +# Prepares the email, then asks the user what to do.
> +#
> +# If the user chooses to send the email, it's sent and 1 is returned.
> +# If the user chooses not to send the email, 0 is returned.
> +# If the user decides they want to make further edits, -1 is returned and the
> +# caller is expected to call send_message again after the edits are performed.

OK, -1 is the new return value.  Thanks for documenting this.
The rest of the prompt implementation looks fine and I won't quote it.

> @@ -1552,7 +1559,9 @@ $references = $initial_in_reply_to || '';
>  $subject = $initial_subject;
>  $message_num = 0;
>  
> -foreach my $t (@files) {
> +sub process_file {
> +	my ($t) = @_;
> +
>  	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
>  
>  	my $author = undef;

OK, process_file is a new function...

> @@ -1755,6 +1764,10 @@ foreach my $t (@files) {
>  	}
>  
>  	my $message_was_sent = send_message();
> +	if ($message_was_sent == -1) {
> +		do_edit($t);
> +		return 0;
> +	}

And the previously documented -1 return value is used here.
Mental note: process_file returns 0 to indicate an edit was done.

>  	# set up for the next message
>  	if ($thread && $message_was_sent &&
> @@ -1776,6 +1789,14 @@ foreach my $t (@files) {
>  		undef $auth;
>  		sleep($relogin_delay) if defined $relogin_delay;
>  	}
> +
> +	return 1;

Mental note: process_file normally returns 1

> +}
> +
> +foreach my $t (@files) {
> +	while (!process_file($t)) {
> +		# This space deliberately left blank

Cute, but that comment could say something useful, instead:

	# user is still editing the file


Otherwise, I think the patch is great.  Thanks!
