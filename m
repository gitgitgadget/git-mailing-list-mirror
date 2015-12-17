From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Thu, 17 Dec 2015 03:17:49 -0500
Message-ID: <CAPig+cT2ia-2LdJDTwkFUrFL84PfHvWXzQGJYzp9Os6=9aDxnw@mail.gmail.com>
References: <1449709654-30189-1-git-send-email-sbeller@google.com>
	<1450311999-3992-1-git-send-email-sbeller@google.com>
	<1450311999-3992-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 09:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Tl5-0001Hg-IO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 09:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbLQIRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 03:17:51 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35490 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbLQIRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 03:17:50 -0500
Received: by mail-vk0-f47.google.com with SMTP id a189so42035641vkh.2
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GRWEFopu2JV1eOEc6Ua4/+REzUQ9ddLiPHCIc0P2dMo=;
        b=fwR0XAHCRUbKRD+WlVLrCeQoObff7LDDrGXcg+0iePHQSrQfDWoT09ji3awS6YjUuN
         jpG2D4bie9ckFeyMKNjHflmoc6H7WkxZqZ8Mgl6xdzFppuISkZGPzxj5XsbsQ94M0+k3
         02NIv+YuBuAnhCXbi5BvwA5/LWvSHgjxoAMR3X3Y46Hs1qrRBlMeU/kp6jyUaMHZJ/9T
         D8ILxKWacqYbg1eaMuoGOKtTGA5n5Ye99ofxvFXY7IffcFDZmzPxGhyd7lNGMCt9AF6g
         agwY0fYvzykKgxpY8GqPTCuiOZ+RkIVRLXp0LLeKu40+TN7tSOFzcFHsmwheFXeycdQD
         Vf2g==
X-Received: by 10.31.128.138 with SMTP id b132mr9532805vkd.14.1450340269453;
 Thu, 17 Dec 2015 00:17:49 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 17 Dec 2015 00:17:49 -0800 (PST)
In-Reply-To: <1450311999-3992-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: AgDplqZC91ph-aUhuKlBihCSjyc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282639>

A rather superficial review...

On Wed, Dec 16, 2015 at 7:26 PM, Stefan Beller <sbeller@google.com> wrote:
> This reimplements the helper function `resolve_relative_url` in shell

s/This reimplements/Reimplement/

> in C. This functionality is needed in C for introducing the groups
> feature later on. When using groups, the user should not need to run
> `git submodule init`, but it should be implicit at all appropriate places,
> which are all in C code. As the we would not just call out to `git

I guess you mean "As then we..." or something?

> submodule init`, but do a more fine grained structure there, we actually
> need all the init functionality in C before attempting the groups
> feature. To get the init functionality in C, rewriting the
> resolve_relative_url subfunction is a major step.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -9,6 +9,156 @@
> +static const char *get_default_remote(void)
> +{
> +       char *dest = NULL;
> +       unsigned char sha1[20];
> +       int flag;
> +       struct strbuf sb = STRBUF_INIT;
> +       const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
> +
> +       if (!refname)
> +               die("No such ref: HEAD");
> +
> +       refname = shorten_unambiguous_ref(refname, 0);
> +       strbuf_addf(&sb, "branch.%s.remote", refname);
> +       if (git_config_get_string(sb.buf, &dest))
> +               return "origin";
> +       else
> +               return xstrdup(dest);

Leaking the strbuf at both returns.

And, leaking the strdup'd dest (in the caller), but I suppose that's
intentional?

> +}
> +
> +static int has_same_dir_prefix(const char *str, const char **out)
> +{
> +#ifdef GIT_WINDOWS_NATIVE
> +       return skip_prefix(str, "./", out)
> +               || skip_prefix(str, ".\\", out);
> +#else
> +       return skip_prefix(str, "./", out);
> +#endif
> +}
> +
> +static int has_upper_dir_prefix(const char *str, const char **out)
> +{
> +#ifdef GIT_WINDOWS_NATIVE
> +       return skip_prefix(str, "../", out)
> +               || skip_prefix(str, "..\\", out);
> +#else
> +       return skip_prefix(str, "../", out);
> +#endif
> +}
> +
> +static char *last_dir_separator(const char *str)
> +{
> +#ifdef GIT_WINDOWS_NATIVE
> +       return strrchr(str, "/")
> +               || strrchr(str, "\\");
> +#else
> +       return strrchr(str, '/');
> +#endif
> +}

Cleaner would be to move the #if's outside the functions:

    #ifdef GIT_WINDOWS_NATIVE

    /* Windows implementations */
    static int has_same_dir_prefix(...) {...}
    static int has_upper_dir_prefix(...) {...}
    static char *last_dir_separator(...) {...}

    #else

    /* POSIX implementations */
    static int has_same_dir_prefix(...) {...}
    static int has_upper_dir_prefix(...) {...}
    static char *last_dir_separator(...) {...}

    #endif

> +static const char *relative_url(const char *url, const char *up_path)
> +{
> +       int is_relative = 0;
> +       size_t len;
> +       char *remoteurl = NULL;
> +       char *sep = "/";

'sep' only ever holds a single character, so why not declare it 'char'
rather than 'char *'? (And, adjust the format string of strbuf_addf(),
of course.)

> +       const char *out;
> +       [...]
> +       while (url) {
> +               if (has_upper_dir_prefix(url, &out)) {
> +                       [...]
> +                       if (rfind)
> +                               *rfind = '\0';
> +                       else {
> +                               rfind = strrchr(remoteurl, ':');
> +                               if (rfind) {
> +                                       *rfind = '\0';
> +                                       sep = ":";
> +                               } else {
> +                                       [...]
> +                               }
> +                       }
> +               } else if (has_same_dir_prefix(url, &out))
> +                       url = out;
> +               else
> +                       break;
> +       }
> +       strbuf_reset(&sb);
> +       strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
> +
> +       if (!has_same_dir_prefix(sb.buf, &out))
> +               out = sb.buf;
> +       out = xstrdup(out);
> +
> +       strbuf_reset(&sb);
> +       strbuf_addf(&sb, "%s%s", is_relative && up_path ? up_path : "", out);
> +
> +       free((char*)out);

Why declare 'out' const if you know you will be freeing it?

> +       return strbuf_detach(&sb, NULL);
> +}
> +
> +static int resolve_relative_url(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc == 2)
> +               printf("%s\n", relative_url(argv[1], NULL));
> +       else if (argc == 3)
> +               printf("%s\n", relative_url(argv[1], argv[2]));
> +       else
> +               die("BUG: resolve_relative_url only accepts one or two arguments");
> +       return 0;
> +}
>
>  struct module_list {
>         const struct cache_entry **entries;
> @@ -264,6 +414,7 @@ static struct cmd_struct commands[] = {
>         {"list", module_list},
>         {"name", module_name},
>         {"clone", module_clone},
> +       {"resolve_relative_url", resolve_relative_url},

Can we please use hyphens rather than underscores, and name this
"resolve-relative-url" instead? Quoting from a review[1] of an earlier
version of git-submodule--helper:

    ... these subcommands would be better spelled with a hyphen than
    an underscore. If I recall correctly, the arguments for using
    underscore were (1) a less noisy diff, (2) these are internal
    commands nobody will be typing anyhow. However, (1) the diff
    noise will be the same with hyphens, and (2) people will want to
    test these commands manually anyhow, and its easier to type
    hyphens and easier to remember them since the precedent for
    hyphens in command-names is already well established.

    Also, the reason that the original shell code used underscores
    was because hyphens are not valid characters in shell function
    names, but that's an implementation detail which shouldn't be
    allowed to bleed over to user-facing interface design (and these
    subcommands are user-facing).

[1]: http://article.gmane.org/gmane.comp.version-control.git/276947

>  };
