From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Tue, 21 May 2013 09:52:38 -0700
Message-ID: <7vppwkp961.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<1369132915-25657-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:52:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uepnu-0001Iz-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab3EUQwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:52:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060Ab3EUQwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:52:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73A1B1EB0A;
	Tue, 21 May 2013 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PzMP3vf6uMbFjhz6mlC0n+9xuek=; b=t0SGvv
	ayGBdn6ULMtUteCLRI1ATEO8x8sYe9LSaoW46R0zWRZKQb9Pg02ww0CdRoThCkGg
	YpinmWJkGKNwKrmiuk8DxgWj/Rlsg7Ihk4ZWTDViAXbAnc6H+jRuxXHKtQd7s7KO
	9nUxL5UOhaI2WPbCeYF3meK3ys7Ostitp+BlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IbFwSmNBDDfE/Z2TnnozWHKSf+NMA/Pp
	6pFYx8dyseBsXgIGRtpKKsiYTIo5kuDnQUPUHsLUESdUybGP+MEDwLHnId7YTjCu
	BwT0ncX1hCoKhLk2kO55hc+F4/KqEoqALQS/L8QX6h8ixGkwmZyEwn/6vNOy7W+y
	qast0mI+/Z0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2DD1EB09;
	Tue, 21 May 2013 16:52:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB2011EB03;
	Tue, 21 May 2013 16:52:42 +0000 (UTC)
In-Reply-To: <1369132915-25657-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 21 May 2013 16:11:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAB37B5A-C236-11E2-86A6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225042>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, when we try to resolve @{<N>} or @{<date>} when the reflog
> for the current branch doesn't go back far enough, we get errors like:
>
>   $ git show @{10000}
>   fatal: Log for '' only has 7 entries.
>
>   $ git show @{10000.days.ago}
>   warning: Log for '' only goes back to Tue, 21 May 2013 14:14:45 +0530.
>   ...
>
> The empty string '' looks ugly and inconsistent with the output of
> <branch>@{<N>}.  Replace it with the string 'current branch'.

Wouldn't that be '*the* current branch'?

More importantly, doesn't "real_ref" have the name of the branch?

Suppose the user said "git show @{10000}" instead of "git show
master@{10000}" while on 'master'.

It could be argued that it may look nicer to say "your current
branch does not have enough update history" instead of saying
"master does not..." (i.e. different input to ask for the same
thing, different output depending on the way the user asked).  It
also could be argued that they should produce the same diagnosis
that is more informative.

I am slightly leaning toward the latter.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  sha1_name.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 416a673..683b4bd 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -517,6 +517,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  		}
>  		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
>  				&co_time, &co_tz, &co_cnt)) {
> +			if (!len) {
> +				str = "current branch";
> +				len = strlen("current branch");
> +			}
>  			if (at_time)
>  				warning("Log for '%.*s' only goes "
>  					"back to %s.", len, str,
