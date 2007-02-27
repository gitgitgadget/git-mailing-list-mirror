From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Tue, 27 Feb 2007 20:35:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272034010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702261827510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702261003480.12485@woody.linux-foundation.org>
 <7vfy8sn20o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM86Z-0005Em-Ma
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbXB0TfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXB0TfM
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:35:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:42593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbXB0TfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:35:10 -0500
Received: (qmail invoked by alias); 27 Feb 2007 19:35:09 -0000
X-Provags-ID: V01U2FsdGVkX18jWGkgcE4jxL3NpqJqmFlUU2NFAkrL0F1e4p2ZjR
	TaUA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy8sn20o.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40773>

Hi

On Mon, 26 Feb 2007, Junio C Hamano wrote:

> [PATCH] fetch--tool: fix uninitialized buffer when reading from stdin
> 
> The original code allocates too much space and forgets to NUL
> terminate the string.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  builtin-fetch--tool.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> index 48de08d..a068f8d 100644
> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -2,17 +2,24 @@
>  #include "refs.h"
>  #include "commit.h"
>  
> -#define CHUNK_SIZE (1048576)
> +#define CHUNK_SIZE 1024
>  
>  static char *get_stdin(void)
>  {
> +	int offset = 0;
>  	char *data = xmalloc(CHUNK_SIZE);
> -	int offset = 0, read = 0;
> -	read = xread(0, data, CHUNK_SIZE);
> -	while (read == CHUNK_SIZE) {
> -		offset += CHUNK_SIZE;
> +
> +	while (1) {
> +		int cnt = xread(0, data + offset, CHUNK_SIZE);
> +		if (cnt < 0)
> +			die("error reading standard input: %s",
> +			    strerror(errno));
> +		if (cnt == 0) {
> +			data[offset] = 0;
> +			break;
> +		}
> +		offset += cnt;
>  		data = xrealloc(data, offset + CHUNK_SIZE);
> -		read = xread(0, data + offset, CHUNK_SIZE);
>  	}
>  	return data;
>  }

Me-liked-by: Dscho. And maybe people forget about my silly "fix"...

Ciao,
Dscho
