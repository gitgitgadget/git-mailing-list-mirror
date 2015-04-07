From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [v6 PATCH] daemon: add systemd support
Date: Tue, 7 Apr 2015 00:42:14 -0400
Message-ID: <CAPig+cQn30sTAYeBGrH_WNxN5Hsme+uqqUtHsm7bTNvVZ7XBiA@mail.gmail.com>
References: <1428372206-120089-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>,
	Shawn Landden <shawnlandden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 06:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfLLM-0007oz-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 06:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbbDGEmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 00:42:17 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35914 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbDGEmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 00:42:16 -0400
Received: by lbbqq2 with SMTP id qq2so25192947lbb.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8YIcOOtaLlCKA0nGeP7E1u4ESbqmwnZ5EoeMZq84s2Q=;
        b=Yyga2gwKsX6a6lPEkAV2xT+ISkiMDz4lqg7OXP+re3Nk8rzj9i5fJlGAfVFpdLcYM8
         wVauk4jzT2REEcfrA9SVaQAXCpa6ChhqzBsPjkKJUsMXnmaDk+w1+GR3aXSZrL7ud6mc
         L/plM5LXZjEJxfhGpYE+a2qXCBGJt5z9IkHlrhh2PLDgv5arRZecCZ9yjJg1zUmmwpGY
         A6iOxDRJMce/JRK6UTDoN/g172Nl12tn0wZs5ErqT+Zec7N48cnZdCfZD7tUJXtml+Hf
         5h22JW83ng2DW66kGsG98SJHBA9PTue2mLPD5fh9C5k698xDp+rl0bK3wbciPUb5ZHTW
         4kyw==
X-Received: by 10.152.170.199 with SMTP id ao7mr16023184lac.27.1428381734467;
 Mon, 06 Apr 2015 21:42:14 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 21:42:14 -0700 (PDT)
In-Reply-To: <1428372206-120089-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: -hOS3Tr7mJOlHLv4m42pSLfyjP0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266897>

On Mon, Apr 6, 2015 at 10:03 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> systemd supports git-daemon's existing --inetd mode as well.
> --systemd allows git-daemon has the advantage of allowing one git-daemon
> to listen to multiple interfaces as well as the system one(s),
> and more allow git-daemon to not be spawned on every connection.

The commit message is much better than previous versions, although, it
fails to parse cleanly and does not seem to have been proof-read. The
first sentence still feels as if its unrelated to the rest of the
commit message, however, prefixing it with "although" helps. Perhaps
something like this:

    Although "git-daemon --inetd" works with systemd, a proper
    "git-daemon --systemd" mode has the advantage of ... listening
    on multiple interfaces, ..., does not require spawning a new
    git-daemon instance for each connection, ...

Fill in the "..." with whatever other benefits a --systemd mode might
provide (if any).

> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index a69b361..3a7a0b1 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -304,7 +313,35 @@ selectively enable/disable services per repository::
>                 uploadpack = false
>                 uploadarch = true
>  ----------------------------------------------------------------
> ++

As mentioned in the last couple reviews, you should replace the above
"+" line with a blank line since the "systemd configuration example"
item is not a continuation of the preceding "selectively
enable/disable services per repository" item.

> +systemd configuration example::
> +Example systemd configuration files, typically placed in `/etc/systemd/system`.
> ++
> +`git-daemon.socket`
> ++
> +----------------------------------------------------------------
> +# /etc/systemd/system/git-daemon.socket

This comment line merely repeats the filename outside of the verbatim
block, thus can be dropped.

> +[Unit]
> +Description=Git Daemon socket
> +
> +[Socket]
> +ListenStream=9418
> +
> +[Install]
> +WantedBy=sockets.target
> +----------------------------------------------------------------
> ++
> +`git-daemon.service`
> ++
> +----------------------------------------------------------------
> +[Unit]
> +Description=Git Daemon
>
> +[Service]
> +ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
> +User=git-daemon
> +StandardError=null
> +----------------------------------------------------------------
>
>  ENVIRONMENT
>  -----------
