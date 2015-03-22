From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] introduce strbuf_read_cmd to avoid deadlocks
Date: Sun, 22 Mar 2015 05:59:25 -0400
Message-ID: <20150322095924.GA24651@peff.net>
References: <CAPx-p4sKD0Nut3E1jnWfPPx4=--ZOxBgiVdt3RRb5tktw31qDg@mail.gmail.com>
 <20150322074455.GA1303@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 10:59:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZcfO-00044L-K0
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 10:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbbCVJ73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 05:59:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:36694 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751727AbbCVJ72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 05:59:28 -0400
Received: (qmail 32215 invoked by uid 102); 22 Mar 2015 09:59:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 04:59:28 -0500
Received: (qmail 6880 invoked by uid 107); 22 Mar 2015 09:59:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 05:59:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 05:59:25 -0400
Content-Disposition: inline
In-Reply-To: <20150322074455.GA1303@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266058>

On Sun, Mar 22, 2015 at 03:44:55AM -0400, Jeff King wrote:

> diff --git a/wt-status.c b/wt-status.c
> index 7036fa2..96f0033 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -748,9 +748,9 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>  	fflush(s->fp);
>  	sm_summary.out = -1;
>  
> -	run_command(&sm_summary);
> -
> +	start_command(&sm_summary);
>  	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
> +	finish_command(&sm_summary);

This isn't quite right. In both the original and the new one, if
start_command fails, we may call strbuf_read on whatever it happens to
have left in sm_summary.out. Worse, in the new one, we would call
finish_command on something that was never started.  And in both old and
new, we leak the sm_summary.out descriptor.

Furthermore, I found two other potential deadlocks (and one more
descriptor leak). I tried at first to fix them all up like I did with
the above patch, but I found that I was introducing similar problems in
each case. So instead, I pulled this pattern out into its own strbuf
helper.

So here's a replacement series.

  [1/7]: wt-status: don't flush before running "submodule status"
  [2/7]: wt_status: fix signedness mismatch in strbuf_read call
  [3/7]: strbuf: introduce strbuf_read_cmd helper
  [4/7]: wt-status: use strbuf_read_cmd
  [5/7]: submodule: use strbuf_read_cmd
  [6/7]: trailer: use strbuf_read_cmd
  [7/7]: run-command: forbid using run_command with piped output

-Peff
