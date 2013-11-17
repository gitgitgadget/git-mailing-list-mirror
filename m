From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH] commit -v: strip diffs and submodule shortlogs from
 the commit message
Date: Sat, 16 Nov 2013 19:22:29 -0500
Message-ID: <CAPig+cTiwA7wg2eeCcfw8d=-+_QoxGiWVq9sABNdUTCka=5fbg@mail.gmail.com>
References: <loom.20131110T222043-57@post.gmane.org>
	<528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org>
	<52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org>
	<5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
	<5287F735.3030306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 17 01:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhq8Z-0002pU-4w
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 01:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab3KQAWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 19:22:32 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46497 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3KQAWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 19:22:30 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so53067lbi.29
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 16:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gOPzpRfZPLLwXmwcCIeyq2GCpkXA6hq9Av/oIn0puXg=;
        b=AcDW+F4Y4d4fJLeVOQuFpVRFnbX0H59b2jb/VHfRwLEDxxYU9JDSzo58n9OV7aUnxc
         tmgCgAPsetSc2OO5HsvS7uP6WfEjodaKSWXEaa38INhYqlpKyQZa4W3wzg3lmptc4mN5
         A5rmij59xsb8o5+jvj7QKIVb+ldJ2Zeq9ABo2YBGmjfCLYdlKuLj2uXbI1y/VRaLhgdx
         Qy8uuPXvlUi0RuitwpQiMKjYUPq0f2JhH2Fd+0ESDO0z8DvuTZn1TfOSYkX3W8UqOBz8
         rRhLQuTe2r+ne0dBvekpytgsuTcYJ/5xmjYPkK9UOQ1rCSg/tEAXL7Q+6MW96Ur2r0Il
         EOuA==
X-Received: by 10.152.23.137 with SMTP id m9mr8274322laf.17.1384647749137;
 Sat, 16 Nov 2013 16:22:29 -0800 (PST)
Received: by 10.114.200.180 with HTTP; Sat, 16 Nov 2013 16:22:29 -0800 (PST)
In-Reply-To: <5287F735.3030306@web.de>
X-Google-Sender-Auth: UcCKs2PaVbfulysWjW30mAuz4No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237948>

On Sat, Nov 16, 2013 at 5:52 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> When using the '-v' option of "git commit" the diff added to the commit
> message temporarily for editing is stripped off after the user exited the
> editor by searching for "\ndiff --git " and truncating the commmit message
> there if it is found. But this approach has two problems: when the commit
> message itself contains a line starting with "diff --git" it will be
> truncated there prematurely. And when the "diff.submodule" setting is set
> to "log", the diff may start with "Submodule <hash1>..<hash2>", which will
> be left in the commit message while it shouldn't.
>
> Fix that by introducing a special scissor separator line starting with the
> comment character '#' followed by a line describing what it is for. The
> scissor line is used to reliably detect the start of the diff so it can be
> chopped off from the commit message, no matter what the user enters there.
> Turn a known test failure fixed by this change into a successful test and
> add another one for a diff starting with a submodule log.
>
> Reported-by: Ari Pollak <ari@debian.org>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
>  builtin/commit.c          |  6 +++---
>  t/t7507-commit-verbose.sh | 15 ++++++++++++++-
>  wt-status.c               |  4 ++++
>  wt-status.h               |  2 ++
>  4 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605..091a6e7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1602,9 +1602,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>
>         /* Truncate the message just before the diff, if any. */
>         if (verbose) {
> -               p = strstr(sb.buf, "\ndiff --git ");
> -               if (p != NULL)
> -                       strbuf_setlen(&sb, p - sb.buf + 1);
> +               p = strstr(sb.buf, wt_status_diff_divider);

Would it make sense to use the more flexible is_scissors_line() from
builtin/mailinfo.c here?

> +               if ((p != NULL) && (p > sb.buf) && (p[-1] == '\n'))
> +                       strbuf_setlen(&sb, p - sb.buf);
>         }
>
>         if (cleanup_mode != CLEANUP_NONE)
> diff --git a/wt-status.c b/wt-status.c
> index b4e44ba..a3f7115 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -16,6 +16,8 @@
>  #include "column.h"
>  #include "strbuf.h"
>
> +const char wt_status_diff_divider[] = "# -----------------------------------8<-----------------------------------\n";
> +
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>         GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
>         GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
> @@ -791,6 +793,8 @@ static void wt_status_print_verbose(struct wt_status *s)
>          */
>         if (s->fp != stdout)
>                 rev.diffopt.use_color = 0;
> +       fprintf(s->fp, wt_status_diff_divider);
> +       fprintf(s->fp, _("# The diff below will be removed when keeping the previous line.\n"));
>         run_diff_index(&rev, 1);
>  }
>
> diff --git a/wt-status.h b/wt-status.h
> index 6c29e6f..cd2709f 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -91,6 +91,8 @@ struct wt_status_state {
>         unsigned char cherry_pick_head_sha1[20];
>  };
>
> +const char wt_status_diff_divider[];
> +
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
> --
