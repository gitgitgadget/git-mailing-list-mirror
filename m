From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Thu, 17 Jan 2013 11:32:39 +0100
Message-ID: <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
	<1358376443-7404-1-git-send-email-apelisse@gmail.com>
	<1358376443-7404-2-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvmmQ-0003JZ-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 11:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759576Ab3AQKco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 05:32:44 -0500
Received: from mail-ea0-f175.google.com ([209.85.215.175]:39674 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759468Ab3AQKcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 05:32:41 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so929149eab.20
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 02:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OTufw+MO3OJ4Udydb+YCerpM5u8HbOxt4jNSZXmDm14=;
        b=fguMKWLGJgTdVSD5Yy1zfjXZajiklgrmmhXdjHs+LfKzG9RD3lHktpGJnV1+oZctUN
         sSJqBaSshlDMDUwnSFY/zukBRKRC0/hPqIaz/xox9EorjvjGgI31gvkbbPi4ztbYwghq
         L830BMoalEcpwbZ2zRRsMsRhDLMayDft44EIrhv8bZokAcjDjH5KRkfNh/kwh3hr6OH+
         yh/xycypKEfmYsQOJdA9i3ZXDz5jJ33JvmbOC+3yg4pbDoIn/ejZeHO21VPipfd66yjs
         nsSfZPQhCRTS18EhN9hk6ZVTXbgpqxJWFSO0Jct1HkwZcZFyHnWNd05Z5w0qA29P2WhX
         zUIA==
X-Received: by 10.14.223.135 with SMTP id v7mr12585413eep.41.1358418759687;
 Thu, 17 Jan 2013 02:32:39 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Thu, 17 Jan 2013 02:32:39 -0800 (PST)
In-Reply-To: <1358376443-7404-2-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213847>

John, could you confirm that you trigger the -Wtautological-compare
warning with your version of clang ?
And that this patch makes clang compilation warning-free (with the
very latest clang) ?

Cheers,

On Wed, Jan 16, 2013 at 11:47 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> Create a GREP_HEADER_FIELD_MIN so we can check that the field value is
> sane and silent the clang warning.
>
> Clang warning happens because the enum is unsigned (this is
> implementation-defined, and there is no negative fields) and the check
> is then tautological.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> I tried to consider discussion [1] and this [2] discussion on clang's list
>
> With these two patches and the patch from Max Horne, I'm finally able to
> compile with CC=clang CFLAGS=-Werror.
>
>  [1]: http://thread.gmane.org/gmane.comp.version-control.git/184908
>  [2]: http://clang-developers.42468.n3.nabble.com/Possibly-invalid-enum-tautology-warning-td3233140.html
>
>  grep.c | 3 ++-
>  grep.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 4bd1b8b..bb548ca 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -625,7 +625,8 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
>         for (p = opt->header_list; p; p = p->next) {
>                 if (p->token != GREP_PATTERN_HEAD)
>                         die("bug: a non-header pattern in grep header list.");
> -               if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
> +               if (p->field < GREP_HEADER_FIELD_MIN ||
> +                   GREP_HEADER_FIELD_MAX <= p->field)
>                         die("bug: unknown header field %d", p->field);
>                 compile_regexp(p, opt);
>         }
> diff --git a/grep.h b/grep.h
> index 8fc854f..e4a1df5 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -28,7 +28,8 @@ enum grep_context {
>  };
>
>  enum grep_header_field {
> -       GREP_HEADER_AUTHOR = 0,
> +       GREP_HEADER_FIELD_MIN = 0,
> +       GREP_HEADER_AUTHOR = GREP_HEADER_FIELD_MIN,
>         GREP_HEADER_COMMITTER,
>         GREP_HEADER_REFLOG,
>
> --
> 1.8.1.1.435.g20d29be.dirty
>
