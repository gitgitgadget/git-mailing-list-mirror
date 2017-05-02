Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A884207E3
	for <e@80x24.org>; Tue,  2 May 2017 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdEBJcV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 05:32:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35849 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbdEBJcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 05:32:20 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 538A2C143CA4;
        Tue,  2 May 2017 09:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 538A2C143CA4
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=pbonzini@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 538A2C143CA4
Received: from [10.36.117.83] (ovpn-117-83.ams2.redhat.com [10.36.117.83])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v429WEL1005835
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 2 May 2017 05:32:17 -0400
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
To:     xiaoqiang zhao <zxq_yx_007@163.com>, git@vger.kernel.org
References: <20170429122632.7122-1-zxq_yx_007@163.com>
Cc:     viktorin@rehivetech.com, mst@kernel.org, mina86@mina86.com,
        artagnon@gmail.com
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6bef306b-0bfb-2314-50fd-9c152888b344@redhat.com>
Date:   Tue, 2 May 2017 11:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170429122632.7122-1-zxq_yx_007@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 02 May 2017 09:32:19 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/04/2017 14:26, xiaoqiang zhao wrote:
> Some email server(e.g. smtp.163.com) limits a fixed number emails to be send per
> session(connection) and this will lead to a send faliure.
> With --split <num> option, a auto reconnection will occur when number of sended
> email reaches <num> and the problem is solved.
> 
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

I think you should also add a matching configuration option, or you are
going to forget it on the command line sooner or later!

Paolo

> ---
>  git-send-email.perl | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f..0de9b7058 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -81,6 +81,8 @@ git send-email --dump-aliases
>                                       This setting forces to use one of the listed mechanisms.
>      --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>  
> +    --split                 <int>  * send \$num message per connection.
> +
>    Automating:
>      --identity              <str>  * Use the sendemail.<id> options.
>      --to-cmd                <str>  * Email To: via `<str> \$patch_path`
> @@ -153,6 +155,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
>  my $have_mail_address = eval { require Mail::Address; 1 };
>  my $smtp;
>  my $auth;
> +my $send_count = 0;
>  
>  # Regexes for RFC 2047 productions.
>  my $re_token = qr/[^][()<>@,;:\\"\/?.= \000-\037\177-\377]+/;
> @@ -186,6 +189,7 @@ my $format_patch;
>  my $compose_filename;
>  my $force = 0;
>  my $dump_aliases = 0;
> +my $split = 0;
>  
>  # Handle interactive edition of files.
>  my $multiedit;
> @@ -358,6 +362,7 @@ $rc = GetOptions(
>  		    "force" => \$force,
>  		    "xmailer!" => \$use_xmailer,
>  		    "no-xmailer" => sub {$use_xmailer = 0},
> +		    "split=i" => \$split,
>  	 );
>  
>  usage() if $help;
> @@ -1158,10 +1163,15 @@ sub smtp_host_string {
>  # (smtp_user was not specified), and 0 otherwise.
>  
>  sub smtp_auth_maybe {
> -	if (!defined $smtp_authuser || $auth) {
> +	if (!defined $smtp_authuser || $send_count != 0) {
>  		return 1;
>  	}
>  
> +	if ($auth && $send_count == 0) {
> +		print "Auth use saved password. \n";
> +		return !!$smtp->auth($smtp_authuser, $smtp_authpass);
> +	}
> +
>  	# Workaround AUTH PLAIN/LOGIN interaction defect
>  	# with Authen::SASL::Cyrus
>  	eval {
> @@ -1187,6 +1197,7 @@ sub smtp_auth_maybe {
>  		'password' => $smtp_authpass
>  	}, sub {
>  		my $cred = shift;
> +		$smtp_authpass = $cred->{'password'};
>  
>  		if ($smtp_auth) {
>  			my $sasl = Authen::SASL->new(
> @@ -1442,6 +1453,15 @@ EOF
>  		}
>  	}
>  
> +	$send_count++;
> +	if ($send_count == $split) {
> +		$smtp->quit;
> +		$smtp = undef;
> +		$send_count = 0;
> +		print "Reconnect SMTP server required. \n";
> +
> +	}
> +
>  	return 1;
>  }
>  
> 
