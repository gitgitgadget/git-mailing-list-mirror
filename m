From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] git svn: info: correctly handle absolute path args
Date: Sun, 07 Sep 2014 10:57:43 +0200
Message-ID: <540C1E07.7030105@kdbg.org>
References: <20140907080626.GA6273@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Andrej Manduch <amanduch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 10:58:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQYIJ-0006KZ-MN
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 10:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbaIGI5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 04:57:48 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42361 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbaIGI5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 04:57:47 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7B593130050;
	Sun,  7 Sep 2014 10:57:44 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D286F19F458;
	Sun,  7 Sep 2014 10:57:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <20140907080626.GA6273@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256617>

Am 07.09.2014 10:06, schrieb Eric Wong:
> diff --git a/git-svn.perl b/git-svn.perl
> index 1f41ee1..47cd6ea 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1477,10 +1477,20 @@ sub cmd_commit_diff {
>  	}
>  }
>  
> -
>  sub cmd_info {
> -	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
> -	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
> +	my $path_arg = defined($_[0]) ? $_[0] : '.';
> +	my $path = $path_arg;
> +	if ($path =~ m!\A/!) {

There must be a more portable way to check for an absolute path. Think
of DOS-style paths...

> +		my $toplevel = eval {
> +			my @cmd = qw/rev-parse --show-toplevel/;
> +			command_oneline(\@cmd, STDERR => 0);
> +		};
> +		$path = canonicalize_path($path);
> +		$path =~ s!\A\Q$toplevel\E/?!!;
> +		$path = canonicalize_path($path);
> +	} else {
> +		$path = canonicalize_path($cmd_dir_prefix . $path);
> +	}
>  	if (exists $_[1]) {
>  		die "Too many arguments specified\n";
>  	}

-- Hannes
