From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] connect: move error check to caller of parse_connect_url
Date: Wed, 29 Jul 2015 16:32:13 -0400
Message-ID: <CAPig+cRGw6-QhYzxkqVE-psQLHORioGmNFbf3Q72nrsSiES5GA@mail.gmail.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-5-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:32:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKY1S-0005wi-2z
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 22:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbbG2UcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 16:32:14 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36418 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbG2UcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 16:32:13 -0400
Received: by ykay190 with SMTP id y190so18068126yka.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=b9zKtvR0VseX3D2GQNtejEzQ23vJ4zRri0mMB7y3Nmg=;
        b=Oizq25VUgNZaJqP32lGsaYcrrjaL/SogqxHVh1psCDbQOO366o34dhfj1xMvunp67h
         1AdWVhd15khibXdayCEjmIem6ovXbziGbexgurvqk38UT8zJlx0K0YWdEKB2/C0hrQQG
         aWjg+KiUiEP37Ze920xHXukpFZVm2jto5DIwYcs5RTbE1jjJAGhNzrlDT6FsrJPYGP7U
         cLxANaHLB/KsT+W27mBGrt7dNdUt7VXFi/hkhtOjYUqYC/JwSFx2jyeSYpJ3G0GJD9VC
         HyK8qncjnQJ6TmZHBmAtQ6qe6itFRXcZ01vU6sS2JS8ryZ/fk6QcZDFKq+b3JO18bOv2
         /w5g==
X-Received: by 10.170.196.4 with SMTP id n4mr46863127yke.127.1438201933244;
 Wed, 29 Jul 2015 13:32:13 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 13:32:13 -0700 (PDT)
In-Reply-To: <1438185076-28870-5-git-send-email-ps@pks.im>
X-Google-Sender-Auth: aHi7zep_661ECBIO0gK6kTt0pQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274952>

On Wed, Jul 29, 2015 at 11:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
> parse_connect_url() checks if the path component of the URL is
> empty and if so causes the program to die. As the function is to
> be used at other call sites which do not require this check, move
> up the error checking to the existing caller.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/connect.c b/connect.c
> index bdbcee4..e8b813d 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -613,9 +613,6 @@ enum protocol parse_connect_url(const char *url_orig, char **ret_host,
>         else
>                 path = strchr(end, separator);
>
> -       if (!path || !*path)
> -               die("No path specified. See 'man git-pull' for valid url syntax");
> -

Given that there are several dereferences of 'path' following this bit
of code, won't this change lead to a crash when path==NULL?

>         /*
>          * null-terminate hostname and point path to ~ for URL's like this:
>          *    ssh://host.xz/~user/repo
> @@ -665,6 +662,9 @@ struct child_process *git_connect(int fd[2], const char *url,
>         signal(SIGCHLD, SIG_DFL);
>
>         protocol = parse_connect_url(url, &hostandport, &path);
> +       if (!path || !*path)
> +               die("No path specified. See 'man git-pull' for valid url syntax");
> +
>         if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
>                 printf("Diag: url=%s\n", url ? url : "NULL");
>                 printf("Diag: protocol=%s\n", prot_name(protocol));
> --
> 2.5.0
