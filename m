From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Teach the --no-ff option to 'rebase -i'.
Date: Wed, 24 Mar 2010 12:06:54 -0700
Message-ID: <7vfx3pilo1.fsf@alter.siamese.dyndns.org>
References: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
 <1269445261-2941-3-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 20:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVvM-00051d-Th
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 20:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab0CXTHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 15:07:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab0CXTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 15:07:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44D89A4454;
	Wed, 24 Mar 2010 15:07:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vJMDffOd4BOcG+SHHR3fkqRf5ZQ=; b=PDDIAH
	Uwq0SDAp2Rvig4SKRbgWjkCAL85R0TY5BXV7lvkLibSiFFZG2qM5CR2bu4/CAGXo
	ynMWMSZUAqVfpTChgRsxsaThcfT9l1ONIRVdozG+ut8NTrEh6ihhcSQdAlCz5YJN
	D2uBJkLrv3cMUsOave+nV48PDyFSHy2+1gVgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJn0T0g4IPpiI5drvEpSAIPTAeRVIBUe
	BGT0ojivnKmd6aoJ+ykqc63inKB8dCPHED7LGYracib2Sz6QEeMUX/YLI7pBTRrS
	OrrJMvM6WUsm971kMWN4Sf+EGoqH/w0uIwa/URPFsJ8ZMhNScF0PmXf3zbBIxUi4
	T0+uOoNHoZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF5F2A4450;
	Wed, 24 Mar 2010 15:07:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D588CA444D; Wed, 24 Mar
 2010 15:06:55 -0400 (EDT)
In-Reply-To: <1269445261-2941-3-git-send-email-marcnarc@xiplink.com> (Marc
 Branchaud's message of "Wed\, 24 Mar 2010 11\:41\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D071590-3778-11DF-9C67-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143106>

Marc Branchaud <marcnarc@xiplink.com> writes:

> This option tells git-rebase--interactive to cherry-pick all the commits in
> the rebased branch, instead of fast-forwarding over any unchanged commits.

Thanks.

> +Sometimes you're in a situation like this
> +
> + P---o---o---M---x---x---W---x
> +  \         /
> +   A---B---C
> +
> +where W is the reversion of merge M and you:
> +
> + - Need to rewrite one of the commits on the A-B-C branch; and
> +
> + - Want the rewritten A-B-C branch to still start at commit P (perhaps P
> +   is a branching-off point for yet another branch, and you want be able to
> +   merge A-B-C into both branches).
> +
> +The natural thing to do in this case is to checkout the A-B-C branch and use
> +"rebase -i A" to change commit B.  However, this does not rewrite commit A,
> +and you end up with this:
> +
> + P---o---o---M---x---x---W---x
> +  \         /
> +   A---B---C   <-- old branch
> +   \
> +    B'---C'    <-- rewritten branch
> +
> +To merge A-B'-C' into the mainline branch you would still have to first revert
> +commit W in order to pick up the changes in A, but then it's likely that the
> +changes in B' will conflict with the original B changes re-introduced by the
> +reversion of W.

I find it somewhat a contrived and unconvincing explanation.  A moderately
intelligent reader would wonder "Why did you choose to 'rebase -i A' in
the first place?  if you did 'rebase -i P' instead, you didn't have to
suffer from this issue, no?", and you are not answering that question.

Two things that you are assuming but not telling the user to make this
explanation appear unsatisfactory are:

 - The true reason you reverted M turns out to be that B was bad, and A
   was fine, so you want to fix B in A-B-C and merge it to master; and

 - Because "rebase -i" by default fast-forwards earlier "pick", even
   "rebase -i P" wouldn't have given you a rewritten A.

If you spell these out, then the explanation starts to make sense.

> +However, you can avoid these problems if you recreate the entire branch,
> +including commit A:
> +
> + P---o---o---M---x---x---W---x
> + |\         /
> + | A---B---C   <-- old branch
> + \
> +  A'---B'---C' <-- entirely recreated branch

This is just an advice on drawing, but you can avoid this ugly picture by
starting your discussion with:

      A---B---C
     /         \
    P---o---o---M---x---x---W---x

and adding the reproduction like this:

      A---B---C
     /         \
    P---o---o---M---x---x---W---x
     \
      A'--B'--C'

> +But if you don't actually need to change commit A, then you need some way to
> +recreate it as a new commit with the same changes in it.  The rebase commmand's
> +two modes (interactive and non-interactive) provide options to do this.  With
> +"rebase -i" use the --no-ff option:
> +
> +    $ git rebase -i --no-ff P
> +
> +With plain "rebase" use the -f option:
> +
> +    $ git rebase -f P

This is exactly why I don't mind giving a --no-ff synonym for --force to
non-interactive rebase.  That would make the choice between -i and no -i
made by the reader solely depend on the need to change anything in the
commits.  If you are fixing B in A-B-C, you would use "rebase -i".  If
instead you queued a fix-up as D, like so:

      A---B---C-------------------D
     /         \
    P---o---o---M---x---x---W---x

then you can rebase non-interactively the whole thing in preparation for
another merge:

      A---B---C---D
     /         \
    P---o---o---M---x---x---W---x...*
     \                             /
      A'--B'--C'------------------D'
