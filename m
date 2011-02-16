From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch/checkout --track: Ensure that upstream branch is
 indeed a branch
Date: Wed, 16 Feb 2011 14:00:02 -0800
Message-ID: <7vwrkzhc7x.fsf@alter.siamese.dyndns.org>
References: <201102151852.03881.johan@herland.net>
 <7vfwrpnjxr.fsf@alter.siamese.dyndns.org>
 <201102161146.23749.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 23:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PppQe-0006Xl-Ck
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab1BPWAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 17:00:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab1BPWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 17:00:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 259B347AF;
	Wed, 16 Feb 2011 17:01:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3U5JJrqFdF6GoN/XT8Z4xl/QOw=; b=OAf+hr
	Ev/4xi7R3Al/g25sgHeJ7IXk2kJhlx+Am3tBOj5GiHfX22ZfGZQeZVfZCWvg4wf8
	JfStzRgOUe5LVDab1dQRYnVJe8FoJ40pcdbPEIu1Wp/YOKzJrKgwHUw6yD/OtBaF
	QCwQBVn3KsBBOrLHdyKs4uzkz5YVxRyw+zSnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RtuoMOaAJfNM+TDAYWYYu6UuHiGcO15O
	hohWzTB41d0QMBkgibFc572CVAzsBs53RkrE8EA0YlhwILANgCenmSlHfxrgTHTd
	FNoPAtMuTnvj+1Vxxcx4LxNF5OEA6i96Epae6YD/LEQbtlTYDxkqiW0kGWM2bLWA
	S/o8YPyItsg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0352F47A9;
	Wed, 16 Feb 2011 17:01:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 776294794; Wed, 16 Feb 2011
 17:01:11 -0500 (EST)
In-Reply-To: <201102161146.23749.johan@herland.net> (Johan Herland's message
 of "Wed\, 16 Feb 2011 11\:46\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46A08C6C-3A18-11E0-9558-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167010>

Johan Herland <johan@herland.net> writes:

> When creating a new branch using the --track option, we must make sure that
> we don't try to set an upstream that does not make sense to follow (using
> 'git pull') or update (using 'git push'). The current code checks against
> using HEAD as upstream (since tracking a symref doesn't make sense). However,
> tracking a tag doesn't make sense either. Indeed, tracking _any_ ref that is
> not a (local or remote) branch doesn't make sense, and should be disallowed.
>
> This patch achieves this by checking that the ref we're trying to --track
> resides within refs/heads/* or refs/remotes/*. This new check replaces the
> previous check against HEAD.
> ...
> Make it so.
>
> diff --git a/branch.c b/branch.c
> index 93dc866..f46a43a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -175,8 +175,10 @@ void create_branch(const char *head,
>  			die("Cannot setup tracking information; starting point is not a branch.");
>  		break;
>  	case 1:
> -		/* Unique completion -- good, only if it is a real ref */
> -		if (explicit_tracking && !strcmp(real_ref, "HEAD"))
> +		/* Unique completion -- good, only if it is a real branch */
> +		if (explicit_tracking &&
> +		    prefixcmp(real_ref, "refs/heads/") &&
> +		    prefixcmp(real_ref, "refs/remotes/"))
>  			die("Cannot setup tracking information; starting point is not a branch.");
>  		break;
>  	default:

Thomas's "HEAD" patch 84c1a89 (branch: do not attempt to track HEAD
implicitly, 2010-12-14) has an extra action to reset real_ref to NULL when
not asking for "explicit_tracking" in the same codepath.

<<<<<<< HEAD
		/* Unique completion -- good, only if it is a real ref */
		if (!strcmp(real_ref, "HEAD")) {
			if (explicit_tracking)
				die("Cannot setup tracking information; starting point is not a branch.");
			else
				real_ref = NULL;
		}
=======
		/* Unique completion -- good, only if it is a real branch */
		if (explicit_tracking &&
		    prefixcmp(real_ref, "refs/heads/") &&
		    prefixcmp(real_ref, "refs/remotes/"))
			die("Cannot setup tracking information; starting point is not a branch.");
>>>>>>> @{-1}

Don't we need something similar here?
