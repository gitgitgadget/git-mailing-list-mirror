From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: delay term initialization
Date: Mon, 15 Sep 2014 11:00:24 -0700
Message-ID: <xmqqbnqg932f.fsf@gitster.dls.corp.google.com>
References: <1410681849-3107-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTaZl-0007Xo-J5
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbaIOSAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:00:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59287 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbaIOSA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:00:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E12F83ABE4;
	Mon, 15 Sep 2014 14:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7LREG5+zojNaiGhh1db4Tb7c1xw=; b=LyKnQb
	phDWF6xgWzf7CRMseMDhNPAVcjiB8pwthBkkzaiJ+xHiqE1+sVzSaUtXcqTzPpsY
	pCDFtzM4/gVTeyYmq0NpWEJ8WYBKjDUKPsyIF6PPDVYxCOE5fQHOjdsQi+8+1XMH
	9RMUZBRwWGVvx4qldOYSAu2wPR+7XKEESWVwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVZZb/2SlmIQXtwO3mXgcISqFCnPBOHy
	/zSG+fH0XhJOpuxCezfDPvCO7sN7nipG6dgDYG5vaHsBTfjzRsFsCY8MNfBjh8p8
	Yr8DukLfEQTK3xCH49aW+YEcFGexH/jylHx8gE9buA3UWaGy1LWvvBP0ScUTPiN7
	bIXrfSZlpt4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A96B3ABE3;
	Mon, 15 Sep 2014 14:00:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77EBD3ABDD;
	Mon, 15 Sep 2014 14:00:26 -0400 (EDT)
In-Reply-To: <1410681849-3107-1-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Sun, 14 Sep 2014 08:04:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2BFA4678-3D02-11E4-B282-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257059>

Eric Wong <normalperson@yhbt.net> writes:

> On my Debian 7 system, this gives annoying warnings when the output
> of "git svn" commands are redirected:
>
>     Unable to get Terminal Size. The TIOCGWINSZ ioctl didn't work.
>     The COLUMNS and LINES environment variables didn't work. The
>     resize program didn't work.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  Also, manually tested to ensure dcommit --interactive works.

Makes sense.

>
>  git-svn.perl | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 40565cd..ce0d7e1 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -306,13 +306,16 @@ sub readline {
>  }
>  package main;
>  
> -my $term = eval {
> -	$ENV{"GIT_SVN_NOTTY"}
> -		? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
> -		: new Term::ReadLine 'git-svn';
> -};
> -if ($@) {
> -	$term = new FakeTerm "$@: going non-interactive";
> +my $term;
> +sub term_init {
> +	$term = eval {
> +		$ENV{"GIT_SVN_NOTTY"}
> +			? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
> +			: new Term::ReadLine 'git-svn';
> +	};
> +	if ($@) {
> +		$term = new FakeTerm "$@: going non-interactive";
> +	}
>  }
>  
>  my $cmd;
> @@ -424,6 +427,7 @@ sub ask {
>  	my $default = $arg{default};
>  	my $resp;
>  	my $i = 0;
> +	term_init() unless $term;
>  
>  	if ( !( defined($term->IN)
>              && defined( fileno($term->IN) )
