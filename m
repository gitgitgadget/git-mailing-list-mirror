From: Pete Harlan <pchpublic88@gmail.com>
Subject: Re: [PATCH v2 2/2] connect: improve check for plink to reduce false positives
Date: Fri, 24 Apr 2015 15:46:30 -0700
Message-ID: <CAM=ud8zKE-Huq_ZGVq9ycFFw+R7TBkQ5R4tcwfha9OBm_geASg@mail.gmail.com>
References: <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
	<1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
	<1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:46:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlmMm-000316-Do
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 00:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbbDXWqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 18:46:32 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:36688 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539AbbDXWqb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 18:46:31 -0400
Received: by qcpm10 with SMTP id m10so33464753qcp.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cY/5kXqS3lqOQeaNljIvXeMo+0GRMCav5yj69lnSInc=;
        b=ePYVeRnwIifuhQvwtYK1hYZ8mWGRvXDOguvfKG7lkF3MbC84TjiX/2BqQyXA7f6RJ0
         8OOkpBq8c+6uR4xwX7/ZcIAjmTYYqj6K2t7CH4b5XHk3FnoLM1K6M/XGobv8LpyxXIjz
         dTtlFRKLPGQEAheR9gQFaarmynjNOguglMoW/JyKazoNG7mYTfFPGdsBzHwjLxbHvjuX
         3ZXL/nEICuCdI+UheQscna5CBsFD0tHVdzjpIYV6WZ1hY5TTmofBfct9LH9JFBoOqwmp
         7BpdxFSrjdVZsykQkSQFCfap77CwIt41+7WysGgLny7gYI30ZbrFsKZNf6ZRuOb8HSIs
         CyKQ==
X-Received: by 10.55.52.129 with SMTP id b123mr1206400qka.34.1429915590860;
 Fri, 24 Apr 2015 15:46:30 -0700 (PDT)
Received: by 10.140.40.80 with HTTP; Fri, 24 Apr 2015 15:46:30 -0700 (PDT)
In-Reply-To: <1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267764>

On Fri, Apr 24, 2015 at 3:28 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> The git_connect function has code to handle plink and tortoiseplink
> specially, as they require different command line arguments from
> OpenSSH.  However, the match was done by checking for "plink"
> case-insensitively in the string, which led to false positives when

Perhaps s/case-insensitively/anywhere/?

It's not important that it ignored case (your change ignores it too),
it's that it was too lenient about its context.

--Pete

> GIT_SSH contained "uplink".  Improve the check by looking for "plink" or
> "tortoiseplink" (or those names suffixed with ".exe") in the final
> component of the path.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  connect.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 749a07b..c0144d8 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -724,7 +724,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>                 conn->in = conn->out = -1;
>                 if (protocol == PROTO_SSH) {
>                         const char *ssh;
> -                       int putty;
> +                       int putty, tortoiseplink = 0;
>                         char *ssh_host = hostandport;
>                         const char *port = NULL;
>                         get_host_and_port(&ssh_host, &port);
> @@ -750,14 +750,26 @@ struct child_process *git_connect(int fd[2], const char *url,
>                                 conn->use_shell = 1;
>                                 putty = 0;
>                         } else {
> +                               const char *base;
> +                               char *ssh_dup;
> +
>                                 ssh = getenv("GIT_SSH");
>                                 if (!ssh)
>                                         ssh = "ssh";
> -                               putty = !!strcasestr(ssh, "plink");
> +
> +                               ssh_dup = xstrdup(ssh);
> +                               base = basename(ssh_dup);
> +
> +                               tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
> +                                       !strcasecmp(base, "tortoiseplink.exe");
> +                               putty = !strcasecmp(base, "plink") ||
> +                                       !strcasecmp(base, "plink.exe") || tortoiseplink;
> +
> +                               free(ssh_dup);
>                         }
>
>                         argv_array_push(&conn->args, ssh);
> -                       if (putty && !strcasestr(ssh, "tortoiseplink"))
> +                       if (tortoiseplink)
>                                 argv_array_push(&conn->args, "-batch");
>                         if (port) {
>                                 /* P is for PuTTY, p is for OpenSSH */
