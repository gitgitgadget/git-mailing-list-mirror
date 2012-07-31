From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] sane_execvp(): ignore non-directory on PATH
Date: Tue, 31 Jul 2012 16:23:40 -0400
Message-ID: <20120731202340.GA31348@sigill.intra.peff.net>
References: <7vobmviuii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIyw-0000uX-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab2GaUXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:23:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43724 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab2GaUXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:23:44 -0400
Received: (qmail 31801 invoked by uid 107); 31 Jul 2012 20:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jul 2012 16:23:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2012 16:23:40 -0400
Content-Disposition: inline
In-Reply-To: <7vobmviuii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202683>

On Tue, Jul 31, 2012 at 12:46:13PM -0700, Junio C Hamano wrote:

> When you have a non-directory on your PATH, a funny thing happens:
> 
> 	$ PATH=$PATH:/bin/sh git foo
> 	fatal: cannot exec 'git-foo': Not a directory?
> 
> Worse yet, as real commands always take precedence over aliases,
> this behaviour interacts rather badly with them:
> 
> 	$ PATH=$PATH:/bin/sh git -c alias.foo=show git foo -s
> 	fatal: cannot exec 'git-foo': Not a directory?
> 
> This is because an ENOTDIR error from the underlying execvp(2) is
> reported back to the caller of our sane_execvp() wrapper as-is.  By
> translating it to ENOENT, just like the case where we _might_ have
> the command in an unreadable directory, fixes it.  Without an alias,
> we would get
> 
> 	git: 'foo' is not a git command. See 'git --help'.
> 
> and we use the 'foo' alias when it is available.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * We can view this as a follow-up to 38f865c (run-command: treat
>    inaccessible directories as ENOENT, 2012-03-30).

Hrm. EACCES is somewhat special, in that the underlying execvp will
continue after seeing EACCES, and will only report it back to us if we
don't eventually find a good candidate.

Is ENOTDIR the same? IOW, If I do:

  PATH=/bin/cat:/bin
  ls

will I still run "ls"? Testing on my glibc system says "yes", which I
think makes this a sane thing to do (if it were not the case and ENOTDIR
causes an early return, then that ENOENT is kind of a lie, since we
simply don't know the answer).

> diff --git a/run-command.c b/run-command.c
> index 805d41f..f9b7db2 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -77,6 +77,8 @@ int sane_execvp(const char *file, char * const argv[])
>  	 */
>  	if (errno == EACCES && !strchr(file, '/'))
>  		errno = exists_in_PATH(file) ? EACCES : ENOENT;
> +	else if (errno == ENOTDIR && !strchr(file, '/'))
> +		errno = ENOENT;
>  	return -1;

Yay. I remember the original 38f865c going through several iterations,
and I am glad we took the time to end up with one that made adding this
case in so simple.

-Peff
