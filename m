Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BD02022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdBWUyy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:54:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60808 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbdBWUyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:54:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DBD172022D;
        Thu, 23 Feb 2017 20:54:52 +0000 (UTC)
Date:   Thu, 23 Feb 2017 20:54:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Hiroshi Shirosaki <h.shirosaki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git svn branch fails with authenticaton failures
Message-ID: <20170223205452.GA29547@whir>
References: <1487731055-29153-1-git-send-email-h.shirosaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487731055-29153-1-git-send-email-h.shirosaki@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiroshi Shirosaki <h.shirosaki@gmail.com> wrote:
> I have the following authentication failure while svn rebase and
> svn dcommit works fine without authentication failures.
> 
> $ git svn branch v7_3
> Copying https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx at r27519
> to https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/v7_3...
> Can't create session: Unable to connect to a repository at URL
> 'https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx': No more
> credentials or we tried too many times.
> Authentication failed at
> C:\Program Files\Git\mingw64/libexec/git-core\git-svn line 1200.
> 
> I can workaround the issue to add auth configuration to
> SVN::Client->new().

Missing sign-off (see Documentation/SubmittingPatches).
Not my rule, but it's unfortunately required for this project.

Also, the Subject: should be in the imperative mood,
Perhaps something like:

Subject: [PATCH] git svn: fix authentication with 'branch'

I am less picky about the message body.

> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1175,10 +1175,10 @@ sub cmd_branch {
>  	::_req_svn();
>  	require SVN::Client;
>  
> +	my ($config, $baton, $callbacks) = Git::SVN::Ra::prepare_config_once();

Since we're not using it, here, you can avoid setting a variable
for $callbacks more explicitly:

	my ($config, $baton, undef) = Git::SVN::Ra::prepare_config_once();

>  	my $ctx = SVN::Client->new(
> -		config => SVN::Core::config_get_config(
> -			$Git::SVN::Ra::config_dir
> -		),
> +		auth => $baton,
> +		config => $config,
>  		log_msg => sub {
>  			${ $_[0] } = defined $_message
>  				? $_message
> -- 

Anyways, this looks like a good change.  I will accept a v2
with your sign-off and changes noted above.  Thank you.
