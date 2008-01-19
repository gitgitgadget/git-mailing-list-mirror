From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push and http-fetch: handle URLs without leading
 /
Date: Sat, 19 Jan 2008 23:14:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192310290.5731@racer.site>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org> <1200756171-11696-2-git-send-email-gb@gbarbier.org> <1200756171-11696-3-git-send-email-gb@gbarbier.org> <1200756171-11696-4-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-107735994-1200784494=:5731"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 00:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMuq-00066M-An
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 00:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbYASXPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 18:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbYASXPG
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 18:15:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:55943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753441AbYASXPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 18:15:04 -0500
Received: (qmail invoked by alias); 19 Jan 2008 23:15:03 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 20 Jan 2008 00:15:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+yI8MAjT+CNcIYbML6MU6xCsxFpzinzYNNXXCWQ
	CUizk2yynDRPwc
X-X-Sender: gene099@racer.site
In-Reply-To: <1200756171-11696-4-git-send-email-gb@gbarbier.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71140>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-107735994-1200784494=:5731
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 19 Jan 2008, Grégoire Barbier wrote:

> Since HTTP/302 is not handled in the git code calling curl, URLs without
> leading / used to lead to frozen git-fetch or git-push with no error message.

JFYI these lines are a little bit too long; I would like to see them 
unwrapped with a 4-space indent on a 80-column display.

I am not sure how easily Junio can fix them.


> @@ -51,6 +52,12 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
>  		commits = 1;
>  	}
>  	url = argv[arg];
> +        if (url && url[strlen(url)-1] != '/') {
> +                rewritten_url = malloc(strlen(url)+2);
> +                strcpy(rewritten_url, url);
> +                strcat(rewritten_url, "/");
> +                url = rewritten_url;
> +        }
>  
>  	walker = get_http_walker(url);
>  	walker->get_tree = get_tree;

Please use strbuf, like so:

	struct strbuf rewritten_url = STRBUF_INIT;

	...
	url = argv[arg];
        if (url && url[strlen(url)-1] != '/') {
		strbuf_addstr(&rewritten_url, url);
		strbuf_addch(&rewritten_url, '/');
		url = rewritten_url.buf;
	}
	...
	strbuf_release(&rewritten_url);
	
BTW it seems you indented using spaces, but we like the indentation as 
tabs in git.git.

Other than that, I like your patch!

Thanks,
Dscho

---1463811741-107735994-1200784494=:5731--
