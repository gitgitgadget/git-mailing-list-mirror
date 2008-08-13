From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: Make it incrementally faster by minimizing temp files
Date: Tue, 12 Aug 2008 20:29:00 -0700
Message-ID: <20080813032900.GB5904@untitled>
References: <1218556853-25906-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcus Griep <marcus@griep.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT73m-00078Q-RJ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbYHMD3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbYHMD3D
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:29:03 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34349 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242AbYHMD3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:29:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D5EDF2DC01B;
	Tue, 12 Aug 2008 20:29:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218556853-25906-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92173>

Marcus Griep <marcus@griep.us> wrote:
> Currently, git-svn would create a temp file on four occasions:
> 1. Reading a blob out of the object db
> 2. Creating a delta from svn
> 3. Hashing and writing a blob into the object db
> 4. Reading a blob out of the object db (in another place in code)
> 
> Any time git-svn did the above, it would dutifully create and then
> delete said temp file.  Unfortunately, this means that between 2-4
> temporary files are created/deleted per file 'add/modify'-ed in
> svn (O(n)).  This causes significant overhead and helps the inode
> counter to spin beautifully.
> 
> By its nature, git-svn is a serial beast.  Thus, reusing a temp file
> does not pose significant problems.  "truncate and seek" takes much
> less time than "unlink and create".  This patch centralizes the
> tempfile creation and holds onto the tempfile until they are deleted
> on exit.  This significantly reduces file overhead, now requiring
> at most three (3) temp files per run (O(1)).
> 
> Signed-off-by: Marcus Griep <marcus@griep.us>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |   35 ++++++++++++++++++-----------------
>  1 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 4dc3380..9eae5e8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1265,7 +1265,7 @@ sub md5sum {
>  	my $arg = shift;
>  	my $ref = ref $arg;
>  	my $md5 = Digest::MD5->new();
> -        if ($ref eq 'GLOB' || $ref eq 'IO::File') {
> +        if ($ref eq 'GLOB' || $ref eq 'IO::File' || $ref eq 'File::Temp') {
>  		$md5->addfile($arg) or croak $!;
>  	} elsif ($ref eq 'SCALAR') {
>  		$md5->add($$arg) or croak $!;
> @@ -1328,6 +1328,7 @@ BEGIN {
>  	}
>  }
>  
> +
>  my (%LOCKFILES, %INDEX_FILES);
>  END {
>  	unlink keys %LOCKFILES if %LOCKFILES;
> @@ -3230,13 +3231,11 @@ sub change_file_prop {
>  
>  sub apply_textdelta {
>  	my ($self, $fb, $exp) = @_;
> -	my $fh = IO::File->new_tmpfile;
> -	$fh->autoflush(1);
> +	my $fh = Git::temp_acquire('svn_delta');
>  	# $fh gets auto-closed() by SVN::TxDelta::apply(),
>  	# (but $base does not,) so dup() it for reading in close_file
>  	open my $dup, '<&', $fh or croak $!;
> -	my $base = IO::File->new_tmpfile;
> -	$base->autoflush(1);
> +	my $base = Git::temp_acquire('git_blob');
>  	if ($fb->{blob}) {
>  		print $base 'link ' if ($fb->{mode_a} == 120000);
>  		my $size = $::_repository->cat_blob($fb->{blob}, $base);
> @@ -3251,9 +3250,9 @@ sub apply_textdelta {
>  		}
>  	}
>  	seek $base, 0, 0 or croak $!;
> -	$fb->{fh} = $dup;
> +	$fb->{fh} = $fh;
>  	$fb->{base} = $base;
> -	[ SVN::TxDelta::apply($base, $fh, undef, $fb->{path}, $fb->{pool}) ];
> +	[ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
>  }
>  
>  sub close_file {
> @@ -3282,22 +3281,25 @@ sub close_file {
>  			}
>  		}
>  
> -		my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
> +		my $tmp_fh = Git::temp_acquire('svn_hash');
>  		my $result;
>  		while ($result = sysread($fh, my $string, 1024)) {
>  			my $wrote = syswrite($tmp_fh, $string, $result);
>  			defined($wrote) && $wrote == $result
> -				or croak("write $tmp_filename: $!\n");
> +				or croak("write ",
> +					$tmp_fh->filename, ": $!\n");
>  		}
>  		defined $result or croak $!;
> -		close $tmp_fh or croak $!;
>  
> -		close $fh or croak $!;
>  
> -		$hash = $::_repository->hash_and_insert_object($tmp_filename);
> -		unlink($tmp_filename);
> +		Git::temp_release($fh, 1);
> +
> +		$hash = $::_repository->hash_and_insert_object(
> +				$tmp_fh->filename);
>  		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
> -		close $fb->{base} or croak $!;
> +
> +		Git::temp_release($fb->{base}, 1);
> +		Git::temp_release($tmp_fh, 1);
>  	} else {
>  		$hash = $fb->{blob} or die "no blob information\n";
>  	}
> @@ -3667,7 +3669,7 @@ sub chg_file {
>  	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
>  		$self->change_file_prop($fbat,'svn:executable',undef);
>  	}
> -	my $fh = IO::File->new_tmpfile or croak $!;
> +	my $fh = Git::temp_acquire('git_blob');
>  	if ($m->{mode_b} =~ /^120/) {
>  		print $fh 'link ' or croak $!;
>  		$self->change_file_prop($fbat,'svn:special','*');
> @@ -3686,9 +3688,8 @@ sub chg_file {
>  	my $atd = $self->apply_textdelta($fbat, undef, $pool);
>  	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
>  	die "Checksum mismatch\nexpected: $exp\ngot: $got\n" if ($got ne $exp);
> +	Git::temp_release($fh, 1);
>  	$pool->clear;
> -
> -	close $fh or croak $!;
>  }
>  
>  sub D {
> -- 
> 1.6.0.rc2.6.g8eda3
