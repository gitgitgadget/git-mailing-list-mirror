From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
 completion
Date: Sun, 13 Jul 2008 14:38:37 -0700
Message-ID: <7vskudpiqq.fsf@gitster.siamese.dyndns.org>
References: <20080713111847.29801.8969.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9IG-0004Et-Rm
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbYGMVip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbYGMVip
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:38:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYGMVio (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:38:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 739C52EF59;
	Sun, 13 Jul 2008 17:38:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A11A32EF58; Sun, 13 Jul 2008 17:38:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10DD90C8-5124-11DD-9452-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88345>

Petr Baudis <pasky@suse.cz> writes:

> When Git sees a string with trailing dot on a place where revision
> range could occur, it will unconditionally append another dot to
> it to help complete a revision range. However, filespec can usually
> occur at such a place as well. I have been hitting this all the time
> lately with
>
> 	git log git-submodule.<tab>
>
> and the like.

Modulo s/Git/bash-completion/ ;-) I think this makes sense.

> This patch will make Git perform the . -> .. completion in
> __git_complete_revlist only if there is no filename starting with
> the entered prefix available.  At few places, filename could not occur
> when calling __git_complete_revlist; however, taking this into account
> did not seem worth complicating the code further.

Theoretically we could take a hint from presense of '--' like d773c63
(bash: offer only paths after '--', 2008-07-08) did.  If the command line
has double-dash and the token we are looking at is before it, it cannot be
pathname and this check does not have to trigger.  But I agree that is not
worth it, because this "theoretical" solution would mean that the user
needs to something awkward like:

	git log v1.5.6. --<C-b><C-b><C-b><TAB>

to take advantage of it.

By the way, the above command line is another "dot" related frustration I
always have.  If you try:

	git log v1.5.6.<TAB>

the completion code adds a dot unconditionally when I want to choose from
the list of v1.5.6.X tags.  Of course, I can work this around by dropping
the last dot before asking for completion, so it is not really a very big
deal, but I mention it here because this annoyance is exactly in the same
league as your "git-submodule.<TAB>" example.

"git show v1.5.6.<TAB>" does complete as expected, which is understandable
(the command does not take range, and completion knows about it -- which
is quite nice).

>  contrib/completion/git-completion.bash |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 61581fe..fe24b8c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -325,7 +325,12 @@ __git_complete_revlist ()
>  		__gitcomp "$(__git_refs)" "$pfx" "$cur"
>  		;;
>  	*.)
> -		__gitcomp "$cur."
> +		if ls "$cur"* >/dev/null 2>&1; then

There is a slight Yuck factor for using "ls" here but I do not think of a
better alternative offhand.

Will queue on top of Shawn's previous one.  Thanks.
