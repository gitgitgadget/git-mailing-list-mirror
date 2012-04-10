From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 09:45:46 -0700
Message-ID: <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeYg-0008Dp-GS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab2DJRIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:08:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab2DJRIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:08:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A52AF7024;
	Tue, 10 Apr 2012 13:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Zf0+XHAtKuKMu1pspO0P8gN9hkY=; b=qGJ53W5JyJmKjSLxobu/
	JaHCrSFVzrBdbD3Ao+9gZHL1Rp0reetjbqZiWqZDoR18u0aVaq3e1MVmUrOpROAJ
	01xWwZTBwNd2cepWVa+MivgkcrDiS2ll01wleC/0uX6xwne/NL0wgeGwnRjcvZGU
	8lYrBTRmsWHHgKaPqE//ZNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=moyKEVG/eIqVygR7wUTEEFvXs+F3P8E4fn4qRzEex220RA
	S7fl3/nmACQcfoK96sO+PH7LPHOHMeyzbWBhDww+d4rTbZoeKoqgZ4ynkgcSblaY
	RoEyva18nuyYZyHeCu49kXcAN7ju7X0O5d2rTD5t2SV2BeUeGJYHsYyh4mRlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AB387023;
	Tue, 10 Apr 2012 13:08:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E69577020; Tue, 10 Apr 2012
 13:08:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCBEDE1E-832F-11E1-82AA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195105>

Neil Horman <nhorman@tuxdriver.com> writes:

> git cherry-pick fails when picking a non-ff commit that is empty.  The advice
> given with the failure is that a git-commit --allow-empty should be issued to
> explicitly add the empty commit during the cherry pick.  This option allows a
> user to specify before hand that they want to keep the empty commit.  This
> eliminates the need to issue both a cherry pick and a commit operation.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> ---
>  Documentation/git-cherry-pick.txt |    9 +++++++++
>  builtin/commit.c                  |    6 +++---
>  builtin/revert.c                  |    2 ++
>  sequencer.c                       |    7 +++++--
>  sequencer.h                       |    1 +
>  5 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index fed5097..730237a 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -103,6 +103,15 @@ effect to your index in a row.
>  	cherry-pick'ed commit, then a fast forward to this commit will
>  	be performed.
>  
> +--allow-empty::
> +	By default, cherry-picking an empty commit will fail,
> +	indicating that an explicit invocation of `git commit
> +	--allow-empty` is required. This option overrides that
> +	behavior, allowing empty commits to be preserved automatically
> +	in a cherry-pick. Note that when "--ff" is in effect, empty
> +	commits that meet the "fast-forward" requirement will be kept
> +	even without this option.
> +
>  --strategy=<strategy>::
>  	Use the given merge strategy.  Should only be used once.
>  	See the MERGE STRATEGIES section in linkgit:git-merge[1]
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3714582..0cd10ab 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -56,10 +56,10 @@ N_("You asked to amend the most recent commit, but doing so would make\n"
>  "remove the commit entirely with \"git reset HEAD^\".\n");
>  
>  static const char empty_cherry_pick_advice[] =
> -N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\n"
> -"If you wish to commit it anyway, use:\n"
> +N_("The previous cherry-pick is empty.\n"
> +"If the commit was created empty, please use:\n"

After reading this three times, I have to say that the updated wording do
not look like an improvement for two reasons.

 (1) After a failed cherry-pick, the index can match the current HEAD for
     two reasons.  Either the original cherry-pick was attempting to pick
     an empty commit (which is likely to be a mistake unless you are doing
     something unusual like creating an empty commit in the first place),
     or the change in the original commit was already found in the current
     version (may be result of a conflict resolution).  The message before
     your change used "possibly" to hint this, and if the reader gets it,
     it is understandable why the reader is seeing this advise.  Updated
     message loses this information by simply saying "is empty".

 (2) The message is given by the "git commit" command.  "If the commit was
     created empty" looks confusing.  Even though I can understand that
     "the commit" refers to the original commit the user tried to
     cherry-pick before running this command while reviewing this patch, I
     suspect that the reader who sees this message may not be able to tell
     if the "git commit" command created a possibly empty commit and then
     telling the user to do something further on _that_ commit, or if it
     is referring to the commit the user tried to pick with the previous
     "git cherry-pick" command.

That is, unless you are making "git cherry-pick --allow-empty" not to stop
and leave it to "git commit" to clean it up.  If that were the case (which
is not, after applying this patch alone), then this message will be issued
only when a conflict resolution resulted in an empty commit, so "If the
commit you were trying to cherry-pick was empty to begin with" would not
apply, either.
