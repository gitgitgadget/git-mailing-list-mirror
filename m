From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] http-push: append slash if possible for
 directories
Date: Sat, 17 Jan 2009 07:02:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170654540.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 07:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO4Ie-00080T-86
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 07:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbZAQGBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 01:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbZAQGBt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 01:01:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:44841 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751581AbZAQGBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 01:01:49 -0500
Received: (qmail invoked by alias); 17 Jan 2009 06:01:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 17 Jan 2009 07:01:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BPvM75nRBLhNrqHgrksHi7V/ARgoIZJN//kgoXp
	Vt/Q31c/64hoRF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

more comments:

On Sat, 17 Jan 2009, Ray Chuan wrote:

> diff --git a/src/git-1.6.1/http-push.c b/src/git-1.6.1/http-push.c
> index 7c64609..25b655d 100644
> --- a/src/git-1.6.1/http-push.c
> +++ b/src/git-1.6.1/http-push.c
> @@ -1189,6 +1189,7 @@ static struct remote_lock *lock_remote(const
> char *path, long timeout)
>  	struct strbuf in_buffer = STRBUF_INIT;
>  	char *url;
>  	char *ep;
> +	char ep_old;
>  	char timeout_header[25];
>  	struct remote_lock *lock = NULL;
>  	struct curl_slist *dav_headers = NULL;
> @@ -1198,9 +1199,18 @@ static struct remote_lock *lock_remote(const
> char *path, long timeout)
>  	sprintf(url, "%s%s", remote->url, path);
> 
>  	/* Make sure leading directories exist for the remote ref */
> -	ep = strchr(url + strlen(remote->url) + 1, '/');
> -	while (ep) {
> -		*ep = 0;
> +	ep = url + strlen(remote->url) + 1;
> +	int has_fs = 0;

decl-after-statement.

And name-not-meaningful.  What does "has_fs" stand for?

> +	while (1) {
> +		ep = strchr(ep + 1, '/');
> +		if(ep) {
> +			ep++;
> +			ep_old=*ep;

Okay, you succeeded in fooling me.  It took fully five minutes until I 
realized that ep_old is not the old value of ep, but of *ep.

And now I know what has_fs does, but the name is an even bigger puzzle.

Almost as big as the puzzle why you did not do a much less intrusive 
change:

- after the "while (ep) {" you could say "char saved_character = ep[1];

- then you replace the "*ep = 0" by "ep[1] = '\0';"

- at the end of the loop, you replace the "*ep = '/'" with "ep[1] = 
  saved_character;"

That way, not only would the patch be much smaller, it would also not have 
been as difficult to review as it was.

Ciao,
Dscho
