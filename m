From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Corrects an Abort Trap: 6 error with completions.
Date: Mon, 08 Jul 2013 10:32:59 -0700
Message-ID: <7vwqp1yn1w.fsf@alter.siamese.dyndns.org>
References: <5FF738AB-DA01-4460-9ADF-D960E2FD6309@7stalks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>, spearce@spearce.org
To: Steven Klass <sklass@7stalks.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 19:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwFJF-0004yo-0y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 19:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3GHRdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 13:33:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab3GHRdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 13:33:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DFC82EEC8;
	Mon,  8 Jul 2013 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QrXDgN7g+urUf3IBv9yGK/+GQ6Q=; b=MoegHt
	5PieZBVhra4GzhrFn67IDuxSS+atwpzGJR3af371O5p3HN44m7bzCi/TFlDBihKJ
	tAGKto0jSzt+IykuDNSDTV0b7mW30orIiYupLBqd6iuaRWUc1+51IWZieZXR3SUj
	jWnC36epSYbjxOU9tkAt6a4HCuZHts6q0tpGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QUMIBtSj2CCJ2yO9EVwOjAGiKEXkMOAC
	8UWpD5a41SwdqRkoOxU/pxICLeJ+EwPzZd5OPPnfTR5yXzF+7BX+oh0j6u6pwcYb
	DNf3pPzIaM/hf/c55ki7xtnSmguNtSug67aS/FsRcxk1aYogSO/5d1crGNPC60ou
	GNPC+F/YOoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 517B42EEC7;
	Mon,  8 Jul 2013 17:33:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EEB2EEC1;
	Mon,  8 Jul 2013 17:33:00 +0000 (UTC)
In-Reply-To: <5FF738AB-DA01-4460-9ADF-D960E2FD6309@7stalks.com> (Steven
	Klass's message of "Mon, 8 Jul 2013 06:58:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FAF1E98-E7F4-11E2-BD22-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229879>

Steven Klass <sklass@7stalks.com> writes:

> Hi Folks,
>
> 	Corrects an Abort Trap: 6 error with completions.
> 	Fixed an issue where the two commands on a single line  would cause a strange unrelated 'Abort trap: 6' error on  non-git commands on Mac OSX 10.8.
>
> Signed-off-by: Steven Klass <sklass@7stalks.com>

Can you explain how/why the original causes "abort trap: 6"
(whatever it is) and how/why the updated one avoids it in the log
message?

It also is not quite clear when the error happens.  Do you mean, by
"non-git commands", something like:

    $ ca<TAB>

does not complete to "cal", "case", "cat", etc. and instead breaks
the shell?

I am confused.  The only change I can see in the patch is that it
makes the argument to this call to the __gitcomp shell function be a
string with tokens separated by LF and HT and no SP (the original
assumes that the tokens will be split by LF, HT or SP, and the shell
function locally sets $IFS to make sure that the change in this
patch does not make any difference).  And in many other places in
the same script, the __gitcomp shell function is called with an
argument with LF, HT or SP spearated tokens, e.g.

    _git_add ()
    {
            case "$cur" in
            --*)
                    __gitcomp "
                            --interactive --refresh --patch --update --dry-run
                            --ignore-errors --intent-to-add
                            "
                    return
            esac



>
> ---
>  contrib/completion/git-completion.bash | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 contrib/completion/git-completion.bash
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> old mode 100644
> new mode 100755
> index 6c3bafe..d63b1ba
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2165,7 +2165,8 @@ _git_config ()
>            user.name
>            user.signingkey
>            web.browser
> -          branch. remote.
> +          branch.
> +          remote.
>       "
>  }
>
> ---
>
> Steven Klass
>
> (480) 225-1112
> sklass@7stalks.com
> http://www.7stalks.com
