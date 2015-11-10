From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] Add git-grep threads param
Date: Tue, 10 Nov 2015 15:55:35 -0500
Message-ID: <CAPig+cQXCHzAJ80ZEHcM_+7J7jRs1obwuSzqe7sRDnuocMYUbw@mail.gmail.com>
References: <1447162118-17636-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:55:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwFx6-00032Z-7V
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 21:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbbKJUzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 15:55:37 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36482 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbKJUzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 15:55:36 -0500
Received: by ykdr82 with SMTP id r82so15935948ykd.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9szEi5bKMXBUW8wH9RrhU+oa+F+2eKGTP5SXTg2eVKY=;
        b=Dc2XyhpV4J1Bs/J1DH3+gF/FgRswldpF+ls2v0txfBhRt4eLGUsKie7iEmx/M5y3nj
         Xyy+3PI8K420sfXa+vvCc36cc22cjCtabJDuTj/E1Z4sd1q8kyiFdBb8gdVe7Q03fLoV
         9ZQwHVQ4HM67inSDH0/NjGw6MIU03zy3MZxBiFEom42Bdb7Pt98wHwNUMRejkS7NtuOt
         I3dqunGO8ctVxI4K0aqCpKNNVod0b014FtCpOK6hGMvGPA8u6zn9yLSQTxHwo+W7YJ6W
         7/UBdSsdeaYgHEQeZOkaacSfro6Wrkmrn4ClBQnnp2boO2rKJst4OVLAySAdcolo2vxp
         yD9w==
X-Received: by 10.129.53.132 with SMTP id c126mr5189963ywa.108.1447188935686;
 Tue, 10 Nov 2015 12:55:35 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 10 Nov 2015 12:55:35 -0800 (PST)
In-Reply-To: <1447162118-17636-1-git-send-email-vleschuk@accesssoftek.com>
X-Google-Sender-Auth: qi9zPCawlvkBnfdcTIq2bjlkVlM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281133>

On Tue, Nov 10, 2015 at 8:28 AM, Victor Leschuk <vleschuk@gmail.com> wrote:
> "git grep" can now be configured (or told from the command line)
>  how many threads to use when searching in the working tree files.
>
> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---

As an aid for reviewers, please use this space (below the "---" line)
to describe what changed since the previous version. It's also helpful
if you can provide a link to the previous version in the mailing list
archive.

>  Documentation/config.txt               |  7 +++++
>  Documentation/git-grep.txt             | 15 ++++++++++
>  builtin/grep.c                         | 50 +++++++++++++++++++++++-----------
>  contrib/completion/git-completion.bash |  1 +
>  4 files changed, 57 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1447,6 +1447,13 @@ grep.extendedRegexp::
>         option is ignored when the 'grep.patternType' option is set to a value
>         other than 'default'.
>
> +grep.threads::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.
> +       Default behavior can be changed in future versions
> +       to better suite hardware and circumstances.

s/suite/suit/ (here and elsewhere)

Was the conclusion of discussion that there should be some explanation
here that this is more about tuning for I/O rather than CPU, or did I
misunderstand?

>  gpg.program::
>         Use this custom program instead of "gpg" found on $PATH when
>         making or verifying a PGP signature. The program must support the
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 4a44d6d..91027b6 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> diff --git a/builtin/grep.c b/builtin/grep.c
> @@ -832,14 +846,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         }
>
>  #ifndef NO_PTHREADS
> -       if (list.nr || cached || online_cpus() == 1)
> -               use_threads = 0;
> +       if (list.nr || cached)
> +               num_threads = 0; /* Can not multi-thread object lookup */
> +       else if (num_threads == 0)
> +               num_threads = GREP_NUM_THREADS_DEFAULT; /* User didn't specify value, or just wants default behavior */
> +       else if (num_threads < 0)
> +               die("Invalid number of threads specified (%d)", num_threads);

The original code consulted online_cpus(), but the new code does not.
This is a sufficiently significant change that it deserves mention in
the commit message. In fact, it's really a distinct change which might
deserve being done in its own preparatory patch (with an explanation
something along the lines of "even single-core machines may benefit
from threading when the bottleneck is I/O").

>  #else
> -       use_threads = 0;
> +       num_threads = 0;
>  #endif
