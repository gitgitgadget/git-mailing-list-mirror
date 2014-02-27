From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: allow shallow fetching from a read-only repository
Date: Thu, 27 Feb 2014 17:11:41 +0700
Message-ID: <CACsJy8Di7vVhZzzHhavTPupbgeiKr70psq_U33C8i4c+auJxUA@mail.gmail.com>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com> <20140227090426.GA21892@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 11:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIxx6-0007Em-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 11:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbaB0KMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 05:12:17 -0500
Received: from mail-qc0-f182.google.com ([209.85.216.182]:57989 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbaB0KMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 05:12:12 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so1130628qcx.13
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 02:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bKLz9Hsoh34vQs2/yibxCD+WFGdSKPEcIJv7Eb+IBhE=;
        b=S/jn7d+Oh8azAT3HiCOHtqnfCmWLTPIDCYHZ9G2q4unFlmnnpx+YnveqZYBVMrZWM6
         QuTiBVUiQ10V+OX2/uJtYSF7B2mbazPVOM3yS8lZElaUSNwvcrOmdvDbgAGIjJRBQF6E
         RcA+owR4SojgXNA0UZcU1WStSGffdbDDGdPVjcfgmmME/cPP/1bFpf9IejSxDomk4t6y
         86sdIvFw2iysFk5OvpKh7lwYbPEdnPHqEZZuamSUjhiCKg45IITgbmevNFyXGTnmkBJP
         MMhb/uYUybcXTPSOuCjf3G3m/uvNS5ZeXr/V24N40rIgdgfU3WMQrjtwaZFqRYFi1xQG
         LRSA==
X-Received: by 10.140.93.130 with SMTP id d2mr5667145qge.41.1393495931766;
 Thu, 27 Feb 2014 02:12:11 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 27 Feb 2014 02:11:41 -0800 (PST)
In-Reply-To: <20140227090426.GA21892@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242798>

On Thu, Feb 27, 2014 at 4:04 PM, Jeff King <peff@peff.net> wrote:
> This is not introduced by your patch, but I notice that we do not seem
> to do anything with the tempfiles when the program dies prematurely.
> We've started collecting stale shallow_XXXXXX files in our server repos.
>
> For the writable cases, should we be using the lockfile API to take
> shallow.lock? It looks like we do take a lock on it, but only after the
> fetch, and then we have to do a manual check for it having moved (by the
> way, shouldn't we do that check under the lock? I think
> setup_alternate_shallow has a race condition).
>
> I guess the reason to take the lock at the last minute is that the whole
> fetch is heavyweight. But if the fetches are going to conflict, perhaps
> it is better to have lock contention at the beginning, rather than
> failing only at the end. I don't know very much about the shallow
> system; does each operation rewrite the shallow file, or is it often
> left untouched (in which case two simultaneous fetches could coexist
> most of the time).

For writable cases (fetch-pack and receive-pack), yes I think locking
earlier is better or multiple fetches/pushes will race to update
shallow file. Chances of racing fetches are practically near zero, I
think. We need to do something about push.

We only update shallow file in these cases: clone --depth, fetch
--update-shallow, fetch --depth, and push when receive.shallowupdate
is set. All of them may end up not updating shallow file though. The
last case is the most troublesome because receive.shallowupdate is set
at server side and we don't want any shallow push to block all other
shallow pushes..

For read-only case in upload-file, locking only reduces the
availability of clone/fetch.

> At any rate, if we used the lockfile API, it handles tempfile cleanup
> automatically. Otherwise, I think we need something like the patch
> below (in the interest of simplicity, I just drop all of the explicit
> unlinks and let them use the atexit handler to clean up; you could also
> add a function to explicitly unlink the tempfile and clear the handler).

Looks like a good thing to do anyway.

>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 85bba35..ac1d9b5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -833,8 +833,6 @@ static void execute_commands(struct command *commands,
>                         error("BUG: run 'git fsck' for safety.\n"
>                               "If there are errors, try to remove "
>                               "the reported refs above");
> -               if (alt_shallow_file && *alt_shallow_file)
> -                       unlink(alt_shallow_file);
>         }
>  }
>
> @@ -1087,10 +1085,6 @@ static void update_shallow_info(struct command *commands,
>                         cmd->skip_update = 1;
>                 }
>         }
> -       if (alt_shallow_file && *alt_shallow_file) {
> -               unlink(alt_shallow_file);
> -               alt_shallow_file = NULL;
> -       }
>         free(ref_status);
>  }
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 90fdd49..ae8550e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -947,17 +947,6 @@ static void update_shallow(struct fetch_pack_args *args,
>         if (!si->shallow || !si->shallow->nr)
>                 return;
>
> -       if (alternate_shallow_file) {
> -               /*
> -                * The temporary shallow file is only useful for
> -                * index-pack and unpack-objects because it may
> -                * contain more roots than we want. Delete it.
> -                */
> -               if (*alternate_shallow_file)
> -                       unlink(alternate_shallow_file);
> -               free((char *)alternate_shallow_file);
> -       }
> -
>         if (args->cloning) {
>                 /*
>                  * remote is shallow, but this is a clone, there are
> diff --git a/shallow.c b/shallow.c
> index bbc98b5..0f2bb48 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -8,6 +8,7 @@
>  #include "diff.h"
>  #include "revision.h"
>  #include "commit-slab.h"
> +#include "sigchain.h"
>
>  static int is_shallow = -1;
>  static struct stat shallow_stat;
> @@ -216,27 +217,49 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
>         return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
>  }
>
> +static struct strbuf shallow_tmpfile = STRBUF_INIT;
> +
> +static void remove_shallow_tmpfile(void)
> +{
> +       if (shallow_tmpfile.len) {
> +               unlink_or_warn(shallow_tmpfile.buf);
> +               strbuf_reset(&shallow_tmpfile);
> +       }
> +}
> +
> +static void remove_shallow_tmpfile_on_signal(int signo)
> +{
> +       remove_shallow_tmpfile();
> +       sigchain_pop(signo);
> +       raise(signo);
> +}
> +
>  char *setup_temporary_shallow(const struct sha1_array *extra)
>  {
>         struct strbuf sb = STRBUF_INIT;
>         int fd;
>
>         if (write_shallow_commits(&sb, 0, extra)) {
> -               struct strbuf path = STRBUF_INIT;
> -               strbuf_addstr(&path, git_path("shallow_XXXXXX"));
> -               fd = xmkstemp(path.buf);
> +               strbuf_addstr(&shallow_tmpfile, git_path("shallow_XXXXXX"));
> +               fd = xmkstemp(shallow_tmpfile.buf);
> +
> +               /* XXX can there be multiple shallow tempfiles in one program?
> +                * In that case, we would need to maintain a list */
> +               atexit(remove_shallow_tmpfile);
> +               sigchain_push_common(remove_shallow_tmpfile_on_signal);
> +
>                 if (write_in_full(fd, sb.buf, sb.len) != sb.len)
>                         die_errno("failed to write to %s",
> -                                 path.buf);
> +                                 shallow_tmpfile.buf);
>                 close(fd);
>                 strbuf_release(&sb);
> -               return strbuf_detach(&path, NULL);
> +               return shallow_tmpfile.buf;
>         }
>         /*
>          * is_repository_shallow() sees empty string as "no shallow
>          * file".
>          */
> -       return xstrdup("");
> +       return shallow_tmpfile.buf;
>  }
>
>  void setup_alternate_shallow(struct lock_file *shallow_lock,
> diff --git a/upload-pack.c b/upload-pack.c
> index 0c44f6b..55c1f71 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -242,11 +242,6 @@ static void create_pack_file(void)
>                 error("git upload-pack: git-pack-objects died with error.");
>                 goto fail;
>         }
> -       if (shallow_file) {
> -               if (*shallow_file)
> -                       unlink(shallow_file);
> -               free(shallow_file);
> -       }
>
>         /* flush the data */
>         if (0 <= buffered) {



-- 
Duy
