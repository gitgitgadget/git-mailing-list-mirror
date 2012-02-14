From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] submodules: always use a relative path from
 gitdir to work tree
Date: Tue, 14 Feb 2012 12:24:19 -0800
Message-ID: <7v4nut6u4s.fsf@alter.siamese.dyndns.org>
References: <4F32F252.7050105@web.de> <4F32F465.7090401@web.de>
 <4F338156.9090507@web.de> <7vlio6ec7q.fsf@alter.siamese.dyndns.org>
 <4F3A9B98.6040908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOvK-0007BE-WB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760635Ab2BNUYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:24:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757144Ab2BNUYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:24:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A76727A12;
	Tue, 14 Feb 2012 15:24:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4xheLDHFaJO33FEvXDQucp69ZMg=; b=qQa5WD
	E8Fr1NgvNoUbGvazTm4cBNHCdJzCT5d0BoNK10FOuvWRS2/Nda7UoNrnVu2VcIuW
	20r+B2iwEDUV7Kf/TasvnVrxeS27eU0OcYIWVun10vpjUc5W+hZ1JZL2qQ2wK0Zm
	NXBtYohPM2rp5jsRcLHrZ56VVjv/07AxyVGWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KxsL+zhHgiP1Mbz/RuprnPqtZ9QETFEi
	MEISnhpPf2PoaWebmQCn+EvdxcbE2bbxnk1J5Vl2o+NT8eKRIMDo2zre0Myx5nAg
	TdVxgfyxUKdtCrBrx91lpFwXiXIrhd7gr3L83ocjhf5mHBwVgTjhoxMPU8I6B0Gy
	wk5I7TiGgoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0AA7A0D;
	Tue, 14 Feb 2012 15:24:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 337D37A0B; Tue, 14 Feb 2012
 15:24:21 -0500 (EST)
In-Reply-To: <4F3A9B98.6040908@web.de> (Jens Lehmann's message of "Tue, 14
 Feb 2012 18:36:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0B82AAE-5749-11E1-B407-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190748>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> After adding a comment, using test instead of [], testing both $a and
> $b and assigning each variable on it's own line I get the following
> interdiff. Does that make more sense?

My earlier request for comment was to say

	# $a is always longer than $b for such and such reasons

to explain why testing $b without testing $a was sufficient.

It is obvious (at least to me) that the loop continues as long as $a and
$b begin with the same string before their first '/' and removes that
common segment from both of them, so I do not think the new comment is
absolutely necessary, but it would not hurt to have it, especially it is
short enough and to the point.

Thanks.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3463d6d..ed76ce2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -172,9 +172,11 @@ module_clone()
>
>         a=$(cd "$gitdir" && pwd)
>         b=$(cd "$path" && pwd)
> -       while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
> +       # Remove all common leading directories
> +       while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
>         do
> -               a=${a#*/} b=${b#*/};
> +               a=${a#*/}
> +               b=${b#*/}
>         done
>         rel=$(echo $a | sed -e 's|[^/]*|..|g')
>         (clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")
