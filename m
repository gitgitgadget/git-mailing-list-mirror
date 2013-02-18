From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 02/10] pkt-line: drop safe_write function
Date: Mon, 18 Feb 2013 01:56:45 -0800
Message-ID: <20130218095644.GA7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218091519.GB5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NTK-0006n7-50
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab3BRJ4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:56:54 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:55767 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab3BRJ4x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:56:53 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1588565pbc.35
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=25p4xj6o3HG4Ok2sEbrjcAcbVb5XiaG+CAEzzUmCG1o=;
        b=fQtidmWOzyC4cFclOV93gBFPQmPMJmdD1LEF37Hnfd05HO5o1UAX/orKSivtEpqMpy
         0RYO8CTH+OsPsvOo3PXuYBUr/XaKop+qh3g652lQ4Mdzgg3TFyVB7xY35qofijxBbRnu
         fCCi8L2Jl2/xKuM37zlqMEduG/Sl3uv/pNUPxWXn7bAj/KDyI4lyUOHtVKc7GSHwzCT1
         +yO4gsXEmjGFCU/AG3ckNPJbgHNsYpYNP6EEHu0LrA4AbVBOtejv2M5UAnIWvKdHoNB8
         tKg9AuwA/P2pop8TwU6DxFR9VmD0J1jcY1mFHNKQ3UXDCsz5kGt6Cna187EOhqgQNHYO
         nchQ==
X-Received: by 10.66.89.226 with SMTP id br2mr34292899pab.57.1361181413071;
        Mon, 18 Feb 2013 01:56:53 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bi8sm103274827pab.15.2013.02.18.01.56.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 01:56:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218091519.GB5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216463>

Jeff King wrote:

> This is just write_or_die by another name.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Actually, they are not quite the same. write_or_die will exit(0) when it
> sees EPIPE.

That information definitely belongs in the commit message.

>             Which makes me a little nervous.

Me, too.  Let's see:

[...]
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -908,7 +908,7 @@ static void report(struct command *commands, const char *unpack_status)
>  	if (use_sideband)
>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>  	else
> -		safe_write(1, buf.buf, buf.len);
> +		write_or_die(1, buf.buf, buf.len);

If the connection to send-pack is lost and stdout becomes a broken
pipe and I am updating enough refs to overflow the pipe buffer,
receive-pack will die with SIGPIPE.  So unless the sadistic caller has
set the inherited SIGPIPE action to SIG_IGN (for example by wrapping
git with an uncautious Python wrapper that uses subprocess.Popen), the
change to EPIPE handling is not a behavior change.

Since the pipe is closed, presumably the calling send-pack has hung up
and won't notice the exit status, so this should be safe.

Arguably it would be more friendly to stay alive to run the
post-receive and post-update hooks, though, given that a ref update
has occurred.  Maybe transport commands like this one should always
set the disposition of SIGPIPE to SIG_IGN.

[...]
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -79,7 +79,7 @@ static void print_helper_status(struct ref *ref)
>  		}
>  		strbuf_addch(&buf, '\n');
>  
> -		safe_write(1, buf.buf, buf.len);
> +		write_or_die(1, buf.buf, buf.len);

A signal will kill send-pack before write_or_die has a chance to
intervene so this change is a no-op unless the caller is sadistic
(as in the [1] case).  In the signal(SIGPIPE, SIG_IGN) case, it might
be a regression, since "git push" should not declare success when its
connection to receive-pack closes early.

[1] http://www.chiark.greenend.org.uk/ucgi/~cjwatson/blosxom/2009-07-02-python-sigpipe.html

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -245,7 +245,7 @@ static void send_request(struct fetch_pack_args *args,
>  		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
>  		packet_flush(fd);
>  	} else
> -		safe_write(fd, buf->buf, buf->len);
> +		write_or_die(fd, buf->buf, buf->len);

Also a no-op except when the parent process is insane enough to let us
inherit signal(SIGPIPE, SIG_IGN).

In that case, if triggerable this looks like a bad change: if
upload-pack has gone missing, the fetch should not be considered a
success.

[...]
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -70,7 +70,7 @@ static void format_write(int fd, const char *fmt, ...)
>  	if (n >= sizeof(buffer))
>  		die("protocol error: impossibly long line");
>  
> -	safe_write(fd, buffer, n);
> +	write_or_die(fd, buffer, n);

Etc.  I'm stopping here.

I'm thinking before a patch like this we should make the following
change:

 1. at startup, set the signal action of SIGPIPE to SIG_DFL, to make
    the behavior a little more predictable.

Perhaps the following as well:

 2. in write_or_die(), when encountering EPIPE, set the signal action
    of SIGPIPE to SIG_DFL and raise(SIGPIPE), ensuring the exit status
    reflects the broken pipe.  If the parent process is unnecessarily
    noisy about that, that's a bug in the parent process (hopefully
    uncommon).

Or alternatively:

 2b. never set SIGPIPE to SIG_IGN except in short blocks of code that
     do not call write_or_die()

What do you think?
Jonathan
