From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 06/24] expire_reflog(): return early if the reference
 has no reflog
Date: Fri, 12 Dec 2014 10:15:14 -0800
Message-ID: <CAGZ79kYHWZW0Q15nx7xWdzw8-2iL-rT034T-vQ4u9nz3Gi7JNQ@mail.gmail.com>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
	<1418374623-5566-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzUkM-0003h0-KO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 19:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935233AbaLLSPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 13:15:18 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:45630 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbaLLSPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 13:15:17 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so1944467igb.5
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TJ7+7YcAlo3mHDSNtHM9lJS2krgQg8TXPAxUG6U6pVo=;
        b=GTgY1oEEn+A2vD3LrjPhuVtdf87ae6HBX89+YzbaJa8RVxyJLi8JEX7imdESkP3/tk
         ew+bU8EcGyy7fmHceOLaYq/d1n97tUUN8DWJJ50tLIQf+nkGK6QAFoluewuMwIlCUp5E
         bhYj8akQ57rhNypGShhpQm3ZU4ncLqjcf28/Eh7JA+dRHw6/6A0mmKC5In0wBxNOp2lg
         VPaAHrdP+LVY4C/Vhel0fzGUgWD6RgYWmmQG44J/hRphF1Z4C8/6v1jyO/GJuxAPev/w
         JIPn/ucmDLXHlz4VsuGgnw+I1lPXHEUbe4SBb26hczwe9suYQcSbrpfpXN6XSEU2r5KN
         Mf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TJ7+7YcAlo3mHDSNtHM9lJS2krgQg8TXPAxUG6U6pVo=;
        b=U1DwLO9rA07FHE6XgdYUYy5sZoxm+u2sfODwfU3+bXA791wfY1MFMPo0qXJIk5YBIV
         QCRGv0WQu0av9tYvA1XcVMJPNZrDDKMhuFGTXBRsp7TPWtpgylB9ufZ9EL4XFL0l98Xj
         zUmRBikX8XNUySD91E66c9hB7/VCY2XYZD+ah5cPrzz6ggAnZLpVzYqcB36crA2/t5rF
         YdvbW1RjwwC4ap0UJ7vnC9Jg4AKeXabBW0duX3nBXIIHriVGY+yqxU7rkkniHcCCjl5L
         AyhA8t4SGZIHyTXyMAct07dEIR5BkU4BViTdwhHeQNjo8fjuNtgQudRqeK/sUW54UpB5
         DWdg==
X-Gm-Message-State: ALoCoQnu/Rt5trYnmnxxi6oRAQFU44GkNDlNfoS2N+NhAVtjjwIVBc5UzJq7NDYFNyYPtHeRq3SC
X-Received: by 10.50.137.65 with SMTP id qg1mr5916082igb.37.1418408115013;
 Fri, 12 Dec 2014 10:15:15 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 10:15:14 -0800 (PST)
In-Reply-To: <1418374623-5566-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261352>

On Fri, Dec 12, 2014 at 12:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> There is very little cleanup needed if the reference has no reflog. If
> we move the initialization of log_file down a bit, there's even less.
> So instead of jumping to the cleanup code at the end of the function,
> just do the cleanup and return inline.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/reflog.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index ff51dbf..37b33c9 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -368,9 +368,11 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>         lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
>         if (!lock)
>                 return error("cannot lock ref '%s'", refname);
> +       if (!reflog_exists(refname)) {
> +               unlock_ref(lock);
> +               return 0;
> +       }
>         log_file = git_pathdup("logs/%s", refname);
> -       if (!reflog_exists(refname))
> -               goto finish;
>         if (!cmd->dry_run) {
>                 newlog_path = git_pathdup("logs/%s.lock", refname);
>                 cb.newlog = fopen(newlog_path, "w");
> @@ -419,7 +421,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>                         clear_commit_marks(tip_commit, REACHABLE);
>                 }
>         }
> - finish:
> +
>         if (cb.newlog) {
>                 if (fclose(cb.newlog)) {
>                         status |= error("%s: %s", strerror(errno),
> --
> 2.1.3
>
