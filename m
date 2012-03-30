From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-commit-am: Allow automatic rebasing to preserve
 empty commits
Date: Fri, 30 Mar 2012 13:47:56 -0700
Message-ID: <7v8vihlssj.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-4-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:48:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiju-00019L-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933811Ab2C3UsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:48:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933072Ab2C3Ur7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274414232;
	Fri, 30 Mar 2012 16:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pJhcblEuUXItSD5+KvNjvohKaqA=; b=TMXFEK
	vfgjoQhHiXWjBbk/3KQE2b1BtV4eNe4FLcB61n2PU8F8bHPiNkb6PpjRJnVMaWDx
	VUT2dcJeMqRtBjelvfYKOPakAhVzxYMkfLbVMaHhTtzbO51c7N1fziX3bChEGQlO
	rewJGAQXWyg8hLU/6qYppkqoGtJ+nTVuoCYrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gqnzHLxN8poF9e0gwGtMEU/3Nliq9tN9
	Q6FmDuMHYFu9bco4GcE0f16bXi5ySTQKVtH02jRKzRhh6zM0xf0plMiiML65mb+E
	8SPz/DpNRGG2IVVzVv50wwEDlGVAbcr02qQywOHqjtVgfhNfn3GJ+DwwuL8owXKy
	aLXHIBCkGOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EAF74231;
	Fri, 30 Mar 2012 16:47:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A560422F; Fri, 30 Mar 2012
 16:47:58 -0400 (EDT)
In-Reply-To: <1333136922-12872-4-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Fri, 30 Mar 2012 15:48:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2141D20-7AA9-11E1-97BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194407>

Neil Horman <nhorman@tuxdriver.com> writes:

> Using the keep_empy environment variable, this change allows git-commit-am to
> apply empty commits to the new branch we are rebasing to
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Jeff King <peff@peff.net>
> CC: Phil Hord <phil.hord@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>
> ---
>  git-rebase--am.sh |   20 +++++++++++++++-----
>  1 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index c815a24..c1d1b60 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -20,11 +20,21 @@ esac
>  
>  test -n "$rebase_root" && root_flag=--root
>  
> -git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> -	--src-prefix=a/ --dst-prefix=b/ \
> -	--no-renames $root_flag "$revisions" |
> -git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
> -move_to_original_branch
> +if [ -n "$keep_empty" ]
> +then
> +	# we have to do this the hard way.  git format-patch completly squashes
> +	# empty commits and even if it didn't the format doesn't really lend
> +	# itself well to recording empty patches.  fortunately, cherry-pick
> +	# makes this easy
> +	git cherry-pick --keep-empty "$revisions" && move_to_original_branch

Does cherry-pick know the "--ignore-if-in-upstream" trick?  Otherwise I
suspect that this will introduce a severe regression to the command, as
the commits that are already in the new base you are rebasing to will all
be kept as empty commits, no?

> +else
> +	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> +		--src-prefix=a/ --dst-prefix=b/ \
> +		--no-renames $root_flag "$revisions" |
> +	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
> +	move_to_original_branch
> +fi
> +
>  ret=$?
>  test 0 != $ret -a -d "$state_dir" && write_basic_state
>  exit $ret
