From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain
 messages
Date: Fri, 15 Feb 2008 10:41:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802151035100.30505@racer.site>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 11:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPy1F-0006in-9Q
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 11:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965AbYBOKli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 05:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758829AbYBOKli
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 05:41:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:36113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757748AbYBOKlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 05:41:37 -0500
Received: (qmail invoked by alias); 15 Feb 2008 10:41:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp055) with SMTP; 15 Feb 2008 11:41:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ey39fVc7Ef/VQZ/lUbLVAt4ZSI0NUVdc+H6hhJn
	dCfyMmHtmw+I6R
X-X-Sender: gene099@racer.site
In-Reply-To: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73951>

Hi,

On Thu, 14 Feb 2008, Jay Soffian wrote:

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 2600847..deaf92b 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -20,6 +20,13 @@ static enum  {
>  static enum  {
>  	TYPE_TEXT, TYPE_OTHER,
>  } message_type;
> +/* RFC 3676 Text/Plain Format and DelSp Parameters */
> +static enum {
> +	FORMAT_NONE, FORMAT_FIXED, FORMAT_FLOWED,
> +} tp_format;

Why not call it "enum message_format"?

> +static enum {
> +	DELSP_NONE, DELSP_YES, DELSP_NO,
> +} tp_delsp;

Why not call it "enum message_is_delsp"?

> @@ -193,6 +200,18 @@ static int handle_content_type(char *line)
>  
>  	if (strcasestr(line, "text/") == NULL)
>  		 message_type = TYPE_OTHER;
> +	else if (strcasestr(line, "text/plain")) {
> +		char attr[256];
> +		if (slurp_attr(line, "format=", attr) && !strcasecmp(attr, "flowed")) {
> +			tp_format = FORMAT_FLOWED;
> +			if (slurp_attr(line, "delsp=", attr) && !strcasecmp(attr, "yes"))
> +				tp_delsp = DELSP_YES;
> +			else
> +				tp_delsp = DELSP_NO;
> +		}
> +		else
> +			tp_format = FORMAT_FIXED;

Does that mean that the format is only set if the content type is 
"text/plain"?

> @@ -681,6 +700,8 @@ again:
>  	transfer_encoding = TE_DONTCARE;
>  	charset[0] = 0;
>  	message_type = TYPE_TEXT;
> +	tp_format = FORMAT_NONE;
> +	tp_delsp = DELSP_NONE;
>  
>  	/* slurp in this section's info */
>  	while (read_one_header_line(line, sizeof(line), fin))
> @@ -770,6 +791,24 @@ static int handle_filter(char *line, unsigned linesize)
>  {
>  	static int filter = 0;
>  
> +	if (tp_format == FORMAT_FLOWED && !!strcmp(line, "-- \n")) {

The !! is unnecessary; please skip it.

> +		char *cp = line;
> +		while (*cp == '>' && *cp != 0)
> +			cp++;
> +		if (*cp == ' ')
> +			cp++;
> +		line = cp;

How about using strchrnul()?

Note: I do not know enough about format=flawed to know why you should skip 
to "> ".  I would have expected "\n", though.

> +		if (!!strcmp(line, "-- \n")) {

The !! is unnecessary; please skip it.

> +			while (*cp != '\n' && *cp !=0)
> +				cp++;

Again, this is the job for strchrnul().

> +			if (cp > line && *cp == '\n' && *(cp-1) == ' ') {
> +				if (tp_delsp == DELSP_YES)
> +					*(cp-1) = '\0';
> +				else
> +					*cp = '\0';
> +			}

Or maybe
				cp[0 - (tp_delsp == DELSP_YES)] = '\0';

But maybe that is too cute.

But another thing struck me here: why setting *cp = '\0'; only if *(cp-1) 
== ' ', even if tp_delsp != DELSP_YES?

> @@ -818,6 +857,7 @@ static void handle_body(void)
>  
>  		switch (transfer_encoding) {
>  		case TE_BASE64:
> +		case TE_QP:
>  		{
>  			char *op = line;

Did that just slip in, or was this intended.  If the latter, is this 
related to format=flawed, or is it a bug fix in its own right?

Ciao,
Dscho
