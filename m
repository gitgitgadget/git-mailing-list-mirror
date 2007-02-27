From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Create a symbolic link as a regular file on filesystems
 without symlinks.
Date: Tue, 27 Feb 2007 23:44:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272342160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
 <11726125033437-git-send-email-johannes.sixt@telecom.at>
 <1172612504272-git-send-email-johannes.sixt@telecom.at>
 <11726125052184-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMB4B-0004Va-Dm
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbXB0Woz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbXB0Woz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:44:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:41349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751998AbXB0Woy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:44:54 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:44:53 -0000
X-Provags-ID: V01U2FsdGVkX1+CY1RHSN+Cm2c6rd3249SB68RS15y3TIzF5uAiwR
	SyNw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <11726125052184-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40832>

Hi,

On Tue, 27 Feb 2007, Johannes Sixt wrote:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index bec95d6..1636807 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2284,7 +2284,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
>  {
>  	int fd;
>  
> -	if (S_ISLNK(mode))
> +	if (trust_symlink_fmt && S_ISLNK(mode))

First of all why "_fmt"? I would have called it "trust_symlinks".

> diff --git a/entry.c b/entry.c
> index c2641dd..3d5c0e4 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -100,6 +100,11 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
>  		if (to_tempfile) {
>  			strcpy(path, ".merge_link_XXXXXX");
>  			fd = mkstemp(path);
> +		} else if (!trust_symlink_fmt) {
> +			/* write a regular file */
> +			fd = create_file(path, 0666);
> +		}
> +		if (to_tempfile || !trust_symlink_fmt) {

Wouldn't this be better:

-  		if (to_tempfile) {
-  			strcpy(path, ".merge_link_XXXXXX");
-  			fd = mkstemp(path);
+  		if (to_tempfile || !trusk_symlink_fmt) {
+			if (to_tempfile) {
+	  			strcpy(path, ".merge_link_XXXXXX");
+				fd = mkstemp(path);
+			} else
+				fd = create_file(path, 0666);

Hmm?
