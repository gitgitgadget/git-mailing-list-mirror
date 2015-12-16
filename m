From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/11] strbuf: introduce strbuf_split_str_without_term()
Date: Wed, 16 Dec 2015 15:35:48 -0500
Message-ID: <CAPig+cQcCGVuzqYT3zXUMK=sF+QLCXUbbzcoqmaAe2zf+faWsA@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:35:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Ini-0000Mc-8K
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 21:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbbLPUfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 15:35:50 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35297 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbbLPUft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 15:35:49 -0500
Received: by mail-vk0-f51.google.com with SMTP id a189so33954776vkh.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Db4zzlfDlu8h0L/4M7GGhnCeSSoRwW20461Y9JKVlDA=;
        b=jKJYwzlZf8SAQ2sMZ3/aQew3UlIJ1hcl1ekj/4HT4HMrNwVAZZSzPDrupEb3UavDJ6
         354Q35le6NpqcyU6GNcTflrrN3f/I05OcmreYVT71x541w2CKXdXDYMAumYyC76IB7oD
         jlmeAoTzPNpZ7UKlEDoHiiH9hazztWLHEYqDGItCb8ILRYfXiBKj4aYjlXN978oDXNE0
         TZbVo1FrfAVV6You6uwNYU8zvw230XO6OkjyUZmliJ2JiFOvjJf/4G2URCke32VhpwNY
         xVfeY0xdRNjM6XBCLimMOayeBHx3ysTDHu+OcyzcQ5iwZ0Fsdz4jNnl9saUWbOpKZBSY
         nvtQ==
X-Received: by 10.31.182.129 with SMTP id g123mr35801398vkf.45.1450298148472;
 Wed, 16 Dec 2015 12:35:48 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 12:35:48 -0800 (PST)
In-Reply-To: <1450279802-29414-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: u6lxIQWq-Ra-k1we4Qp0Y-9xUPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282586>

On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> strbuf: introduce strbuf_split_str_without_term()

s/without/omit/

> The current implementation of 'strbuf_split_buf()' includes the
> terminator at the end of each strbuf post splitting. Add an option
> wherein we can drop the terminator if desired. In this context
> introduce a wrapper function 'strbuf_split_str_without_term()' which

s/without/omit/

> splits a given string into strbufs without including the terminator.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/strbuf.c b/strbuf.c
> @@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
> -                                int terminator, int max)
> +                                int terminator, int max, int omit_term)
>  {
>         struct strbuf **ret = NULL;
>         size_t nr = 0, alloc = 0;
> @@ -123,14 +123,15 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>
>         while (slen) {
>                 int len = slen;
> +               const char *end = NULL;
>                 if (max <= 0 || nr + 1 < max) {
> -                       const char *end = memchr(str, terminator, slen);
> +                       end = memchr(str, terminator, slen);
>                         if (end)
>                                 len = end - str + 1;
>                 }
>                 t = xmalloc(sizeof(struct strbuf));
>                 strbuf_init(t, len);
> -               strbuf_add(t, str, len);
> +               strbuf_add(t, str, len - !!end * !!omit_term);

This version of the patch with its minimal[1] change is much easier to
review for correctness than the original attempt[2].

[1]: http://article.gmane.org/gmane.comp.version-control.git/281882
[2]: http://article.gmane.org/gmane.comp.version-control.git/281189

>                 ALLOC_GROW(ret, nr + 2, alloc);
>                 ret[nr++] = t;
>                 str += len;
> diff --git a/strbuf.h b/strbuf.h
> index 6ae7a72..a865a74 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -450,11 +450,12 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
>  /**
>   * Split str (of length slen) at the specified terminator character.
>   * Return a null-terminated array of pointers to strbuf objects
> - * holding the substrings.  The substrings include the terminator,
> - * except for the last substring, which might be unterminated if the
> - * original string did not end with a terminator.  If max is positive,
> - * then split the string into at most max substrings (with the last
> - * substring containing everything following the (max-1)th terminator
> + * holding the substrings.  The substrings include the terminator if
> + * the value of omit_term is '0' else the terminator is excluded.  The

Perhaps just say "if omit_term is false" rather than "if the value of ... is 0".

> + * last substring, might be unterminated if the original string did
> + * not end with a terminator.  If max is positive, then split the

This bit about the last substring is perhaps too disconnected from the
previous sentence. What if you re-word the entire thing something like
this:

    If omit_term is true, the terminator will be stripped from all
    substrings. Otherwise, substrings will include the terminator,
    except for the final substring, if the original string lacked a
    terminator.

> + * string into at most max substrings (with the last substring
> + * containing everything following the (max-1)th terminator
>   * character).
>   *
>   * The most generic form is `strbuf_split_buf`, which takes an arbitrary
> @@ -465,19 +466,25 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
>   * For lighter-weight alternatives, see string_list_split() and
>   * string_list_split_in_place().
>   */
> -extern struct strbuf **strbuf_split_buf(const char *, size_t,
> -                                       int terminator, int max);
> +extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
> +                                       int terminator, int max, int omit_term);
> +
> +static inline struct strbuf **strbuf_split_str_omit_term(const char *str,
> +                                                           int terminator, int max)
> +{
> +       return strbuf_split_buf(str, strlen(str), terminator, max, 1);
> +}
>
>  static inline struct strbuf **strbuf_split_str(const char *str,
>                                                int terminator, int max)
>  {
> -       return strbuf_split_buf(str, strlen(str), terminator, max);
> +       return strbuf_split_buf(str, strlen(str), terminator, max, 0);
>  }
>
>  static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
>                                                 int terminator, int max)
>  {
> -       return strbuf_split_buf(sb->buf, sb->len, terminator, max);
> +       return strbuf_split_buf(sb->buf, sb->len, terminator, max, 0);
>  }
>
>  static inline struct strbuf **strbuf_split(const struct strbuf *sb,
> --
> 2.6.4
