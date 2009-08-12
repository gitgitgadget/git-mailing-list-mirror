From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: bad revision 'HEAD'
Date: Wed, 12 Aug 2009 00:37:44 -0700
Message-ID: <7v7hx98otz.fsf@alter.siamese.dyndns.org>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
 <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Mahoney <joelmahoney@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:38:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb8Pn-0000Jy-Kt
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbZHLHiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 03:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbZHLHiW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:38:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbZHLHiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 03:38:21 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6177727;
	Wed, 12 Aug 2009 03:38:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48FEC7726; Wed, 12 Aug
 2009 03:38:11 -0400 (EDT)
In-Reply-To: <20090812032740.GA26089@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 11 Aug 2009 23\:27\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C8F22B2-8713-11DE-A32E-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125676>

Jeff King <peff@peff.net> writes:

> I was able to replicate your problem, but only if I set
> branch.master.rebase to "true" in my user-wide git config (i.e.,
> ~/.gitconfig). It looks like "git pull" is not capable of handling a
> rebase when you have no commits yet.

It does sound sick to store such a setting in $HOME/.gitconfig file, when
the variable is clearly per-repository.  As you wrote, you can easily
trigger it with an explicit --rebase, but again, it is insane to ask
"rebase" when you clearly do not have anything.

But just like we twisted the definition of merge to mean "merging
something into nothing yields that something", we could twist the
definition of rebase to mean "rebasing nothing on top of something result
in that something".  It sort of makes sense in a twisted way.

> diff --git a/git-pull.sh b/git-pull.sh
> index 0f24182..427b5c6 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -119,9 +119,15 @@ error_on_no_merge_candidates () {
>  }
>  
>  test true = "$rebase" && {
> +	if git rev-parse -q --verify HEAD >/dev/null; then
> +		parent_tree=HEAD
> +	else # empty tree
> +		parent_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +	fi
> +
>  	git update-index --ignore-submodules --refresh &&
>  	git diff-files --ignore-submodules --quiet &&
> -	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
> +	git diff-index --ignore-submodules --cached --quiet $parent_tree -- ||
>  	die "refusing to pull with rebase: your working tree is not up-to-date"

Two comments.

 * Is "rev-parse -q --verify" a safe test to guarantee that HEAD is
   unborn?  Shouldn't we be checking with "symbolic-ref" or something?

 * In such an "unborn branch" case, by definition, a non-empty index won't
   be based on whatever we are pulling down from the remote.  So how about
   doing something like the following instead?

	if on unborn branch
	then
		if test -f "$GIT_DIR/index"
                then
			die "refusing to update; you have a non-empty index"
		fi
	else
		... existing tests against HEAD ...
	fi
