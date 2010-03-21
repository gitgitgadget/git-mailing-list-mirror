From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use -q instead of redirect to /dev/null for git
 update-index
Date: Sun, 21 Mar 2010 06:17:17 -0700
Message-ID: <7vy6hlvmoy.fsf@alter.siamese.dyndns.org>
References: <1269168827-18694-1-git-send-email-romain@peerfuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Romain Bignon <romain@peerfuse.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 14:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtL29-0001pD-Q0
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 14:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0CUNR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 09:17:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0CUNR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 09:17:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 098BFA3B60;
	Sun, 21 Mar 2010 09:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mNlln4HKgDa9ufDEGsaCgIW+e64=; b=pgizn+
	2Zrp2X31E0qo51GNSQDYSkuNl6e+LRkQdlCcHiRq6ABPnYBN0yjiWkEFBXdJQ14n
	2YNk0OxpFSS5xLhnJYcnKS9Ua1/QCS8FnSkXISPfPY/aPUMT4VGZibLoclTUpx42
	q0CBRvud+AskSLm3q0ltur1twuEA2PBIkt3dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAuRQk+dzEk1tXjHXaX03uUDnwdlU1Bu
	n2jXKcrNDcMvj8ToL3uZNeDOwvDr4FMdeKozFhBfnqP5RgI9XGA4Tg4cDgI6t/ZF
	786Pfr3Sljdr5026tx0gQEvrIMCTAcdWXC8SLXpEhAlcpfeoYaS9JU11V33J//Hc
	qBgwxx67fCM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5C35A3B5F;
	Sun, 21 Mar 2010 09:17:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21AB6A3B5D; Sun, 21 Mar
 2010 09:17:19 -0400 (EDT)
In-Reply-To: <1269168827-18694-1-git-send-email-romain@peerfuse.org> (Romain
 Bignon's message of "Sun\, 21 Mar 2010 11\:53\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15489F1A-34EC-11DF-A64B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142824>

Romain Bignon <romain@peerfuse.org> writes:

> Signed-off-by: Romain Bignon <romain@peerfuse.org>
> ---
> ...
> diff --git a/git-rebase.sh b/git-rebase.sh
> index fb4fef7..c814c30 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -389,7 +389,7 @@ else
>  fi
>  
>  # The tree must be really really clean.
> -if ! git update-index --ignore-submodules --refresh > /dev/null; then
> +if ! git update-index --ignore-submodules --refresh -q; then
>  	echo >&2 "cannot rebase: you have unstaged changes"
>  	git diff-files --name-status -r --ignore-submodules -- >&2

I don't think this is quite "identical" conversion, if that is what you
were aiming at.  But it is not even clear why you wanted to do this patch;
it is not justified with any proposed commit log message.

The original is written in such a way that you won't see any output, not
just for the "needs-update" entries, but also not for the "needs-merge"
entries; "-q" traditionally never squelched the output for the latter
kind.

Maybe in some other codepath, it might be the correct thing not to squelch
the "needs-merge" message, but because we run diff-files to show them in
the error codepath, redirecting everything to /dev/null is the right thing
to do in this particular case.

Because the patch wasn't accompanied by any explanation to justify why
this change is necessary or desirable, it forced me to study and read
through the history to come up with the two paragraph analysis above,
costing 30 minutes of my time, only to reject it.

Even if this _were_ a correct conversion, we are not gaining much (what's
the point of removing the perfectly-well-working discard-to-null?).

The above can be said to other "/dev/null to -q" patches we saw on the
list recently.  The saddest part of the story is that, the review cost
(not necessarily spent by me, but time spent by other people reviewing
patches is precious) is paid only to prevent a breakage like this patch
tries to introduce from getting accepted, without much potential reward.
Even if some of those patches turn out to be harmless, the only thing we
would have bought with the cost of reviewing is that we made sure that the
system would continue to work as before, but that is what we could have
easily done by not even looking at the patches at all.

Sadly, the cost-to-reward tradeoff is simply not worth it, unless the
patch is accompanied by necessary homework to reduce the review load.
