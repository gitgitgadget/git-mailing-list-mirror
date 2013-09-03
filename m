From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: the pager
Date: Mon, 2 Sep 2013 22:27:48 -0400
Message-ID: <201309030227.r832RmBd013888@freeze.ariadne.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
	<xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
	<201308281819.r7SIJmnh025977@freeze.ariadne.com>
	<xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
	<201308291541.r7TFfuJr023110@freeze.ariadne.com> <vpqsixsv6dq.fsf@anie.imag.fr>
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 03 04:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGgLV-00072M-7V
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 04:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188Ab3ICC1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 22:27:53 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:57821
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753966Ab3ICC1w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 22:27:52 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id LRe31m00727AodY5FSTqG6; Tue, 03 Sep 2013 02:27:50 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id LSTq1m00R1KKtkw3fSTqSE; Tue, 03 Sep 2013 02:27:50 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r832RnN2013889;
	Mon, 2 Sep 2013 22:27:49 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r832RmBd013888;
	Mon, 2 Sep 2013 22:27:48 -0400
In-reply-to: <vpqsixsv6dq.fsf@anie.imag.fr> (Matthieu.Moy@grenoble-inp.fr)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1378175270;
	bh=Xvv3Fd6sCYvYofVNcB4dEueWYWym4Mt/dGJdC3RFeW0=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=ZVHwHnHGYW0hUAiGRKQOZ4QXkB/DkgK48u+zMbBHFWM7B88cJGX3whi9jz/HU8KQG
	 DTFnoURaBusiNz38/O3rgFzgGEQjsCyk9s76S9+/skqczzXjjYfFF5uC+Je5+MLoRO
	 yHROTwPd/TJRsDpvMjBzNP2U//BOxFjq/vb7CLTyuvdecxshcakl2Gci+JUuOVHy4x
	 QrdFMfUfGLFaWFTe9yxypPgPy3FS5OiuFygCky1yyOH1iAtWh16epWeQZVHJDp5yZF
	 Bhv2Y/DG69RyKMGACEey1ut2XOyRQPeFg9+NcmB6hcVBYr+hDkx+5IDS315GuicoNK
	 g9xSC5zO9Fzww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233675>

> From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

> >     const char *git_pager(int stdout_is_tty)
> >     {
> >             const char *pager;
> >
> >             if (!stdout_is_tty)
> >                     return NULL;
> >
> >             pager = getenv("GIT_PAGER");
> >             if (!pager) {
> >                     if (!pager_program)
> >                             git_config(git_default_config, NULL);
> >                     pager = pager_program;
> >             }
> >             if (!pager)
> >                     pager = getenv("PAGER");
> >             if (!pager)
> >                     pager = DEFAULT_PAGER;
> >             else if (!*pager || !strcmp(pager, "cat"))
> >                     pager = NULL;
> 
> I guess the "else" could and should be dropped. If you do so (and
> possibly insert a blank line between the DEFAULT_PAGER case and the
> "pager = NULL" case), you get a nice pattern
> 
> if (!pager)
> 	try_something();
> if (!pager)
> 	try_next_option();

That's true, but it would change the effect of using "cat" as a value:
"cat" as a value of DEFAULT_PAGER would cause git_pager() to return
NULL, whereas now it causes git_pager() to return "cat".  (All other
places where "cat" can be a value are translated to NULL already.)

This is why I want to know what the *intended* behavior is, because we
might be changing Git's behavior, and I want to know that if we do
that, we're changing it to what it should be.  And I haven't seen
anyone venture an opinion on what the intended behavior is.

> I agree that a comment like this would help, though:
> 
> --- a/cache.h
> +++ b/cache.h
> @@ -1266,7 +1266,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
>  
>  /* pager.c */
>  extern void setup_pager(void);
> -extern const char *pager_program;
> +extern const char *pager_program; /* value read from git_config() */
>  extern int pager_in_use(void);
>  extern int pager_use_color;
>  extern int term_columns(void);

First off, the wording is wrong, it should be "value set by
git_config()".

But that doesn't tell the reader what the significance of the value
is.  I suspect that a number of global variables need to be marked:

> /* The pager program name, or "cat" if there is no pager.
>  * Can be overridden by the pager.<cmd> configuration value for a
>  * single command, or suppressed by the --no-pager option.
>  * Set by calling git_config().
>  * NULL if hasn't been set yet by calling git_config(). */
> extern const char *pager_program;

Dale
