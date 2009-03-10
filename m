From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 13:37:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903101335470.30483@xanadu.home>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>
 <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
 <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh5up-00066k-Py
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 18:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbZCJRhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 13:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbZCJRhZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 13:37:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52934 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974AbZCJRhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 13:37:24 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGA00AXWWY5LKY0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Mar 2009 13:37:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49B61703.8030602@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112835>

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> This removes the last parameter of recv_sideband, by which the callers
> told which channel band #2 data should be written to. Since both callers
> of the function passed 2 for the parameter, we hereby remove the
> parameter and send band #2 to stderr explicitly using fprintf.
> 
> This has the nice side-effect that the band #2 data (most importantly
> progress reports during a fetch operation) passes through our ANSI
> emulation layer on Windows.

You appear to modify band #3 as well.  Better mention it in the commit 
log.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Acked-by: Nicolas Pitre <nico@cam.org>


> ---
> Johannes Sixt schrieb:
> > Johannes Schindelin schrieb:
> >> To make use of it during a fetch, write() needs to be overridden, too.
> > 
> > No, that's not necessary with the patch that I'm about to send in a
> > moment. To replace write() for ANSI emulation really goes too far.
> 
> Here it is. The patch is still RFC because I didn't have a chance, yet,
> to test it in practice. It passes the test suite.
> 
> -- Hannes
> 
>  builtin-archive.c    |    2 +-
>  builtin-fetch-pack.c |    2 +-
>  sideband.c           |   20 +++++++++-----------
>  sideband.h           |    2 +-
>  4 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin-archive.c b/builtin-archive.c
> index 60adef9..ab50ceb 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -52,7 +52,7 @@ static int run_remote_archiver(int argc, const char **argv,
>  		die("git archive: expected a flush");
> 
>  	/* Now, start reading from fd[0] and spit it out to stdout */
> -	rv = recv_sideband("archive", fd[0], 1, 2);
> +	rv = recv_sideband("archive", fd[0], 1);
>  	close(fd[0]);
>  	close(fd[1]);
>  	rv |= finish_connect(conn);
> diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
> index c2e5adc..2b36099 100644
> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -482,7 +482,7 @@ static int sideband_demux(int fd, void *data)
>  {
>  	int *xd = data;
> 
> -	return recv_sideband("fetch-pack", xd[0], fd, 2);
> +	return recv_sideband("fetch-pack", xd[0], fd);
>  }
> 
>  static int get_pack(int xd[2], char **pack_lockfile)
> diff --git a/sideband.c b/sideband.c
> index cca3360..a706ac8 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -19,7 +19,7 @@
> 
>  #define FIX_SIZE 10  /* large enough for any of the above */
> 
> -int recv_sideband(const char *me, int in_stream, int out, int err)
> +int recv_sideband(const char *me, int in_stream, int out)
>  {
>  	unsigned pf = strlen(PREFIX);
>  	unsigned sf;
> @@ -41,8 +41,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>  		if (len == 0)
>  			break;
>  		if (len < 1) {
> -			len = sprintf(buf, "%s: protocol error: no band designator\n", me);
> -			safe_write(err, buf, len);
> +			fprintf(stderr, "%s: protocol error: no band designator\n", me);
>  			return SIDEBAND_PROTOCOL_ERROR;
>  		}
>  		band = buf[pf] & 0xff;
> @@ -50,8 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>  		switch (band) {
>  		case 3:
>  			buf[pf] = ' ';
> -			buf[pf+1+len] = '\n';
> -			safe_write(err, buf, pf+1+len+1);
> +			buf[pf+1+len] = '\0';
> +			fprintf(stderr, "%s\n", buf);
>  			return SIDEBAND_REMOTE_ERROR;
>  		case 2:
>  			buf[pf] = ' ';
> @@ -95,12 +94,13 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>  					memcpy(save, b + brk, sf);
>  					b[brk + sf - 1] = b[brk - 1];
>  					memcpy(b + brk - 1, suffix, sf);
> -					safe_write(err, b, brk + sf);
> +					fprintf(stderr, "%.*s", brk + sf, b);
>  					memcpy(b + brk, save, sf);
>  					len -= brk;
>  				} else {
>  					int l = brk ? brk : len;
> -					safe_write(err, b, l);
> +					if (l > 0)
> +						fprintf(stderr, "%.*s", l, b);
>  					len -= l;
>  				}
> 
> @@ -112,10 +112,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>  			safe_write(out, buf + pf+1, len);
>  			continue;
>  		default:
> -			len = sprintf(buf,
> -				      "%s: protocol error: bad band #%d\n",
> -				      me, band);
> -			safe_write(err, buf, len);
> +			fprintf(stderr, "%s: protocol error: bad band #%d\n",
> +				me, band);
>  			return SIDEBAND_PROTOCOL_ERROR;
>  		}
>  	}
> diff --git a/sideband.h b/sideband.h
> index a84b691..d72db35 100644
> --- a/sideband.h
> +++ b/sideband.h
> @@ -7,7 +7,7 @@
>  #define DEFAULT_PACKET_MAX 1000
>  #define LARGE_PACKET_MAX 65520
> 
> -int recv_sideband(const char *me, int in_stream, int out, int err);
> +int recv_sideband(const char *me, int in_stream, int out);
>  ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
> 
>  #endif
> -- 
> 1.6.2.987.g90c1d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
