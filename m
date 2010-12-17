From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
Date: Thu, 16 Dec 2010 18:33:59 -0800
Message-ID: <20101217023357.GA30083@gmail.com>
References: <4D07B724.8000901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 17 03:20:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTPw6-0008Di-0M
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 03:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab0LQCUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 21:20:41 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:59511 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0LQCUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 21:20:40 -0500
Received: by gxk19 with SMTP id 19so117167gxk.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 18:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jjgwUzKzN39Lh2e/j1EbcbRdZUom9peAaTvzRX1DBcA=;
        b=IWPKHxyk9YOi/E5bIhA3UmWxPk/Wik2gQbuonSvRic6bDz3Fh+o9PJmhRiUbhM6FH2
         MFwL81QsmB8P//OLFctUnXMcOjzRaxOgDkOic97DBGOalowcTe2j+pq+tqBgdFkYbQTC
         2oYbGcWuheDr0BdhvmoNTdVWxTbDa1N9BaTN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UZcwmmMGcYvGjggLPpDlg4TQpCzmASNnkU5D8iXjnhLjKHFkhxLXMfDo0PPyNjm3ga
         tP4NgP8lg2lyOvgt4ZAPWV64DptBPvTnDsyB7JusKS8UpJWknPR2FpAmrrN4GjQVkw9C
         52+5H3BuDElvkPyMwf+YgZsHOzPEvive8r6FM=
Received: by 10.236.102.171 with SMTP id d31mr185474yhg.42.1292552439466;
        Thu, 16 Dec 2010 18:20:39 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 26sm514026yhl.23.2010.12.16.18.20.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 18:20:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D07B724.8000901@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163851>

On Tue, Dec 14, 2010 at 06:27:48PM +0000, Ramsay Jones wrote:
> 
> In particular, test 14 'difftool last flag wins' fails. This is
> caused by git-difftool.perl passing both GIT_DIFFTOOL_NO_PROMPT
> (='true') and GIT_DIFFTOOL_PROMPT (='true') to the difftool helper
> script. Despite the appropriate key being deleted from the ENV
> hash, it seems that once a key has been set in the hash, it gets
> passed along to the system() call. (ie deleting the key does not
> do the equivalent of unsetenv()).
> 
> In order to fix the problem, we keep track of the required prompt
> state while processing the arguments, and then set the relevant
> ENV hash key only once at the end.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  git-difftool.perl |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index e95e4ad..ced1615 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -52,6 +52,7 @@ sub generate_command
>  	my @command = (exe('git'), 'diff');
>  	my $skip_next = 0;
>  	my $idx = -1;
> +	my $prompt = '';

Would it be simpler to set $prompt = 1 and then
flip it to 0 when -y | or --no-prompt is supplied?



>  	for my $arg (@ARGV) {
>  		$idx++;
>  		if ($skip_next) {
> @@ -89,13 +90,11 @@ sub generate_command
>  			next;
>  		}
>  		if ($arg eq '-y' || $arg eq '--no-prompt') {
> -			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
> -			delete $ENV{GIT_DIFFTOOL_PROMPT};
> +			$prompt = 'no';
>  			next;
>  		}
>  		if ($arg eq '--prompt') {
> -			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
> -			delete $ENV{GIT_DIFFTOOL_NO_PROMPT};
> +			$prompt = 'yes';
>  			next;
>  		}
>  		if ($arg eq '-h' || $arg eq '--help') {
> @@ -103,6 +102,11 @@ sub generate_command
>  		}
>  		push @command, $arg;
>  	}
> +	if ($prompt eq 'yes') {

This would become:

	if ($prompt) {
		...
	}
	else {
		...
	}

> +		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
> +	} elsif ($prompt eq 'no') {
> +		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
> +	}
>  	return @command
>  }
>  
> -- 
> 1.7.3
> 
> 

-- 
		David
