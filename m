From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone --branch: refuse to clone if upstream repo is empty
Date: Tue, 15 Oct 2013 02:08:38 +0700
Message-ID: <CACsJy8AgU89=s4P+28Smp5Vysbc06GhaN-o0Rw3N-OEOVbhLRA@mail.gmail.com>
References: <CAN0XMOLRt=kJPNhNDSfY_oMV90Xp=_wY=yf0OhiAcaShhWLCnA@mail.gmail.com>
 <1381510142-3026-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	robert.mitwicki@opensoftware.pl
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 21:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVnVy-0008H4-V5
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 21:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757133Ab3JNTJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 15:09:10 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:49798 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab3JNTJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 15:09:09 -0400
Received: by mail-ob0-f173.google.com with SMTP id wo20so5085441obc.18
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9Vsi9uUBtWm8WeyFfKjPI/MNDPQ/Csr7wety6TAciJw=;
        b=NkR2fHd3+IiulKkEiGpc1luDHMQ1eVhBQWAV3aQdSvUUtgHHqXCOQznunZK5xqLRZo
         kCXJN5Jc/M19TUxNCVmVsJ3rW5IWwAGZcXoqEovFXSJBccM1mlh/7cX0eTFbptEbgvI9
         mpUvawcG7hScBC02BR2/Y/zfD/FQ69WnTpWqDdumJrV3weVo8JJblz954RtkgPWmqJGo
         Q+BQjBee8KR2YQUN6SJ0ML8Ti/pBNpLyo8jjFRGqMOOt5K6QAvsc/Cqm14F/XOFfOfZa
         XjDngVU6gGmrGuBfaRP7NUi9UCmn3SEaJQaja6JrSG/r8fwWDyK5IEFvw7CaQfJwGttU
         cXMQ==
X-Received: by 10.60.42.168 with SMTP id p8mr22197oel.73.1381777748658; Mon,
 14 Oct 2013 12:09:08 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Mon, 14 Oct 2013 12:08:38 -0700 (PDT)
In-Reply-To: <1381510142-3026-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236114>

On Fri, Oct 11, 2013 at 11:49 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> Since 920b691 (clone: refuse to clone if --branch
> points to bogus ref) we refuse to clone with option
> "-b" if the specified branch does not exist in the
> (non-empty) upstream. If the upstream repository is empty,
> the branch doesn't exist, either. So refuse the clone too.

Yeah, much simpler approach :)

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/clone.c         | 4 ++++
>  t/t5706-clone-branch.sh | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ca3eb68..5af386e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -945,6 +945,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>                         our_head_points_at = remote_head_points_at;
>         }
>         else {
> +               if (option_branch)
> +                       die(_("Remote branch %s not found in upstream %s"),
> +                                       option_branch, option_origin);
> +
>                 warning(_("You appear to have cloned an empty repository."));
>                 mapped_refs = NULL;
>                 our_head_points_at = NULL;
> diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
> index 56be67e..6e7a7be 100755
> --- a/t/t5706-clone-branch.sh
> +++ b/t/t5706-clone-branch.sh
> @@ -20,7 +20,9 @@ test_expect_success 'setup' '
>          echo one >file && git add file && git commit -m one &&
>          git checkout -b two &&
>          echo two >file && git add file && git commit -m two &&
> -        git checkout master)
> +        git checkout master) &&
> +       mkdir empty &&
> +       (cd empty && git init)
>  '
>
>  test_expect_success 'vanilla clone chooses HEAD' '
> @@ -61,4 +63,8 @@ test_expect_success 'clone -b with bogus branch' '
>         test_must_fail git clone -b bogus parent clone-bogus
>  '
>
> +test_expect_success 'clone -b not allowed with empty repos' '
> +       test_must_fail git clone -b branch empty clone-branch-empty
> +'
> +
>  test_done
> --
> 1.8.4.652.g0d6e0ce
>



-- 
Duy
