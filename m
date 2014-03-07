From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Fri, 7 Mar 2014 04:34:22 -0500
Message-ID: <CAPig+cR0tw4em_mPNLdp1-gNER2G1FyAVCyZAb9_TbtSyuGyaA@mail.gmail.com>
References: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 10:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLrAk-0005tL-5C
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 10:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbaCGJeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 04:34:25 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:39385 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaCGJeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 04:34:22 -0500
Received: by mail-yh0-f47.google.com with SMTP id c41so3912781yho.20
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 01:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=itsPU7iJkAQB/GAvO8y7Lrskt/yQEvuFDFwM9rrnQak=;
        b=T/aJedi3+b7p+i58vG7M2S4DMhxy05k2Kxpnw1FAZ5GelUzOpO1Zm/POULqENTk6AP
         b4I0aGh9R2sGdazGMgOL15wFDkZNxI8GHwnzabFmkmIK9uH2P2RlSbkxFdFcmdtmixNw
         n80/kDMum/mMobMlNLuQEZJChEP1uyCQHIghslcegPZpB/KJl57beUD8OgQnjNd1A1T9
         xJeaj1ZJXGDPIpVww83eJsglPInCM1cZi2cOTWutuuQu4/G6U2tKcfTgY18Oxyjrovf5
         YJpvnTKvzBhj6KtfgN6NVWHc6zD44swMJNYHMyDAOfXAWVKVezdtdkRZYq2FBhaIRPb1
         7nXw==
X-Received: by 10.236.229.195 with SMTP id h63mr482537yhq.121.1394184862229;
 Fri, 07 Mar 2014 01:34:22 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Fri, 7 Mar 2014 01:34:22 -0800 (PST)
In-Reply-To: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: IlDgBxn9U9yVU7xEO0OM3flqZ1s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243609>

On Thu, Mar 6, 2014 at 12:05 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Replace all instances of starts_with() by skip_prefix(),
> which can not only be used to check presence of a prefix,
> but also used further on as it returns the string after the prefix,
> if the prefix is present. And also manages to do, what the current
> code does in two steps.

Better. Thanks.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> Hello Eric,
> In this patch, I have:
> 1. Fixed the improper placement of buf_date , initialised to a NULL string.
> 2. Fixed whitespace.
> 3. Better naming as per your suggestion.
> 4. Fixed the initilisation before the if statement.
> Thanks for your suggestion.
> ---
>  commit.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..4144e00 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
>         struct ident_split ident;
>         char *date_end;
>         unsigned long date;
> +       const char *buf_date;
>
>         if (!commit->buffer) {
>                 unsigned long size;
> @@ -565,15 +566,15 @@ static void record_author_date(struct author_date_slab *author_date,
>         for (buf = commit->buffer ? commit->buffer : buffer;
>              buf;
>              buf = line_end + 1) {
> +               buf_date = skip_prefix(buf, "author ");

The data after "author " is identification information (name, email),
not date. In fact, this information gets passed to the function
split_ident_line(), so a better name for this variable is 'ident_line'
(but not the misspelling 'indent_line' from one of your earlier
attempts).

>                 line_end = strchrnul(buf, '\n');
> -               if (!starts_with(buf, "author ")) {
> +               if (!buf_date) {
>                         if (!line_end[0] || line_end[1] == '\n')
>                                 return; /* end of header */
>                         continue;
>                 }
> -               if (split_ident_line(&ident,
> -                                    buf + strlen("author "),
> -                                    line_end - (buf + strlen("author "))) ||
> +               if (split_ident_line(&ident, buf_date,
> +                                    line_end - buf_date) ||
>                     !ident.date_begin || !ident.date_end)
>                         goto fail_exit; /* malformed "author" line */
>                 break;
> @@ -1098,6 +1099,7 @@ int parse_signed_commit(const unsigned char *sha1,
>         char *buffer = read_sha1_file(sha1, &type, &size);
>         int in_signature, saw_signature = -1;
>         char *line, *tail;
> +       const char *gpg_sig;
>
>         if (!buffer || type != OBJ_COMMIT)
>                 goto cleanup;
> @@ -1113,9 +1115,9 @@ int parse_signed_commit(const unsigned char *sha1,
>                 next = next ? next + 1 : tail;
>                 if (in_signature && line[0] == ' ')
>                         sig = line + 1;
> -               else if (starts_with(line, gpg_sig_header) &&
> -                        line[gpg_sig_header_len] == ' ')
> -                       sig = line + gpg_sig_header_len + 1;
> +               else if ((gpg_sig = skip_prefix(line, gpg_sig_header))
> +                         && gpg_sig[0] == ' ')
> +                       sig = gpg_sig + 1;

Other than the poor variable name 'buf_date' and the review comments
by Junio and Tanay that this particular change is of questionable
value and perhaps should be dropped, this version of the patch looks
reasonable.

Thanks.

>                 if (sig) {
>                         strbuf_add(signature, sig, next - sig);
>                         saw_signature = 1;
> @@ -1193,10 +1195,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>                 const char *found, *next;
>
> -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> -                       /* At the very beginning of the buffer */
> -                       found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> -               } else {
> +               found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> +               if (!found) {
>                         found = strstr(buf, sigcheck_gpg_status[i].check);
>                         if (!found)
>                                 continue;
> --
> 1.9.0.138.g2de3478
>
