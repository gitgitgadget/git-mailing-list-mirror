From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use
 it when provided instead of defaulting to end-user prompt
Date: Mon, 14 Oct 2013 07:11:27 -0700
Message-ID: <20131014141127.GA21200@google.com>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: arnaud.brejeon@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 14 16:11:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VViry-0000r2-N0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 16:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab3JNOLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 10:11:34 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:50898 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab3JNOLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 10:11:34 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so7296272pbc.23
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XFtS8zjYsl3LONIPdkKiSxERp20p52pyIODd/pwLZ9Y=;
        b=Xo8oaxn1PxbslKmSXvQ8YC3Fro28YOzDt0ExdYyW+z5jrNXqMzrUNPogFZ5vmtVe8v
         ISTSEIJkPNP/h+OyrWDeeVeFL1ft0y16hBgJTiCk/gyIXj9740kJKL9g0REaFZ5c4M0l
         /cgpQc3xuvIVBk8R5qe13l1/W399wwFw9DvLf5nAPiRbQy2uSdTc4n+Ca8j7yWLs8hXJ
         myWv7Rksg6cFL4DxwwHUSnQAxMAgWMQ+iAT45l+7fCWNpsCo5Vg9jbyTCTqn9sklLEr/
         nK83KG67s1nr2bE+kqHVujpre75DL2FmufX8wNurEYhKPA7jDa1hAIFbXzwiXyxv9sBz
         5KOw==
X-Received: by 10.66.27.143 with SMTP id t15mr1873463pag.171.1381759893575;
        Mon, 14 Oct 2013 07:11:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id va8sm78290099pbc.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 07:11:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236100>

Hi,

arnaud.brejeon@gmail.com wrote:

> Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>

Thanks.

Can you say a little more about the context?  Do you run a script that
wants to pass a password to 'git svn', do you type it each time on the
command line, or something else?  Is it ok that the password would
show up in "ps" output?  Would the platform's keyring or netrc be
usable here, or is there something in the context that avoids that?

> ---
>  git-svn.perl           |    3 +++
>  perl/Git/SVN/Prompt.pm |   12 +++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)

If we're going to do this, it would also need to be documented in
Documentation/git-svn.txt, and ideally tested in one of the t/t91*.sh
test scripts.

The implementation looks reasonable from a quick glance.  Cc-ing
Eric for other comments.

Hope that helps,
Jonathan

(patch left unsnipped for reference)
> diff --git a/git-svn.perl b/git-svn.perl
> index ff1ce3d..07f0a6c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -123,6 +123,7 @@ sub opt_prefix { return $_prefix || '' }
>  $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
>  $_q ||= 0;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
> +                    'password=s' => \$Git::SVN::Prompt::_password,
>                      'config-dir=s' => \$Git::SVN::Ra::config_dir,
>                      'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
>                      'ignore-paths=s' => \$Git::SVN::Fetcher::_ignore_regex,
> @@ -206,6 +207,7 @@ my %cmd = (
>  	              'parents' => \$_parents,
>  	              'tag|t' => \$_tag,
>  	              'username=s' => \$Git::SVN::Prompt::_username,
> +	              'password=s' => \$Git::SVN::Prompt::_password,
>  	              'commit-url=s' => \$_commit_url } ],
>  	tag => [ sub { $_tag = 1; cmd_branch(@_) },
>  	         'Create a tag in the SVN repository',
> @@ -214,6 +216,7 @@ my %cmd = (
>  	           'dry-run|n' => \$_dry_run,
>  	           'parents' => \$_parents,
>  	           'username=s' => \$Git::SVN::Prompt::_username,
> +	           'password=s' => \$Git::SVN::Prompt::_password,
>  	           'commit-url=s' => \$_commit_url } ],
>  	'set-tree' => [ \&cmd_set_tree,
>  	                "Set an SVN repository to a git tree-ish",
> diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
> index e940b08..a94a847 100644
> --- a/perl/Git/SVN/Prompt.pm
> +++ b/perl/Git/SVN/Prompt.pm
> @@ -2,7 +2,7 @@ package Git::SVN::Prompt;
>  use strict;
>  use warnings;
>  require SVN::Core;
> -use vars qw/$_no_auth_cache $_username/;
> +use vars qw/$_no_auth_cache $_username $_password/;
>  
>  sub simple {
>  	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
> @@ -17,8 +17,14 @@ sub simple {
>  	} else {
>  		username($cred, $realm, $may_save, $pool);
>  	}
> -	$cred->password(_read_password("Password for '" .
> -	                               $cred->username . "': ", $realm));
> +
> +	if (defined $_password && length $_password) {
> +		$cred->password($_password);
> +	} else {
> +		$cred->password(_read_password("Password for '" .
> +		                               $cred->username . "': ", $realm));
> +	}
> +
>  	$cred->may_save($may_save);
>  	$SVN::_Core::SVN_NO_ERROR;
>  }
> -- 
> 1.7.10.2 (Apple Git-33)
