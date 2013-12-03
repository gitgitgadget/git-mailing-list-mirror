From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] tests: fix gzip with exported GZIP variable in environment
Date: Tue, 3 Dec 2013 04:49:06 -0500
Message-ID: <CAPig+cQqKQdVEojYF+-+ZE2hQjxsH4WrgPymj8g7P6pSQzfVpw@mail.gmail.com>
References: <1386061054-30796-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Tue Dec 03 10:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnmbR-00068t-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 10:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab3LCJtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 04:49:10 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45172 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3LCJtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 04:49:07 -0500
Received: by mail-lb0-f177.google.com with SMTP id w7so8567684lbi.22
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iVRsNi+yZmhFxI3vfU9a+ymZTVkR+3jmy5mZS/lzDDw=;
        b=YWWLjkqpt8192s6+u7/vksja900EINlO/LFnhOeohByR4645S7FEqanqydEBWWk7rI
         Rqj3E3LhedVC1TJ7FYALrUmDay6k3GWKe+k2A8qw8DSOI/jHgg7V2AKTvPRns/nOp2/6
         lJ60BJQq/uSOGMHA2Eucd9X1bRsstW4XSe/8GZkTXVPhSiI2g0CYcFraYQmrkr3a+QzQ
         w+mi4o/a+tDol9YuWC8kih3eJCUPy2JIWoMjlT74c5fEXXjrJgYm3I9k/t37IT4Emp2m
         SEpO2twrdeHwqgCHj3GWIWgy3iW73SZXjWaqjFUGWjy9GcE9B1wV+uBQ7UrUVKuxxQe0
         S73w==
X-Received: by 10.112.37.134 with SMTP id y6mr538705lbj.29.1386064146088; Tue,
 03 Dec 2013 01:49:06 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Tue, 3 Dec 2013 01:49:06 -0800 (PST)
In-Reply-To: <1386061054-30796-1-git-send-email-mail@eworm.de>
X-Google-Sender-Auth: 9-zkkSoUFH6OUgcnhmYqJ745XsU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238680>

[cc'ing Peff, the author of these tests]

On Tue, Dec 3, 2013 at 3:57 AM, Christian Hesse <mail@eworm.de> wrote:
> In t/t5000-tar-tree.sh the variable GZIP is used for the command name.
> From man gzip:
>
>> The environment variable GZIP can hold a set of default options for
>> gzip. These options are interpreted first and can be overwritten by
>> explicit command line parameters.
>
> So using any other variable name fixes this.

Missing Signed-off-by: <you>

> ---
>  t/t5000-tar-tree.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index c2023b1..01b0ed9 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -25,7 +25,7 @@ commit id embedding:
>  '
>
>  . ./test-lib.sh
> -GZIP=${GZIP:-gzip}
> +GZIPCMD=${GZIPCMD:-gzip}
>  GUNZIP=${GUNZIP:-gzip -d}
>
>  SUBSTFORMAT=%H%n
> @@ -275,27 +275,27 @@ test_expect_success 'only enabled filters are available remotely' '
>         test_cmp remote.bar config.bar
>  '
>
> -if $GZIP --version >/dev/null 2>&1; then
> -       test_set_prereq GZIP
> +if $GZIPCMD --version >/dev/null 2>&1; then
> +       test_set_prereq GZIPCMD

test_set_prereq is not actually operating on an environment variable.
Its argument is just a generic tag, which is uppercase by convention,
but not otherwise related to a variable which may share the same name,
and which does not pollute the environment. Consequently, it should
not be necessary to rename the argument to test_set_prereq, thus all
changes following this one become superfluous (since they are checking
for presence of tag GZIP, not referencing environment variable GZIP or
GZIPCMD). Thus, the patch becomes much smaller.

In fact, the GZIP command does not appear to be used at all by the
tests, so a simpler solution might be to remove the variable
altogether, and perhaps the prerequisite. Peff?

>  else
>         say "Skipping some tar.gz tests because gzip not found"
>  fi
>
> -test_expect_success GZIP 'git archive --format=tgz' '
> +test_expect_success GZIPCMD 'git archive --format=tgz' '
>         git archive --format=tgz HEAD >j.tgz
>  '
>
> -test_expect_success GZIP 'git archive --format=tar.gz' '
> +test_expect_success GZIPCMD 'git archive --format=tar.gz' '
>         git archive --format=tar.gz HEAD >j1.tar.gz &&
>         test_cmp j.tgz j1.tar.gz
>  '
>
> -test_expect_success GZIP 'infer tgz from .tgz filename' '
> +test_expect_success GZIPCMD 'infer tgz from .tgz filename' '
>         git archive --output=j2.tgz HEAD &&
>         test_cmp j.tgz j2.tgz
>  '
>
> -test_expect_success GZIP 'infer tgz from .tar.gz filename' '
> +test_expect_success GZIPCMD 'infer tgz from .tar.gz filename' '
>         git archive --output=j3.tar.gz HEAD &&
>         test_cmp j.tgz j3.tar.gz
>  '
> @@ -306,17 +306,17 @@ else
>         say "Skipping some tar.gz tests because gunzip was not found"
>  fi
>
> -test_expect_success GZIP,GUNZIP 'extract tgz file' '
> +test_expect_success GZIPCMD,GUNZIP 'extract tgz file' '
>         $GUNZIP -c <j.tgz >j.tar &&
>         test_cmp b.tar j.tar
>  '
>
> -test_expect_success GZIP 'remote tar.gz is allowed by default' '
> +test_expect_success GZIPCMD 'remote tar.gz is allowed by default' '
>         git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
>         test_cmp j.tgz remote.tar.gz
>  '
>
> -test_expect_success GZIP 'remote tar.gz can be disabled' '
> +test_expect_success GZIPCMD 'remote tar.gz can be disabled' '
>         git config tar.tar.gz.remote false &&
>         test_must_fail git archive --remote=. --format=tar.gz HEAD \
>                 >remote.tar.gz
> --
> 1.8.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
