From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH (performance tracing)] test git-status performance
Date: Sat, 26 Jul 2014 16:59:08 +0700
Message-ID: <CACsJy8BugcnUF1AmLqZ3jnWiRtark81jOTGkDP-xCr8LBgaf8A@mail.gmail.com>
References: <53AA0129.1080109@gmail.com> <53AA0228.4080600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 11:59:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAylV-0002xl-PW
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 11:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbaGZJ7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 05:59:40 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:62898 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaGZJ7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2014 05:59:39 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so5604757qae.20
        for <git@vger.kernel.org>; Sat, 26 Jul 2014 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F/QSRYfbzfKLy7iQmpnv/qr3Dkv2MgPF6ZjQnJZk1OU=;
        b=Ru8zBlKuKjUNNX91T5dpTSq3bddD8FUevHuQx0r1ouefSiGvCDD+W5yG3eCKJWD71s
         NEGCzqfzwVj0ry5kHAMpt7bXwLmlbgOI28K4hWm9ACos25IP15BuKWxH4ImvaAb/69zI
         2U722CYhQ9xeFB0KKzm0BLlheKyZve+1PJ1iHgGt+5TtwXdZPxCc7u57WZNxhH5pYa+F
         1IQdhRKn5nu8DRUR961qhHxH6UlLcHVbKsOBgy3n/M5XMI/huVYAolSUeuWRXHuBDv47
         7wKeMDwV28O/jUXgU4LFuBe6jtmc/CQVairyNnKtnWh2gxrANapzJ+1XrX+kKOnxFCTx
         HN1A==
X-Received: by 10.140.24.140 with SMTP id 12mr21165080qgr.11.1406368778733;
 Sat, 26 Jul 2014 02:59:38 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 26 Jul 2014 02:59:08 -0700 (PDT)
In-Reply-To: <53AA0228.4080600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254276>

On Wed, Jun 25, 2014 at 5:56 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Add trace_performance output to functions involved in git-status.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>

Should this patch be merged to git.git? It's useful for tracking
performance (of git-status) and does not seem to have any negative
impacts.

> ---
>
> Applies on top of performance-tracing topic.
>
>  builtin/commit.c |  8 ++++++++
>  preload-index.c  |  4 ++++
>  read-cache.c     |  2 ++
>  wt-status.c      | 11 +++++++++++
>  4 files changed, 25 insertions(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 94eb8a3..6a38fa2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1322,9 +1322,11 @@ static int git_status_config(const char *k, const char *v, void *cb)
>
>  int cmd_status(int argc, const char **argv, const char *prefix)
>  {
> +       uint64_t start = getnanotime();
>         static struct wt_status s;
>         int fd;
>         unsigned char sha1[20];
> +
>         static struct option builtin_status_options[] = {
>                 OPT__VERBOSE(&verbose, N_("be verbose")),
>                 OPT_SET_INT('s', "short", &status_format,
> @@ -1369,13 +1371,19 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>                        PATHSPEC_PREFER_FULL,
>                        prefix, argv);
>
> +       trace_performance_since(start, "cmd_status:setup");
> +
>         read_cache_preload(&s.pathspec);
>         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
>
> +       start = getnanotime();
> +
>         fd = hold_locked_index(&index_lock, 0);
>         if (0 <= fd)
>                 update_index_if_able(&the_index, &index_lock);
>
> +       trace_performance_since(start, "cmd_status:update_index");
> +
>         s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
>         s.ignore_submodule_arg = ignore_submodule_arg;
>         wt_status_collect(&s);
> diff --git a/preload-index.c b/preload-index.c
> index 968ee25..189c5a4 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -33,6 +33,7 @@ struct thread_data {
>
>  static void *preload_thread(void *_data)
>  {
> +       uint64_t start = getnanotime();
>         int nr;
>         struct thread_data *p = _data;
>         struct index_state *index = p->index;
> @@ -64,6 +65,7 @@ static void *preload_thread(void *_data)
>                         continue;
>                 ce_mark_uptodate(ce);
>         } while (--nr > 0);
> +       trace_performance_since(start, "preload_thread");
>         return NULL;
>  }
>
> @@ -106,8 +108,10 @@ static void preload_index(struct index_state *index,
>  int read_index_preload(struct index_state *index,
>                        const struct pathspec *pathspec)
>  {
> +       uint64_t start = getnanotime();
>         int retval = read_index(index);
>
>         preload_index(index, pathspec);
> +       trace_performance_since(start, "read_index_preload");
>         return retval;
>  }
> diff --git a/read-cache.c b/read-cache.c
> index 132d032..5c6b763 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1136,6 +1136,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>                   const struct pathspec *pathspec,
>                   char *seen, const char *header_msg)
>  {
> +       uint64_t start = getnanotime();
>         int i;
>         int has_errors = 0;
>         int really = (flags & REFRESH_REALLY) != 0;
> @@ -1222,6 +1223,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>
>                 replace_index_entry(istate, i, new);
>         }
> +       trace_performance_since(start, "refresh_index");
>         return has_errors;
>  }
>
> diff --git a/wt-status.c b/wt-status.c
> index 318a191..a744565 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -623,13 +623,24 @@ static void wt_status_collect_untracked(struct wt_status *s)
>
>  void wt_status_collect(struct wt_status *s)
>  {
> +       uint64_t start = getnanotime();
> +
>         wt_status_collect_changes_worktree(s);
>
> +       trace_performance_since(start, "wt_status_collect_changes_worktree");
> +       start = getnanotime();
> +
>         if (s->is_initial)
>                 wt_status_collect_changes_initial(s);
>         else
>                 wt_status_collect_changes_index(s);
> +
> +       trace_performance_since(start, "wt_status_collect_changes_index");
> +       start = getnanotime();
> +
>         wt_status_collect_untracked(s);
> +
> +       trace_performance_since(start, "wt_status_collect_untracked");
>  }
>
>  static void wt_status_print_unmerged(struct wt_status *s)
-- 
Duy
