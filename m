From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] completion: work around zsh option propagation
 bug
Date: Fri, 03 Feb 2012 12:23:02 -0800
Message-ID: <7v1uqbpsyh.fsf@alter.siamese.dyndns.org>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
 <1328214625-3576-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:23:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtPf6-0001AJ-MX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 21:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab2BCUXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 15:23:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab2BCUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 15:23:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A266D87;
	Fri,  3 Feb 2012 15:23:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sxHGMHkfCg2XeupVIY2Fi7aPEyM=; b=m8ABgquxF+q6KpeY2pRf
	bT0cZcl5FAFnjn+Dv1q3pIwfnVGBH5wcTYi+xoXukA54Y1K1s3ltNrR7JHWI10pg
	6JTOX+gCFeK9ecn82yfPmjD9vS6TR1sdgcgz0bxu1XckGnIQVJFolz42Hc2dCotK
	q6RbLrg3+ZRI9cAGdSv68hA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PZPAenEFAaBBX2MkBPzcRoACMSzp9sJQj7+fE1WB6HTukL
	M4YDHxVhUwzYWgAG2OeNBrdhpt+xtb0BLTimrT2QFLEtTpNYgxTVtO1Wh12RNaUn
	rLIeNtcWnFTxdwwlQRRk5Q49ZmKVG3zRbXCXi06TnxxhMCR15K0vgqIyi3hLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860AF6D86;
	Fri,  3 Feb 2012 15:23:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFF856D85; Fri,  3 Feb 2012
 15:23:03 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E01B1604-4EA4-11E1-81A3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189797>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Right now when listing commands in zsh (git <TAB><TAB>), all of them
> will show up, instead of only porcelain ones.

Jonathan's rewrite goes straight to the root cause instead, which is
another way to describe the problem.

Explaining user-visible symptoms at the beginning like you did is a good
strategy that I would want to see more contributors follow, though.

> Basically, in zsh, this:
>
>  for i in $__git_all_commands
>
> Should be:
>
>  for i in ${=__git_all_commands}
>
> Otherwise there's no word-splitting expansion (unless SH_WORD_SPLIT is
> set). sh emulation should take care of that, but the subshell is messing
> up with that. So __git_list_porcelain_commands does not do any
> filtering.

Let me step back a bit and see if we are on the same page wrt the root
cause of the problem and for whom we are explaining the change.

The adaptation of the bash completion script to zsh is done by asking zsh
to obey POSIXy word splitting rules to honor $IFS that is in effect when
the words are split.  However zsh does not do a good job at it in some
cases, and your patch works it around by avoiding a construct known to be
troublesome to zsh.

Am I correct so far?  If so, especially if the first sentence of the above
paragraph is correct, then how would it help others to teach "this is the
right way to do a word-split if we were writing in native zsh" when we are
not?

While it probably is a good description to have in a bug report given to
zsh folks, it is useless for people who read the history of Git.  Unless
you are writing zsh-native completion script and this patch is not about
git-completion.bash, that is.

The readers need to read the solution described in order to understand why
the updated construct is written in an unnatural (to people who write to
POSIXy shells) way, or to avoid reintroducing a similar problem elsewhere
in the future.  I find that what Jonathan gave you helps them much better:

	...
        fn () {
                var='one two'
                printf '%s\n' $var
        }
        x=$(fn)
        : ${y=$(fn)}

    printing "$x" results in two lines as expected, but printing "$y" results
    in a single line because $var is expanded as a single word when evaluating
    fn to compute y.

    So avoid the construct, and use an explicit 'test -n "$foo" || foo=$(bar)'
    instead.

So I'll take the first two lines of the message (good bits), and simplify
the "This fixes a bug tht caused..." from the last paragraph (or perhaps
even drop it).

Thanks.
