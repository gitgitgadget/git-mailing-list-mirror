From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC v1 4/5] fast-import.c: cleanup using strbuf_set operations
Date: Mon, 9 Jun 2014 06:12:12 -0400
Message-ID: <CAPig+cRPPN7N+KUHULXxoGHetN8WPtASxnC7L1fe5rFoBFQ4KA@mail.gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
	<b64218c4f2a188c5aeb48a07da01972ef4d0ca33.1402301816.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 12:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtwYu-0003PT-8E
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 12:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbaFIKMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 06:12:17 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:50636 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbaFIKMN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 06:12:13 -0400
Received: by mail-yk0-f176.google.com with SMTP id 131so748362ykp.21
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BOn2yNnUM3TMOFHHKTmdaen4Ej7HcPk1ai0uctH4Msk=;
        b=exo7/pzG3eZzu7mmwkohZ3SwTq49F7ljtWj6zRcrcFjwajlcd9u3WB0RyUQod0pj2O
         wWs9cBvXiLEoa5u/9abON4y50kvAh6SA9CUdR6r4GqGfjomLPg3XVJDz28liUqIS7zqK
         yjBScCcHRLf2uhxuBbVPDaT1pPeCwmyOI9yN2iclHG89a3kP2purLlMXJRvmdy9Qx2+7
         d2BhsXZzMMfxD7RTV3DRlRwG050DkDkCHi5yzskKY1jw4s6bjpb9+l2aEJWTLwvaRczw
         sbL30e8zaQijFwq62X+WxcGowyZhoazEUi01icI5l/XpSdcB3BlE2zhnl4Ta0E5UkQ+6
         3vTA==
X-Received: by 10.236.66.139 with SMTP id h11mr12826822yhd.30.1402308732346;
 Mon, 09 Jun 2014 03:12:12 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 9 Jun 2014 03:12:12 -0700 (PDT)
In-Reply-To: <b64218c4f2a188c5aeb48a07da01972ef4d0ca33.1402301816.git.jmmahler@gmail.com>
X-Google-Sender-Auth: thPd9qAjIItkSgxlRIBDOZ5vQeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251066>

On Mon, Jun 9, 2014 at 4:36 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Subject: fast-import.c: cleanup using strbuf_set operations

This might read more clearly if written:

    fast-import: simplify via strbuf_set()

> Simplified cases where a strbuf_reset was immediately followed by a
> strbuf_add using the new strbuf_set operations.

On this project, commit messages are written in imperative mood:

    Simplify cases where ... is immediately ...

More below.

> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  fast-import.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index e8ec34d..c23935c 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2741,8 +2741,7 @@ static void parse_new_commit(void)
>         hashcpy(b->branch_tree.versions[0].sha1,
>                 b->branch_tree.versions[1].sha1);
>
> -       strbuf_reset(&new_data);
> -       strbuf_addf(&new_data, "tree %s\n",
> +       strbuf_setf(&new_data, "tree %s\n",
>                 sha1_to_hex(b->branch_tree.versions[1].sha1));
>         if (!is_null_sha1(b->sha1))
>                 strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));

Unlike the cases in patches 3/5 and 5/5 where the strbuf is used or
returned immediately following the strbuf_set() call, I am not
convinced that this change is an improvement. This code has the
general form:

    strbuf_reset(...);
    strbuf_add(...);
    if (condition)
        strbuf_add(...);
    strbuf_add(...);

in which it is clear that the string is being built piecemeal, and
it's easy for a programmer to insert, remove, or re-order strbuf_add()
calls.

Replacing the first two lines with strbuf_set() somewhat obscures the
fact that the string is going to be built up piecemeal. Plus, the
change makes it more difficult to insert, remove, or re-order the
strbuf_add() invocations.

This isn't a strong objection, but the benefit of the change seems
minimal or non-existent.

Ditto for several remaining cases in this patch.

> @@ -2829,9 +2828,7 @@ static void parse_new_tag(void)
>         parse_data(&msg, 0, NULL);
>
>         /* build the tag object */
> -       strbuf_reset(&new_data);
> -
> -       strbuf_addf(&new_data,
> +       strbuf_setf(&new_data,
>                     "object %s\n"
>                     "type %s\n"
>                     "tag %s\n",
> @@ -2898,8 +2895,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
>          * Output based on batch_one_object() from cat-file.c.
>          */
>         if (type <= 0) {
> -               strbuf_reset(&line);
> -               strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
> +               strbuf_setf(&line, "%s missing\n", sha1_to_hex(sha1));
>                 cat_blob_write(line.buf, line.len);
>                 strbuf_release(&line);
>                 free(buf);
> @@ -2910,8 +2906,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
>         if (type != OBJ_BLOB)
>                 die("Object %s is a %s but a blob was expected.",
>                     sha1_to_hex(sha1), typename(type));
> -       strbuf_reset(&line);
> -       strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
> +       strbuf_setf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
>                                                 typename(type), size);
>         cat_blob_write(line.buf, line.len);
>         strbuf_release(&line);
> @@ -3034,14 +3029,12 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
>
>         if (!mode) {
>                 /* missing SP path LF */
> -               strbuf_reset(&line);
> -               strbuf_addstr(&line, "missing ");
> +               strbuf_setstr(&line, "missing ");
>                 quote_c_style(path, &line, NULL, 0);
>                 strbuf_addch(&line, '\n');
>         } else {
>                 /* mode SP type SP object_name TAB path LF */
> -               strbuf_reset(&line);
> -               strbuf_addf(&line, "%06o %s %s\t",
> +               strbuf_setf(&line, "%06o %s %s\t",
>                                 mode & ~NO_DELTA, type, sha1_to_hex(sha1));
>                 quote_c_style(path, &line, NULL, 0);
>                 strbuf_addch(&line, '\n');
> --
> 2.0.0.573.ged771ce.dirty
