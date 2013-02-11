From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 22:59:08 -0500
Message-ID: <20130211035908.GA4543@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Mon Feb 11 04:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kYI-0003z5-Sm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 04:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab3BKD7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 22:59:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43935 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab3BKD7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 22:59:11 -0500
Received: (qmail 17569 invoked by uid 107); 11 Feb 2013 04:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Feb 2013 23:00:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2013 22:59:08 -0500
Content-Disposition: inline
In-Reply-To: <20130211012016.GA13243@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215982>

On Sun, Feb 10, 2013 at 05:20:16PM -0800, Jonathan Nieder wrote:

> > This of course now means that the ~/git-shell-commands should not be
> > empty, since that is where this default command also will be present.
> 
> How about this?

I like the general direction this is going, but:

> +When run interactively (with no arguments), 'git-shell' will
> +automatically run `~/git-shell-commands/help` on startup, provided it
> +exists.  If the 'help' command fails then the interactive shell is
> +aborted.

Doesn't that mean that people who currently do allow interactive access
and have a ~/git-shell-commands/help (that returns zero) will get
spammed by its as a motd each time they connect?

To be honest, I am not really clear on what interactive git-shell is
used for. AFAIK, it does nothing unless you have set up custom commands,
and I have never actually seen them in the wild. So maybe it is not a
big deal.

If I understand correctly, calling it "check-interactive", "greeting",
or something instead of "help" would be sufficient, and then you
wouldn't have to worry about backwards compatibility.

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

This kicks in only when there is no command given, right? So if I ran
"ssh example.com", it would give me the help message rather than (or in
addition) giving me interactive access.

What about "ssh example.com foo"? Do we want to allow a custom message
there, too (it might be different there; e.g., an allowed list of
commands might make more sense)?

-Peff
