From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Fri, 26 Feb 2010 08:34:21 +0100
Message-ID: <4B87797D.7030905@viscovery.net>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkuiX-0006gY-SE
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 08:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935430Ab0BZHe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 02:34:28 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37739 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935416Ab0BZHe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 02:34:27 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkuiM-0003Va-Ag; Fri, 26 Feb 2010 08:34:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 07C911660F;
	Fri, 26 Feb 2010 08:34:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141111>

Frank Li schrieb:
>  connect.c   |   40 ++++++++++++++++++++++++++++++++++++++++
>  http.c      |    4 ++--
>  imap-send.c |    2 +-

I don't see any header file changes. Don't you get warnings about an
undeclared function git_getpass() at the call sites?

> +char *git_getpass(char *prompt)

char *git_getpass(const char *prompt)

> +	askpass = getenv("GIT_ASKPASS");
> +	if (askpass && strlen(askpass) != 0) {
> +		args[0] = getenv("GIT_ASKPASS");

	if (askpass && *askpass) {
		args[0] = askpass;

BTW, to save a level of indentation, you could handle the "trivial" case
early like this:

	if (!askpass || !*askpass)
		return get_pass(prompt);

and continue without an 'else' branch.

> +		args[1]	= prompt;
> +		args[2] = NULL;
> +
> +		memset(&pass, 0, sizeof(pass));
> +		pass.argv = args;
> +		pass.out = -1;
> +		pass.no_stdin = 1;
> +		pass.no_stderr = 1;

Is it such a good idea to redirect stdin and stderr to /dev/null? What if
my password prompt program depends on them? I think it should not matter
for your use-case, where a GUI is invoked, to just inherit all channels.

OTOH, it may be worthwhile to set

		pass.use_shell = 1;

to allow commands that are not just a single plain word. But perhaps this
has security implications - I don't know.

> +
> +		if (start_command(&pass)) {
> +			error("could not run %s\n", askpass);
> +			return getpass(prompt);

I don't think this is a good idea. The user instructed to use GIT_ASKPASS,
and you fall back to asking a password from the terminal. I think the most
sensible thing to do here is to 'exit(1)' (start_command has already
printed an error message that included the command), because there are
callers that do not expect NULL.

> +		}
> +
> +		strbuf_read(&buffer, pass.out, 20);
> +		close(pass.out);
> +		for (i = 0; i < buffer.len; i++)
> +			if (buffer.buf[i] == '\n' || buffer.buf[i] == '\r') {
> +				buffer.buf[i] = '\0';
> +				buffer.len = i;
> +		}
> +		return strbuf_detach(&buffer, NULL);

You don't call finish_command() anywhere. Call it after the close() call.

> +
> +	} else {
> +		return getpass(prompt);

You handle the return value in different ways. getpass() returns a pointer
to a static buffer, but in the 'then' branch you return an allocated
buffer. Not that it matters a lot, though. You could add a comment that
you are aware that the memory is leaked.

> +	}
> +	return NULL;

What is this good for?

-- Hannes
