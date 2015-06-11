From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] fetch-pack: optionally save packs to disk
Date: Thu, 11 Jun 2015 11:19:21 -0700
Message-ID: <CAGZ79kZo7ZCu8c=w6fxtccahX7vf1oo2ud8M2-q2AL_FuAyjsA@mail.gmail.com>
References: <1434044676-2942-1-git-send-email-augie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 20:19:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z374h-00081o-JX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 20:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbbFKSTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 14:19:25 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:33059 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbbFKSTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 14:19:24 -0400
Received: by yhpn97 with SMTP id n97so5385384yhp.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LMx+HIbGqYeM5r5CjZfIFfFfe0dyn3gd4ov2aMeaOp8=;
        b=W4foiIb21TSEBqaj68AZHe+IiMycf7TpHYz5H7ZSgvuUyQKV8bSoGfffAoE+ZwX3/I
         WJfCmqPNMaD5WXNfP4vy5UPmu22+V3CcXP++hXGFu3mjgzx8kopk20tTooY/sDgGAABY
         XxJ8jky9xtDdR3jnJHKjwbNNP0RvwmTbMzzObto68Q1dSbIPPxHc01Ry6D6QxqTT+V3U
         07riWdgL/9GnmmormIFo5nxbeQqT22BBgFH/WsTH1akYqP1HcRLqQxq8hW5mvpRUrkxT
         /gk7bh4oQnexOaAZUF9jNqNGPmLHbHQPWO05X73rYBLDvlfpqmmCuT5JhnZG5BCWNbgG
         vF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LMx+HIbGqYeM5r5CjZfIFfFfe0dyn3gd4ov2aMeaOp8=;
        b=Gd+mJC5afErF7bseZJy6PfNgcqhsMjZmiXL9PjYffdvhz6OidpFtgPJM9Wz/yxT63z
         401ByxQ7U2gu8BrUufoUL8rbrSZuOenYQSczeoXfM+Tq+4WkIKsuw0DDnPyfHMLCsQ34
         z6OwpalPAbOCZNa/y3CgHLMnfUmFd8MW2CnVAoYhBADxGBfh7gB9zaWPsgMELhrg5JjY
         S3GWDfO+USZvyNquhqYOLIT676f+XjMz5y/myixuugxfJWUUR5+MT6knvTVUpFX4ucm/
         ctpX0Ju9J7BREfqHBt5Etb2mpqYIRS0VzM5b7WS4t5r+iyJqUBscJdj0PMzA1x7FzYNk
         8dYA==
X-Gm-Message-State: ALoCoQlUL9RsSBvt7YXxNqnznIA/5IjoOHS/1Cj0QB5QvOEN0l9ECC9+4Q8TrQ4+mcSe8j5nc3OH
X-Received: by 10.13.238.71 with SMTP id x68mr13757132ywe.129.1434046761738;
 Thu, 11 Jun 2015 11:19:21 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Thu, 11 Jun 2015 11:19:21 -0700 (PDT)
In-Reply-To: <1434044676-2942-1-git-send-email-augie@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271448>

On Thu, Jun 11, 2015 at 10:44 AM, Augie Fackler <augie@google.com> wrote:
> When developing server software, it's often helpful to save a
> potentially-bogus pack for later analysis. This makes that trivial,
> instead of painful. This is made a little complicated by the fact that
> in some cases (like cloning from smart-http, but not from a local repo)
> the fetch code reads the pack header before sending the pack to
> index-pack (which then gets a --pack_header flag). The included tests
> cover both of these cases.
>
> To use the new feature, set GIT_SAVE_FETCHED_PACK_TO to a file path and
> git-fetch will do the rest. The resulting pack can be examined with
> git-index-pack or similar tools (although if it's corrupt, custom tools
> can be especially helpful.)

Please sign off your patch. (See Documentation/SubmittingPatches)

Do we want to document the config variable in Documentation/config.txt ?

Thanks,
Stefan

> ---
>  fetch-pack.c                | 44 ++++++++++++++++++++++++++++++++++++++++----
>  t/t5551-http-fetch-smart.sh | 12 ++++++++++++
>  t/t5601-clone.sh            |  9 +++++++++
>  3 files changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index a912935..fe6ba58 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -684,7 +684,7 @@ static int get_pack(struct fetch_pack_args *args,
>         const char *argv[22];
>         char keep_arg[256];
>         char hdr_arg[256];
> -       const char **av, *cmd_name;
> +       const char **av, *cmd_name, *savepath;
>         int do_keep = args->keep_pack;
>         struct child_process cmd = CHILD_PROCESS_INIT;
>         int ret;
> @@ -708,9 +708,8 @@ static int get_pack(struct fetch_pack_args *args,
>         cmd.argv = argv;
>         av = argv;
>         *hdr_arg = 0;
> +       struct pack_header header;
>         if (!args->keep_pack && unpack_limit) {
> -               struct pack_header header;
> -
>                 if (read_pack_header(demux.out, &header))
>                         die("protocol error: bad pack header");
>                 snprintf(hdr_arg, sizeof(hdr_arg),
> @@ -762,7 +761,44 @@ static int get_pack(struct fetch_pack_args *args,
>                 *av++ = "--strict";
>         *av++ = NULL;
>
> -       cmd.in = demux.out;
> +       savepath = getenv("GIT_SAVE_FETCHED_PACK_TO");
> +       if (savepath) {
> +               struct child_process cmd2 = CHILD_PROCESS_INIT;
> +               const char *argv2[22];
> +               int pipefds[2];
> +               int e;
> +               const char **av2;
> +               cmd2.argv = argv2;
> +               av2 = argv2;
> +               *av2++ = "tee";
> +               if (*hdr_arg) {
> +                       /* hdr_arg being nonempty means we already read the
> +                        * pack header from demux, so we need to drop a pack
> +                        * header in place for tee to append to, otherwise
> +                        * we'll end up with a broken pack on disk.
> +                        */
> +                       int fp;
> +                       struct sha1file *s;
> +                       fp = open(savepath, O_CREAT | O_TRUNC | O_WRONLY, 0666);
> +                       s = sha1fd_throughput(fp, savepath, NULL);
> +                       sha1write(s, &header, sizeof(header));
> +                       sha1flush(s);
> +                       close(fp);
> +                       /* -a is supported by both GNU and BSD tee */
> +                       *av2++ = "-a";
> +               }
> +               *av2++ = savepath;
> +               *av2++ = NULL;
> +               cmd2.in = demux.out;
> +               e = pipe(pipefds);
> +               if (e != 0)
> +                       die("couldn't make pipe to save pack");
> +               cmd2.out = pipefds[1];
> +               cmd.in = pipefds[0];
> +               if (start_command(&cmd2))
> +                       die("couldn't start tee to save a pack");
> +       } else
> +               cmd.in = demux.out;
>         cmd.git_cmd = 1;
>         if (start_command(&cmd))
>                 die("fetch-pack: unable to fork off %s", cmd_name);
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 58207d8..bf4640d 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -82,11 +82,23 @@ test_expect_success 'fetch changes via http' '
>         test_cmp file clone/file
>  '
>
> +test_expect_success 'fetch changes via http and save pack' '
> +       echo content >>file &&
> +       git commit -a -m two &&
> +       git push public &&
> +       GIT_SAVE_FETCHED_PACK_TO=saved.pack &&
> +       export GIT_SAVE_FETCHED_PACK_TO &&
> +       (cd clone && git pull) &&
> +       git index-pack clone/saved.pack
> +'
> +
>  cat >exp <<EOF
>  GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
>  POST /smart/repo.git/git-upload-pack HTTP/1.1 200
>  GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
>  POST /smart/repo.git/git-upload-pack HTTP/1.1 200
> +GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
> +POST /smart/repo.git/git-upload-pack HTTP/1.1 200
>  EOF
>  test_expect_success 'used upload-pack service' '
>         sed -e "
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index bfdaf75..73f9e1c 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -40,6 +40,15 @@ test_expect_success C_LOCALE_OUTPUT 'output from clone' '
>         test $(grep Clon output | wc -l) = 1
>  '
>
> +test_expect_success 'clone allows saving a pack' '
> +       rm -fr dst saved.pack &&
> +       GIT_SAVE_FETCHED_PACK_TO=saved.pack &&
> +       export GIT_SAVE_FETCHED_PACK_TO &&
> +       git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
> +       test -e saved.pack &&
> +       git index-pack saved.pack
> +'
> +
>  test_expect_success 'clone does not keep pack' '
>
>         rm -fr dst &&
> --
> 2.4.3.369.gda395ba.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
