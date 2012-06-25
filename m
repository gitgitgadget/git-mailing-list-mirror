From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Sun, 24 Jun 2012 22:47:04 -0700
Message-ID: <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj28n-0006Sx-CA
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 07:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab2FYFrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 01:47:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab2FYFrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 01:47:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 654743FD6;
	Mon, 25 Jun 2012 01:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crNgiF4kOZHoV8T/6DAsSUBXlpw=; b=MrSNI8
	PjzhNhp8SKCEdz5tS4vSaIQEQu3VA7XaJ7Dm82EI1Su6ZCWMqD8kebA9TScXDE78
	DWFr7rqWyY1Wl6Vo5UXqyuaJxaCsGn3GnjEXWUowyY706E9hoVmxcerb4NrS4m31
	KYpTXj57xCqjeVPLlGiXl9oDtOdBOKALZwhgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tJJMOE+cHAMpSySp7MWd2kJWpAFGNaOh
	OB7dzXgTobLUuRNTU/wxFMuCdz/Qu+mK5f82tH+iD3wI+D184yfPRx6Bp4SV/Ryn
	dCkdbZkuxPsOkIcZXvpRKo8WfGBwtPxPOFaiSPmpWlOIqvxP3Ig3FRqc0LlK3cdw
	4KR27e28JeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CDCA3FD5;
	Mon, 25 Jun 2012 01:47:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2B5F3FD4; Mon, 25 Jun 2012
 01:47:05 -0400 (EDT)
In-Reply-To: <20120624220835.GA4762@beczulka> (Marcin Owsiany's message of
 "Sun, 24 Jun 2012 23:08:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 322C8578-BE89-11E1-8939-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200548>

Marcin Owsiany <marcin@owsiany.pl> writes:

> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..90f3d06 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
>  	}
>  
>  	my $valid_head = verify_ref('HEAD^0');
> +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
> +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;
>  	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
>  	return if ($valid_head || !verify_ref('HEAD^0'));

This looks like a typical XY solution.  What are you really trying
to validate?  "HEAD" points at an existing branch and you do not
care what branch it is?  HEAD may not even point at a valid branch
but can be detached as long as it happens to point at a commit that
is at the tip of some branch (hence building further commit on HEAD
will break the condition you are checking in the above code)?
