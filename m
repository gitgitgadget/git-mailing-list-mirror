From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http: use strbuf API in quote_ref_url
Date: Sat, 7 Mar 2009 16:57:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903071654480.10279@pacific.mpi-cbg.de>
References: <49B29554.30805@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 16:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfyuR-0002jq-7T
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 16:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbZCGP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbZCGP41
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 10:56:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:50046 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754773AbZCGP41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 10:56:27 -0500
Received: (qmail invoked by alias); 07 Mar 2009 15:56:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 07 Mar 2009 16:56:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LO1YKJ9FLsy9u3T9wvKLNCa8OrWgDz8rdNAEalo
	khg34slb2RXfXa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49B29554.30805@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112545>

Hi,

On Sat, 7 Mar 2009, Tay Ray Chuan wrote:

> In addition, ''quote_ref_url'' inserts a slash between the base URL and
> remote ref path only if needed. Previously, this insertion wasn't
> contingent on the lack of a separating slash.
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I would prefer to give my ACK explicitely... :-)

>  http.c |   29 ++++++++++-------------------
>  1 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/http.c b/http.c
> index cdedeb6..9de4130 100644
> --- a/http.c
> +++ b/http.c
> @@ -577,31 +577,22 @@ static inline int hex(int v)
> 
>  static char *quote_ref_url(const char *base, const char *ref)
>  {
> +	struct strbuf buf = STRBUF_INIT;
>  	const char *cp;
> -	char *dp, *qref;
> -	int len, baselen, ch;
> +	int ch;
> +
> +	strbuf_addstr(&buf, base);
> +	if (strcmp(base+strlen(base)-1, "/") && strcmp(ref, "/"))
> +		strbuf_addstr(&buf, "/");

I would not have scratched my head that much if it read like this:

	if (buf.len && buf.buf[buf.len - 1] != '/' && *ref != '/')
		strbuf_addch(&buf, '/');

>  	for (cp = ref; (ch = *cp) != 0; cp++) {
> -		if (needs_quote(ch)) {
> -			*dp++ = '%';
> -			*dp++ = hex((ch >> 4) & 0xF);
> -			*dp++ = hex(ch & 0xF);
> -		}
> +		if (needs_quote(ch))
> +			strbuf_addf(&buf, "%%%02x", ch);
>  		else
> -			*dp++ = ch;
> +			strbuf_addch(&buf, *cp);
>  	}

Seems as if you could remove even the curly brackets here.

Other than that, it indeed looks like an ACK from me...

Ciao,
Dscho
