From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 07:46:46 -0700
Message-ID: <20090310144646.GQ11989@spearce.org>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 15:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3Go-00033Q-R5
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 15:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbZCJOqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 10:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755981AbZCJOqt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 10:46:49 -0400
Received: from george.spearce.org ([209.20.77.23]:60449 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036AbZCJOqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 10:46:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C387B38211; Tue, 10 Mar 2009 14:46:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49B61703.8030602@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112822>

Johannes Sixt <j.sixt@viscovery.net> wrote:
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
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Looks right to me.

> diff --git a/sideband.c b/sideband.c
> index cca3360..a706ac8 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -50,8 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>  		switch (band) {
>  		case 3:
>  			buf[pf] = ' ';
> -			buf[pf+1+len] = '\n';
> -			safe_write(err, buf, pf+1+len+1);
> +			buf[pf+1+len] = '\0';
> +			fprintf(stderr, "%s\n", buf);

Can't you instead do:

	fprintf(stderr, "%.*s\n", buf, pf + len);

like you do...

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

here?

-- 
Shawn.
