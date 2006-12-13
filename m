X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/3] git-svn: correctly handle packed-refs in refs/remotes/
Date: Tue, 12 Dec 2006 17:27:51 -0800
Message-ID: <7vlklcmvoo.fsf@assigned-by-dhcp.cox.net>
References: <11659636223725-git-send-email-normalperson@yhbt.net>
	<11659636263755-git-send-email-normalperson@yhbt.net>
	<20061213004500.GA17811@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 01:28:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34176>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuIuZ-0002T7-Ra for gcvg-git@gmane.org; Wed, 13 Dec
 2006 02:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750752AbWLMB1x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 20:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWLMB1x
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 20:27:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35649 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751573AbWLMB1w (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 20:27:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213012752.BVGE16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 20:27:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id y1U21V00s1kojtg0000000; Tue, 12 Dec 2006
 20:28:03 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> We now use git-rev-parse universally to read refs, instead
> of our own file_to_s function (which I plan on removing).
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 1f8a3b0..aac8f73 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2016,9 +2016,17 @@ sub git_commit {
>  
>  	# just in case we clobber the existing ref, we still want that ref
>  	# as our parent:
> -	if (my $cur = eval { file_to_s("$GIT_DIR/refs/remotes/$GIT_SVN") }) {
> +	open my $null, '>', '/dev/null' or croak $!;
> +	open my $stderr, '>&', \*STDERR or croak $!;
> +	open STDERR, '>&', $null or croak $!;
> +	if (my $cur = eval { safe_qx('git-rev-parse',
> +	                             "refs/remotes/$GIT_SVN^0") }) {
> +		chomp $cur;
>  		push @tmp_parents, $cur;
>  	}
> +	open STDERR, '>&', $stderr or croak $!;
> +	close $stderr or croak $!;
> +	close $null or croak $!;
>  
>  	if (exists $tree_map{$tree}) {
>  		foreach my $p (@{$tree_map{$tree}}) {

It's a neat trick you do to stash away STDERR and redirect to
/dev/null ;-).  It might be worth doing something like this:

	sub without_stderr {
        	my ($cmd, @param) = @_;
                # stash away magic
                my @return = eval {
                	safe_qx($cmd, @param);
                };
                # restore magic
                return @return;
	}

in Git.pm?

Then the caller would do something like this instead:

	sub git_commit {
        	...
		if (my ($cur) = without_stderr(qw(git rev-parse --verify),
			"refs/remotes/$GIT_SVN^0")) {
                	...

