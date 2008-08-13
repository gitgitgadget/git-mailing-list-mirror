From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Tue, 12 Aug 2008 20:28:13 -0700
Message-ID: <20080813032813.GA5904@untitled>
References: <1218470035-13864-2-git-send-email-marcus@griep.us> <1218556818-14006-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcus Griep <marcus@griep.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT72z-0006vz-W3
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbYHMD2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbYHMD2P
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:28:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34343 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949AbYHMD2O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:28:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 245742DC01B;
	Tue, 12 Aug 2008 20:28:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218556818-14006-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92172>

Marcus Griep <marcus@griep.us> wrote:
> This patch offers a generic interface to allow temp files to be
> cached while using an instance of the 'Git' package. If many
> temp files are created and destroyed during the execution of a
> program, this caching mechanism can help reduce the amount of
> files created and destroyed by the filesystem.
> 
> The temp_acquire method provides a weak guarantee that a temp
> file will not be stolen by subsequent requests. If a file is
> locked when another acquire request is made, a simple error is
> thrown.
> 
> Signed-off-by: Marcus Griep <marcus@griep.us>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  perl/Git.pm |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 123 insertions(+), 2 deletions(-)
> 
> diff --git a/perl/Git.pm b/perl/Git.pm
> index e1ca5b4..405f68f 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -57,7 +57,8 @@ require Exporter;
>                  command_output_pipe command_input_pipe command_close_pipe
>                  command_bidi_pipe command_close_bidi_pipe
>                  version exec_path hash_object git_cmd_try
> -                remote_refs);
> +                remote_refs
> +                temp_acquire temp_release temp_reset);
>  
>  
>  =head1 DESCRIPTION
> @@ -99,7 +100,9 @@ use Carp qw(carp croak); # but croak is bad - throw instead
>  use Error qw(:try);
>  use Cwd qw(abs_path);
>  use IPC::Open2 qw(open2);
> -
> +use File::Temp ();
> +require File::Spec;
> +use Fcntl qw(SEEK_SET SEEK_CUR);
>  }
>  
>  
> @@ -933,6 +936,124 @@ sub _close_cat_blob {
>  	delete @$self{@vars};
>  }
>  
> +
> +{ # %TEMP_* Lexical Context
> +
> +my (%TEMP_LOCKS, %TEMP_FILES);
> +
> +=item temp_acquire ( NAME )
> +
> +Attempts to retreive the temporary file mapped to the string C<NAME>. If an
> +associated temp file has not been created this session or was closed, it is
> +created, cached, and set for autoflush and binmode.
> +
> +Internally locks the file mapped to C<NAME>. This lock must be released with
> +C<temp_release()> when the temp file is no longer needed. Subsequent attempts
> +to retrieve temporary files mapped to the same C<NAME> while still locked will
> +cause an error. This locking mechanism provides a weak guarantee and is not
> +threadsafe. It does provide some error checking to help prevent temp file refs
> +writing over one another.
> +
> +In general, the L<File::Handle> returned should not be closed by consumers as
> +it defeats the purpose of this caching mechanism. If you need to close the temp
> +file handle, then you should use L<File::Temp> or another temp file faculty
> +directly. If a handle is closed and then requested again, then a warning will
> +issue.
> +
> +=cut
> +
> +sub temp_acquire {
> +	my ($self, $name) = _maybe_self(@_);
> +
> +	my $temp_fd = _temp_cache($name);
> +
> +	$TEMP_LOCKS{$temp_fd} = 1;
> +	$temp_fd;
> +}
> +
> +=item temp_release ( NAME )
> +
> +=item temp_release ( FILEHANDLE )
> +
> +Releases a lock acquired through C<temp_acquire()>. Can be called either with
> +the C<NAME> mapping used when acquiring the temp file or with the C<FILEHANDLE>
> +referencing a locked temp file.
> +
> +Warns if an attempt is made to release a file that is not locked.
> +
> +The temp file will be truncated before being released. This can help to reduce
> +disk I/O where the system is smart enough to detect the truncation while data
> +is in the output buffers. Beware that after the temp file is released and
> +truncated, any operations on that file may fail miserably until it is
> +re-acquired. All contents are lost between each release and acquire mapped to
> +the same string.
> +
> +=cut
> +
> +sub temp_release {
> +	my ($self, $temp_fd, $trunc) = _maybe_self(@_);
> +
> +	if (ref($temp_fd) ne 'File::Temp') {
> +		$temp_fd = $TEMP_FILES{$temp_fd};
> +	}
> +	unless ($TEMP_LOCKS{$temp_fd}) {
> +		carp "Attempt to release temp file '",
> +			$temp_fd, "' that has not been locked";
> +	}
> +	temp_reset($temp_fd) if $trunc and $temp_fd->opened;
> +
> +	$TEMP_LOCKS{$temp_fd} = 0;
> +	undef;
> +}
> +
> +sub _temp_cache {
> +	my ($name) = @_;
> +
> +	my $temp_fd = \$TEMP_FILES{$name};
> +	if (defined $$temp_fd and $$temp_fd->opened) {
> +		if ($TEMP_LOCKS{$$temp_fd}) {
> +			throw Error::Simple("Temp file with moniker '",
> +				$name, "' already in use");
> +		}
> +	} else {
> +		if (defined $$temp_fd) {
> +			# then we're here because of a closed handle.
> +			carp "Temp file '", $name,
> +				"' was closed. Opening replacement.";
> +		}
> +		$$temp_fd = File::Temp->new(
> +			TEMPLATE => 'Git_XXXXXX',
> +			DIR => File::Spec->tmpdir
> +			) or throw Error::Simple("couldn't open new temp file");
> +		$$temp_fd->autoflush;
> +		binmode $$temp_fd;
> +	}
> +	$$temp_fd;
> +}
> +
> +=item temp_reset ( FILEHANDLE )
> +
> +Truncates and resets the position of the C<FILEHANDLE>.
> +
> +=cut
> +
> +sub temp_reset {
> +	my ($self, $temp_fd) = _maybe_self(@_);
> +
> +	truncate $temp_fd, 0
> +		or throw Error::Simple("couldn't truncate file");
> +	sysseek($temp_fd, 0, SEEK_SET) and seek($temp_fd, 0, SEEK_SET)
> +		or throw Error::Simple("couldn't seek to beginning of file");
> +	sysseek($temp_fd, 0, SEEK_CUR) == 0 and tell($temp_fd) == 0
> +		or throw Error::Simple("expected file position to be reset");
> +}
> +
> +sub END {
> +	unlink values %TEMP_FILES if %TEMP_FILES;
> +}
> +
> +} # %TEMP_* Lexical Context
> +
>  =back
>  
>  =head1 ERROR HANDLING
> -- 
> 1.6.0.rc2.6.g8eda3
