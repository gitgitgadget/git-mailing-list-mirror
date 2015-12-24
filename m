From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 04/11] update-index: add untracked cache notifications
Date: Thu, 24 Dec 2015 17:01:50 +0700
Message-ID: <CACsJy8BQi8LQSHsZ7UMduCdE2_AeNwxn3kppc1xTfaNsMN=OXA@mail.gmail.com>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org> <1450904639-25592-5-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 11:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC2j5-00057q-MT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 11:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbLXKCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 05:02:23 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34046 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbbLXKCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 05:02:21 -0500
Received: by mail-lb0-f171.google.com with SMTP id pv2so72784059lbb.1
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 02:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yuLYNGZycLGScn6lMg0NmKkK66eNFhNST4CVY+laXLg=;
        b=TlpUHNLrqN2TcwMoBS+GDwGORChGGIfJ3lylmVzDIop/1CEdYl8swfwJTlaJ2I6GqJ
         S0f1vtksMWMyTE4x40qPU0yAhd9pP57BIt4+08UocDNPwscfVA7FKSMz4csjbXI247g6
         h6nr7qe6j8IdniKdzszW32OYYR9okoPisCGfp750MnzQpeTdkvjD53i52XltZP1Hn/fL
         QqKyuZ8SAVXRqzC5xYvksxD8iROGa4TLBt6h4MJenJyS3xBd4CSzXGunotAnt0hhMlgw
         EV1AspAKaL8NrLNUe04ludhJn+EyWVaJmLbqe+6D39TD8y1jaXv1Y+avsMkhAOL1UMG4
         yqVw==
X-Received: by 10.112.172.233 with SMTP id bf9mr12120312lbc.137.1450951339990;
 Thu, 24 Dec 2015 02:02:19 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 24 Dec 2015 02:01:50 -0800 (PST)
In-Reply-To: <1450904639-25592-5-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282978>

On Thu, Dec 24, 2015 at 4:03 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Attempting to flip the untracked-cache feature on for a random index
> file with
>
>     cd /random/unrelated/place
>     git --git-dir=/somewhere/else/.git update-index --untracked-cache
>
> would not work as you might expect. Because flipping the feature on
> in the index also records the location of the corresponding working
> tree (/random/unrelated/place in the above example), when the index
> is subsequently used to keep track of files in the working tree in
> /somewhere/else, the feature is disabled.
>
> With this patch "git update-index --[test-]untracked-cache" tells the
> user in which directory tests are performed. This makes it easy to
> spot any problem.
>
> Also in verbose mode, let's tell the user when the cache is enabled
> or disabled.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 62222dd..c91e695 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -130,7 +130,7 @@ static int test_if_untracked_cache_is_supported(void)
>         if (!mkdtemp(mtime_dir.buf))
>                 die_errno("Could not make temporary directory");
>
> -       fprintf(stderr, _("Testing "));
> +       fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
>         atexit(remove_test_directory);
>         xstat_mtime_dir(&st);
>         fill_stat_data(&base, &st);
> @@ -1135,10 +1135,16 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                 }
>                 add_untracked_ident(the_index.untracked);
>                 the_index.cache_changed |= UNTRACKED_CHANGED;
> -       } else if (untracked_cache == UC_DISABLE && the_index.untracked) {
> -               free_untracked_cache(the_index.untracked);
> -               the_index.untracked = NULL;
> -               the_index.cache_changed |= UNTRACKED_CHANGED;
> +               if (verbose)
> +                       printf(_("Untracked cache enabled for '%s'\n"), get_git_work_tree());

Nit. If you use report(), then you can skip "if (verbose)" because
it's done inside report().

> +       } else if (untracked_cache == UC_DISABLE) {
> +               if (the_index.untracked) {
> +                       free_untracked_cache(the_index.untracked);
> +                       the_index.untracked = NULL;
> +                       the_index.cache_changed |= UNTRACKED_CHANGED;
> +               }
> +               if (verbose)
> +                       printf(_("Untracked cache disabled\n"));
>         }
>
>         if (active_cache_changed) {
> --
> 2.7.0.rc2.11.g68ccdd4
>
-- 
Duy
