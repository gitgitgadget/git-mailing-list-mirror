From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of
 xmalloc + sprintf
Date: Mon, 23 Jun 2014 06:21:26 -0400
Message-ID: <CAPig+cTyZxH6Ka3JVpYBP7=i=HAWoSYBt9MScwfVaTcKKmi1UA@mail.gmail.com>
References: <20140619211659.GA32412@sigill.intra.peff.net>
	<20140619212800.GF28474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 12:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1NT-0000ZY-S9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbaFWKV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:21:28 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:49702 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaFWKV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:21:27 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so4856450yha.17
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XSXerf/NB0Yos6FMklm2OW5hw7MH7tRsjb3rKzlGsJc=;
        b=GpiTzdXGLw7V+kp1gO7XHYNrnIv/T4ob+C9rfVdyBp3sTkWhPCx5aDmjKGGG6n2n0w
         ATFTu7PPtSMPKJMN3s083MdLWSFiqrfVyPwdnmW6Ke5GSVIamq54noXwqxHPHZ7CIv12
         +9sFuwXgzRg1bRn/ED/2GjmiGw9XpI5jLB5uAdfABxw+JvmN03xH95ho/j6fOFOiJyr4
         2eTSPrZwxGftcppvciWLnVBhMr0z6XYZ44PGfCG2gyO/jp6pQ3rhDEuxHdS2mhMibQdl
         9yNpg0DI7GmU7617RpWw00Y8iFIbXcVbX2WH+vTWvBgy82uyPEavMzAvJTVx6CjQO+Cq
         TcoA==
X-Received: by 10.236.26.172 with SMTP id c32mr2555643yha.145.1403518886886;
 Mon, 23 Jun 2014 03:21:26 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Mon, 23 Jun 2014 03:21:26 -0700 (PDT)
In-Reply-To: <20140619212800.GF28474@sigill.intra.peff.net>
X-Google-Sender-Auth: YM0gMOUQlI8JHLpit0XPu6MJG94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252333>

On Thu, Jun 19, 2014 at 5:28 PM, Jeff King <peff@peff.net> wrote:
> This is shorter, harder to get wrong, and more clearly
> captures the intent.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I wondered if there was a reason to avoid this (because we are in
> setup_git_env, which can potentially be called by git_pathdup). But the
> git_graft_file initialization below already uses it, and I
> double-checked that it is safe once git_dir is set.

This patch will conflict textually with patch 6/28 of Duy's
nd/multiple-work-trees series [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/242300/focus=243649

>  environment.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 4dac5e9..4de7b81 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -135,15 +135,11 @@ static void setup_git_env(void)
>         gitfile = read_gitfile(git_dir);
>         git_dir = xstrdup(gitfile ? gitfile : git_dir);
>         git_object_dir = getenv(DB_ENVIRONMENT);
> -       if (!git_object_dir) {
> -               git_object_dir = xmalloc(strlen(git_dir) + 9);
> -               sprintf(git_object_dir, "%s/objects", git_dir);
> -       }
> +       if (!git_object_dir)
> +               git_object_dir = git_pathdup("objects");
>         git_index_file = getenv(INDEX_ENVIRONMENT);
> -       if (!git_index_file) {
> -               git_index_file = xmalloc(strlen(git_dir) + 7);
> -               sprintf(git_index_file, "%s/index", git_dir);
> -       }
> +       if (!git_index_file)
> +               git_index_file = git_pathdup("index");
>         git_graft_file = getenv(GRAFT_ENVIRONMENT);
>         if (!git_graft_file)
>                 git_graft_file = git_pathdup("info/grafts");
> --
> 2.0.0.566.gfe3e6b2
