From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] [RFT] git-svn: more efficient revision -> commit mapping
Date: Thu, 13 Dec 2007 08:30:03 -0800
Message-ID: <20071213163003.GB18433@soma>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net> <1197233768.7185.6.camel@brick> <1197248646.7185.25.camel@brick> <20071212180510.GB18980@untitled> <47609BF9.4030005@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Harvey Harrison <harvey.harrison@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qxD-000422-CC
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbXLMQaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbXLMQaF
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:30:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59015 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754261AbXLMQaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:30:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8F7577DC109;
	Thu, 13 Dec 2007 08:30:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47609BF9.4030005@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68172>

Sam Vilain <sam@vilain.net> wrote:
> Eric Wong wrote:
> > Sam (or anybody else using useSvmProps:
> > 
> >   Do you have any feedback with svmProps enabled?
> 
> 3682645  120 -rw-rw-r--   1 samv     samv       121893 Dec 13 14:05
> tags/debian_version_1_2_0beta1@2972/.rev_db.d29f7b36-84ff-0310-85ce-ba787dbd31ca
> 
>  =>
> 
> -3683050    4 -rw-rw-r--   1 samv     samv           48 Dec 13 14:26
> ./tags/debian_version_1_2_0beta1@2972/.rev_map.d29f7b36-84ff-0310-85ce-ba787dbd31ca
> 
> git-log --all | grep git-svn | tail -3
> 
>     git-svn-id:
> file:///home/samv/.svk/local/mirror/fai/branches/source-dist@2971
> d29f7b36-84ff-0310-85ce-ba787dbd31ca
>     git-svn-id: svn+ssh://svn.debian.org/svn/fai/trunk@2
> ba5ec265-b0fb-0310-8e1a-cf9e4c2b1591
>     git-svn-id: svn+ssh://svn.debian.org/svn/fai/trunk@1
> ba5ec265-b0fb-0310-8e1a-cf9e4c2b1591
> 
> So, the remapping is still working fine.

Hi Sam, nice.

> The one that failed there is not a new bug.  Here's the fix anyway
> though :-)
> 
> Subject: [PATCH] git-svn: fix --use-svm-props and --follow-parent
> 
> If, when using --follow-parent, it finds that the parent is an SVM
> path, *and* the SVM path is not at the root of the corresponding SVN
> repository (the usual case when using SVK), then the logic in
> Git::SVN::ra will not find the correct source repository.  This is
> because the freshly created RA object is missing the path.  So, set
> this after creation.

This seems to break the non-useSvmProps case (in t9104).  I'll look more
at it later.

> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 54d7844..3e5fd82 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2189,6 +2189,7 @@ sub find_parent_branch {
>  		$ref_id .= '-' while find_ref($ref_id);
>  		print STDERR "Initializing parent: $ref_id\n";
>  		$gs = Git::SVN->init($new_url, '', $ref_id, $ref_id, 1);
> +		$gs->{path} = $branch_from;
>  	}
>  	my ($r0, $parent) = $gs->find_rev_before($r, 1);
>  	if (!defined $r0 || !defined $parent) {

-- 
Eric Wong
