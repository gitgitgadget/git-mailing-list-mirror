From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process
 instead of a pid_t.
Date: Sun, 30 Sep 2007 22:04:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302158110.28395@racer.site>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic5yj-0000X8-WD
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbXI3VFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbXI3VFW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:05:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:34900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751831AbXI3VFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:05:21 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:05:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 30 Sep 2007 23:05:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19P8up1+itP/pyD/ngOo2LYYahF30uUn8I/3pY9d9
	WTKdZ56/45Xotf
X-X-Sender: gene099@racer.site
In-Reply-To: <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59563>

Hi,

On Sun, 30 Sep 2007, Johannes Sixt wrote:

> -	pid_t pid;
> +	struct child_process *chld;

Why not call it "child"?  It's only one letter more, and much less 
confusing.

> -	pid = git_connect(fd, url, exec, 0);
> -	if (pid < 0)
> -		return pid;
> +	chld = git_connect(fd, url, exec, 0);

chld never gets free()d.  (I'm was about to suggest doing that in 
finish_command(), but I'm not quite sure what this would break.)

> @@ -773,16 +773,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
>  			st.st_mtime = 0;
>  	}
>  
> -	pid = git_connect(fd, (char *)dest, uploadpack,
> +	chld = git_connect(fd, (char *)dest, uploadpack,
>                            args.verbose ? CONNECT_VERBOSE : 0);
> -	if (pid < 0)
> -		return NULL;
>  	if (heads && nr_heads)
>  		nr_heads = remove_duplicates(nr_heads, heads);
>  	ref = do_fetch_pack(fd, nr_heads, heads, pack_lockfile);

In general, I would not lightly do away with the "return NULL" on error, 
since it is really hard to assess what do_fetch_pack() or packet_write() 
do (or don't) when git_connect() failed.

> -	while (waitpid(pid, NULL, 0) < 0) {
> +	while (waitpid(chld->pid, NULL, 0) < 0) {

Shouldn't this be converted to finish_command() already?

Ciao,
Dscho
