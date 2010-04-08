From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: return the entered branch if more branches
 are at the same commit
Date: Wed, 07 Apr 2010 18:45:46 -0700
Message-ID: <7vvdc290ol.fsf@alter.siamese.dyndns.org>
References: <1270678956.27317.34.camel@neo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Lars.Jarnbo.Pedersen@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 08 03:46:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzgoi-00046M-Vj
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 03:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab0DHBpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 21:45:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab0DHBpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 21:45:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3717A9336;
	Wed,  7 Apr 2010 21:45:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=SQtBOqXm2DU8OlmsJaxmYhSJmQg=; b=A8X04e
	wYNUA9r1/KpRcHq0mEb8ZEsIktJhlzkNy/3sxw9QlSeBxsd2OhAVGsq4bQUL+43X
	7FYUXThH42gRZobFOany/GBo/vEFl7Ye5Zqm6Ak/imEgIVGm/hPrhp7JAEvyT6a/
	E4C+sxeDBOTXQ/e1bOT9w597feA7hK+gpotOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E7zn7mTUV8YgElZw1yNTv2xECd8gmKfe
	yjSPlIhFPXva7UifjLhQAC50JDeoYfD78UavQlnk6eamTBGq6xHAKGUuhUi7NY/n
	MPuIGcdUtgUABoQ4LW7iulkR6LLTcSSePIDbasXIPSz2AvzxY3sd+Nczd/qDE2DD
	jiVXVeZR/pg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8054DA9334;
	Wed,  7 Apr 2010 21:45:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72D2FA932C; Wed,  7 Apr
 2010 21:45:47 -0400 (EDT)
In-Reply-To: <1270678956.27317.34.camel@neo> (Lars Jarnbo Pedersen's message
 of "Thu\, 08 Apr 2010 00\:22\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75F2EEA2-42B0-11DF-B14A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144300>

Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com> writes:

>  git-request-pull.sh |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 8fd15f6..787383f 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -49,11 +49,21 @@ merge_base=`git merge-base $baserev $headrev` ||
>  die "fatal: No commits in common between $base and $head"
>  
>  branch=$(git ls-remote "$url" \
> +	| sed -n -e "/^$headrev	refs.heads.$head/{

Isn't $head often omitted, defaulting to HEAD?

Since the original version of this logic was written, git has changed a
lot, not in an incompatible way, but simply it got a lot richer.  Some
assumptions the script made when it was written may need to be revisited,
working backwards from the command line to see what we can compute better
and how.

    $ git request-pull [options] start url [end]

When "end" is specified, and if that is the name of a branch, we know what
branch you are talking about.  We can dereference HEAD with symbolic-ref
if "end" was missing and we defaulted to HEAD.  Either way, in majority of
the cases, the user has pushed out the tip of a local branch and that is
what "end" would be.

But that "end" branch may not necessarily be the name of the branch your
publishing repository has.  By looking at configured refspec mapping and
the push.default configuration, we can tell which remote ref a push to the
url should have updated.  The script predates many configurations that
control this process, and that is the primary reason it currently guesses
from ls-remote output.

You are introducing something better than a guess, but it is not quite
there, I suspect.  Who says that your branch 'my/topic' will push to your
published branch 'my/topic', not 'topic' with "push = my/topic:topic", or
"branch.my/topic.merge = topic", for example?

We can take one step at a time, and your patch might be a good first step
in the right direction, but I think overhauling this script to be more
aware of the ref mapping is worth discussing before moving forward.  After
such a discussion, it may turn out that majority of people do:

    $ git push $my_public_repo master~3:for-linus

and say "git request-pull origin master~3", in which case the current
program output is already correct and the new code may not be adding much
value in practice.
