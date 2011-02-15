From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Tue, 15 Feb 2011 12:30:53 -0800
Message-ID: <7vzkpxm45e.fsf@alter.siamese.dyndns.org>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, <santi@agolina.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 21:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpRYF-0003Yf-Cs
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 21:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab1BOUbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 15:31:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab1BOUbE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 15:31:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BFE323BF3;
	Tue, 15 Feb 2011 15:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cwISLr3Z7RuyrtYtPSIbh0UngFo=; b=X9Uj/Y
	dZbnMGapjF0XWiYfVNEZm9FyFdLH3DYeS7KAhhBHvle1+eKxRDUTkzGRZbk+v3mZ
	lvIdoXIC6dJH0KEwRhWdXkMpa33VA3FF0C+VRZD4zS26GXXexBql/1WahqX5TcJA
	t0G+qqQ5V3xVAlwG+LXMFviThH/2WzPjCAjyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=piqCZHx4KBFhbFGETnzjhnSrdd28YVmf
	9BxnnGQEXZbxGPYYDmSRWnGR3hdPD17a6o/BPT4snb215bJAa7+Z1nkb7208GEUH
	c+tvcL4ZzfdSggsj+nSr7pP+GRR2DmcSPmsVXjmS5ViyH2Sl8e6c6bH/o2RQZGZ9
	roLHCCYklaU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E3F63BF0;
	Tue, 15 Feb 2011 15:32:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CEA63BEF; Tue, 15 Feb 2011
 15:32:02 -0500 (EST)
In-Reply-To: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Mon\, 14 Feb 2011 08\:51\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7B57412-3942-11E0-BC86-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166875>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5abfeac..1bc0c29 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -466,6 +466,19 @@ esac
>  
>  require_clean_work_tree "rebase" "Please commit or stash them."
>  
> +test -n "$upstream_name" && for reflog in \
> +	$(git rev-list -g $upstream_name 2>/dev/null)

Ugly.

	test -n "$upstream_name" &&
        for reflog in $(git rev-list ...)
        do
        	...
	done

Don't you need to make sure $upstream_name is a branch (or a ref in
general that can have a reflog), or does it not matter because the
"rev-list -g" will die without producing anything and you are discarding
the error message?

Now, a handful of random questions, none of them rhetorical, as I don't
know the answers to any of them.

Would it help if the code is made just as clever as the patch attempts to
be, when the user says

	git rebase origin/next~4

IOW, use the reflog of origin/next even in such a case?

> +do
> +	if test $reflog = $(git merge-base $reflog $orig_head)
> +	then
> +		if test $reflog != $(git merge-base $onto $reflog)
> +		then
> +			upstream=$reflog
> +		fi
> +		break
> +	fi

Do we always traverse down to the beginning of the reflog in the worst
case?  Would bisection help to avoid the cost?
