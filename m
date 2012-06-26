From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 12:20:22 -0700
Message-ID: <7vtxxxc22x.fsf@alter.siamese.dyndns.org>
References: <20120626133339.GT9682@arachsys.com>
 <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjbJO-0003mJ-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab2FZTU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:20:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab2FZTU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 15:20:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B08939B;
	Tue, 26 Jun 2012 15:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bRRY0cwXo7iSMOvyRF3dqtLlmgw=; b=F06j+f
	DL51Kcdy9YehhQ+Kvwr5ulP8Sjbn4ek4rgFw5o7ZW1QASUD5yKkzmRyioL/TmDqU
	F799LG48+krYWX15VUcA90ddqOq+d413wtuHqw4fNG2FI/Ez5vqCeGLgHtVmqW+1
	eSPVGnAt2qyJTtGXFCgOBniCbGtw1TAAWi6bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ra6DnsNMsSJpa19CHwGjZ//5GZBTYJgn
	aCd2rbk9pnFZdbijo+d3elu+4h6HNgezdLcd+PmB8t8TkKrYzGNG6S0iGy9u+NXw
	l2EI0tR1Q+Biw422i6u86NRDMrZ2QSngASYW1+h9bb6ZcQ7R5WVI2Fy08OrX8gje
	N9Zo64fbKWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E5E6939A;
	Tue, 26 Jun 2012 15:20:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 677479399; Tue, 26 Jun 2012
 15:20:24 -0400 (EDT)
In-Reply-To: <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
 (Chris Webb's message of "Tue, 26 Jun 2012 14:36:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAC1902E-BFC3-11E1-80F0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200673>

Chris Webb <chris@arachsys.com> writes:

> +do_pick () {
> +	if test "$(git rev-parse HEAD)" = "$squash_onto"

The idea to create a sentinel root upfront and special case it here
is a good one.

> +	then

I am not quite sure what is going on in this "then" clause.

> +		git commit --allow-empty --allow-empty-message --amend \
> +			   --no-post-rewrite -n -q -C $1 &&

At this point, nobody touched the empty sentinel root yet; you
rewrite its log message and authorship using the picked commit.

> +			pick_one -n $1 &&

And then you create a new commit that records the update "$1" does
relative to its parent (this hopefully only contains additions -- is
it sensible to die-with-patch if it doesn't?), making sure that it
does not fast-forward.  Does this always make the result a root commit?
If "$1" has parents, wouldn't it become a child of the commits its
parents were rewritten to (if any) in pick_one_preserving_merges()
that is called from pick_one?

> +			git commit --allow-empty --allow-empty-message \
> +				   --amend --no-post-rewrite -n -q -C $1 ||

And then you rewrite the log and authorship of that one.

In short, my questions are:

 (1) what is the purpose of the first "commit --amend" to update the
     sentinel root commit?

 (2) Is the purpose of "pick_one -n" done here to create a root
     commit?  Does it always do so correctly?

> diff --git a/git-rebase.sh b/git-rebase.sh
> index e616737..bde2be8 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -31,7 +31,7 @@ SUBDIRECTORY_OK=Yes
>  OPTIONS_KEEPDASHDASH=
>  OPTIONS_SPEC="\
>  git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
> -git rebase [-i] [options] --onto <newbase> --root [<branch>]
> +git rebase [-i] [options] [--onto <newbase>] --root [<branch>]
>  git-rebase [-i] --continue | --abort | --skip
>  --
>   Available options are
> @@ -364,6 +364,11 @@ and run me again.  I am stopping in case you still have something
>  valuable there.'
>  fi
>  
> +if test -n "$rebase_root" && test -z "$onto"
> +then
> +	test -z "$interactive_rebase" && interactive_rebase=implied
> +fi
> +

This makes "git rebase --root" without $onto imply "-i", which makes
sense, but it was a bit unexpected (it wasn't in the proposed log
message).
