From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/4] reset: use "unpack_trees()" directly instead of
 "git read-tree"
Date: Thu, 31 Dec 2009 21:14:29 -0800
Message-ID: <7vtyv6o18q.fsf@alter.siamese.dyndns.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
 <20091230055448.4475.64716.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:15:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZqr-0000rO-Nb
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab0AAFO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 00:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813Ab0AAFO6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 00:14:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0AAFO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 00:14:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 228B78CCA6;
	Fri,  1 Jan 2010 00:14:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J3OXFI6wVvL5HsjMQZd3XSfN/Ig=; b=HVNhXk
	USknbLHewryHuEhRzrN+cnoz9CQHmSRBQaLgc3IRPvN0scQIX2ZPHe/fjsXI9nXf
	WStUf5C0VIVV0djNL/E6Xg16bWFclT4e+cwluo36Y2ICqXNkyhWjIQqmzzQW+3Sj
	gA6sYU/BXhSwsxzv4mxMiX2zyeJENRmEBYuak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpzViPInY5ueL+eCiXpHqXv0DLE9TZ1W
	8gnv/h3DXdVdpGa2jVo0TqIEnY9o004tq/MIJE9LM5hD4W1TdHwO0/Yxw8bxLBrI
	WX+uur9jwQfUrITTV/Gsea/GRPu8wZ3fFyuJpO2EyOqRCI8UrhMPnQbZUG/lDDX5
	DSNFxZEuKt0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64D618CCA4;
	Fri,  1 Jan 2010 00:14:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB5B48CCA3; Fri,  1 Jan
 2010 00:14:30 -0500 (EST)
In-Reply-To: <20091230055448.4475.64716.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed\, 30 Dec 2009 06\:54\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 921039A4-F694-11DE-BBC4-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135998>

Christian Couder <chriscool@tuxfamily.org> writes:

> But in 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01) there is
> the following:
>
> "
>      - if the index has unmerged entries, "--merge" will currently
>        simply refuse to reset ("you need to resolve your current index
>        first"). You'll need to use "--hard" or similar in this case.
>
>        This is sad, because normally a unmerged index means that the
>        working tree file should have matched the source tree, so the
>        correct action is likely to make --merge reset such a path to
>        the target (like --hard), regardless of dirty state in-tree or
>        in-index. But that's not how read-tree has ever worked, so..
> "
>
> So the new behavior looks better according to the original
> implementation of "git reset --merge".

This is not really an improvement..  You are swapping an breakage with a
different breakage of a riskier kind.

At least disallowing means that the user _is notified_ and has to manually
deal with the situation.  Pretending it succeeded by resetting only the
index while still leaving the conflicted state in the work tree intact is
a bit worse in that sense.

> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index c9044c9..b40999f 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -122,7 +122,7 @@ entries:
>         X       U     A    B     --soft  (disallowed)
>                                  --mixed  X       B     B
>                                  --hard   B       B     B
> -                                --merge (disallowed)
> +                                --merge  X       B     B

IOW, I think the result should be "B B B" instead of "X B B" in this
case.
