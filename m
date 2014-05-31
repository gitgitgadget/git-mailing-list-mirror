From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH alt-v1] Improve function dir.c:trim_trailing_spaces()
Date: Sat, 31 May 2014 08:12:09 +0700
Message-ID: <CACsJy8DAgBms0=8JMfM_67DdURrKUXyLRYA-7v9rws2shyLPnw@mail.gmail.com>
References: <1401481233-14500-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 03:12:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqXqm-0002uQ-1i
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 03:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934345AbaEaBMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 21:12:40 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:58652 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbaEaBMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 21:12:39 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so7378816qge.22
        for <git@vger.kernel.org>; Fri, 30 May 2014 18:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zlEWou34A1G2cMVBKndqzF1sbjlT1Aa/rGlTbyWL3IA=;
        b=DoPOsBxHVsYj/kWMCKwJlDC0E4ZHOXFRk2d9osQh/Pay316MJmd/JOCOmmfyJE7Hcd
         +ylI9sd1V5p0doyzkRUMBuNuqDGLnm2zl5O8jUhZXozQT6C13lRtP5G7ZNywwp3o1YFo
         blRBgX9YRKo51BpgOvUBSFYzRVDJOhnd5WDOSSyMDeZAHLBy7QQRtetUtLnOc/JhvoG0
         V/5VvwloPPfoNUz7zq/XN1agofldwAYPRRsUoFLC3gutm1uJKeyPujYEoRQ1eJRtT5Mb
         LjkO1P66XUdWCvSZp3H8uALPBtYfVVk8XcNYi+4a+z2Xqfnj3M8RflNRhIfmsW+yXYuc
         fxqQ==
X-Received: by 10.140.20.68 with SMTP id 62mr21840228qgi.30.1401498759066;
 Fri, 30 May 2014 18:12:39 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Fri, 30 May 2014 18:12:09 -0700 (PDT)
In-Reply-To: <1401481233-14500-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250497>

On Sat, May 31, 2014 at 3:20 AM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
> Discard unnecessary 'nr_spaces' variable and improve
> the 'if' structure. Switch to pointers instead of integers
>
> Slightly more rare occurrences of 'text  \    ' with a backslash
> in between spaces are handled correctly. Namely, the code in
> 8ba87adad6 does not reset 'last_space' when a backslash is
> encountered and the above line stays intact as
> a result. Add a test at the end of t/t0008-ignores.sh to
> exhibit this behavior

Definitely easier to read than the other version. Nit, we usually
strip "!= NULL" and "== NULL" out of the conditional expressions.

>
> Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
> ---
> Instead of the "optimized" version, which had complaints about
> reasonability, I am attaching the "correction" of the original version.
> 'last_space' was not reset after encountering a backslash, and
> 'nr_spaces' is an unnecessary variable.
>
> I myself am still leaning towards the optimized version (which scans
> backwards instead of forward), since it completely ignores strings
> which do not have spaces at the end, while these forward implementations
> (both the one being attached and the original one) always scan
> all strings through. Again, I'm not attaching the optimized one
> because its readability is indeed less
>
>  dir.c              | 29 ++++++++++++++---------------
>  t/t0008-ignores.sh | 21 +++++++++++++++++++++
>  2 files changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index eb6f581..e67dcc2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -508,21 +508,20 @@ void clear_exclude_list(struct exclude_list *el)
>
>  static void trim_trailing_spaces(char *buf)
>  {
> -       int i, last_space = -1, nr_spaces, len = strlen(buf);
> -       for (i = 0; i < len; i++)
> -               if (buf[i] == '\\')
> -                       i++;
> -               else if (buf[i] == ' ') {
> -                       if (last_space == -1) {
> -                               last_space = i;
> -                               nr_spaces = 1;
> -                       } else
> -                               nr_spaces++;
> -               } else
> -                       last_space = -1;
> -
> -       if (last_space != -1 && last_space + nr_spaces == len)
> -               buf[last_space] = '\0';
> +       char *p, *last_space = NULL;
> +
> +       for (p = buf; *p; p++)
> +               if (*p == ' ') {
> +                       if (last_space == NULL)
> +                               last_space = p;
> +               } else {
> +                       if (*p == '\\')
> +                               p++;
> +                       last_space = NULL;
> +               }
> +
> +       if (last_space != NULL)
> +               *last_space = '\0';
>  }
>
>  int add_excludes_from_file_to_list(const char *fname,
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 63beb99..7becf96 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -806,4 +806,25 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
>         test_cmp err.expect err
>  '
>
> +test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
> +       rm -rf whitespace &&
> +       mkdir whitespace &&
> +       >"whitespace/trailing 1  "      &&
> +       >"whitespace/trailing 2 \\\\"   &&
> +       >"whitespace/trailing 3 \\\\"   &&
> +       >"whitespace/trailing 4   \\ "  &&
> +       >"whitespace/trailing 5 \\ \\ " &&
> +       >whitespace/untracked &&
> +       echo "whitespace/trailing 1 \\    "                     >ignore  &&
> +       echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\"           >>ignore &&
> +       echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ "          >>ignore &&
> +       echo "whitespace/trailing 4   \\\\\\\\\\\\    "         >>ignore &&
> +       echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   "   >>ignore &&
> +       echo whitespace/untracked >expect &&
> +       : >err.expect &&
> +       git ls-files -o -X ignore whitespace >actual 2>err &&
> +       test_cmp expect actual &&
> +       test_cmp err.expect err
> +'
> +
>  test_done
> --
> 1.9.1
>



-- 
Duy
