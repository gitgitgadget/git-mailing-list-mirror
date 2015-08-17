From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v7 2/2] path: implement common_dir handling in git_path_submodule()
Date: Mon, 17 Aug 2015 16:56:24 -0700
Message-ID: <CAGZ79kbCg1x0s_5eRLuxGs-7=-KvxLwpZ1h7ZFeZ-Yhgwfwe_Q@mail.gmail.com>
References: <1438725067-3295-1-git-send-email-max@max630.net>
	<1438725925-3689-1-git-send-email-max@max630.net>
	<1438725925-3689-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:56:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUGV-0002pH-6W
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 01:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbbHQX40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 19:56:26 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33652 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbHQX4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 19:56:25 -0400
Received: by ykll84 with SMTP id l84so79214557ykl.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V5rfLr1DZcFjw7z9OQ1iS2MPWZxM8PT3aRjR+pAnWqs=;
        b=J9+uaX6Uhv6YOwDZQ9ViqdhP0wAr0pDoANbPPExrn/jl5lCwund2/SLgQTSM1ohyHa
         l6Eyebn348IHeObPJjADh6LeuRgxtXmurBuj0qaVy/PLrNAGozyUCrusxgThTUVyObZ1
         pVY3mep2XPwLotzdpWEKCTYmJQ9qllDeDZsffM/BEP14OXbI3PkFU79qUPB6coXAWrR2
         C9ffKfrvMkzLm/IOfdooo48JEf+hnNSrgzDntp52wZyfx6HGS3hlZz32Bl8GWQxwu+8+
         WJwyB2AH6vnCv/Fi8YGsjhPUA8SwMBuzIP0LZ81JXfz8U6Iu8kmu66+ZEROmz7MZAddT
         9TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=V5rfLr1DZcFjw7z9OQ1iS2MPWZxM8PT3aRjR+pAnWqs=;
        b=TcdWi2iRXPhNe98qG9kkRBWtjMZISeJnLIrIVgYdIhI+Hp53soJqj4nBgFcl6Dbbce
         io5+HoJ4B+vBtXlQDq0o7TIpK8caPebD2NFTgcq9EuTGkLkvcuPyuSPqz9zTHiMKzt+f
         zvgg9CpNrQC9JXBmb4bESZ8bjhsPBVyQXoKkecRNmU5jYA4hXUEFSGl40JAOAM1KxlzT
         jj2g9cUcCMD8CSF0ptHqNc0x0qB20mc6LsN5rsGioUz8NpLcjju6TKTgqiGUXb1MnhI5
         eEGQVf0M9UUnmqFXlYwyKtdlBI+wFEIlrB7pPWl+HfuZwM1wvPZ9UgzTX+ZmBVVhjFZi
         Jvhg==
X-Gm-Message-State: ALoCoQkOQLPh0bRt9hbNJ3ISpeEMVVT7QO86WG4cfrxO/pEqSPwJXpn5+kw5x7Pd1bDTbthDlqYI
X-Received: by 10.170.186.131 with SMTP id c125mr4268512yke.25.1439855784971;
 Mon, 17 Aug 2015 16:56:24 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 17 Aug 2015 16:56:24 -0700 (PDT)
In-Reply-To: <1438725925-3689-3-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276107>

On Tue, Aug 4, 2015 at 3:05 PM, Max Kirillov <max@max630.net> wrote:
> When submodule is a linked worktree, "git diff --submodule" and other
> calls which directly access the submodule's object database do not correctly
> calculate its path. Fix it by changing the git_path_submodule() behavior,
> to use either common or per-worktree directory.
>
> Do it similarly as for parent repository, but ignore the GIT_COMMON_DIR
> environment variable, because it would mean common directory for the parent
> repository and does not make sense for submodule.
>
> Also add test for functionality which uses this call.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  cache.h                          |  1 +
>  path.c                           | 24 ++++++++++++++++++++----
>  setup.c                          | 17 ++++++++++++-----
>  t/t7410-submodule-checkout-to.sh | 10 ++++++++++
>  4 files changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 4f55466..b87ec75 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -442,6 +442,7 @@ extern char *get_object_directory(void);
>  extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
> +extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
>  extern int get_common_dir(struct strbuf *sb, const char *gitdir);
>  extern const char *get_git_namespace(void);
>  extern const char *strip_namespace(const char *namespaced_ref);
> diff --git a/path.c b/path.c
> index 10f4cbf..b0cf444 100644
> --- a/path.c
> +++ b/path.c
> @@ -98,7 +98,7 @@ static const char *common_list[] = {
>         NULL
>  };
>
> -static void update_common_dir(struct strbuf *buf, int git_dir_len)
> +static void update_common_dir(struct strbuf *buf, int git_dir_len, const char *common_dir)
>  {
>         char *base = buf->buf + git_dir_len;
>         const char **p;
> @@ -115,12 +115,17 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len)
>                         path++;
>                         is_dir = 1;
>                 }
> +
> +               if (!common_dir) {
> +                       common_dir = get_git_common_dir();
> +               }

Usually we omit the braces for blocks with just one command.

> +
>                 if (is_dir && dir_prefix(base, path)) {
> -                       replace_dir(buf, git_dir_len, get_git_common_dir());
> +                       replace_dir(buf, git_dir_len, common_dir);
>                         return;
>                 }
>                 if (!is_dir && !strcmp(base, path)) {
> -                       replace_dir(buf, git_dir_len, get_git_common_dir());
> +                       replace_dir(buf, git_dir_len, common_dir);
>                         return;
>                 }
>         }
> @@ -160,7 +165,7 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
>         else if (git_db_env && dir_prefix(base, "objects"))
>                 replace_dir(buf, git_dir_len + 7, get_object_directory());
>         else if (git_common_dir_env)
> -               update_common_dir(buf, git_dir_len);
> +               update_common_dir(buf, git_dir_len, NULL);
>  }
>
>  static void do_git_path(struct strbuf *buf, const char *fmt, va_list args)
> @@ -228,6 +233,8 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
>  {
>         struct strbuf *buf = get_pathname();
>         const char *git_dir;
> +       struct strbuf git_submodule_common_dir = STRBUF_INIT;
> +       struct strbuf git_submodule_dir = STRBUF_INIT;
>         va_list args;
>
>         strbuf_addstr(buf, path);
> @@ -241,11 +248,20 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
>                 strbuf_addstr(buf, git_dir);
>         }
>         strbuf_addch(buf, '/');
> +       strbuf_addstr(&git_submodule_dir, buf->buf);
>
>         va_start(args, fmt);
>         strbuf_vaddf(buf, fmt, args);
>         va_end(args);
> +
> +       if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf)) {
> +               update_common_dir(buf, git_submodule_dir.len, git_submodule_common_dir.buf);
> +       }
> +
>         strbuf_cleanup_path(buf);
> +
> +       strbuf_release(&git_submodule_dir);
> +       strbuf_release(&git_submodule_common_dir);
>         return buf->buf;
>  }
>
> diff --git a/setup.c b/setup.c
> index 82c0cc2..39ea06b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -229,14 +229,21 @@ void verify_non_filename(const char *prefix, const char *arg)
>
>  int get_common_dir(struct strbuf *sb, const char *gitdir)
>  {
> +       const char *git_env_common_dir = getenv(GIT_COMMON_DIR_ENVIRONMENT);
> +       if (git_env_common_dir) {
> +               strbuf_addstr(sb, git_env_common_dir);
> +               return 1;
> +       } else {
> +               return get_common_dir_noenv(sb, gitdir);
> +       }
> +}
> +
> +int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
> +{
>         struct strbuf data = STRBUF_INIT;
>         struct strbuf path = STRBUF_INIT;
> -       const char *git_common_dir = getenv(GIT_COMMON_DIR_ENVIRONMENT);
>         int ret = 0;
> -       if (git_common_dir) {
> -               strbuf_addstr(sb, git_common_dir);
> -               return 1;
> -       }
> +
>         strbuf_addf(&path, "%s/commondir", gitdir);
>         if (file_exists(path.buf)) {
>                 if (strbuf_read_file(&data, path.buf, 0) <= 0)
> diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
> index 3f609e8..1acef32 100755
> --- a/t/t7410-submodule-checkout-to.sh
> +++ b/t/t7410-submodule-checkout-to.sh
> @@ -47,4 +47,14 @@ test_expect_success 'checkout main and initialize independed clones' \
>  test_expect_success 'can see submodule diffs after independed cloning' \
>      '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
>
> +test_expect_success 'checkout sub manually' \
> +    'mkdir linked_submodule &&
> +    (cd clone/main &&
> +       git worktree add "$base_path/linked_submodule/main" "$rev1_hash_main") &&
> +    (cd clone/main/sub &&
> +       git worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub")'
> +
> +test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
> +    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
> +
>  test_done
> --
> 2.3.4.2801.g3d0809b

Looks good to me otherwise.

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
