From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] Add per-svn-remote ignore-paths config
Date: Fri, 10 Apr 2009 18:22:57 -0700
Message-ID: <20090411012256.GA2945@dcvr.yhbt.net>
References: <1239314289-36149-1-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ben Jackson <ben@ben.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 03:24:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsRxO-0004f5-Up
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 03:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZDKBW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 21:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbZDKBW6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 21:22:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56245 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754419AbZDKBW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 21:22:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3247711309A;
	Sat, 11 Apr 2009 01:22:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1239314289-36149-1-git-send-email-ben@ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116287>

Ben Jackson <ben@ben.com> wrote:
> The --ignore-paths option to fetch is very useful for working on a subset
> of a SVN repository.  For proper operation, every command that causes a
> fetch (explicit or implied) must include a matching --ignore-paths option.
> 
> This patch adds a persistent svn-remote.$repo_id.ignore-paths config by
> promoting Fetcher::is_path_ignored to a member function and initializing
> $self->{ignore_regex} in Fetcher::new.  Command line --ignore-paths is
> still recognized and acts in addition to the config value.
> 
> Signed-off-by: Ben Jackson <ben@ben.com>

Hi Ben, the patch looks useful, but there are some minor issues
with comments inline.

> --- a/git-svn.perl
> +++ b/git-svn.perl
>  # return value: 0 -- don't ignore, 1 -- ignore
>  sub is_path_ignored {
> -	my ($path) = @_;
> +	my ($self, $path) = @_;
>  	return 1 if in_dot_git($path);
> +	return 1 if defined($self->{ignore_regex}) &&
> +	            $path =~ m!$self->{ignore_regex}!o;

Since we're making the regex per-remote, I'd remove the "o" operator. It
can break things if Git::SVN::Fetcher ever gets reused by multiple SVN
remotes within the same process.

> --- a/t/t9134-git-svn-ignore-paths.sh
> +++ b/t/t9134-git-svn-ignore-paths.sh
> @@ -44,7 +51,7 @@ test_expect_success 'SVN-side change outside of www' '
>  test_expect_success 'update git svn-cloned repo' '
>  	(
>  		cd g &&
> -		git svn rebase --ignore-paths="^www" &&
> +		git svn rebase &&

I'd rather not change the existing tests since existing behavior
can break.  Instead, augment the existing tests so we test both
the .git/config and command-line cases.

Thanks.

-- 
Eric Wong
