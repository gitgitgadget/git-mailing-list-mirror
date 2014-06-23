From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/7] commit: provide a function to find a header in a buffer
Date: Sun, 22 Jun 2014 21:26:44 -0400
Message-ID: <CAPig+cQuBg0sjZXfkB7c_L=PMJuaPbWZBz9UV2Jbtr3eqJuPcw@mail.gmail.com>
References: <20140618201944.GA23238@sigill.intra.peff.net>
	<20140618202737.GA23896@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 03:26:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyt22-0001ry-14
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 03:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbaFWB0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 21:26:46 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:50525 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaFWB0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 21:26:45 -0400
Received: by mail-yh0-f52.google.com with SMTP id a41so4525141yho.39
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XThNOQgO3XlfxdwEne6MXyowc+nSKLbHcCX1UZrbdr0=;
        b=Rbd5KOwoFjaYSOjbgKC7qLpGNnkjLKztK6a2yZzQYIgKtcvwzlojNDxXPRlnxJ704o
         x3hEaO0btZ5dgbFJ667wYEG00fH0uRV4Qk0Vdeca/0SIxoUZuRmHG1ldJxwc4sPyShlk
         FqRsmZYR4tSjVKVTkkVQ1gWzIe+FVRU6ToEu5kK37Y//F19blExrECrKEF/tRK7ha1OK
         gRH+HTbm20SuDjPOzqfNiObAbmwQeR5K6tdqLs5Cy7b1f5ooeGFrGfc74RjnbdFgcPAf
         2rrehUQ6yvtuHssvZQj1OEgvOBQLCmwnNv/reZkitH4E7N2sj+w4tDuuW66ykBQ6ZSW3
         N+rg==
X-Received: by 10.236.20.114 with SMTP id o78mr31071153yho.91.1403486804922;
 Sun, 22 Jun 2014 18:26:44 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Sun, 22 Jun 2014 18:26:44 -0700 (PDT)
In-Reply-To: <20140618202737.GA23896@sigill.intra.peff.net>
X-Google-Sender-Auth: WPTisbtvGGKtxC8QRInV5KMqGR4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252316>

On Wednesday, June 18, 2014, Jeff King <peff@peff.net> wrote:
> Usually when we parse a commit, we read it line by line and
> handle each header in a single pass (e.g., in parse_commit
> and parse_commit_header).  Sometimes, however, we only care
> about extracting a single header. Code in this situation is
> stuck doing an ad-hoc parse of the commit buffer.
>
> Let's provide a reusable function to locate a header within
> the commit.  The code is modeled after pretty.c's
> get_header, which is used to extract the encoding.
>
> Since some callers may not have the "struct commit" to go
> along with the buffer, we drop that parameter.  The only
> thing lost is a warning for truncated commits, but that's
> OK.  This shouldn't happen in practice, and even if it does,
> there's no particular reason that this function needs to
> complain about it. It either finds the header it was asked
> for, or it doesn't (and in the latter case, the caller can
> complain).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/commit.c b/commit.c
> index 11106fb..d04b525 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1652,3 +1652,26 @@ void print_commit_list(struct commit_list *list,
>                 printf(format, sha1_to_hex(list->item->object.sha1));
>         }
>  }
> +
> +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
> +{
> +       int key_len = strlen(key);
> +       const char *line = msg;
> +
> +       while (line) {
> +               const char *eol = strchrnul(line, '\n'), *next;
> +
> +               if (line == eol)
> +                       return NULL;
> +               next = *eol ? eol + 1 : NULL;
> +
> +               if (eol - line > key_len &&
> +                   !strncmp(line, key, key_len) &&
> +                   line[key_len] == ' ') {
> +                       *out_len = eol - line - key_len - 1;
> +                       return line + key_len + 1;
> +               }
> +               line = next;

This is already simplified from the original implementation in
get_header(), but it can be simplified further by dropping 'next',
which is not otherwise used, and assigning 'line' directly:

    line = *eol ? eol + 1 : NULL;

> +       }
> +       return NULL;
> +}
> diff --git a/commit.h b/commit.h
> index 61559a9..7c766e9 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -312,6 +312,17 @@ extern struct commit_extra_header *read_commit_extra_headers(struct commit *, co
>
>  extern void free_commit_extra_headers(struct commit_extra_header *extra);
>
> +/*
> + * Search the commit object contents given by "msg" for the header "key".
> + * Returns a pointer to the start of the header contents, or NULL. The length
> + * of the header, up to the first newline, is returned via out_len.
> + *
> + * Note that some headers (like mergetag) may be multi-line. It is the caller's
> + * responsibility to parse further in this case!
> + */
> +extern const char *find_commit_header(const char *msg, const char *key,
> +                                     size_t *out_len);
> +
>  struct merge_remote_desc {
>         struct object *obj; /* the named object, could be a tag */
>         const char *name;
> diff --git a/pretty.c b/pretty.c
> index cc5b45d..6081750 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -548,31 +548,11 @@ static void add_merge_info(const struct pretty_print_context *pp,
>         strbuf_addch(sb, '\n');
>  }
>
> -static char *get_header(const struct commit *commit, const char *msg,
> -                       const char *key)
> +static char *get_header(const char *msg, const char *key)
>  {
> -       int key_len = strlen(key);
> -       const char *line = msg;
> -
> -       while (line) {
> -               const char *eol = strchrnul(line, '\n'), *next;
> -
> -               if (line == eol)
> -                       return NULL;
> -               if (!*eol) {
> -                       warning("malformed commit (header is missing newline): %s",
> -                               sha1_to_hex(commit->object.sha1));
> -                       next = NULL;
> -               } else
> -                       next = eol + 1;
> -               if (eol - line > key_len &&
> -                   !strncmp(line, key, key_len) &&
> -                   line[key_len] == ' ') {
> -                       return xmemdupz(line + key_len + 1, eol - line - key_len - 1);
> -               }
> -               line = next;
> -       }
> -       return NULL;
> +       size_t len;
> +       const char *v = find_commit_header(msg, key, &len);
> +       return v ? xmemdupz(v, len) : NULL;
>  }
>
>  static char *replace_encoding_header(char *buf, const char *encoding)
> @@ -618,11 +598,10 @@ const char *logmsg_reencode(const struct commit *commit,
>
>         if (!output_encoding || !*output_encoding) {
>                 if (commit_encoding)
> -                       *commit_encoding =
> -                               get_header(commit, msg, "encoding");
> +                       *commit_encoding = get_header(msg, "encoding");
>                 return msg;
>         }
> -       encoding = get_header(commit, msg, "encoding");
> +       encoding = get_header(msg, "encoding");
>         if (commit_encoding)
>                 *commit_encoding = encoding;
>         use_encoding = encoding ? encoding : utf8;
> --
> 2.0.0.566.gfe3e6b2
