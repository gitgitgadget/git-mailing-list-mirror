From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] diff: don't read index when --no-index is given
Date: Mon, 9 Dec 2013 15:57:21 -0500
Message-ID: <CAPig+cT_TXEAV-Jb_1N8vhKyenpEJLpw+7J45bsQ6aycdO3ftg@mail.gmail.com>
References: <20131209192000.GS29959@google.com>
	<1386621634-25444-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7ta-0001dJ-IH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059Ab3LIU5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:57:23 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:42731 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab3LIU5W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:57:22 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so2031176lab.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WnhURj2rZlF/5l41jiH/Eq0P3TaZNmu3sqBVXYJdroc=;
        b=QaWwVJyfum56e8WP5C8V9Gr/a65WTZ2+aWASoPapUvrwpiszLIDY1DfGhtY50ubpz9
         /87EjmdFdJwCbOIXd1Fm+vcqtJ0pAndmzoUu/EztfN4Vd+zFKq7MmzCRkbZnP7qqYkNu
         V4Rhg2WFO53fAxzQp2UAM/t1d0P00fZJ4/8YxEEDSrfKEcYHc6DeScOysE3vyHiiw4kq
         8tAgJhZdWAGBKA2a5wT03Ksn27IjCcUJ2ne6opffsz6ycKBCCDMHRo13vHYKr0v+IoGP
         7H05nwLIAcmUkkmtciW7qdPRWge3FEowrDzaKIyFuOPZdzai5MPzY7hFqkpkfAjkcrWS
         UAuA==
X-Received: by 10.152.116.46 with SMTP id jt14mr6380598lab.31.1386622641106;
 Mon, 09 Dec 2013 12:57:21 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Mon, 9 Dec 2013 12:57:21 -0800 (PST)
In-Reply-To: <1386621634-25444-1-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: J2wXBUeGwy0Z5VYxCN9NI8tWUio
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239097>

On Mon, Dec 9, 2013 at 3:40 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> git diff --no-index ... currently reads the index, during setup, when
> calling gitmodules_config().  This results in worse performance when
> the index is not actually needed.  This patch avoids calling
> gitmodules_config() when the --no-index option is given.  The times for
> executing "git diff --no-index" in the WebKit repository are improved as
> follows:
>
> Test                      HEAD~3            HEAD
> ------------------------------------------------------------------
> 4001.1: diff --no-index   0.24(0.15+0.09)   0.01(0.00+0.00) -95.8%
>
> An additional improvement of this patch is that "git diff --no-index" no
> longer breaks when the index file is corrupt, which makes it possible to
> use it for investigating the broken repository.
>
> To improve the possible usage as investigation tool for broken
> repositories, setup_git_directory_gently() is also not called when the
> --no-index option is given.
>
> Also add a test to guard against future breakages, and a performance
> test to show the improvements.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 979e983..d3dbf6b 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -29,4 +29,10 @@ test_expect_success 'git diff --no-index relative path outside repo' '
>         )
>  '
>
> +test_expect_success 'git diff --no-index with broken index' '
> +       cd repo &&
> +       echo broken >.git/index &&
> +       git diff --no-index a ../non/git/a &&
> +'

Stray && on the last line of the test.

Also, don't you want to do the 'cd' and subsequent commands inside a
subshell so that tests added after this one won't have to worry about
cd'ing back to the top-level?

> +
>  test_done
> --
> 1.8.5.4.g8639e57
