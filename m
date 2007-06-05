From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow to specify svn branch for commands
Date: Mon, 4 Jun 2007 21:14:47 -0700
Message-ID: <20070605041446.GA4266@untitled>
References: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Central <git@vger.kernel.org>, stephen@touset.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQS4-0008E7-F0
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbXFEEPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXFEEPM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:15:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51764 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbXFEEPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 00:15:11 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CCBE12DC032;
	Mon,  4 Jun 2007 21:14:55 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 04 Jun 2007 21:14:47 -0700
Content-Disposition: inline
In-Reply-To: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49154>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> "git-svn dcommit" ends up making an arbitrary decision when pushing
> back merges.  Allow the user to specify which one is used, albeit in a
> rather hack-ish way.

Frightening...  Perhaps we should echo the final URL out
to the user and prompt them for confirmation.

> ---
>  Documentation/git-svn.txt |   11 +++++++++++
>  git-svn.perl              |   16 +++++++++-------
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index c0d7d95..3e64522 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -69,6 +69,17 @@ COMMANDS
>  	argument if that is what you want.  This is useful if
>  	you wish to track multiple projects that share a common
>  	repository.
> +-B<svn_branch>;;
> +--branch=<svn_branch>;;
> +	Normally, git-svn is capable of figuring out which branch you
> +	are working on.  However, if you are doing merges between svn
> +	branches using git then the decision about which branch to
> +	dcommit to will end up being made based on which of the
> +	branches you are merging has the newest upstream commit.  This
> +	option enables a global filter that tells git-svn what to look
> +	for in the git-svn-id: line - specify a repository UUID or a
> +	branch name here.  So, it may be used with "git-svn log",
> +	"git-svn dcommit", etc.

This should clarify that a Perl regular expression is used.
'.' can match '-' or '_' which is also pretty common in version
numbers.  Perhaps give an -F(ixed-string) option like grep does?

>  sub working_head_info {
> -	my ($head, $refs) = @_;
> +	my ($head, $refs, $grep) = @_;
>  	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
>  	while (my $hash = <$fh>) {
>  		chomp($hash);
>  		my ($url, $rev, $uuid) = cmt_metadata($hash);
> +		next unless (!$grep or $url =~ m{$grep} or $uuid =~ m{$grep});
> @@ -3394,7 +3396,7 @@ sub git_svn_log_cmd {

-- 
Eric Wong
