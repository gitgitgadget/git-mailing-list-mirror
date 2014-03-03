From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Mon, 3 Mar 2014 03:52:47 -0500
Message-ID: <CAPig+cQLoZy=MV_AqPQseMxsrU6T_PqmCifWn1SrOGwF2FcYzg@mail.gmail.com>
References: <1393832875-29096-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:52:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKOcH-00061t-A2
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 09:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbaCCIwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 03:52:49 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:58285 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbaCCIws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 03:52:48 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so9809552ykr.9
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MGrOBzYHrqhUeOO/kRQKTa/x55E90TxkWGPu2+UZGfY=;
        b=xTGkKMn9k6EI4C3T1vJXRb1lxr6g2ncIG+tN0ESuuXN8ucXVI3GzguAWEvYGmBNeB1
         SPFS3eohGvINOe3EL0Dlt6mJz3WidwxfAldeVHt5WkY9kmONI+/I1cdMOyHmXXMJLQG/
         /WuUQNPgGPDw8NIm/+b18jaMobLMXHnc9cES/Z+xyru51SmkllXif6RXvPii0L3ZWL2S
         HHV4mNUV6aBSyEyo2H8JwVPbpIAtpX0hVA14RF9DWCY50w/IvTAMInR7NO+X2AxkfuXM
         JTnZoHRTR8YziQ3wHF+Ig37i/EcQRGEcixlkVee8ZHdj3aX9ZJfk/iSoAJ19Hodzw8C2
         OGkw==
X-Received: by 10.236.157.102 with SMTP id n66mr19733206yhk.41.1393836767918;
 Mon, 03 Mar 2014 00:52:47 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 00:52:47 -0800 (PST)
In-Reply-To: <1393832875-29096-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: PRss07gc0H3dl-RzzRYzwL9fQXc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243199>

Thanks for the submission. Some commentary below to expose you to the
review process on this project...

On Mon, Mar 3, 2014 at 2:47 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Replace with skip_prefix(), which uses the inbuilt function
> strcmp() to compare.

Explaining the purpose of the change is indeed important, however,
this description misses the mark. See below.

> Other Places were this can be implemented:
> commit.c : line 1117
> commit.c : line 1197

Bonus points if you actually follow through with this.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..1e181cf 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -552,6 +552,7 @@ static void record_author_date(struct author_date_slab *author_date,
>         char *buffer = NULL;
>         struct ident_split ident;
>         char *date_end;
> +       char *flag_sp; /* stores return value of skip_prefix() */

It's not clear why this variable is needed. It's only assigned (below)
but never referenced. Also, the name conveys little or no meaning. If
you need a comment to explain the purpose of the variable, that's
probably a good indication that it's poorly named.

>         unsigned long date;
>
>         if (!commit->buffer) {
> @@ -566,7 +567,7 @@ static void record_author_date(struct author_date_slab *author_date,
>              buf;
>              buf = line_end + 1) {
>                 line_end = strchrnul(buf, '\n');
> -               if (!starts_with(buf, "author ")) {
> +               if ((flag_sp = skip_prefix(buf, "author ")) == NULL) {

Unfortunately, this change makes the code more difficult to read.
Let's review the GSoC microproject:

    Rewrite commit.c:record_author_date() to use skip_prefix().
    Are there other places in this file where skip_prefix() would
    be **more readable** than starts_with()?

Note the part I **highlighted**. This is a good clue that use of
skip_prefix() can be used to simplify the code. Examine
record_author_date() more carefully and see if you can identify how to
do so.

>                         if (!line_end[0] || line_end[1] == '\n')
>                                 return; /* end of header */
>                         continue;
> --
> 1.9.0.138.g2de3478
