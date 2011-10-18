From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/2 (fixed)] Refactor Git::config_*
Date: Tue, 18 Oct 2011 12:52:06 -0700
Message-ID: <7vty76f57d.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <7vsjmrl4ur.fsf@alter.siamese.dyndns.org>
 <201110172347.42568.jnareb@gmail.com> <201110181147.02397.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 21:52:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGFhw-0000oh-2T
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 21:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab1JRTwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 15:52:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab1JRTwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 15:52:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA5E85984;
	Tue, 18 Oct 2011 15:52:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9CIuSp8wKgSEi761QWc5gMwAxmY=; b=vgZNsJ
	+jgybaoUDE9LJYUd1jQo1dBrzGmOBUStGffG0u34TKvau1HDFwSoMh3crKdgARTR
	MvlFPmQO6l5oZUf6wuWs59F0eYZDFugU9+pzoABB9Jf4bYguj/MAPDa4NEqCX+ry
	PVMFWp794N/eRojVY9n3zdYtKZ2/EDYcMIB1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QGGJ7KAksm0xokdAlSQPouCXY7PDsWZ9
	ytO2lSV3kdL+fqs3o3z1qX8RAkT1XGiqXQ5ZmyK2v9okgFzneI+G5Cqntc83SoWO
	DmHibFuKj/ihlXpYNtZespQhKDE/Vgnpdk8o4v4VLlznso9l6F9W8Xlvc8fs3Ji8
	avjo+7dVXzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1B6D5982;
	Tue, 18 Oct 2011 15:52:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 654115981; Tue, 18 Oct 2011
 15:52:08 -0400 (EDT)
In-Reply-To: <201110181147.02397.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 18 Oct 2011 11:47:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A986DE98-F9C2-11E0-952A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183899>

Jakub Narebski <jnareb@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> There is, especially with addition of Git::config_path(), much code
> repetition in the Git::config_* family of subroutines.
>
> Refactor common parts of Git::config(), Git::config_bool(),
> Git::config_int() and Git::config_path() into _config_common()
> helper method, reducing code duplication.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Jakub Narebski wrote:
>>
>> I'll resend amended commit.
>
> Here it is.

Well, this breaks t9001 and I ended up spending an hour and half figuring
out why. Admittedly, I was doing something else on the side, so it is not
like the whole 90 minutes is the billable hour for reviewing this patch,
but as far as the Git project is concerned, I didn't have any other branch
checked out in my working tree, so that whole time was what ended up
costing.

The real problem was here.

> @@ -609,25 +592,10 @@ This currently wraps command('config') so it is not so fast.
>  
>  sub config_bool {
>  	my ($self, $var) = _maybe_self(@_);
> -
> -	try {
> -		my @cmd = ('config', '--bool', '--get', $var);
> -		unshift @cmd, $self if $self;
> -		my $val = command_oneline(@cmd);
> -		return undef unless defined $val;
> -		return $val eq 'true';
> ...
> -	};
> +	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
> +	return (defined $val && $val eq 'true');
>  }

Can you spot the difference?

This is the reason why I do not particularly like a rewrite for the sake
of rewriting.
