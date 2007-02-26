From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Mon, 26 Feb 2007 08:24:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 17:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLieU-0002Zo-8l
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 17:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbXBZQYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 11:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbXBZQYb
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 11:24:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51695 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbXBZQY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 11:24:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QGOJhB030065
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 08:24:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QGOJHj024469;
	Mon, 26 Feb 2007 08:24:19 -0800
In-Reply-To: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.445 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40625>



On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  builtin-fetch--tool.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> index 48de08d..e5bb560 100644
> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -14,6 +14,10 @@ static char *get_stdin(void)
>  		data = xrealloc(data, offset + CHUNK_SIZE);
>  		read = xread(0, data + offset, CHUNK_SIZE);
>  	}
> +	if (read > 0 && data[read - 1] == '\n')
> +		data[read - 1] = '\0';
> +	else
> +		data[read] = '\0';
>  	return data;
>  }

This is horrible crap.

First off, "read" here may be -1.

Secondly, "data[read]", even if read is positive, is in the *middle* of a 
buffer.

It should probably be something like

	if (read > 0)
		offset += read;

	/* Why do this? Because Dscho did.. */
	if (offset && data[offset-1] == '\n')
		offset--;

	data[offset] = 0;

which at least seems to be potentially sane.

		Linus
