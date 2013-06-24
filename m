From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 08:58:40 +0200
Message-ID: <CALKQrgebusbcDOTR+bFccoT4qzDJ8E=2LULutL0egEN9YY1v_g@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 08:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur0jj-0006Cj-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 08:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab3FXG6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 02:58:46 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:64213 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab3FXG6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 02:58:44 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur0jc-000LfP-4Z
	for git@vger.kernel.org; Mon, 24 Jun 2013 08:58:44 +0200
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uqzcz-0008Qe-73
	for git@vger.kernel.org; Mon, 24 Jun 2013 07:47:49 +0200
Received: by mail-ob0-f173.google.com with SMTP id wc20so10534293obb.18
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 23:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=leRhdII4/8gPudgvAFOlqBB5/Ff/DQ/DAb9t4t1liZo=;
        b=SUzk4YNLNYnkMU1qGH/ybud5gSLk/3x9yJT9KlU/rWvPpb1pzg5Ppx8EMjkeB34b1f
         tQ0Tz0A9uuOIQFYvBHP+sk9PweoTser5E7cfINLpXfX/zgwxYB223YlvogS37WwmwP9a
         ea/nfeIkw6byxB3f1tQOf8I4QHS2nl/6/wuqbfyapAN0x+M27jYePpcCBOWhj82LeBdS
         prrzJh3HG/KeI6vS+NptL5Snuj27ivkkE8oGQ0sFxRyWPh89nXmhdwf84ChWWJDLqP41
         /lbKxHyanjnTWULRl/1Luv0nNBDw/xw8bOzNU9CJYTyW/fm6BHy+A/D4MIfYzMu/B0Tb
         D7ew==
X-Received: by 10.182.81.34 with SMTP id w2mr7486025obx.8.1372057120324; Sun,
 23 Jun 2013 23:58:40 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Sun, 23 Jun 2013 23:58:40 -0700 (PDT)
In-Reply-To: <1372048388-16742-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228779>

On Mon, Jun 24, 2013 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When branch.*.push configuration variable is defined for the current
> branch, a lazy-typing "git push" (and "git push there") will push
> the commit at the tip of the current branch to the destination and
> update the branch named by that variable.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/push.c | 18 +++++++++++++++++-
>  remote.c       |  5 +++++
>  remote.h       |  2 ++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index f6c8047..a140b8e 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -185,6 +185,15 @@ static void warn_unspecified_push_default_configuration(void)
>         warning("%s\n", _(warn_unspecified_push_default_msg));
>  }
>
> +static void setup_per_branch_push(struct branch *branch)
> +{
> +       struct strbuf refspec = STRBUF_INIT;
> +
> +       strbuf_addf(&refspec, "%s:%s",
> +                   branch->name, branch->push_name);
> +       add_refspec(refspec.buf);

This goes back to the question I raised in 3/6: If this code path adds
refspec "foo:bar", and - say - setup_push_current() has already added
refspec "foo:foo" (or simply "foo"), then do we end up pushing into
"foo" or "bar"? To me, "branch.*.push" feels more specific than
"push.default = current", so it would make sense that "foo:bar"
overrides "foo:foo", but that is not obvious from the refspec alone.
IMHO, this definitely needs some tests.

> +}
> +
>  static int is_workflow_triagular(struct remote *remote)
>  {
>         struct remote *fetch_remote = remote_get(NULL);
> @@ -194,7 +203,14 @@ static int is_workflow_triagular(struct remote *remote)
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
>         struct branch *branch = branch_get(NULL);
> -       int triangular = is_workflow_triagular(remote);
> +       int triangular;
> +
> +       if (branch->push_name) {
> +               setup_per_branch_push(branch);
> +               return;

I guess this return ensures that branch.*.push overrides push.default,
but might there be other sources of add_refspec() that would
complicate things?

> +       }
> +
> +       triangular = is_workflow_triagular(remote);
>
>         switch (push_default) {
>         default:
> diff --git a/remote.c b/remote.c
> index e71f66d..e033fef 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -372,6 +372,11 @@ static int handle_config(const char *key, const char *value, void *cb)
>                         if (!value)
>                                 return config_error_nonbool(key);
>                         add_merge(branch, xstrdup(value));
> +               } else if (!strcmp(subkey, ".push")) {
> +                       if (!value)
> +                               return config_error_nonbool(key);
> +                       free(branch->push_name);
> +                       branch->push_name = xstrdup(value);
>                 }
>                 return 0;
>         }
> diff --git a/remote.h b/remote.h
> index cf56724..84e0f72 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -138,6 +138,8 @@ struct branch {
>         struct refspec **merge;
>         int merge_nr;
>         int merge_alloc;
> +
> +       char *push_name;
>  };
>
>  struct branch *branch_get(const char *name);

Otherwise, this patch, and the entire series looks good to me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
