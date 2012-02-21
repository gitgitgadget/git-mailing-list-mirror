From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Ignore SIGPIPE when running a filter driver
Date: Mon, 20 Feb 2012 21:01:50 -0600
Message-ID: <20120221030150.GA31737@burratino>
References: <1329771217-9088-1-git-send-email-jehan@orb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, j.sixt@viscovery.net,
	peff@peff.net
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 04:02:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzfzW-000196-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 04:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab2BUDCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 22:02:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50071 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab2BUDCE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 22:02:04 -0500
Received: by iacb35 with SMTP id b35so8324623iac.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 19:02:03 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.42.138.193 as permitted sender) client-ip=10.42.138.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.42.138.193 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.42.138.193])
        by 10.42.138.193 with SMTP id d1mr24690901icu.0.1329793323455 (num_hops = 1);
        Mon, 20 Feb 2012 19:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NisbyWNsUS3drix0umVm6E47DOXDv+Yl92lgLP4F5XQ=;
        b=V4C2eafU884UqLN4AnSC3pec57rGSUgMQwh1Wuy6SF0HK0V0O852WbJr+0JaIIlrx4
         yoiGoj5bs/Q2H8MFrgQJt+VykqCkpTgBhSAVoxMHKIaE8nHR0yAuxgy3c96Qh84TUzSA
         I+dDMaIMBRJJfwPxhCDbPWxmIcHqjG1rTbp1I=
Received: by 10.42.138.193 with SMTP id d1mr19697638icu.0.1329793323403;
        Mon, 20 Feb 2012 19:02:03 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ak10sm8826892igc.6.2012.02.20.19.02.02
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 19:02:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329771217-9088-1-git-send-email-jehan@orb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191132>

Hi,

Jehan Bing wrote:

> If a filter is not defined or if it fails, git behaves as if the filter
> is a no-op passthru. However, if the filter exits before reading all
> the content, and depending on the timing git, could be kill with
> SIGPIPE instead.
>
> Ignore SIGPIPE while processing the filter to detect when it exits
> early and fallback to using the unfiltered content.
>
> Signed-off-by: Jehan Bing <jehan@orb.com>

For the benefit of the uninitiated ("how would ignoring an error help
me detect an error?"): setting the SIGPIPE handler to SIG_IGN does not
actually ignore the broken pipe condition but causes it to be reported
as an I/O error, errno == EPIPE.  That means instead of being killed
by SIGPIPE, git gets to fall back to passthrough and report the
filter's mistake:

	error: cannot feed the input to external filter <foo>
	error: external filter <foo> failed

[...]
> +++ b/convert.c
[...]
> @@ -360,12 +361,16 @@ static int filter_buffer(int in, int out, void *data)
>  	if (start_command(&child_process))
>  		return error("cannot fork to run external filter %s", params->cmd);
>  
> +	sigchain_push(SIGPIPE, SIG_IGN);

Setting the signal disposition after launching the external filter
which would otherwise inherit it, so the filter does not have to cope
with unfamiliar SIGPIPE handling[*].  Phew.

> +
>  	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
>  	if (close(child_process.in))
>  		write_err = 1;
>  	if (write_err)
>  		error("cannot feed the input to external filter %s", params->cmd);
>  
> +	sigchain_pop(SIGPIPE);
> +

This happens in an async procedure.  SIGPIPE is ignored in the
following block in the other thread:

	if (strbuf_read(&nbuf, async.out, len) < 0) {
		error("read from external filter %s failed", cmd);
		ret = 0;
	}
	if (close(async.out)) {
		error("read from external filter %s failed", cmd);
		ret = 0;
	}
	if (finish_async(&async)) {

That implies a tiny behavior change: if there is an I/O error reading
from async.out at the right moment and stderr is going to a closed
pipe, inability to report the error can result in the error flag being
set on stderr instead of the process being killed.  I don't think
anyone will notice.

So at least on POSIX-y platforms, this patch looks good to me.  Thanks
for writing it.

Sincerely,
Jonathan

[*] See http://bugs.python.org/issue1652 for some stories about what
we are narrowly escaping here. :)
