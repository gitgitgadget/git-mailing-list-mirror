From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] tree-walk: micro-optimization in
 tree_entry_interesting
Date: Sun, 03 Apr 2011 11:55:40 -0700
Message-ID: <7vaag7dv0z.fsf@alter.siamese.dyndns.org>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
 <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 20:56:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6SSs-0001KX-5n
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 20:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab1DCSzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 14:55:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab1DCSzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 14:55:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54199401F;
	Sun,  3 Apr 2011 14:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=krFphD2mUPGxMKg+704xmXClPe4=; b=dVewXBegxuV6Q4Iqywea
	Uq9Vatg6O13QeZxKYgyrkVhxEJ4w63IjZzLRAtZTq+HY/Gfo+M89rvmDPYc7eF08
	8WaSC7xbaYZsSb/sBNDdeV+rgW8UM0ivvYfTGJL5ZqFj73cYYzzZ2AUc3Qn3dD7U
	0WQrM35kj0JsSmHMV04C4Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XkPWCv4y0hGdDeRsgc/ScGU00lQJfavtpayK7ti7WdySnr
	c6vI9K9i3+DgDTytgSyTH+IXlnrxxsI+2dCu8QATwGZjZpkK9qpHXgpXTW/Lp4Ho
	4li1W8M85JvMI+9jocZfctUKxwkCMC97lrHCGIdWTwLFjiq/DJA2Q4uyVeDek=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31E30401E;
	Sun,  3 Apr 2011 14:57:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 327894019; Sun,  3 Apr 2011
 14:57:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DD95FD4-5E24-11E0-9732-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170768>

Dan McGee <dpmcgee@gmail.com> writes:

> In the case of a wide breadth top-level tree (~2400 entries, all trees
> in this case), we can see a noticeable cost in the profiler calling
> strncmp() here. Most of the time we are at the base level of the
> repository, so base is "" and baselen == 0, which means we will always
> test true. Break out this one tiny case so we can short circuit the
> strncmp() call.

This sounds as if the patch helps only when you have a superfat tree at
the "top-level" of the project, but wouldn't this benefit any superfat
tree at _any_ level while we recursively descend into it?

> This resulted in an ~11% improvement (43 to 38 secs) for a reasonable
> log operation on the Arch Linux Packages SVN clone repository, which
> contained 117220 commits and the aforementioned 2400 top-level objects:
>     git log -- autogen/trunk pacman/trunk/ wget/trunk/
>
> Negligible slowdown was noted with other repositories (e.g. linux-2.6).

It would have been easier to swallow if the last sentence were "This could
lead to a slowdown in repositories without directories that are too wide,
but in practice it was not even measurable."  "Negligible" sounds as if it
had still measurable downside, and as if you decided that the slowdown can
be ignored---but obviously you are not an unbiased judge.

There is nothing wrong in the patch per-se, but I really wish we didn't
have to do this; it feels like the compiler should be helping us in this
case.

> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
>  tree-walk.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 9be8007..f386151 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -591,8 +591,8 @@ int tree_entry_interesting(const struct name_entry *entry,
>  					      ps->max_depth);
>  		}
>  
> -		/* Does the base match? */
> -		if (!strncmp(base_str, match, baselen)) {
> +		/* Either there must be no base, or the base must match. */
> +		if (baselen == 0 || !strncmp(base_str, match, baselen)) {
>  			if (match_entry(entry, pathlen,
>  					match + baselen, matchlen - baselen,
>  					&never_interesting))
