From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC PATCH] git-svn: proper detection of bare repositories
Date: Tue, 4 Nov 2008 00:30:15 -0800
Message-ID: <20081104083015.GA14405@untitled>
References: <20081103000903.GA1135@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:31:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHK2-0006IH-Ad
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbYKDIaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbYKDIaT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:30:19 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35002 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbYKDIaS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:30:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7D6872DC01B;
	Tue,  4 Nov 2008 08:30:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081103000903.GA1135@euler>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100054>

Deskin Miller <deskinm@umich.edu> wrote:
> I keep coming across commands like this, which don't work properly in bare
> repositories, and thinking that they need to be patched (see e.g. ddff8563, or
> Duy's comments on the thread starting at
> http://thread.gmane.org/gmane.comp.version-control.git/98849), but now I'm not
> so sure.  For one, despite this patch working, it turns out that 'git --bare
> svn <cmd>' also works (and presumably has) for some time.

Interesting.  I've never even looked at --bare myself.  It always
should've worked if GIT_DIR= was explicitly set and I guess back in the
old days when I wrote git-svn, --bare wasn't even a flag :)

> Is git --bare the correct way to deal with this situation?  That is to say, do
> we intend commands to 'just work' regardless of whether the repo is bare or
> not, or should the user be thinking about the difference and including --bare
> in the command invocation when necessary?  I'm a vote for the 'just work' camp,
> but it seems a lot of things aren't necessarily that way.  On the other hand,
> the majority of commands do just work.
>
> I guess I'm asking for a sanity check before I write any more such patches;
> certainly I find them useful, as the issues come up during my normal use of
> Git, but I don't want to be pursuing things of no use to anyone else, or
> (worse) things that are fundamentally wrong for some reason I don't understand
> yet.

I don't think there's anything fundamentally wrong with things 'just
working' on bare repos.  It's just another case of something that not
many people end up using (especially for git-svn) and hence got fewer
testers and bug reports.

> -- 8< --
> 
> When in a bare repository (or .git, for that matter), git-svn would fail
> to initialise properly, since git rev-parse --show-cdup would not output
> anything.  However, git rev-parse --show-cdup actually returns an error
> code if it's really not in a git directory.
> 
> Fix the issue by checking for an explicit error from git rev-parse, and
> setting $git_dir appropriately if instead it just does not output.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>
> ---
>  git-svn.perl             |   14 ++++++++++----
>  t/t9100-git-svn-basic.sh |    9 +++++++++
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 56238da..d25e9be 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -42,6 +42,7 @@ use File::Path qw/mkpath/;
>  use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
>  use IPC::Open3;
>  use Git;
> +use Error qw/:try/;
>  
>  BEGIN {
>  	# import functions from Git into our packages, en masse
> @@ -214,11 +215,16 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>  			    "but it is not a directory\n";
>  		}
>  		my $git_dir = delete $ENV{GIT_DIR};
> -		chomp(my $cdup = command_oneline(qw/rev-parse --show-cdup/));
> -		unless (length $cdup) {
> -			die "Already at toplevel, but $git_dir ",
> -			    "not found '$cdup'\n";
> -		}
> +		my $cdup = undef;
> +		try {
> +			$cdup = command_oneline(qw/rev-parse --show-cdup/);
> +			$git_dir = '.' unless ($cdup);
> +			chomp $cdup if ($cdup);
> +			$cdup = "." unless ($cdup && length $cdup);
> +		}
> +		catch Git::Error::Command with {
> +			die "Already at toplevel, but $git_dir not found\n";
> +		};

How about using git_cmd_try instead?

The Error.pm try/catch stuff makes me a bit uncomfortable.  I realize
it's (unfortunately) in Git.pm; but I'd rather keep it confined there so
we can more easily remove it later if someone were inclined.

Otherwise I like the idea of this patch.

Thanks,

-- 
Eric Wong
