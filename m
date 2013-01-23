From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Tue, 22 Jan 2013 18:53:43 -0800
Message-ID: <7vbocgk3t4.fsf@alter.siamese.dyndns.org>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 <20130123023235.GA24135@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Barry Wardell <barry.wardell@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxqTX-0006mo-7m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab3AWCxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:53:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263Ab3AWCxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:53:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B9EDB4B4;
	Tue, 22 Jan 2013 21:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gubWuGjBfhlkdcyRooOfCAZScMI=; b=jLEA7F
	Fpw/PU9t1u89XN9Die/gJOJau5OE9I/UhVG5gwKUfHZUqd7UaJG4zol0hKITAv6+
	QzWkYJ9zabd9MIMKbfJsLzJk07Ogtls1vkMfUHIAD4m6F8BaNaLHVuiJ0vCEnY01
	eFdU5Tu5A0zX5RqS27DUPsu14AfxFS8pqmyUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzAOExhL25iGUAPwJdU68XY3dYiGNxSf
	rM4W5KZk9Cr3g5ffxp1vKvgRNA3o3C+EHbjC+RgzMA1mVuwP3Be0/8EFyJUn9BDc
	0ZFmcTxdSIT035RAAkc40Huqy95211Z3SvFduDIHl5qwk4w18aIZ2M8Sekqd03JE
	LMkmTqN/XO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80783B4B3;
	Tue, 22 Jan 2013 21:53:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0525BB4B2; Tue, 22 Jan 2013
 21:53:44 -0500 (EST)
In-Reply-To: <20130123023235.GA24135@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 23 Jan 2013 02:32:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A5271A8-6508-11E2-89BA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214276>

Eric Wong <normalperson@yhbt.net> writes:

> `git rev-parse --show-cdup` outputs nothing if GIT_DIR is set,
> so I unset GIT_DIR temporarily.
>
> I'm not sure why --show-cdup behaves like this, though..

Setting GIT_DIR is to say "That is the directory that has the
repository objects and refs; I am letting you know the location
explicitly because it does not have any relation with the location
of the working tree.  The $(cwd) is at the root of the working
tree".

If you want to say "That is the directory that has metainformation,
and that other one is the root of the working tree", you use
GIT_WORK_TREE to name the latter.

So by definition, if you only set GIT_DIR without setting
GIT_WORK_TREE, show-cdup must say "you are already at the top".

>
> Does squashing this on top of your changes fix all your failures?
> I plan on squashing both your changes together with the below:
>
> diff --git a/git-svn.perl b/git-svn.perl
> index c232798..e5bd292 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -332,11 +332,13 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>  		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
>  	} "Unable to find .git directory\n";
>  	my $cdup = undef;
> +	my $git_dir = delete $ENV{GIT_DIR};
>  	git_cmd_try {
>  		$cdup = command_oneline(qw/rev-parse --show-cdup/);
>  		chomp $cdup if ($cdup);
>  		$cdup = "." unless ($cdup && length $cdup);
> -	} "Already at toplevel, but $ENV{GIT_DIR} not found\n";
> +	} "Already at toplevel, but $git_dir not found\n";
> +	$ENV{GIT_DIR} = $git_dir;
>  	chdir $cdup or die "Unable to chdir up to '$cdup'\n";
>  	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
>  }
