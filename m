From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 08/19] grep.c: Use index api
Date: Sun, 14 Jul 2013 10:32:57 +0700
Message-ID: <CACsJy8CMqJ5TF1V7CMTQjnAUp=zXPYxotq5uLqvaF0Sikzv+uw@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-9-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 05:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyD41-0001ku-VI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 05:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3GNDd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 23:33:29 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43943 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab3GNDd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 23:33:28 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so12930901obc.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=az6kGn2VU0ab/tLQ7ae3rsVvq39EqA/t9h4niddXWRs=;
        b=sq54N8De/QsIRJS8T+U0yzkyrg0iJwpR3fAVHkQxOKZcZguHLYD6VN4s6UZFNHV5Mg
         5DNbw/F2fHIXIoSWwZfheW2PZM/dDIdKpZpENYJ2b4bZx7UOkhRejCoiy1jqKqnEYytX
         Q+lg+Xgvtozr10fdKBJ7R5FmCehZ4nk56ZdvxuGQ6Dk6T8OWU386dxHRw+oY9wn5Sj+j
         kafc3nrY2Kc94lUNM9Bhk746FQHWiGzgfeJcUnCsTD6Go/tXd5ZpC+zKRy76YNK3QGZQ
         87ar82KxO+chxrzqC1tDdQRTlipfHVCIeg5gcx2YZu0ncMlYY9k/zypYbxLyFNk9pfHC
         ZmHg==
X-Received: by 10.60.83.116 with SMTP id p20mr39547248oey.83.1373772808080;
 Sat, 13 Jul 2013 20:33:28 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 20:32:57 -0700 (PDT)
In-Reply-To: <1373650024-3001-9-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230304>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static int grep_cache(struct cache_entry *ce, void *cb_data)
>  {
> -       int hit = 0;
> -       int nr;
> -       read_cache();
> +       struct grep_opts *opts = cb_data;
>
> -       for (nr = 0; nr < active_nr; nr++) {
> -               struct cache_entry *ce = active_cache[nr];
> -               if (!S_ISREG(ce->ce_mode))
> -                       continue;
> -               if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
> -                       continue;
> -               /*
> -                * If CE_VALID is on, we assume worktree file and its cache entry
> -                * are identical, even if worktree file has been modified, so use
> -                * cache version instead
> -                */
> -               if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
> -                       if (ce_stage(ce))
> -                               continue;
> -                       hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
> -               }
> -               else
> -                       hit |= grep_file(opt, ce->name);
> -               if (ce_stage(ce)) {
> -                       do {
> -                               nr++;
> -                       } while (nr < active_nr &&
> -                                !strcmp(ce->name, active_cache[nr]->name));
> -                       nr--; /* compensate for loop control */
> -               }
> -               if (hit && opt->status_only)
> -                       break;
> -       }
> -       return hit;
> +       if (!S_ISREG(ce->ce_mode))
> +               return 0;
> +       if (!match_pathspec_depth(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL))
> +               return 0;

You do a match_pathspec_depth here..

> @@ -895,10 +887,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         } else if (0 <= opt_exclude) {
>                 die(_("--[no-]exclude-standard cannot be used for tracked contents."));
>         } else if (!list.nr) {
> +               struct grep_opts opts;
> +               struct filter_opts *filter_opts = xmalloc(sizeof(*filter_opts));
> +
>                 if (!cached)
>                         setup_work_tree();
>
> -               hit = grep_cache(&opt, &pathspec, cached);
> +               memset(filter_opts, 0, sizeof(*filter_opts));
> +               filter_opts->pathspec = &pathspec;
> +               opts.opt = &opt;
> +               opts.pathspec = &pathspec;
> +               opts.cached = cached;
> +               opts.hit = 0;
> +               read_cache_filtered(filter_opts);
> +               for_each_cache_entry(grep_cache, &opts);

And here again inside for_each_cache_entry. In the worst case that
could turn into 2 expensive fnmatch instead of one. Is this conversion
worth it? Note that match_pathspec is just a deprecated version of
match_pathspec_depth. They basically do the same thing.
-- 
Duy
