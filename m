From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] submodule--helper: initial clone learns retry logic
Date: Fri, 10 Jun 2016 16:31:36 -0700
Message-ID: <CAGZ79kb6qt0BM6ypJXXcBLh1ZbMpFi3Xk2StaT6BfmyjCCYAYA@mail.gmail.com>
References: <20160610003536.27924-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 01:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBVtv-0000ou-F1
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 01:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbcFJXbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 19:31:39 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36628 "EHLO
	mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcFJXbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 19:31:38 -0400
Received: by mail-qt0-f172.google.com with SMTP id 37so22479399qtc.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O0wOf/vXqGM2E2DVdn1XO5wBgb1v4UlIrXuBLHYS1j4=;
        b=Qjht0zYWfS6ut1GhosTXHpF/aIVaxw+r6d70i7HLbPOTmnl2Lo1I6MTTlg7DyVvkgW
         AQMalbkC2Ex9cayDT5Brwt9esxNwNZLgA2oYtKfAMJcJzS/ED2DiFWOBUxFW6Bdk3Szz
         5zghJLnOPOmPC9Z94YvBUNYvALoAbxjttE5xJuO7I8auswCpztAsbEEzM/95c3AupEf+
         WhRQfowDdJEL4tzxnQajrLp/nZeHM6KMem3z/RsGqJuZuqetvyqNDojfwU+tuYo2IKjE
         h1iWTFjBl1djdl0EAJq6DMu8RCBkn1KLRjozGbgcdrajEIUkPOK+rVYJtMfETA4PiA9z
         RfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O0wOf/vXqGM2E2DVdn1XO5wBgb1v4UlIrXuBLHYS1j4=;
        b=ZXpHo3QuMHPHWFgbdY+Ni3WS1OpFjIgvyQCzIFiGSn/Vi3e4luLn0xbfgcx4I7CbXj
         LNv/6v73kF0n4it4K2Fim+obGV+rIyO41nj1M87iRegskcCrtRmf6fciEmOMqRcMuowR
         W9eYLJXlXZtL4/iVhvWB4U7siqWrh/Z7axHqKQfhMG2HE/O5b76XJ5VWaXPEUIy3ULR+
         XolyGA1z9VFZFfHI2urtroTrXvozSjJ+fo+IURYLHg00zoenCBItFGLJLd/kwpmShyeZ
         +PXzH/hNLtKuoWbuxhCrW8KUzO9Ye2Qjd90JHRLDi8zG4kd92/tJzqiQ+eXx+I3B77xr
         K7gw==
X-Gm-Message-State: ALyK8tLvovrfnjQ+XZoVMrrHkPcShRTQRD6zIMkMbpQ34rpn3Ncgq4SVXpznlshdHvmWkj096N1jp4kO0PAkHoAX
X-Received: by 10.200.39.142 with SMTP id w14mr4421349qtw.59.1465601497321;
 Fri, 10 Jun 2016 16:31:37 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Fri, 10 Jun 2016 16:31:36 -0700 (PDT)
In-Reply-To: <20160610003536.27924-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297085>

On Thu, Jun 9, 2016 at 5:35 PM, Stefan Beller <sbeller@google.com> wrote:
> Each submodule that is attempted to be cloned, will be retried once in
> case of failure after all other submodules were cloned. This helps to
> mitigate ephemeral server failures and increases chances of a reliable
> clone of a repo with hundreds of submodules immensely.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  This patch doesn't do pointer forbidden magic, also we don't abuse the
>  prio queue.
>
>  The API for running parallel commands isn't quite designed for this
>  though as we need to pass around an int instead of a pointer, so we wrap
>  the int into a int*, which will create a xmalloc/free for each submodule.
>
>  This replaces the patch [1/2] in the series
>  "[PATCH 0/2] Dealing with a lot of submodules"
>
>  Thanks,
>  Stefan
>
>  builtin/submodule--helper.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c7deb55..6424b40 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -590,10 +590,14 @@ struct submodule_update_clone {
>
>         /* If we want to stop as fast as possible and return an error */
>         unsigned quickstop : 1;
> +
> +       /* failed clones to be retried again */
> +       const struct cache_entry **failed_clones;
> +       int failed_clones_nr, failed_clones_alloc;
>  };
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>         SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
> -       STRING_LIST_INIT_DUP, 0}
> +       STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
>
>
>  static void next_submodule_warn_missing(struct submodule_update_clone *suc,
> @@ -718,23 +722,47 @@ cleanup:
>  static int update_clone_get_next_task(struct child_process *child,
>                                       struct strbuf *err,
>                                       void *suc_cb,
> -                                     void **void_task_cb)
> +                                     void **idx_task_cb)
>  {
>         struct submodule_update_clone *suc = suc_cb;
> +       const struct cache_entry *ce;
> +       int index;
>
>         for (; suc->current < suc->list.nr; suc->current++) {
> -               const struct cache_entry *ce = suc->list.entries[suc->current];
> +               ce = suc->list.entries[suc->current];
>                 if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
> +                       int *p = xmalloc(sizeof(*p));
> +                       *p = suc->current;
> +                       *idx_task_cb = p;
>                         suc->current++;
>                         return 1;
>                 }
>         }
> +
> +       /*
> +        * The loop above tried cloning each submodule once, now try the
> +        * stragglers again, which we can imagine as an extension of the
> +        * entry list.
> +        */
> +       index = suc->current - suc->list.nr;
> +       if (index < suc->failed_clones_nr) {
> +               int *p;
> +               ce = suc->failed_clones[index];
> +               if (!prepare_to_clone_next_submodule(ce, child, suc, err))
> +                       die("BUG: ce was a submodule before?");
> +               p = xmalloc(sizeof(*p));
> +               *p = suc->current;
> +               *idx_task_cb = p;
> +               suc->current ++;
> +               return 1;
> +       }
> +
>         return 0;
>  }
>
>  static int update_clone_start_failure(struct strbuf *err,
>                                       void *suc_cb,
> -                                     void *void_task_cb)
> +                                     void *idx_task_cb)
>  {

Here we would leak the pointer, but as we quickstop soon, this may not
be a problem.

>         struct submodule_update_clone *suc = suc_cb;
>         suc->quickstop = 1;
> @@ -744,15 +772,39 @@ static int update_clone_start_failure(struct strbuf *err,
>  static int update_clone_task_finished(int result,
>                                       struct strbuf *err,
>                                       void *suc_cb,
> -                                     void *void_task_cb)
> +                                     void *idx_task_cb)
>  {
> +       const struct cache_entry *ce;
>         struct submodule_update_clone *suc = suc_cb;
>
> +       int *idxP = *(int**)idx_task_cb;
> +       int idx = *idxP;
> +       free(idxP);
> +
>         if (!result)
>                 return 0;
>
> -       suc->quickstop = 1;
> -       return 1;
> +       if (idx < suc->list.nr) {
> +               ce  = suc->list.entries[idx];
> +               strbuf_addf(err, _("Failed to clone '%s'. Retry scheduled"),
> +                           ce->name);
> +               strbuf_addch(err, '\n');
> +               ALLOC_GROW(suc->failed_clones,
> +                          suc->failed_clones_nr + 1,
> +                          suc->failed_clones_alloc);
> +               suc->failed_clones[suc->failed_clones_nr++] = ce;
> +               return 0;
> +       } else {
> +               idx = suc->current - suc->list.nr;
> +               ce  = suc->failed_clones[idx];
> +               strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
> +                           ce->name);
> +               strbuf_addch(err, '\n');
> +               suc->quickstop = 1;
> +               return 1;
> +       }
> +
> +       return 0;
>  }

I wonder how we can test this properly as the git binary we have here
is too reliable,
but I observed the correctness of this patch when cloning a repo with
lots of submodules
and one of them failing.

Thanks,
Stefan
