From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: avoid filling up the disk with temp files.
Date: Sat, 28 Jun 2008 19:38:37 -0700
Message-ID: <20080629023804.GA6768@untitled>
References: <1214686673-28099-1-git-send-email-apenwarr@gmail.com> <1214696036-8294-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, B.Steinbrink@gmx.de,
	gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 04:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCmpn-0006MP-3j
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 04:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYF2Cij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 22:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbYF2Cii
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 22:38:38 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45782 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbYF2Cii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 22:38:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 487832DC095;
	Sat, 28 Jun 2008 19:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1214696036-8294-1-git-send-email-apenwarr@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86755>

Avery Pennarun <apenwarr@gmail.com> wrote:
> Commit ffe256f9bac8a40ff751a9341a5869d98f72c285 ("git-svn: Speed up fetch")
> introduced changes that create a temporary file for each object fetched by
> svn.  These files should be deleted automatically, but perl apparently
> doesn't do this until the process exits (or perhaps when its garbage
> collector runs).
> 
> This means that on a large fetch, especially with lots of branches, we
> sometimes fill up /tmp completely, which prevents the next temp file from
> being written completely.  This is aggravated by the fact that a new temp
> file is created for each updated file, even if that update produces a file
> identical to one already in git.  Thus, it can happen even if there's lots
> of disk space to store the finished repository.
> 
> We weren't adequately checking for write errors, so this would result in an
> invalid file getting committed, which caused git-svn to fail later with an
> invalid checksum.
> 
> This patch adds a check to syswrite() so similar problems don't lead to
> corruption in the future.  It also unlink()'s each temp file explicitly
> when we're done with it, so the disk doesn't need to fill up.
> 
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
> ---
 
> Please use this in favour of the "Revert "git-svn: Speed up fetch" I sent
> earlier.  I ended up having a surprise inspiration that led to a real fix :)

Ouch, I didn't noticed these unchecked syscalls :x

Very graciously
Acked-by: Eric Wong <normalperson@yhbt.net>

Apologies to all users who were bitten by this bug.

>  git-svn.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 263d66c..0011387 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3243,7 +3243,9 @@ sub close_file {
>  		my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
>  		my $result;
>  		while ($result = sysread($fh, my $string, 1024)) {
> -			syswrite($tmp_fh, $string, $result);
> +			my $wrote = syswrite($tmp_fh, $string, $result);
> +			defined($wrote) && $wrote == $result
> +				or croak("write $tmp_filename: $!\n");
>  		}
>  		defined $result or croak $!;
>  		close $tmp_fh or croak $!;
> @@ -3251,6 +3253,7 @@ sub close_file {
>  		close $fh or croak $!;
>  
>  		$hash = $::_repository->hash_and_insert_object($tmp_filename);
> +		unlink($tmp_filename);
>  		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
>  		close $fb->{base} or croak $!;
>  	} else {
> -- 
> 1.5.4.3
