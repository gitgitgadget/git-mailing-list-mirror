From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: Make it scream by minimizing temp files
Date: Mon, 11 Aug 2008 20:14:42 -0700
Message-ID: <20080812031442.GB14051@untitled>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <1218470035-13864-3-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Tue Aug 12 05:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSkMj-00082x-KD
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 05:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYHLDOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 23:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbYHLDOo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 23:14:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33143 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbYHLDOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 23:14:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CD4002DC01B;
	Mon, 11 Aug 2008 20:14:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218470035-13864-3-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92064>

Marcus Griep <marcus@griep.us> wrote:
> ---
>  git-svn.perl |   53 +++++++++++++++++++++++++++++++++++------------------
>  1 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index fe78461..0937918 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1285,6 +1285,8 @@ use Carp qw/croak/;
>  use File::Path qw/mkpath/;
>  use File::Copy qw/copy/;
>  use IPC::Open3;
> +use File::Temp ();
> +use File::Spec;
>  
>  my ($_gc_nr, $_gc_period);
>  
> @@ -1323,10 +1325,11 @@ BEGIN {
>  	}
>  }
>  
> -my (%LOCKFILES, %INDEX_FILES);
> +my (%LOCKFILES, %INDEX_FILES, %TEMP_FILES);
>  END {
>  	unlink keys %LOCKFILES if %LOCKFILES;
>  	unlink keys %INDEX_FILES if %INDEX_FILES;
> +	unlink values %TEMP_FILES if %TEMP_FILES;
>  }
  
>  sub resolve_local_globs {
> @@ -2935,6 +2938,21 @@ sub remove_username {
>  	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
>  }
>  
> +sub _temp_file {
> +	my ($self, $fd) = @_;
> +	if (defined $TEMP_FILES{$fd}) {
> +		truncate $TEMP_FILES{$fd}, 0 or croak $!;
> +		sysseek $TEMP_FILES{$fd}, 0, 0 or croak $!;
> +	} else {
> +		$TEMP_FILES{$fd} = File::Temp->new(
> +			TEMPLATE => 'GitSvn_XXXXXX',
> +			DIR => File::Spec->tmpdir
> +			) or croak $!;
> +		$TEMP_FILES{$fd}->autoflush(1);
> +	}
> +	$TEMP_FILES{$fd};
> +}
> +

The above is dead code now that we're using the versions in Git::,
right?

> @@ -3246,9 +3262,10 @@ sub apply_textdelta {
> -	[ SVN::TxDelta::apply($base, $fh, undef, $fb->{path}, $fb->{pool}) ];
> +	my $return = [ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
> +	$return;

Why create a temporary variable? (and break the sacred 80-column limit).

> @@ -3277,22 +3294,23 @@ sub close_file {
> -				or croak("write $tmp_filename: $!\n");
> +				or croak("write ", $tmp_fh->filename, ": $!\n");

I missed this before, but $tmp_fh->filename doesn't interpolate correctly.

("write ${\$tmp_fh->filename}: $!\n")
or
("write ", $tmp_fh->filename, ": $!\n") works.

I believe the latter form is more idiomatic so we should probably use
that...

-- 
Eric Wong
