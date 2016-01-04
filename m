From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/14] shortlog: replace hand-parsing of author with pretty-printer
Date: Mon, 4 Jan 2016 04:43:23 -0500
Message-ID: <CAPig+cRxBHp9hRBbFPYtEdytnmGdVYVMfJLKzjT6qoQ8EOSxQw@mail.gmail.com>
References: <20151229071847.GA8726@sigill.intra.peff.net>
	<20151229072953.GF8842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 10:43:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG1fq-00049f-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 10:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbcADJn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 04:43:27 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33777 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbcADJnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 04:43:24 -0500
Received: by mail-vk0-f48.google.com with SMTP id a188so247503378vkc.0
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iN6UNDm/rJO/TjB9Fq+54uBwS6Eq8dFBGEiC2h3nQeA=;
        b=KiCe/W9+dBrbaIhN72/ioCpYByK6UDbFlSKRqYJzyEhpN5C9COSYFh6vF0jzciqOGr
         lrHCjojmHM5b65jEzJrELYx8NO0d1GWCUQ6mdvhsLexK89d5CGFXC0HOnmiTjb0ToB6R
         hXCIabIM0dtdKsPOsmhDf6OXOGF9NvZayT78gCZLgIUehNJT9BcxRvtFUHt62pWl+Csw
         W84TEGO8emu95WJ9mxlRKQueOSOLBQTkuqCBDoSlZiazJlwUTi2l/ndQFJCTld+1yNNN
         wluIKrtz5END2WHv8rTYSSs/qzaTYcFny8ToezuNzXIc3kGd5sHrE4w7EEUO91A8uOjZ
         p42Q==
X-Received: by 10.31.47.130 with SMTP id v124mr59568803vkv.117.1451900603477;
 Mon, 04 Jan 2016 01:43:23 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 4 Jan 2016 01:43:23 -0800 (PST)
In-Reply-To: <20151229072953.GF8842@sigill.intra.peff.net>
X-Google-Sender-Auth: TMokggRgLZqmyvxFs1hFiXSkcBo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283290>

On Tue, Dec 29, 2015 at 2:29 AM, Jeff King <peff@peff.net> wrote:
> When gathering the author and oneline subject for each
> commit, we hand-parse the commit headers to find the
> "author" line, and then continue past to the blank line at
> the end of the header.
>
> We can replace this tricky hand-parsing by simply asking the
> pretty-printer for the relevant items. This also decouples
> the author and oneline parsing, opening up some new
> optimizations in further commits.
>
> One reason to avoid the pretty-printer is that it might be
> less efficient than hand-parsing. However, I measured no
> slowdown at all running "git shortlog -ns HEAD" on
> linux.git.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> @@ -112,45 +112,32 @@ static void read_from_stdin(struct shortlog *log)
>  void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  {
> -       const char *author = NULL, *buffer;
> -       struct strbuf buf = STRBUF_INIT;
> -       struct strbuf ufbuf = STRBUF_INIT;
> -
> -       pp_commit_easy(CMIT_FMT_RAW, commit, &buf);
> -       buffer = buf.buf;
> -       while (*buffer && *buffer != '\n') {
> -               const char *eol = strchr(buffer, '\n');
> -
> -               if (eol == NULL)
> -                       eol = buffer + strlen(buffer);
> -               else
> -                       eol++;
> -
> -               if (starts_with(buffer, "author "))
> -                       author = buffer + 7;
> -               buffer = eol;
> -       }
> -       if (!author) {
> +       struct strbuf author = STRBUF_INIT;
> +       struct strbuf oneline = STRBUF_INIT;
> +       struct pretty_print_context ctx = {0};
> +
> +       ctx.fmt = CMIT_FMT_USERFORMAT;
> +       ctx.abbrev = log->abbrev;
> +       ctx.subject = "";
> +       ctx.after_subject = "";
> +       ctx.date_mode.type = DATE_NORMAL;
> +       ctx.output_encoding = get_log_output_encoding();
> +
> +       format_commit_message(commit, "%an <%ae>", &author, &ctx);
> +       if (author.len <= 3) {

I suppose magic number 3 is the space, '<', and '>'...

>                 warning(_("Missing author: %s"),
>                     oid_to_hex(&commit->object.oid));
>                 return;

Is this leaking strbuf 'author'?

>         }
> -       if (log->user_format) {
> -               struct pretty_print_context ctx = {0};
> -               ctx.fmt = CMIT_FMT_USERFORMAT;
> -               ctx.abbrev = log->abbrev;
> -               ctx.subject = "";
> -               ctx.after_subject = "";
> -               ctx.date_mode.type = DATE_NORMAL;
> -               ctx.output_encoding = get_log_output_encoding();
> -               pretty_print_commit(&ctx, commit, &ufbuf);
> -               buffer = ufbuf.buf;
> -       } else if (*buffer) {
> -               buffer++;
> -       }
> -       insert_one_record(log, author, !*buffer ? "<none>" : buffer);
> -       strbuf_release(&ufbuf);
> -       strbuf_release(&buf);
> +
> +       if (log->user_format)
> +               pretty_print_commit(&ctx, commit, &oneline);
> +       else
> +               format_commit_message(commit, "%s", &oneline, &ctx);
> +
> +       insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
> +       strbuf_release(&author);
> +       strbuf_release(&oneline);
>  }
