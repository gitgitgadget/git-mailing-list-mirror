From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Tue, 10 Jan 2012 11:44:21 -0600
Message-ID: <20120110174420.GA22184@burratino>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 18:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkffZ-0007qJ-13
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 18:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372Ab2AJRj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 12:39:27 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36758 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2AJRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 12:39:27 -0500
Received: by ghbg21 with SMTP id g21so2263153ghb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 09:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5O5rennuX6gBX8Wz5H4On67TwK8s4zvA+HS+O6s01mI=;
        b=K3aEnkO57+UpJm10PBJzPRyC+7QVyJIV5cl/OI1o7+Xhwzpmxr5se+l65EGQ1wdf0u
         ipeLENkPbIVBaK3VoUt3fLnJBPs2+6OkNC2kxVF1zLRFoiqzQftA82KoOGjSIzoJAOGv
         4KS8ksj0OZuIgKRCCrrZBTuIrt+hckGpJ7gTY=
Received: by 10.50.87.164 with SMTP id az4mr1032839igb.27.1326217165807;
        Tue, 10 Jan 2012 09:39:25 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l28sm265308194ibc.3.2012.01.10.09.39.24
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 09:39:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120110044430.GA23619@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188270>

Jeff King wrote:

>   2. A hack in credential-cache won't help any unix-socket
>      users who come along later.
>
>   3. The chdir trickery isn't that likely to fail (basically
>      it's only a problem if your cwd is missing or goes away
>      while you're running).  And because we only enable the
>      hack when we get a too-long name, it can only fail in
>      cases that would have failed under the previous code
>      anyway.
>
> Signed-off-by: Jeff King <peff@peff.net>

A part of me worries that this assumption (3), and the additional
assumption that nothing running concurrently cares about the cwd,
might come back to bite us when the future (2) arrives.  But I don't
see a better approach.

Follow-on ideas: on platforms that support it, it would be nice to use

	ctx->orig_dirfd = open(".", O_RDONLY);
	if (ctx->orig_dirfd < 0)
		... error handling ...
	...
	if (ctx->orig_dirfd >= 0) {
		if (fchdir(ctx->orig_dirfd))
			die_errno("unable to restore original working directory");
		close(ctx->orig_dirfd);
	}

> --- a/unix-socket.c
> +++ b/unix-socket.c
> @@ -9,27 +9,86 @@ static int unix_stream_socket(void)
[...]
> +		dir = path;
> +		dir_len = slash - path;
[...]
> +		if (chdir_len(dir, dir_len) < 0)
> +			return -1;

Could avoid some complication by eliminating the dir_len var.

		if (chdir_len(dir, slash - dir))
			return -1;

Neither seems worth holding up the patch, so
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
