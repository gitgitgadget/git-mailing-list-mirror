From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 09/15] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Wed, 20 Apr 2016 07:15:37 +0700
Message-ID: <CACsJy8CM409OH12w3EdVP3UjXoURbWNuqb_coQ=AagdCs+ctaQ@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com> <1461108489-29376-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 02:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asfod-0003es-W4
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 02:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbcDTAQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 20:16:16 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33494 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbcDTAQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 20:16:14 -0400
Received: by mail-lb0-f172.google.com with SMTP id u8so702189lbk.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qPb78qJXPh5TnsjWG0l+WRxy4BB3qr69+/9Yt5i0bE8=;
        b=bTpYm07qZEgZt1VCbc/PwvbXEifzI2N3TwFKRJr2r5CQg6Swrkgy80sGQmhrGz90Jw
         ZCqyrD6swZHhk95e2sRHt8XCVnA2QO4dHwoFOeYYlJNEsdqYpDM4K/hohVK0yBVaTvwu
         bFpTKqv/y2httEsYFXKGjZf8HkyjaiXH+k3DjJQGXXVebUwVDXEbao1yszfUO0VRBZyd
         4MuoHlook/7dKkk2ayF4tRJcoVwWk7fP41554O5pYdqpTbdoDAmP0HouK3LZUSXy48h0
         TSEvwHFNEQw6q8jpuwCdJUv7LJDyfAtv0NhuSViG8gaVGAOe5Ewl+QgXy405jkkDDUl1
         q+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qPb78qJXPh5TnsjWG0l+WRxy4BB3qr69+/9Yt5i0bE8=;
        b=LfQ0shILDtsFzoMgP2XDK6GRpLmE9GKEO/Q3jm8pA4zeiJawy4/Mr8n/vt+++7Zlr0
         f79CKA8KI9c+7HVPTohmklx1zNjYXCLbtN3nH4jq9XeUP8IK4N6LYBxRmoKDlegfbjbR
         ePe0t3wJhXYEVo5NmgYjVuTwmbuywwu/6rAcFxQz2U9nakFhgqczVeYM7xesqCxuQVxm
         y5+wuK1gRDU+ba8df/dk3wFwkv/dydrjQCXcTTSJDkDoJRlBnzGdJNM3xv5HfO5RRRaG
         FdnVg/thoH77Cbl4IqMggd2UW4BbRgUS29mCm4YFI/CUfJV2XZy12EA0IC2dQwoi5bsv
         Lufw==
X-Gm-Message-State: AOPr4FUd+JW6CY9FNtNWE4oB49QFr//zpE+smgoJ1IvQJrIH+bsTQneZPvs8KvFV/kBOWqPK7IQ+Im7DVbWHVQ==
X-Received: by 10.112.22.131 with SMTP id d3mr2292914lbf.145.1461111367459;
 Tue, 19 Apr 2016 17:16:07 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 19 Apr 2016 17:15:37 -0700 (PDT)
In-Reply-To: <1461108489-29376-10-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291971>

Continuing my comment from the --use-watchman patch about watchman not
being supported...

On Wed, Apr 20, 2016 at 6:28 AM, David Turner <dturner@twopensource.com> wrote:
> +static int poke_and_wait_for_reply(int fd)
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       struct strbuf reply = STRBUF_INIT;
> +       int ret = -1;
> +       fd_set fds;
> +       struct timeval timeout;
> +
> +       timeout.tv_usec = 0;
> +       timeout.tv_sec = 1;
> +
> +       if (fd < 0)
> +               return -1;
> +
> +       strbuf_addf(&buf, "poke %d", getpid());
> +       if (write_in_full(fd, buf.buf, buf.len + 1) != buf.len + 1)
> +               goto done_poke;
> +
> +       /* Now wait for a reply */
> +       FD_ZERO(&fds);
> +       FD_SET(fd, &fds);
> +       if (select(fd + 1, &fds, NULL, NULL, &timeout) == 0)
> +               /* No reply, giving up */
> +               goto done_poke;
> +
> +       if (strbuf_getwholeline_fd(&reply, fd, 0))
> +               goto done_poke;
> +
> +       if (!starts_with(reply.buf, "OK"))
> +               goto done_poke;

... while we could simply check USE_WATCHMAN macro and reject in
update-index, a better solution is sending "poke %d watchman" and
returning "OK watchman" (vs "OK") when watchman is supported and
active. If the user already requests watchman and index-helper returns
just "OK" then we can warn the user the reason of possible performance
degradation. It's related to the error reporting, but I don't think
you can send straight errors over unix socket. It's possible but it's
a bit more complicated.

> +static void refresh_by_watchman(struct index_state *istate)
> +{
> +       void *shm = NULL;
> +       int length;
> +       int i;
> +       struct stat st;
> +       int fd = -1;
> +       const char *path = git_path("shm-watchman-%s-%"PRIuMAX,
> +                                   sha1_to_hex(istate->sha1),
> +                                   (uintmax_t)getpid());
> +
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0)
> +               return;
> +
> +       /*
> +        * This watchman data is just for us -- no need to keep it
> +        * around once we've got it open.
> +        */
> +       unlink(path);

This will not play well when multiple processes read and refresh the
index at the same time. They could refresh non-overlapping
subdirectories, and I think it's perfectly ok for them to do so
(writing index down is a different matter). I don't have a good answer
for this. Perhaps if shm-watchman-%s-%d file is small enough (and it
should be, we store it in the index), then we can just send the
content straight over unix socket. I didn't have this option with my
signal-based communication model.

This is really extra. But if we know in advance that git does not need
refresh(), then we should be able to tell index-helper not to waste
cycles contacting watchman and preparing shm-watchman-%s-%d (the poke
line gets more parameters). Either that, or we decouple watchman
requests from read_cache() requests. Only when refresh_index() is
called that we send something to request shm-watchman-%s-%d. The same
for read_directory() (i.e. untracked cache stuff). Hmm?

Now that I think of it, with watchman backing us, we probably should
just do nothing in update_index_if_able() (or write_locked_index()
when we know only stat info is changed) when watchman is active. The
purpose of update_index_if_able() is to avoid costly refresh, but we
can already avoid that with watchman. And updating big index files is
always costly (even though it should cost less with split-index). Of
course this can only be done if watchman (inotify to be precise) can
cover whole worktree. I'm not sure how watchman behaves when there's
not enough inotify resource to cover full worktree.
-- 
Duy
