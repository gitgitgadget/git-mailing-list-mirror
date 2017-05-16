Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B051E1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 12:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdEPMLb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 08:11:31 -0400
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:34956 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751567AbdEPMLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 08:11:30 -0400
Received: from pcviktorin.fit.vutbr.cz (dhcpz185.fit.vutbr.cz [147.229.14.185])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 3wRxBL4DQzz1rp;
        Tue, 16 May 2017 14:11:22 +0200 (CEST)
Date:   Tue, 16 May 2017 14:10:14 +0200
From:   Jan Viktorin <viktorin@rehivetech.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP
 server limit
Message-ID: <20170516141014.6e8487df.viktorin@rehivetech.com>
In-Reply-To: <20170513015726.20281-1-zxq_yx_007@163.com>
References: <20170513015726.20281-1-zxq_yx_007@163.com>
Organization: RehiveTech
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

with this patch applied to git 2.12, I could see:

Use of uninitialized value $batch_size in numeric eq (==) at /usr/lib/git-core/git-send-email line 1679

when --batch-size is NOT used. See below...

On Sat, 13 May 2017 09:57:26 +0800
xiaoqiang zhao <zxq_yx_007@163.com> wrote:

> Some email servers (e.g. smtp.163.com) limit the number emails to be
> sent per session(connection) and this will lead to a faliure when
> sending many messages.
> 
> Teach send-email to disconnect after sending a number of messages
> (configurable via the --batch-size=<num> option), wait for a few
> seconds (configurable via the --relogin-delay=<seconds> option) and
> reconnect, to work around such a limit.
> 
> Also add this two configure option for git config command.
> 
> Note:
>    Re-authentication will happen every $<batch-size> messages, so it
> will be much more acceptable if you use some form of credential helper
> (e.g. the 'sendemail.smtppass' config option), otherwise you will have
> to retype password every time when asked.
> 
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  contrib/completion/git-completion.bash |  2 ++
>  git-send-email.perl                    | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index af658995d..29496353a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2608,6 +2608,8 @@ _git_config ()
>  		sendemail.thread
>  		sendemail.to
>  		sendemail.validate
> +		sendemail.smtpbatchsize
> +		sendemail.smtprelogindelay
>  		showbranch.default
>  		status.relativePaths
>  		status.showUntrackedFiles
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f..071d1ab9d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -81,6 +81,10 @@ git send-email --dump-aliases
>                                       This setting forces to use one of the listed mechanisms.
>      --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>  
> +    --batch-size            <int>  * send max <int> message per connection.
> +    --relogin-delay         <int>  * delay <int> seconds between two successive login, default to 1,
> +                                     This option can only be used with --batch-size
> +
>    Automating:
>      --identity              <str>  * Use the sendemail.<id> options.
>      --to-cmd                <str>  * Email To: via `<str> \$patch_path`
> @@ -153,6 +157,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
>  my $have_mail_address = eval { require Mail::Address; 1 };
>  my $smtp;
>  my $auth;
> +my $num_sent = 0;
>  
>  # Regexes for RFC 2047 productions.
>  my $re_token = qr/[^][()<>@,;:\\"\/?.= \000-\037\177-\377]+/;
> @@ -216,6 +221,7 @@ my ($cover_cc, $cover_to);
>  my ($to_cmd, $cc_cmd);
>  my ($smtp_server, $smtp_server_port, @smtp_server_options);
>  my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
> +my ($batch_size, $relogin_delay);
>  my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
>  my ($validate, $confirm);
>  my (@suppress_cc);
> @@ -247,6 +253,8 @@ my %config_settings = (
>      "smtppass" => \$smtp_authpass,
>      "smtpdomain" => \$smtp_domain,
>      "smtpauth" => \$smtp_auth,
> +    "smtpbatchsize" => \$batch_size,
> +    "smtprelogindelay" => \$relogin_delay,
>      "to" => \@initial_to,
>      "tocmd" => \$to_cmd,
>      "cc" => \@initial_cc,
> @@ -358,6 +366,8 @@ $rc = GetOptions(
>  		    "force" => \$force,
>  		    "xmailer!" => \$use_xmailer,
>  		    "no-xmailer" => sub {$use_xmailer = 0},
> +		    "batch-size=i" => \$batch_size,
> +		    "relogin-delay=i" => \$relogin_delay,
>  	 );
>  
>  usage() if $help;
> @@ -1664,6 +1674,14 @@ foreach my $t (@files) {
>  		}
>  	}
>  	$message_id = undef;
> +	$num_sent++;
> +	if ($num_sent == $batch_size) {

This is the line. I think, batch_size can be sometimes uninitialized
while this statement is executed.

Regards
Jan

> +		$num_sent = 0;
> +		$smtp->quit if defined $smtp;
> +		undef $smtp;
> +		undef $auth;
> +		sleep($relogin_delay);
> +	}
>  }
>  
>  # Execute a command (e.g. $to_cmd) to get a list of email addresses
