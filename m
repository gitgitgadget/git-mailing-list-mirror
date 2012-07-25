From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: Do not remove temporary files on error
Date: Wed, 25 Jul 2012 09:49:57 -0700
Message-ID: <7vlii7dbuy.fsf@alter.siamese.dyndns.org>
References: <1343196876-59195-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4nS-0000AD-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab2GYQuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:50:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755866Ab2GYQt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:49:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 649478EE1;
	Wed, 25 Jul 2012 12:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bSNx/Rm5pBbXVYsAmPKDiwK09Nc=; b=POFtTs
	0/AOE0JaAs16ionkU9Ii4bbx6L8BG80U9y3b9LKFCI2/a9OW1e/Q0wOJ2jNS8P5s
	3HbpKIdn+hYtsraC2pHdWyFSjW6QEZR6hqu9L3pQGKFjNm/H9TfI8nudiNTELlAT
	BdfLXck74eKdzdxPt7ZELhALjELBNMwN9KQLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vsx7JKz0P7XCKJoFi75UjyI1fd55vP3R
	gfxoY+R65h81dFucunix+TJBKeNp6x5hSaqoPP0q9PPHG7ocrPZOfskdsNj3DQ4g
	iOLUUk7twE6CgZeD5h1zNXmJRFocLCFXymFs0BnNHFmYgr17iTIJUsb9YWarwE0N
	u53hi8XNh9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 521658EE0;
	Wed, 25 Jul 2012 12:49:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ED6A8EDF; Wed, 25 Jul 2012
 12:49:58 -0400 (EDT)
In-Reply-To: <1343196876-59195-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 24 Jul 2012 23:14:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4E05B40-D678-11E1-8C28-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202175>

David Aguilar <davvid@gmail.com> writes:

> Keep the temporary directory around when either compare() or
> the difftool returns a non-zero exit status.
>
> Tell the user about the location of the temporary files so that
> they can recover from the failure.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-difftool.perl | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 10d3d97..f4f7d4a 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -18,7 +18,7 @@ use File::Copy;
>  use File::Compare;
>  use File::Find;
>  use File::stat;
> -use File::Path qw(mkpath);
> +use File::Path qw(mkpath rmtree);
>  use File::Temp qw(tempdir);
>  use Getopt::Long qw(:config pass_through);
>  use Git;
> @@ -119,7 +119,7 @@ sub setup_dir_diff
>  	exit(0) if (length($diffrtn) == 0);
>  
>  	# Setup temp directories
> -	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 1, TMPDIR => 1);
> +	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
>  	my $ldir = "$tmpdir/left";
>  	my $rdir = "$tmpdir/right";
>  	mkpath($ldir) or die $!;
> @@ -257,7 +257,7 @@ sub setup_dir_diff
>  		}
>  	}
>  
> -	return ($ldir, $rdir, @working_tree);
> +	return ($ldir, $rdir, $tmpdir, @working_tree);
>  }
>  
>  sub write_to_file
> @@ -349,20 +349,23 @@ sub main
>  sub dir_diff
>  {
>  	my ($extcmd, $symlinks) = @_;
> -
>  	my $rc;
> +	my $error = 0;
>  	my $repo = Git->repository();
> -
>  	my $workdir = find_worktree($repo);
> -	my ($a, $b, @worktree) = setup_dir_diff($repo, $workdir, $symlinks);
> +	my ($a, $b, $tmpdir, @worktree) =
> +		setup_dir_diff($repo, $workdir, $symlinks);
> +
>  	if (defined($extcmd)) {
>  		$rc = system($extcmd, $a, $b);
>  	} else {
>  		$ENV{GIT_DIFFTOOL_DIRDIFF} = 'true';
>  		$rc = system('git', 'difftool--helper', $a, $b);
>  	}
> -
> -	exit($rc | ($rc >> 8)) if ($rc != 0);
> +	if ($rc != 0) {
> +		dir_diff_tmpdir_warning($tmpdir);
> +		exit($rc | ($rc >> 8));
> +	}

Hrm.

What does a non-zero exit code from these "compare two trees" diff
tools (e.g. "diff -r a/ b/") mean?  Isn't "there are difference
between the two trees" the usual meaning?  And we treat that as a
failure and make the user clean up after us?

The patch is not making things any worse with respect to that point,
so I'd queue it as-is, but it smells like a fishy design decision to
me.

>  	# If the diff including working copy files and those
>  	# files were modified during the diff, then the changes
> @@ -377,16 +380,29 @@ sub dir_diff
>  		if ($diff == 0) {
>  			next;
>  		} elsif ($diff == -1 ) {
> -			my $errmsg = "warning: could not compare ";
> +			my $errmsg = "warning: Could not compare ";
>  			$errmsg += "'$b/$file' with '$workdir/$file'\n";
>  			warn $errmsg;
> +			$error = 1;
>  		} elsif ($diff == 1) {
>  			copy("$b/$file", "$workdir/$file") or die $!;
>  			my $mode = stat("$b/$file")->mode;
>  			chmod($mode, "$workdir/$file") or die $!;
>  		}
>  	}
> -	exit(0);
> +	if ($error) {
> +		dir_diff_tmpdir_warning($tmpdir);
> +	} else {
> +		rmtree($tmpdir);
> +	}
> +	exit($error);
> +}
> +
> +sub dir_diff_tmpdir_warning
> +{
> +	my ($tmpdir) = @_;
> +	warn "warning: Temporary files exist in '$tmpdir'.\n";
> +	warn "warning: You may want to cleanup or recover these.\n";
>  }
>  
>  sub file_diff
