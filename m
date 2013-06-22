From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] help: introduce man.viewer = eman
Date: Sat, 22 Jun 2013 12:59:38 +0100
Message-ID: <20130622115938.GF4676@serenity.lan>
References: <1371901409-8319-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 13:59:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqMTx-0000OA-AP
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 13:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab3FVL7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 07:59:49 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53245 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab3FVL7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 07:59:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 19FD5CDA59B;
	Sat, 22 Jun 2013 12:59:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CABOzGvI+FLJ; Sat, 22 Jun 2013 12:59:47 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C2A2CCDA5BA;
	Sat, 22 Jun 2013 12:59:40 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1371901409-8319-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228700>

On Sat, Jun 22, 2013 at 05:13:29PM +0530, Ramkumar Ramachandra wrote:
> Corresponding to woman.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-help.txt |  3 +++
>  builtin/help.c             | 11 ++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index b21e9d7..0cb4c46 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -104,6 +104,9 @@ The 'man.viewer' config variable will be checked if the 'man' format
>  is chosen. The following values are currently supported:
>  
>  * "man": use the 'man' program as usual,
> +* "eman": use 'emacsclient' to launch the "man" mode in emacs
> +(this only works starting with emacsclient versions 22), on systems
> +with man,
>  * "woman": use 'emacsclient' to launch the "woman" mode in emacs
>  (this only works starting with emacsclient versions 22),
>  * "konqueror": use 'kfmclient' to open the man page in a new konqueror
> diff --git a/builtin/help.c b/builtin/help.c
> index 062957f..7cb44e0 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -120,7 +120,7 @@ static int check_emacsclient_version(void)
>  	return 0;
>  }
>  
> -static void exec_woman_emacs(const char *path, const char *page)
> +static void exec_woman_emacs(const char *path, const char *page, int eman)
>  {
>  	if (!check_emacsclient_version()) {
>  		/* This works only with emacsclient version >= 22. */
> @@ -128,7 +128,10 @@ static void exec_woman_emacs(const char *path, const char *page)
>  
>  		if (!path)
>  			path = "emacsclient";
> -		strbuf_addf(&man_page, "(woman \"%s\")", page);
> +		if (eman)
> +			strbuf_addf(&man_page, "(man \"%s\")", page);
> +		else
> +			strbuf_addf(&man_page, "(woman \"%s\")", page);

Would it be nicer to pass a string in here instead of a flag?  Then this
becomes:

	strbuf_addf(&man_page, "(%s \"%s\")", command, page);

You should probably also rename this function to "exec_emacsclient" or
something as well now that it doesn't just launch woman.

>  		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
>  		warning(_("failed to exec '%s': %s"), path, strerror(errno));
>  	}
> @@ -341,8 +344,10 @@ static void exec_viewer(const char *name, const char *page)
>  
>  	if (!strcasecmp(name, "man"))
>  		exec_man_man(info, page);
> +	else if (!strcasecmp(name, "eman"))
> +		exec_woman_emacs(info, page, 1);
>  	else if (!strcasecmp(name, "woman"))
> -		exec_woman_emacs(info, page);
> +		exec_woman_emacs(info, page, 0);
>  	else if (!strcasecmp(name, "konqueror"))
>  		exec_man_konqueror(info, page);
>  	else if (info)
> -- 
> 1.8.3.1.487.g3e7a5b4.dirty
