From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Thu, 26 Jul 2012 22:18:07 -0700
Message-ID: <7vobn13hps.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-2-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sucwf-0002oZ-Jh
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 07:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab2G0FS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 01:18:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab2G0FSL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 01:18:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1237F67F2;
	Fri, 27 Jul 2012 01:18:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=6wYLzGfrksdNz+slRnmClYtGlTs=; b=Sg2PG1p6juPvDaO5LWdl
	xRDAdlIkubrHUwVDhxrdPAdaWwEF6p2Beo6C7MTIluiBM2wivKW8zfEWK5xofZ+a
	jAcKXaErGd1MOWKIoSUKumV9MyywzPUq0n4VDsZUI8hXISX5B05BCg4XB1z1cAdT
	VhTtiR6HZOnXe69UUQeaFtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AgGpJ82SK0wqx4LGHNvxmBBBWX27tlXlqA+eLlOoGghlCY
	HyMg2tb3AxXYhxmC8BX/H0eT9jFWok/vEzQFCFpflcdjHcSPlPfuQj/kR67T4zuw
	sMBI2eQYezIf0+UoocLw5FeCrVmm4erHoBW1zdgdoDnHMvCZzikEc8aelU6zo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0080167F1;
	Fri, 27 Jul 2012 01:18:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 537BF67EF; Fri, 27 Jul 2012
 01:18:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 744E1400-D7AA-11E1-878A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202334>

"Michael G. Schwern" <schwern@pobox.com> writes:

> From: "Michael G. Schwern" <schwern@pobox.com>
>
> Put them in a new module called Git::SVN::Utils.  Yeah, not terribly
> original and it will be a dumping ground.  But its better than having
> them in the main git-svn program.  At least they can be documented
> and tested.
>
> * fatal() is used by many classes.
> * Change the $can_compress lexical into a function.
>
> This should be enough to extract Git::SVN.
>
> Signed-off-by: Michael G. Schwern <schwern@pobox.com>
> ---

Looks good.

> diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
> new file mode 100644
> index 0000000..3d0bfa4
> --- /dev/null
> +++ b/perl/Git/SVN/Utils.pm
> @@ -0,0 +1,59 @@
> ...
> +=head1 FUNCTIONS
> +
> +All functions can be imported only on request.
> +
> +=head3 fatal
> +
> +    fatal(@message);
> +
> +Display a message and exit with a fatal error code.
> +
> +=cut
> +
> +# Note: not certain why this is in use instead of die.  Probably because
> +# the exit code of die is 255?  Doesn't appear to be used consistently.
> +sub fatal (@) { print STDERR "@_\n"; exit 1 }

Very true.  Also I do not think the line-noise prototype buys us
anything (other than making the code look mysterious to non Perl
programmers); we are not emulating any Perl's builtin with this
function, and I do not see a reason why we want to force list
context to its arguments, either.  But removal of it is not part of
this step anyway, so I wouldn't complain.

> +=head3 can_compress
> +
> +    my $can_compress = can_compress;
> +
> +Returns true if Compress::Zlib is available, false otherwise.
> +
> +=cut
> +
> +my $can_compress;
> +sub can_compress {
> +    return $can_compress if defined $can_compress;
> +
> +    return $can_compress = eval { require Compress::Zlib; } ? 1 : 0;
> +}

The original said "eval { require Compress::Zlib; 1; }"; presumably,
when require does succeed, the value inside is the "1;" that has to
be at the end of Compress::Zlib, so the difference should not matter.
