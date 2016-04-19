From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] mv: allow moving nested submodules
Date: Tue, 19 Apr 2016 00:13:32 -0700
Message-ID: <CA+P7+xrzH3gMWsCBmW9y40AFOEfUxMQR+s8O05ofMN09nF_Pkw@mail.gmail.com>
References: <1461022884-30819-1-git-send-email-sbeller@google.com> <1461022884-30819-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, gmane@otterhall.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asPrB-0003Bt-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 09:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcDSHNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 03:13:54 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33809 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDSHNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 03:13:53 -0400
Received: by mail-vk0-f52.google.com with SMTP id e185so8819727vkb.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I01mzWS81OikfkWZEXYfBpoUNJuJ1fLOPlPIvhnyp50=;
        b=IPn2rLUyk8sdbNxYerPZsuL2Kd/NctFp22vBqvCCor7nlFYghi+MhgjhXoiJ0OT50+
         A9Ddo/mOdOvN8AB7ZQ01dJDYP3KYyXuFhTo1T9uQjz8+pIbZCbZgW8WtTiPuzQE9H+tJ
         D5bNfHO4by1hpwXGKIjro7+RQXmuqIUOtVU4ki2zLhifwMoqT+KizHyiWUrWKm330dGo
         equ6sZZtudyLsGsDHY47ZMSXPBFPqNkPBaPbU36lXWg8NLNGdqh/dDrldFBoPbq3hvPG
         b53cZah/9xiHvTvs2BWly3NY0Srajau8awAPYp6EZLtchJgfl7QnrYZcK4eBzHNkowuE
         iaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I01mzWS81OikfkWZEXYfBpoUNJuJ1fLOPlPIvhnyp50=;
        b=Sj2qTdMQCcIJ3p/0IlR1KGPRVa/ZOldOqg+Q5dOGMoyped81ahPO/7/imDTX/F4vkc
         3rNmUp/TeazOfcOpcrPwWZjP05Yi1GU0h8qVpqHYDGL9rYcSmC1dB6/slOlJMMlVeuQ2
         0TpP2WqKvMbCQNxoECtIPZ4WFu29k/XbUolvg0r1FzdWDfMArJj8woh1Hl9HmntUOcGT
         HpbLBLUQ1yESCJ/ruiYvKlepqO6OB0xAzCweYuwMPIZhoqXy/WxOaAS9PDN5hg5FMwsa
         NQ7l8RKzGgw2NdgnSrw7MjMrygIAQW1m3crZjyKLf50lQuQ6GEEU8OqwSdiu7FymsYiI
         v+BA==
X-Gm-Message-State: AOPr4FXtzVH4JHksl63g5VinOCDIJrABR3jn+2pY+HhKzoMDJlG9dgD4sAI0ej8W5/T+l+cA7k/fKq2fzNJJJQ==
X-Received: by 10.176.7.35 with SMTP id h32mr714760uah.17.1461050032254; Tue,
 19 Apr 2016 00:13:52 -0700 (PDT)
Received: by 10.159.53.112 with HTTP; Tue, 19 Apr 2016 00:13:32 -0700 (PDT)
In-Reply-To: <1461022884-30819-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291848>

On Mon, Apr 18, 2016 at 4:41 PM, Stefan Beller <sbeller@google.com> wrote:
> When directories are moved using `git mv` all files in the directory
> have been just moved, but no further action was taken on them. This
> was done by assigning the mode = WORKING_DIRECTORY to the files
> inside a moved directory.
>
> submodules however need to update their link to the git directory as
> well as updates to the .gitmodules file. By removing the condition of
> `mode != INDEX` (the remaining modes are BOTH and WORKING_DIRECTORY) for
> the required submodule actions, we perform these for submodules in a
> moved directory.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>


The patch looks good to me. I've marked some comments that I thought
through while reviewing but it looks correct.

> ---
>  builtin/mv.c  | 39 ++++++++++++++++++++++-----------------
>  t/t7001-mv.sh | 16 ++++++++++++++++
>  2 files changed, 38 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 74516f4..2deb95b 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -253,23 +253,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 int pos;
>                 if (show_only || verbose)
>                         printf(_("Renaming %s to %s\n"), src, dst);
> -               if (!show_only && mode != INDEX) {
> -                       if (rename(src, dst) < 0 && !ignore_errors)
> -                               die_errno(_("renaming '%s' failed"), src);
> -                       if (submodule_gitfile[i]) {
> -                               if ((submodule_gitfile[i] != SUBMODULE_WITH_GITDIR &&
> -                                   connect_work_tree_and_git_dir(dst, submodule_gitfile[i], &err)) ||
> -                                   update_path_in_gitmodules(src, dst, &err)) {
> -                                       if (err.len) {
> -                                               if (ignore_errors) {
> -                                                       warning("%s", err.buf);
> -                                                       continue;
> -                                               } else
> -                                                       die("%s", err.buf);
> -                                       }
> -                               } else
> -                                       gitmodules_modified = 1;
> -                       }
> +               if (show_only)
> +                       continue;

So here, we skip the item after displaying when we're in show only
mode. That seems correct.

> +               if (mode != INDEX &&
> +                   rename(src, dst) < 0) {
> +                       if (ignore_errors)
> +                               continue;
> +                       die_errno(_("renaming '%s' failed"), src);
> +               }

Then when the mode isn't INDEX, we attempt the rename.

> +
> +               if (submodule_gitfile[i]) {
> +                       if ((submodule_gitfile[i] != SUBMODULE_WITH_GITDIR &&
> +                           connect_work_tree_and_git_dir(dst, submodule_gitfile[i], &err)) ||
> +                           update_path_in_gitmodules(src, dst, &err)) {
> +                               if (err.len) {
> +                                       if (ignore_errors) {
> +                                               warning("%s", err.buf);
> +                                               continue;
> +                                       } else
> +                                               die("%s", err.buf);
> +                               }
> +                       } else
> +                               gitmodules_modified = 1;
>                 }

Finally for all modes, we perform the steps for submodules. That makes
sense to me.
>

This version results in a much larger diff, but I think the resulting
code is much easier to follow. The use of the continue allows us to
drop a layer of indentation making the remaining code a bit easier on
the eyes. The patch description doesn't at first glance match the code
change, since now it's a much larger chunk of moved code. However on
inspection, I don't think anything needs to change, as it's just the
conversion to if (show_only) { continue; }

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake
