Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45D12095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757628AbdCUTZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:25:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60410 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933373AbdCUTYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:24:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8E70B2095B;
        Tue, 21 Mar 2017 19:23:13 +0000 (UTC)
Date:   Tue, 21 Mar 2017 19:23:13 +0000
From:   Eric Wong <e@80x24.org>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <royger@FreeBSD.org>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Issues with git send-email and msmtp
Message-ID: <20170321192313.GA15269@whir>
References: <20170321154921.3jgn4ktcop4shct2@dhcp-3-128.uk.xensource.com>
 <20170321165004.fvhzuu3otv4nmh4j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170321165004.fvhzuu3otv4nmh4j@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Tue, Mar 21, 2017 at 03:49:21PM +0000, Roger Pau Monné wrote:
> 
> > I'm trying to use git send-email with msmtp, and I have added the following to
> > my .gitconfig:
> > 
> > [sendemail]
> > 	smtpserver = "/usr/local/bin/msmtp"
> > 
> > This seems to work fine, except that sometimes git dies unexpectedly after
> > queuing a patch to msmtp:
> > 
> > Died at /usr/local/Cellar/git/2.12.0/libexec/git-core/git-send-email line 1350, <FIN> line 3.

Hi Roger, can you also enable msmtp logging and debugging?

logfile /path/to/log # in ~/.msmtprc
And "msmtp --debug" in the command line

> That line looks like it's the "close" on the pipe. If it's dying racily
> that could mean that msmtp for some reason is not eating all of the
> data and we're getting EPIPE (though that seems weird, since we're just
> dumping the message until EOF). Or possibly msmtp is sometimes exiting
> non-zero.
> 
> Capturing an "strace" for a failing run would be helpful. If that's not
> possible, something like this patch might help diagnose it:
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f..32d34f995 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1346,7 +1346,10 @@ EOF
>  			exec($smtp_server, @sendmail_parameters) or die $!;
>  		}
>  		print $sm "$header\n$message";

Perhaps also:

		print $sm "$header\n$message" or
				die "print failed to $smtp_server: $!";

> -		close $sm or die $!;
> +		if (!close($sm)) {
> +			die $! ? "unable to write to $smtp_server: $!"
> +			       : "smtp program '$smtp_server' exited non-zero: $?"

Parentheses please :>
