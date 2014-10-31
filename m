From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFC] Git.pm: stat the FD to ensure the file is really open
Date: Thu, 30 Oct 2014 17:13:51 -0700
Message-ID: <4DCE1FB9-F0FA-48FD-866C-67E7C2E97951@gmail.com>
References: <20141030220836.GA7873@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:14:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjzqt-0002gm-E8
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 01:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbaJaAN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 20:13:58 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45277 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161019AbaJaANz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 20:13:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so6502450pab.14
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=149SvR44fLpKJlos9gvCGyKW82KINSRAe1DVVj7nnhc=;
        b=GO/kFAvSF1IBQkkjm/i5FQ/WjAi1ccTaVRBR0JYEKcCNr1p/Gpg3iRP6rcT/PmCGm5
         lbaYQ9nsmS1BU+Hu9TaCWZllo4m89A7xT0k82AABdulGZDlLA/nnCVCzjlKl43ZT4IsH
         IZ2OkfWbhEYH7u5S0M0rYaKzPrd4q9NxJobfOI1tD594+QP2gyDnOQfXYCjVw29J5Vtx
         sqWGJTig0rkP72iimiBss0oUqByUmCbUIG4pLoxB+4/56pTAr2Y2yhQdOVkqPI++t7+9
         rHzFIpOyJ7mc6wQ1hbF9hzdF7D9IVlC3kIADKqrglDdQ9zaE1GMHFqxpqr1mvI6OLM8n
         T02w==
X-Received: by 10.68.211.193 with SMTP id ne1mr134887pbc.49.1414714434907;
        Thu, 30 Oct 2014 17:13:54 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id uj7sm8245931pac.4.2014.10.30.17.13.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 Oct 2014 17:13:54 -0700 (PDT)
In-Reply-To: <20141030220836.GA7873@dcvr.yhbt.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Oct 30, 2014, at 15:08, Eric Wong wrote:
> For a (currently) unknown reason, Git::SVN::Fetcher::close_file
> sometimes triggers "Bad file descriptor" errors on syswrite when
> writing symlink contents on the "svn_hash" tempfile.
>
> The current IO::Handle::opened call in Git.pm is not a
> sufficient check, as the underlying file descriptor is closed
> without the PerlIO layer knowing about it.  This is likely a bug
> inside libsvn (1.6.17), as none of the Git.pm or Git::SVN
> modules close IOs without the knowledge of the PerlIO layer.
>
> Cc: Kyle J. McKay <mackyle@gmail.com>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> Kyle/Junio: thoughts?  I'm running out of time to track this down
> so it might be necessary for 2.2-rc0.  What's even stranger is
> I cannot always reproduce the problem even without this patch,
> so it may be only triggered by network latency...
> Thanks.

With this patch added, do you then see the warning:

   carp "Temp file '", $name,
	"' was closed. Opening replacement.";

 From _temp_cache?  It would seem odd if you didn't unless there was  
only one symlink involved.

I suspect that symlinks were rare in the repositories I was testing  
against.  I wonder if having a test svn repo that adds several new  
symlinks for several revisions in a row might trigger this problem  
more robustly.

The _repository->temp_acquire('svn_hash') call is assigned to a "my"  
variable and then has Git::temp_release called on it later in the same  
function and the only calls made on it in between are Git::temp_path,  
so I don't see how the libsvn library could be responsible for closing  
it since it looks to me like it never sees it.  But I'm looking at  
v2.1.2 of Fetcher.pm, so if some other calls have been inserted there  
since then.

> perl/Git.pm | 18 ++++++++++++++----
> 1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index b5905ee..f1f210b 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -99,7 +99,7 @@ increase notwithstanding).
> =cut
>
>
> -use Carp qw(carp croak); # but croak is bad - throw instead
> +use Carp qw(carp croak cluck); # but croak is bad - throw instead
> use Error qw(:try);
> use Cwd qw(abs_path cwd);
> use IPC::Open2 qw(open2);
> @@ -1206,6 +1206,16 @@ sub temp_acquire {
> 	$temp_fd;
> }
>
> +sub _temp_really_open {
> +	my ($fh) = @_;
> +
> +	if (defined($fh) && $fh->opened) {
> +		return 1 if stat($fh);
> +		cluck("$fh closed independently of PerlIO\n");
> +	}
> +	return 0;
> +}
> +
> =item temp_is_locked ( NAME )
>
> Returns true if the internal lock created by a previous  
> C<temp_acquire()>
> @@ -1232,7 +1242,7 @@ sub temp_is_locked {
> 	my ($self, $name) = _maybe_self(@_);
> 	my $temp_fd = \$TEMP_FILEMAP{$name};
>
> -	defined $$temp_fd && $$temp_fd->opened && $TEMP_FILES{$$temp_fd} 
> {locked};
> +	_temp_really_open($$temp_fd) && $TEMP_FILES{$$temp_fd}{locked};
> }
>
> =item temp_release ( NAME )
> @@ -1264,7 +1274,7 @@ sub temp_release {
> 		carp "Attempt to release temp file '",
> 			$temp_fd, "' that has not been locked";
> 	}
> -	temp_reset($temp_fd) if $trunc and $temp_fd->opened;
> +	temp_reset($temp_fd) if $trunc && _temp_really_open($temp_fd);
>
> 	$TEMP_FILES{$temp_fd}{locked} = 0;
> 	undef;
> @@ -1276,7 +1286,7 @@ sub _temp_cache {
> 	_verify_require();
>
> 	my $temp_fd = \$TEMP_FILEMAP{$name};
> -	if (defined $$temp_fd and $$temp_fd->opened) {
> +	if (_temp_really_open($$temp_fd)) {
> 		if ($TEMP_FILES{$$temp_fd}{locked}) {
> 			throw Error::Simple("Temp file with moniker '" .
> 				$name . "' already in use");
> -- 
> EW

The changes themselves look okay, but eeewwww.  I don't see how libsvn  
can see the svn_hash fd to close it unless it's randomly closing fds.

--Kyle
