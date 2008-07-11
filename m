From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Display error output from git-checkout
 when detaching HEAD fails.
Date: Fri, 11 Jul 2008 15:57:25 -0700
Message-ID: <7vr6a0hvvu.fsf@gitster.siamese.dyndns.org>
References: <1215811619-28512-1-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHRZN-0000xf-Gd
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYGKW5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYGKW5c
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:57:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYGKW5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:57:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 24B54298ED;
	Fri, 11 Jul 2008 18:57:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B339298EC; Fri, 11 Jul 2008 18:57:27 -0400 (EDT)
In-Reply-To: <1215811619-28512-1-git-send-email-robertshearman@gmail.com>
 (Robert Shearman's message of "Fri, 11 Jul 2008 22:26:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD5BABFC-4F9C-11DD-B5FA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88195>

Robert Shearman <robertshearman@gmail.com> writes:

> The "git checkout" command executed could fail if, for example, upstream contains a file that would overrwrite a local, untracked file. The output redirection didn't work as stderr was redirected to /dev/null, as was stdout. This appears to be not what was intended so the order of redirections is fixed so that stderr is redirected to stdout instead.

Very long lines, lacks sign-off.

> ---
>  git-rebase.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index e2d85ee..0da2210 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -376,7 +376,7 @@ fi
>  
>  # Detach HEAD and reset the tree
>  echo "First, rewinding head to replay your work on top of it..."
> -git checkout "$onto^0" >/dev/null 2>&1 ||

I think this very much is done deliberately by somebody who knows the
shell to discard everything.

> +git checkout "$onto^0" 2>&1 >/dev/null ||

And if it is beneficial to show the error, you just do not touch fd #2,
like this:

	git checkout "$onto^0" >/dev/null

As I do not see any reason to send the error message to stdout like you
did.

I also suspect that this part of the script predates 6124aee (add a quiet
option to git-checkout, 2007-02-01) where the command learned to be more
quiet during the normal operation.  Perhaps you can replace the line with

	git checkout -q "$onto^0"

and be done with it.  I haven't tested it, though.
