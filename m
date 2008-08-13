From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] git-svn: Reduce temp file usage when dealing with non-links
Date: Tue, 12 Aug 2008 20:29:56 -0700
Message-ID: <20080813032956.GC5904@untitled>
References: <1218470035-13864-4-git-send-email-marcus@griep.us> <1218556876-26554-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcus Griep <marcus@griep.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:31:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT74g-0007Iz-Sz
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbYHMD36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbYHMD36
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:29:58 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34356 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbYHMD35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:29:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1EBED2DC01B;
	Tue, 12 Aug 2008 20:29:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218556876-26554-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92174>

Marcus Griep <marcus@griep.us> wrote:
> Currently, in sub 'close_file', git-svn creates a temporary file and
> copies the contents of the blob to be written into it. This is useful
> for symlinks because svn stores symlinks in the form:
> 
> link $FILE_PATH
> 
> Git creates a blob only out of '$FILE_PATH' and uses file mode to
> indicate that the blob should be interpreted as a symlink.
> 
> As git-hash-object is invoked with --stdin-paths, a duplicate of the
> link from svn must be created that leaves off the first five bytes,
> i.e. 'link '. However, this is wholly unnecessary for normal blobs,
> though, as we already have a temp file with their contents. Copying
> the entire file gains nothing, and effectively requires a file to be
> written twice before making it into the object db.
> 
> This patch corrects that issue, holding onto the substr-like
> duplication for symlinks, but skipping it altogether for normal blobs
> by reusing the existing temp file.
> 
> Signed-off-by: Marcus Griep <marcus@griep.us>

Thank you Marcus!

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |   46 ++++++++++++++++++++++------------------------
>  1 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 9eae5e8..95d1510 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3268,38 +3268,36 @@ sub close_file {
>  				    "expected: $exp\n    got: $got\n";
>  			}
>  		}
> -		sysseek($fh, 0, 0) or croak $!;
>  		if ($fb->{mode_b} == 120000) {
> -			eval {
> -				sysread($fh, my $buf, 5) == 5 or croak $!;
> -				$buf eq 'link ' or die "$path has mode 120000",
> -						       " but is not a link";
> -			};
> -			if ($@) {
> -				warn "$@\n";
> -				sysseek($fh, 0, 0) or croak $!;
> -			}
> -		}
> -
> -		my $tmp_fh = Git::temp_acquire('svn_hash');
> -		my $result;
> -		while ($result = sysread($fh, my $string, 1024)) {
> -			my $wrote = syswrite($tmp_fh, $string, $result);
> -			defined($wrote) && $wrote == $result
> -				or croak("write ",
> -					$tmp_fh->filename, ": $!\n");
> -		}
> -		defined $result or croak $!;
> +			sysseek($fh, 0, 0) or croak $!;
> +			sysread($fh, my $buf, 5) == 5 or croak $!;
>  
> +			unless ($buf eq 'link ') {
> +				warn "$path has mode 120000",
> +						" but is not a link\n";
> +			} else {
> +				my $tmp_fh = Git::temp_acquire('svn_hash');
> +				my $res;
> +				while ($res = sysread($fh, my $str, 1024)) {
> +					my $out = syswrite($tmp_fh, $str, $res);
> +					defined($out) && $out == $res
> +						or croak("write ",
> +							$tmp_fh->filename,
> +							": $!\n");
> +				}
> +				defined $result or croak $!;
>  
> -		Git::temp_release($fh, 1);
> +				($fh, $tmp_fh) = ($tmp_fh, $fh);
> +				Git::temp_release($tmp_fh, 1);
> +			}
> +		}
>  
>  		$hash = $::_repository->hash_and_insert_object(
> -				$tmp_fh->filename);
> +				$fh->filename);
>  		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
>  
>  		Git::temp_release($fb->{base}, 1);
> -		Git::temp_release($tmp_fh, 1);
> +		Git::temp_release($fh, 1);
>  	} else {
>  		$hash = $fb->{blob} or die "no blob information\n";
>  	}
> -- 
> 1.6.0.rc2.6.g8eda3
