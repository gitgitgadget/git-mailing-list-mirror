From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix git-svn to handle svn not reporting the md5sum of a file, and test.
Date: Thu, 24 May 2007 02:16:56 -0700
Message-ID: <20070524091655.GA29070@muzzle>
References: <1179981426176-git-send-email-foom@fuhm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Y Knight <foom@fuhm.net>
X-From: git-owner@vger.kernel.org Thu May 24 11:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr9RP-0007X6-TY
	for gcvg-git@gmane.org; Thu, 24 May 2007 11:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbXEXJQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 05:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbXEXJQ7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 05:16:59 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59990 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbXEXJQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 05:16:58 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6C6A92DC032;
	Thu, 24 May 2007 02:16:56 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 24 May 2007 02:16:56 -0700
Content-Disposition: inline
In-Reply-To: <1179981426176-git-send-email-foom@fuhm.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48237>

James Y Knight <foom@fuhm.net> wrote:

Thanks.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl                    |    2 +-
>  t/t9112-git-svn-md5less-file.sh |   45 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletions(-)
>  create mode 100755 t/t9112-git-svn-md5less-file.sh
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 3c4f490..b2773dc 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2471,7 +2471,7 @@ sub close_file {
>  		$md5->addfile($fh);
>  		my $got = $md5->hexdigest;
>  		die "Checksum mismatch: $path\n",
> -		    "expected: $exp\n    got: $got\n" if ($got ne $exp);
> +		    "expected: $exp\n    got: $got\n" if (defined $exp && $got ne $exp);
>  		sysseek($fh, 0, 0) or croak $!;
>  		if ($fb->{mode_b} == 120000) {
>  			sysread($fh, my $buf, 5) == 5 or croak $!;
> diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
> new file mode 100755
> index 0000000..08313bb
> --- /dev/null
> +++ b/t/t9112-git-svn-md5less-file.sh
> @@ -0,0 +1,45 @@
> +test_description='test that git handles an svn repository with missing md5sums'
> +
> +. ./lib-git-svn.sh
> +
> +# Loading a node from a svn dumpfile without a Text-Content-Length
> +# field causes svn to neglect to store or report an md5sum.  (it will
> +# calculate one if you had put Text-Content-Length: 0).  This showed
> +# up in a repository creted with cvs2svn.
> +
> +cat > dumpfile.svn <<EOF
> +SVN-fs-dump-format-version: 1
> +
> +Revision-number: 1
> +Prop-content-length: 98
> +Content-length: 98
> +
> +K 7
> +svn:log
> +V 0
> +
> +K 10
> +svn:author
> +V 4
> +test
> +K 8
> +svn:date
> +V 27
> +2007-05-06T12:37:01.153339Z
> +PROPS-END
> +
> +Node-path: md5less-file
> +Node-kind: file
> +Node-action: add
> +Prop-content-length: 10
> +Content-length: 10
> +
> +PROPS-END
> +
> +EOF
> +
> +test_expect_success 'load svn dumpfile' "svnadmin load $rawsvnrepo < dumpfile.svn"
> +
> +test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
> +test_expect_success 'fetch revisions from svn' 'git-svn fetch'
> +test_done
> -- 
> 1.5.2.rc2.1.g7f0b
> 

-- 
Eric Wong
