From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Sun, 01 Mar 2009 23:34:54 -0800
Message-ID: <7vwsb85qe9.fsf@gitster.siamese.dyndns.org>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 08:36:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2hU-0005m9-KS
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbZCBHfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 02:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbZCBHfE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 02:35:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZCBHfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 02:35:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BF5DE2BA6;
	Mon,  2 Mar 2009 02:35:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D289E2BA5; Mon, 
 2 Mar 2009 02:34:55 -0500 (EST)
In-Reply-To: <1235924234-16923-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sun, 1 Mar 2009 11:17:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A33A8A96-06FC-11DE-BF2D-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111907>

Jay Soffian <jaysoffian@gmail.com> writes:

> send-email violates the principle of least surprise by automatically
> cc'ing additional recipients without confirming this with the user.
>
> This patch teaches send-email a --confirm option. It takes the
> following values:
>
>  --confirm=always   always confirm before sending
>  --confirm=never    never confirm before sending
>  --confirm=cc       confirm before sending when send-email has
>                     automatically added addresses from the patch to
>                     the Cc list
>  --confirm=compose  confirm before sending the first message when
>                     using --compose. (Needed to maintain backwards
>                     compatibility with existing behavior.)
>  --confirm=auto     'cc' + 'compose'
>
> The option defaults to 'compose' if any suppress Cc related options have
> been used, otherwise it defaults to 'auto'.
>
> Unfortunately, it is impossible to introduce this patch such that it
> helps new users without potentially upsetting some existing users. We
> attempt to mitigate the latter by:
>
>  * Allowing the user to "git config sendemail.config never"
>  * Allowing the user to say "all" after the first prompt to not be
>    prompted on remaining emails during the same invocation.
>  * Telling the user about the "sendemail.confirm" setting whenever they
>    use "all"
>  * Only prompting if no --suppress related options have been passed, as
>    using such an option is likely to indicate an experienced send-email
>    user.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Other than that the "sendemail.config never" is probably a typo, I think
this is the best you (or anybody) could do at this moment, unless we take
the route to introduce an "improved and different command", which I
actually am slightly in favor.

In any case, with the lesson I learned from the post v1.6.0 fiasco, it
might make sense to make the command louder when it needs to look at the
setting of $confirm option and when the user does not have anything in the
config nor command line.

What I mean is this.

In this codepath,

> +	$needs_confirm = (
> +		$confirm eq "always" or
> +		($confirm =~ /^(?:auto|cc)$/ && @cc) or
> +		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
> +

if @cc is not empty, or $compose is true, you _need to know_ what the user
wants to happen, and you need to look at $confirm to decide (otherwise the
value of $confirm does not matter).  In such a case, if the repository is
unconfigured with a sendemail.confirm configuration and the there was no
explicit --confirm from the command line, you do not know what the user
wants.  Instead of silently assuming 'auto' to confirm and potentially
annoying the users with this new extra step, the command could also say
"by the way, if you do not want to see this message, you can squelch it by
'git config sendemail.confirm never'" when it defaults to 'auto'.

The command could also refuse to work in such a case and instead explain
what the user's choices are, and instruct "say 'git config
sendemail.confirm auto' if you are not sure" or something like that, but I
think for this particular new option it is a bit overkill and I wouldn't
suggest going that far.
