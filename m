From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-rebase--interactive: auto amend only edited
 commit
Date: Mon, 08 Sep 2008 17:33:22 -0700
Message-ID: <7viqt6cg4t.fsf@gitster.siamese.dyndns.org>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com>
 <1220906569-26878-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 02:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcrCB-0000nC-PW
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 02:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYIIAdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 20:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbYIIAdc
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 20:33:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbYIIAdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 20:33:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3654079216;
	Mon,  8 Sep 2008 20:33:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B61E79215; Mon,  8 Sep 2008 20:33:25 -0400 (EDT)
In-Reply-To: <1220906569-26878-2-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Tue, 9 Sep 2008 00:42:49 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED984E90-7E06-11DD-A8B3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95322>

I may not be reading your patch correctly; I am confused by what you are
trying to do.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5b2b1e5..84721c9 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -284,7 +284,7 @@ do_next () {
>  		pick_one $sha1 ||
>  			die_with_patch $sha1 "Could not apply $sha1... $rest"
>  		make_patch $sha1
> -		: > "$DOTEST"/amend
> +		echo $sha1 > "$DOTEST"/amend

You record the $sha1 from the TODO file.  If you are editing the first one
in the insn sequence, that is also the same as HEAD (i.e. the commit you
are telling the user to modify with "commit --amend").  If you already
have edited earlier ones, it is not the value of HEAD at this point.

>  		warn "Stopped at $sha1... $rest"
>  		warn "You can amend the commit now, with"
>  		warn
> @@ -430,6 +430,8 @@ do
>  			if test -f "$DOTEST"/amend
>  			then
>  				amend=$(git rev-parse --verify HEAD)
> +				test "$amend" = $(cat "$DOTEST"/amend) ||
> +				die "You have uncommitted changes"

And then you complain if HEAD, after running "commit --amend", is
not the value you recorded above.

>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"
>  			fi

If the first commit was marked as "edit", then the value you recorded in
"$DOTEST/amend" was the HEAD, the commit the user was told to modify with
"commit --amend".  $DOTEST/amend being the same as HEAD here would be a
sign that the user staged changes but hasn't done "commit --amend".

But if we think about the second and subsequent commits that are marked as
"edit" in TODO file, the value recorded in "$DOTEST/amend" would not be
the value of HEAD at this point, and whether "commit --amend" has been run
or not, the value of HEAD is very likely to be different from that value
(unless the user said "reset --hard $that_one").  Wouldn't this test
almost always complain for them?

Perhaps you wanted to record the value of the HEAD in the first hunk?

How would this change interact with the workflow of splitting existing
commits, described at the end of git-rebase documentation?
