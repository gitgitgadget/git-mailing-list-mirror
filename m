From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7800-difftool.sh failure on pu
Date: Thu, 29 Mar 2012 14:26:40 -0700
Message-ID: <7v7gy3qesv.fsf@alter.siamese.dyndns.org>
References: <4F74A604.3040402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tim.henigan@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:26:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDMrq-0002uI-2S
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 23:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933853Ab2C2V0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 17:26:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933323Ab2C2V0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 17:26:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 066E47E66;
	Thu, 29 Mar 2012 17:26:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CjkCUMQozj0rOvUHTvMAuUob0uI=; b=uu2Co6
	XQr0PJyGf1gCwPQa7v78rOnFBZ8keaqwsNt7tl9zgsAySwzbP7UclgoJRdoM/ODe
	4/8MztXJTxC1sc3xbXT6h1aTEplyKLScI6R1XVGwe+6Ap0cemvx2/1D2vKFkeQDD
	vdnv5fRoAm+HgopRV/72n6LaBy6FVGDHEBVr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qtx39FjvTyaFYuLp0UvX35m09CO3UxmW
	rHv8cfteysbabPA3sSkZR8KCkXQFlexFtWOmBWIHX97Jfkf6EsNTqmZJMpzXHmdh
	+e1/qpFz6FJWG/WAVBzfPQZTItE7CschmrVcBQJ5DQT3UtR2/uDqfTc1VBfu8pBV
	PT7NmiY1M9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F165C7E65;
	Thu, 29 Mar 2012 17:26:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 870E17E63; Thu, 29 Mar 2012
 17:26:41 -0400 (EDT)
In-Reply-To: <4F74A604.3040402@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Thu, 29 Mar 2012 19:12:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0500F0A-79E5-11E1-9638-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194296>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Hi Tim,
>
> With the current pu branch, I have t7800.3 (difftool ignores bad --tool values)
> failing on Linux (I haven't tried cygwin or mingw yet). The failure is caused
> by the test for the value of the exit code; for me the exit code is 9 not 1.
>
> I have investigated, briefly, and found *two* alternatives for a fix. ;-)
>
> The first option is to (effectively) revert commit 0440ed72 ("difftool: replace
> system call with Git::command_noisy", 22-03-2012), like so:
>
> -- >8 --
> diff --git a/git-difftool.perl b/git-difftool.perl
> index e1754ff..49613b1 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -237,5 +237,7 @@ if (defined($dirdiff)) {
>  
>  	$ENV{GIT_PAGER} = '';
>  	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
> -	git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
> +	my @command = ('git', 'diff', @ARGV);
> +	my $rc = system(@command);
> +	exit($rc | ($rc >> 8));
>  }
> -- 8< --

I would prefer this, regardless of the issue.

I actually recall asking Tim about the exit status when I reviewed this
change.
