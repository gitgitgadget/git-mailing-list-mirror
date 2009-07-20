From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 00:59:29 -0700
Message-ID: <20090720075929.GA5591@dcvr.yhbt.net>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 09:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSnmc-0007uX-4I
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 09:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbZGTH7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 03:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbZGTH7a
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 03:59:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57390 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbZGTH7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 03:59:30 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 0352F1F5FC;
	Mon, 20 Jul 2009 07:59:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123578>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> Add a git svn gc command that gzips all unhandled.log files, and removes 
> all index files under .git/svn.
>
> Signed-off-by: Robert Allan Zeh <robert.a.zeh@gmail.com>
> ---
>  Documentation/git-svn.txt |    4 ++++
>  git-svn.perl              |   37 +++++++++++++++++++++++++++++++++++++
>  t/t9140-git-svn-gc.sh     |   45 ++++++++++++++++++++++++++++++++++++ 
> +++++++++
>  3 files changed, 86 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9140-git-svn-gc.sh

Hi Robert,

Your mailer is mangling whitespace badly so the patch isn't applying
at all.  Make sure indents are real tabs like the rest of the code.

Some more comments below, but I think this will be a good addition
to git svn.

> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -35,11 +35,14 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
>  push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
>  push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
>  use Carp qw/croak/;
> +use Compress::Zlib;

I'd "require" Compress::Zlib lazilly so it's not loaded at startup.
It's not a stock component of Perl and not needed for the majority of
commands.

> +sub cmd_gc
> +{
> +    use Cwd;
> +       my $git_dir = $ENV{GIT_DIR};
> +    my $svn_dir = "$git_dir/svn";
> +    print getcwd;
> +    print "\n";

I'm not sure why you need to print getcwd there, leftover code from
testing/debugging?

> +sub gc_directory {
> +    if (-f $_ && basename($_) eq "unhandled.log") {
> +        my $out_filename = $_ . ".gz";
> +        print $out_filename, "\n";
> +        open my $in_fh, "<", $_ or die "Unable to open $_: $!\n";
> +        binmode $in_fh;
> +        my $gz = gzopen($out_filename, "wb") or die "Unable to open  
> $out_filename: $!\n";

gzopen with "ab" might be a better idea than "wb".  I'm not sure if
clobbering the existing log every time we run this command is a good
idea.

-- 
Eric Wong
