From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Tue, 04 Sep 2012 22:52:28 -0700
Message-ID: <7vobll6moz.fsf@alter.siamese.dyndns.org>
References: <7vsjax6trn.fsf@alter.siamese.dyndns.org>
 <1346819164-8116-1-git-send-email-ktdreyer@ktdreyer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Ken Dreyer <ktdreyer@ktdreyer.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 07:52:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T98Xe-0005tm-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 07:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab2IEFwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 01:52:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517Ab2IEFwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 01:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7B87995;
	Wed,  5 Sep 2012 01:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qIuvNSmmNPjgyBtwIR+qIBkuVYY=; b=ODODDS
	LKfnGjAto50K3wY07lsYFBUsCpMCUVS518ajpBFd1PmRSkNehQnuYSYz5UoMOfp5
	uvJYuROewhn292n3oEfxFvBfAENnuKBZDEkXWuc8ddPRz9Fpqi3RWV+07BQuR8XM
	Ln1Y4B2UTyCaai1Z/xL6panVOMgWvSP0qBSCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvGTakz+otGRodywxEXGRIS/4BXewDGl
	QBH6U1mtekjgytb/JXZ8+jWFguoRBnP004d6v5fkbmVOALAXP4qnILAgUSSuCDu9
	0DT4n8a3RSgCpLbArw5AnskC7BjTndZxNi3Ac8iBaxDlTk0+RgNq9oTGOntZPBTP
	lNAdgynuIa8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB37D7994;
	Wed,  5 Sep 2012 01:52:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1829A7992; Wed,  5 Sep 2012
 01:52:30 -0400 (EDT)
In-Reply-To: <1346819164-8116-1-git-send-email-ktdreyer@ktdreyer.com> (Ken
 Dreyer's message of "Tue, 4 Sep 2012 22:26:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E122703E-F71D-11E1-BC17-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204798>

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

Thanks, will queue.

I think we also forbid tagnames (or branchnames for that matter)
that begin with a dash on the creation side, even though the reading
side tries to be lenient (i.e. if for some bad tool already created
a file .git/refs/tags/-foobar, we allow "git show tags/-foobar" to
show it).  The routines in refs.c enforces primarily on the reading
codepath.  So this part:

> +		# Tag cannot begin or end with '.'.
> +		$xtag =~ s/^\.+//;
> +		$xtag =~ s/\.+$//;

may need to become

	# Tag cannot begin with '.' or '-', or end with '.'.
	$xtag =~ s/^[-.]+//;
	$xtag =~ s/\.+$//;

or something.


>  git-cvsimport.perl | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 8d41610..0dc598d 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -889,7 +889,25 @@ sub commit {
>  		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
>  		$xtag =~ tr/_/\./ if ( $opt_u );
>  		$xtag =~ s/[\/]/$opt_s/g;
> -		$xtag =~ s/\[//g;
> +
> +		# See ref.c for these rules.
> +		# Tag cannot end with a '/' - this is already handled above.
> +		# Tag cannot contain bad chars. See bad_ref_char in ref.c.
> +		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
> +		# Tag cannot contain '..'.
> +		$xtag =~ s/\.\.//g;
> +		# Tag cannot contain '@{'.
> +		$xtag =~ s/\@{//g;
> +		# Tag cannot end with '.lock'.
> +		$xtag =~ s/(?:\.lock)+$//;
> +		# Tag cannot begin or end with '.'.
> +		$xtag =~ s/^\.+//;
> +		$xtag =~ s/\.+$//;
> +		# Tag cannot consist of a single '.' - already handled above.
> +		# Tag cannot be empty.
> +		if ($xtag eq '') {
> +			return;
> +		}
>  
>  		system('git' , 'tag', '-f', $xtag, $cid) == 0
>  			or die "Cannot create tag $xtag: $!\n";
