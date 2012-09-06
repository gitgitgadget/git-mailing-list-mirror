From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Wed, 05 Sep 2012 20:52:53 -0700
Message-ID: <7vipbr6c4q.fsf@alter.siamese.dyndns.org>
References: <1346827469.1137.22.camel@umgah.localdomain>
 <1346881194-19076-1-git-send-email-ktdreyer@ktdreyer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ken Dreyer <ktdreyer@ktdreyer.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:53:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9T9M-00028W-5H
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 05:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2IFDw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 23:52:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab2IFDw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 23:52:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1C99414;
	Wed,  5 Sep 2012 23:52:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=loiE8RYZBqQ47vJ15ewnR2v2CSI=; b=BD3TZc
	JOTn+udwsdOP4CKG6K1gNDWJLZ5MysNhMZTo/IwsIwT74yuu2cGIQFrVFt2RdvJz
	8hLGV04jB8GRhFnRQ9S3fZ44iBtXVgZSPVBcYqV0qEbnVUGtYRYJtLFwTYFY8JlS
	oRpdSezQK8l15fnyufflZWoE3mdHCEWDgWQ2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fGjrVMgFIrlDCEcEz12S6gUK9CGtTxds
	Zm+ODc2seMK6/6nWHiZwoAEhGM5LA3txDD1kT7tj1zzMRpLiBJzrWlsmxxkAR4Hw
	Qn1HqscCRkaZ4gccGT+ZN0KBoSgJvYeEfkOYc7tYvEL1xESZd1Z6wPbkzVIoRV69
	ooWYLeFRNo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CC419413;
	Wed,  5 Sep 2012 23:52:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D4469412; Wed,  5 Sep 2012
 23:52:54 -0400 (EDT)
In-Reply-To: <1346881194-19076-1-git-send-email-ktdreyer@ktdreyer.com> (Ken
 Dreyer's message of "Wed, 5 Sep 2012 15:39:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 569A85F0-F7D6-11E1-B4DF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204859>

Ken Dreyer <ktdreyer@ktdreyer.com> writes:

> Certain characters such as "?" can be present in a CVS tag name, but
> git does not allow these characters in tags. If git-cvsimport
> encounters a CVS tag that git cannot handle, cvsimport will error and
> refuse to continue the import beyond that point.
>
> When importing CVS tags, strip all the inappropriate strings from the
> tag names as we translate them to git tag names.
>
> Signed-off-by: Ken Dreyer <ktdreyer@ktdreyer.com>
> ---
>
> Thanks Junio and Alex for your review and comments. I've implemented
> both of your suggestions in this patch.

Thanks.

Do we want to give a warning instead of silently dropping a tag on
the floor, or is the output verbose enough that such a warning will
be drowned in the noise?

>  git-cvsimport.perl | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 8d41610..dda8a6d 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -889,7 +889,23 @@ sub commit {
>  		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
>  		$xtag =~ tr/_/\./ if ( $opt_u );
>  		$xtag =~ s/[\/]/$opt_s/g;
> -		$xtag =~ s/\[//g;
> +
> +		# See ref.c for these rules.
> +		# Tag cannot contain bad chars. See bad_ref_char in ref.c.
> +		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
> +		# Other bad strings for tags:
> +		1 while $xtag =~ s/
> +			(?: \.\.        # Tag cannot contain '..'.
> +			|   \@{         # Tag cannot contain '@{'.
> +			| ^ -           # Tag cannot begin with '-'.
> +			|   \.lock $    # Tag cannot end with '.lock'.
> +			| ^ \.          # Tag cannot begin...
> +			|   \. $        # ...or end with '.'
> +			)//xg;
> +		# Tag cannot be empty.
> +		if ($xtag eq '') {

That is, adding something like:

	print STDERR "warning: ignoring tag '$tag' with invalid tagname";

here.

> +			return;
> +		}
>  
>  		system('git' , 'tag', '-f', $xtag, $cid) == 0
>  			or die "Cannot create tag $xtag: $!\n";

It also may be worthwhile to show the original tagname ($tag)
somewhere in this message to help diagnosis.
