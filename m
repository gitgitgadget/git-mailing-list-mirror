From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] improve git svn performance
Date: Wed, 22 Jan 2014 02:56:30 +0000
Message-ID: <20140122025630.GA15886@dcvr.yhbt.net>
References: <1390192672-3827-1-git-send-email-manjian2006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linzj <linzj@ucweb.com>
To: manjian2006@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 22 03:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5nzY-0006C3-CW
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 03:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbaAVC4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 21:56:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49137 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbaAVC4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 21:56:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C8C1FAAF;
	Wed, 22 Jan 2014 02:56:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1390192672-3827-1-git-send-email-manjian2006@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240813>

manjian2006@gmail.com wrote:
> From: linzj <linzj@ucweb.com>
>   I am trying to improve git svn's performance according to some
>   profiling data.As the data showed,_rev_list subroutine and rebuild
>   subroutine are consuming a large proportion of time.So I improve
>   _rev_list's performance by memoize its results,and avoid subprocess
>   invocation by memoize rebuild subroutine's key data.Here's my patch:

Hi, I'm interested in this.  How much did performance improve by
(and how many revisions is the repository)>

However, I cannot accept the patch in the current state.

The commit message is inadequate; and you need a Signed-off-by and follow
existing coding convention/style.  See Documentation/SubmittingPatches
and Documentation/CodingGuidelines for more info.

Some comments inline...

>  		tie_for_persistent_memoization(\%lookup_svn_merge_cache,
> -		    "$cache_path/lookup_svn_merge");
> +				"$cache_path/lookup_svn_merge");
>  		memoize 'lookup_svn_merge',
> -			SCALAR_CACHE => 'FAULT',
> -			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
> -		;
> +				SCALAR_CACHE => 'FAULT',
> +				LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
> +				;

Please no extraneous whitespace changes.

> +#define a global associate map to record rebuild status
> +my %rebuildStatus;

We prefer snake_case variables, not camelCase.

>  sub rebuild {
>  	my ($self) = @_;
>  	my $map_path = $self->map_path;
>  	my $partial = (-e $map_path && ! -z $map_path);
> -	return unless ::verify_ref($self->refname.'^0');
> +    my $verifyKey = $self->refname.'^0';
> +    if (! exists $rebuildVerifyStatus{$verifyKey} || ! defined $rebuildVerifyStatus{$verifyKey} ) {
> +        my $verifyResult = ::verify_ref($verifyKey);
> +        if ($verifyResult) {
> +            $rebuildVerifyStatus{$verifyKey} = 1;
> +        }
> +    }
> +    if (! exists $rebuildVerifyStatus{$verifyKey}) {
> +        return;
> +    }

Please use tabs for indentation to match surrounding code
(most of git is tabs).

Thanks.
