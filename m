From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:45:11 -0500
Message-ID: <20130211044511.GA12809@sigill.intra.peff.net>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4lGv-0008EB-1Y
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3BKEpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:45:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43991 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab3BKEpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:45:14 -0500
Received: (qmail 18253 invoked by uid 107); 11 Feb 2013 04:46:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Feb 2013 23:46:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2013 23:45:12 -0500
Content-Disposition: inline
In-Reply-To: <20130211012016.GA13243@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215991>

On Sun, Feb 10, 2013 at 05:20:16PM -0800, Jonathan Nieder wrote:

> diff --git a/shell.c b/shell.c
> index 84b237fe..3abc2b84 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -63,10 +63,16 @@ static void cd_to_homedir(void)
>  
>  static void run_shell(void)
>  {
> -	int done = 0;
> +	int done = 0, status;
>  	static const char *help_argv[] = { HELP_COMMAND, NULL };
>  	/* Print help if enabled */
> -	run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
> +	status = run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
> +	if (!status)
> +		; /* success */
> +	else if (status == -1 && errno == ENOENT)
> +		; /* help disabled */
> +	else
> +		exit(status);

One final comment on this. I believe we convert an exit code of 127 from
the child into ENOENT. So something like:

  #!/bin/sh
  echo >&2 "Sorry, no interactive shells allowed."
  exti 1

would actually go into the "help disabled" code path and accidentally
run an interactive shell. I wondered if this is something that might
happen accidentally (since the old semantics of "help" were that exit
code did not matter), and if there might be security implications to
entering an interactive shell. But I think we are OK for two reasons:

  1. An old script would not be trying to exit with failure and
     expecting to abort the interactive session; that is a new feature
     you are adding. So even if we accidentally exit 127 (because the
     old script relied on a missing command), it is not changing the
     semantics.

  2. Even if we accidentally do enter the interactive prompt, it should
     not be a security issue. It is not like you can then run arbitrary
     commands; unless you have put something else into
     ~/git-shell-commands, the user can only run "help" over and over.

Maybe obvious, but I wanted to note it as part of the review. I think we
need to be extra careful with thinking through git-shell security
implications, since it is a major potential attack surface for many git
setups.

-Peff
