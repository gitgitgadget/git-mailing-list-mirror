From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't checkout the full tree if avoidable
Date: Mon, 01 Oct 2007 00:58:48 -0700
Message-ID: <7vejgftgef.fsf@gitster.siamese.dyndns.org>
References: <1191000259190-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Walter <stevenrwalter@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 09:59:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcGBC-0002Bt-Rd
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 09:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbXJAH64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 03:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbXJAH64
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 03:58:56 -0400
Received: from rune.pobox.com ([208.210.124.79]:42263 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbXJAH6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 03:58:55 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 1056813EED3;
	Mon,  1 Oct 2007 03:59:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 463EE13EBD6;
	Mon,  1 Oct 2007 03:59:12 -0400 (EDT)
In-Reply-To: <1191000259190-git-send-email-stevenrwalter@gmail.com> (Steven
	Walter's message of "Fri, 28 Sep 2007 13:24:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59586>

Steven Walter <stevenrwalter@gmail.com> writes:

> In most cases of branching, the tree is copied unmodified from the trunk
> to the branch.  When that is done, we can simply start with the parent's
> index and apply the changes on the branch as usual.
>
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>

Eric, do you like this one?

> ---
>  git-svn.perl |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 484b057..2ca2042 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1847,6 +1847,13 @@ sub find_parent_branch {
>  			$gs->ra->gs_do_switch($r0, $rev, $gs,
>  					      $self->full_url, $ed)
>  			  or die "SVN connection failed somewhere...\n";
> +		} elsif ($self->trees_match($new_url, $r0,
> +			                    $self->full_url, $rev)) {
> +			$self->tmp_index_do(sub {
> +			    command_noisy('read-tree', $parent);
> +			});
> +			$self->{last_commit} = $parent;
> +			# Assume copy with no changes
>  		} else {
>  			print STDERR "Following parent with do_update\n";
>  			$ed = SVN::Git::Fetcher->new($self);
> @@ -1859,6 +1866,17 @@ sub find_parent_branch {
>  	return undef;
>  }
>  
> +sub trees_match {
> +    my ($self, $url1, $rev1, $url2, $rev2) = @_;
> +    
> +    my $ret=1;
> +    open(my $fh, "svn diff $url1\@$rev1 $url2\@$rev2 |");
> +    $ret=0 if (<$fh>);
> +    close($fh);
> +
> +    return $ret;
> +}
> +
>  sub do_fetch {
>  	my ($self, $paths, $rev) = @_;
>  	my $ed;
> -- 
> 1.5.3.1
