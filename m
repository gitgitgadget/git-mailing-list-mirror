From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: document usage via OPTIONS_SPEC
Date: Tue, 26 Feb 2008 13:23:11 -0800
Message-ID: <7v4pbv4dkw.fsf@gitster.siamese.dyndns.org>
References: <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
 <1204058554-74593-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7HU-0001pv-L5
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbYBZVXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbYBZVXc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:23:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYBZVXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 16:23:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F40DC1FDD;
	Tue, 26 Feb 2008 16:23:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BA1A11FDA; Tue, 26 Feb 2008 16:23:23 -0500 (EST)
In-Reply-To: <1204058554-74593-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue, 26 Feb 2008 15:42:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75175>

Jay Soffian <jaysoffian@gmail.com> writes:

>  * There is one semantic change. You can't use "-s=<strategy>" anymore. That's not
>    really proper usage of a short option (it's either "-s<strategy>" or 
>    "-s <strategy>"). Is it okay to not accept the "-s=<strategy>" form?

Well, with my maintainer hat on, I must resist _any_ change ;-).
Personally I would not mind this.  It is a borderline between
regression and making the option parameters more consistent.

>  * Is it worth doing this at all? If the plan is to rewrite everything as
>    builtins I kinda feel like I'm wasting my time.

If a contributor feels wasting his time, what should reviewers
feel reviewing such patches ;-)?

>  * You can see I added the GIT_PULL_DEBUG_ARGS blob. Frankly, I can't really
>    think of a good way to test this change other than to do
>    something like that and then add a test for each individual option.

I see this would be useful while you are developing.  But the
testsuite is meant to check the behaviour that is externally
observable.  It does not matter if you change the way you
internally represent --verbose option from settting $verbose to
resetting $quiet, but tests based on GIT_PULL_DEBUG_ARGS would
notice the difference in the implementation detail, so I do not
see much point leaving this in; it would not be useful for test
scripts, I suspect.

> +git pull [options] [<repo>] [<refspec>]
> +--
> +  fetch options
> +q,quiet          make the fetch process less verbose
> +v,verbose        make the fetch process more verbose
> +a,append         append to FETCH_HEAD instead of overwritting
> +upload-pack=,    specify path to git-fetch-pack on remote end
> +f,force          force local branch to be updated by remote branch
> +t,tags           fetch all remote tags

While it is technically correct that you _can_ feed any option
meant for git-fetch to this command, some options do not make
any sense in the context of git-pull, and we should not
advertise them, or better yet, actively reject them if you can.

I think --tags is one of them.

>  . git-sh-setup
>  set_reflog_action "pull $*"
>  require_work_tree
> @@ -23,46 +49,33 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
>  while :
>  do
>  	case "$1" in
> ...
>  		;;
>  	*)
>  		# Pass thru anything that may be meant for fetch.
>		break

Because the loop breaks here, the option description above
should mention that options meant for fetch should come after
all the options you want to give to git-pull itself.  For
example, I do not think "git pull -q -s stupid $there $that" is
meant to work.

A better long-term alternative would be to lift that restriction.

I do not recall offhand but does the parse-options reorder the
options in any way?  If that is the case, it makes the above not
a long-term thing but a must-be-done in a patch that starts to
use parse-options.
