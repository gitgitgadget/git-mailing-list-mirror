From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http-backend: Fix access beyond end of string.
Date: Sun, 15 Nov 2009 23:55:32 -0500
Message-ID: <20091116045532.GC14664@coredump.intra.peff.net>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
 <20091116013654.GX11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 05:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9tcu-0004WR-6E
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 05:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbZKPEzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 23:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZKPEzb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 23:55:31 -0500
Received: from peff.net ([208.65.91.99]:44617 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbZKPEza (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 23:55:30 -0500
Received: (qmail 14176 invoked by uid 107); 16 Nov 2009 04:59:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Nov 2009 23:59:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Nov 2009 23:55:32 -0500
Content-Disposition: inline
In-Reply-To: <20091116013654.GX11919@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132985>

On Sun, Nov 15, 2009 at 05:36:54PM -0800, Shawn O. Pearce wrote:

> Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> > diff --git a/http-backend.c b/http-backend.c
> > index f8ea9d7..ab9433d 100644
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -634,7 +634,7 @@ int main(int argc, char **argv)
> >  			cmd = c;
> >  			cmd_arg = xmalloc(n);
> >  			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
> > -			cmd_arg[n] = '\0';
> > +			cmd_arg[n-1] = '\0';
> >  			dir[out[0].rm_so] = 0;
> >  			break;
> 
> Shouldn't this instead be:
> 
> diff --git a/http-backend.c b/http-backend.c
> index 9021266..16ec635 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -626,7 +626,7 @@ int main(int argc, char **argv)
>  			}
>  
>  			cmd = c;
> -			cmd_arg = xmalloc(n);
> +			cmd_arg = xmalloc(n + 1);
>  			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
>  			cmd_arg[n] = '\0';
>  			dir[out[0].rm_so] = 0;
> 
> The cmd_arg string was simply allocated too small.  Your fix is
> terminating the string one character too short which would cause
> get_loose_object and get_pack_file to break.

Actually, from my reading, I think his fix is right, because you trim
the first character during the strncpy (using "out[0].rm_so + 1"). But
it's not clear when you create 'n' that you are dropping that character.
IOW, you are doing:

  /* string + '\0' - '/' */
  size_t n = out[0].rm_eo - (out[0].rm_so + 1) + 1;

which ends up the same as your n, but means that the NUL goes at
cmd_arg[n-1]. But I didn't actually run it, so if his fix is breaking
things, then both Tarmigan and I are counting wrong. ;)

-Peff
