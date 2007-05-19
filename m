From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix crlf attribute handling to match documentation
Date: Fri, 18 May 2007 17:02:35 -0700
Message-ID: <7v646p4r50.fsf@assigned-by-dhcp.cox.net>
References: <200705181333.32719.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCPU-0001Mk-LH
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXESACh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbXESACh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:02:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44101 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXESACh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:02:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519000236.LWCT22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 20:02:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0o2b1X00E1kojtg0000000; Fri, 18 May 2007 20:02:36 -0400
In-Reply-To: <200705181333.32719.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 18 May 2007 13:33:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47684>

Andy Parkins <andyparkins@gmail.com> writes:

> gitattributes.txt says, of the crlf attribute:
>
>  Set::
>     Setting the `crlf` attribute on a path is meant to mark
>     the path as a "text" file.  'core.autocrlf' conversion
>     takes place without guessing the content type by
>     inspection.
>
> That is to say that the crlf attribute does not force the file to have
> CRLF line endings, instead it removes the autocrlf guesswork and forces
> the file to be treated as text.  Then, whatever line ending is defined
> by the autocrlf setting is applied.

Thanks; I looked at the patch (although I am still _physically_
at work ;-).  I think your code is correct but the explanation
is slightly misleading.

> However, that is not what convert.c was doing.  The conversion to CRLF
> was being skipped in crlf_to_worktree() when the following condition was
> true:
>
>  action == CRLF_GUESS && auto_crlf <= 0

The check you modified in the first hunk is not the above '<='
comparison but is this:

	(action == CRLF_GUESS && !auto_crlf)

and "core.autocrlf = input" makes "auto_crlf = -1", so when
action is not GUESS, or even when action is GUESS, if the config
is set to "input", the if() statement you patched in the first
hunk should not trigger.  The above description is different from
what the code was doing.

The logic (in crlf_to_git, which is the input codepath) should be:

	* if action is BINARY, do nothing (obviously -- and the
          code gets this right).

	* if action is GUESS, do nothing if config says false
          (we want 'input' and 'true' to apply the munging after
          guessing).

	* if action is TEXT or INPUT, do not guess but do CRLF
          only on platforms that need it -- which means where
          auto_crlf is -1 (input) or 1 (true).  Otherwise do not
          do the conversion.

The original code gets the third case incorrectly, and your
patch fixes it by returning early in that case as well.

The output codepath is the same.  Regardless of action
(GUESS/TEXT/INPUT), we will not do anything if config says 'false'
or 'input', so removing the check with "action == GUESS" is the
right thing.
