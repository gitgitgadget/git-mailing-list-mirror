From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: Squelch the "fatal: Not an error." message
Date: Fri, 26 Mar 2010 12:25:13 -0700
Message-ID: <7vy6helwbq.fsf@alter.siamese.dyndns.org>
References: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFA3-0007BL-0P
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab0CZTZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:25:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab0CZTZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:25:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E11D5A515B;
	Fri, 26 Mar 2010 15:25:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n9/YcrvKzPGS/YEPDf44Jzs3n3c=; b=j9vBp1
	pck7NhDT2nHIFHJVtTEFk2FxEhl9Pw1AcDVIENLRMXE9A68Kr/fyU5HZ/CWaYa2U
	rrT3847zar8vvF6cfVCG1FmZihNFJgO0YvdxuirGlP25Qjkq0+OaVUHbkMA1fB8J
	uL/HKx/i2+QkukzfJaem1wESzLHKeQdpMM42U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NlU+6GCkQvGQNzIyFTKnTzeLOqMhEM6B
	wQrGFrgZ1AIRDWIZZ38yUTiJqtCSkqJtvng3cKiytefdknxfAgofg0zKgjLJMlx1
	NNqYt3/O2Av2bhU3z8u2iSU8UQk89qOblKJxOTnoclUVghcV2J6NA3395XMlIBrN
	urtUmtliSwc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B37A5159;
	Fri, 26 Mar 2010 15:25:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BC5DA5156; Fri, 26 Mar
 2010 15:25:15 -0400 (EDT)
In-Reply-To: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org> (Kevin Ballard's
 message of "Tue\, 23 Mar 2010 17\:03\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FF82A16-390D-11DF-9901-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143265>

Kevin Ballard <kevin@sb.org> writes:

> ... The error itself is
> actually caused by running `git rebase --onto newbase upstream` where
> upstream is the same commit as HEAD. This causes `git format-patch` to
> be called with "upstream..upstream" as the range and it complains. My
> solution was to squelch all errors from `git format-patch`, though I am
> unsure if the "fatal: Not a range." error is the only error that can be
> raised in this situation.

Hmm, since "git format-patch HEAD" simply exits with success, I am
inclined to think that we should fix "format-patch HEAD..HEAD" to do the
same instead.  I didn't check how involved such a change might be,
though.

>
> git-rebase.sh |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index e0eb956..8868dee 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -544,7 +544,7 @@ fi
>  if test -z "$do_merge"
>  then
>  	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> -		$root_flag "$revisions" |
> +		$root_flag "$revisions" 2>/dev/null |
>  	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
>  	move_to_original_branch
>  	ret=$?
