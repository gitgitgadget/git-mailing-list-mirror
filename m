From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] Add concept of 'publish' branch
Date: Sun, 1 Sep 2013 04:41:28 -0400
Message-ID: <CAPig+cQUiSC4r01nSqRnrDj230x=tUK4dGUXhWrUitSAVKZ-Wg@mail.gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
	<1378024002-26190-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 10:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG3Dz-0004Zx-VO
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab3IAIlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:41:32 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44577 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab3IAIla (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:41:30 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so2976960lbi.25
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QLkiV7bOnDO4Kkw4Udb+SOa3v1hsw5OMmMKKiNgNXOs=;
        b=wxLCBqlBYbb/P7WgMTs3Gd4qldNjgi8u6WPm7jlPAL7zsnm81QUDhpZWPdONDwkC5q
         3MGnd4cfGJPUGf1lZK5KgaxfrWVRDyric649v7MPjxpYTADK+o+Znz98Ng8q3mUTSlrF
         aphsrKsZSUWkxT+o3fLuJejtDCBkLQSoaytUQqsQ42mTbooMgWYv8P9P6MKThC2pQYLf
         4EhYd0lKZV5oeCZ+E8H/UmiZ2EptPrsCHP1gnNO08lyFDmPCXI38snd1I0H0u9+VVnua
         DBMZN8+eHoMcpB9TSE5RlH7SiZdDm1VTFf+WmYxWNW1Q1zkOaOXlmZUcYUKBnwIwecI7
         64hg==
X-Received: by 10.152.116.7 with SMTP id js7mr16000114lab.11.1378024889041;
 Sun, 01 Sep 2013 01:41:29 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 1 Sep 2013 01:41:28 -0700 (PDT)
In-Reply-To: <1378024002-26190-3-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: Ue90BQFs_sd-Ozef_cHMeJvjVK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233579>

On Sun, Sep 1, 2013 at 4:26 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> The upstream branch is:
>
>   branch.$name.remote
>   branch.$name.merge
>
> The publish branch is:
>
>   branch.$name.pushremote
>   branch.$name.push
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 19 +++++++++++++++----
>  remote.c       | 34 ++++++++++++++++++++++++++++------
>  remote.h       |  4 ++++
>  3 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 5dc06a3..f2deddf 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -150,6 +150,20 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>         add_refspec(branch->name);
>  }
>
> +static void setup_push_simple(struct remote *remote, struct branch *branch,
> +                               int triangular)
> +{
> +       if (branch->push_name) {
> +               struct strbuf refspec = STRBUF_INIT;
> +               strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
> +               add_refspec(refspec.buf);

strbuf_release(&refspec);

> +       } else if (triangular) {
> +               setup_push_current(remote, branch);
> +       } else {
> +               setup_push_upstream(remote, branch, triangular);
> +       }
> +}
> +
>  static char warn_unspecified_push_default_msg[] =
>  N_("push.default is unset; its implicit value is changing in\n"
>     "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
> @@ -210,10 +224,7 @@ static void setup_default_push_refspecs(struct remote *remote)
>                 break;
>
>         case PUSH_DEFAULT_SIMPLE:
> -               if (triangular)
> -                       setup_push_current(remote, get_current_branch(remote));
> -               else
> -                       setup_push_upstream(remote, get_current_branch(remote), triangular);
> +               setup_push_simple(remote, get_current_branch(remote), triangular);
>                 break;
>
>         case PUSH_DEFAULT_UPSTREAM:
> diff --git a/remote.c b/remote.c
> index efcba93..04c7ed9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -350,13 +350,17 @@ static int handle_config(const char *key, const char *value, void *cb)
>                                 explicit_default_remote_name = 1;
>                         }
>                 } else if (!strcmp(subkey, ".pushremote")) {
> +                       if (git_config_string(&branch->pushremote_name, key, value))
> +                               return -1;
>                         if (branch == current_branch)
> -                               if (git_config_string(&pushremote_name, key, value))
> -                                       return -1;
> +                               pushremote_name = xstrdup(branch->pushremote_name);
>                 } else if (!strcmp(subkey, ".merge")) {
>                         if (!value)
>                                 return config_error_nonbool(key);
>                         add_merge(branch, xstrdup(value));
> +               } else if (!strcmp(subkey, ".push")) {
> +                       if (git_config_string(&branch->push_name, key, value))
> +                               return -1;
>                 }
>                 return 0;
>         }
> @@ -1492,6 +1496,14 @@ struct branch *branch_get(const char *name)
>                         }
>                 }
>         }
> +       if (ret && ret->pushremote_name) {
> +               struct remote *pushremote;
> +               pushremote = pushremote_get(ret->pushremote_name);
> +               ret->push.src = xstrdup(ret->push_name);
> +               if (remote_find_tracking(pushremote, &ret->push)
> +                   && !strcmp(ret->pushremote_name, "."))
> +                       ret->push.dst = xstrdup(ret->push_name);
> +       }
>         return ret;
>  }
>
> @@ -1694,6 +1706,15 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
>         return found;
>  }
>
> +static char *get_base(struct branch *branch)
> +{
> +       if (branch->push.dst)
> +               return branch->push.dst;
> +       if (branch->merge && branch->merge[0] && branch->merge[0]->dst)
> +               return branch->merge[0]->dst;
> +       return NULL;
> +}
> +
>  /*
>   * Return true if there is anything to report, otherwise false.
>   */
> @@ -1710,15 +1731,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>          * Nothing to report unless we are marked to build on top of
>          * somebody else.
>          */
> -       if (!branch ||
> -           !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
> +       if (!branch)
> +               return 0;
> +       base = get_base(branch);
> +       if (!base)
>                 return 0;
>
>         /*
>          * If what we used to build on no longer exists, there is
>          * nothing to report.
>          */
> -       base = branch->merge[0]->dst;
>         if (read_ref(base, sha1))
>                 return 0;
>         theirs = lookup_commit_reference(sha1);
> @@ -1781,7 +1803,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
>         if (!stat_tracking_info(branch, &num_ours, &num_theirs))
>                 return 0;
>
> -       base = branch->merge[0]->dst;
> +       base = get_base(branch);
>         base = shorten_unambiguous_ref(base, 0);
>         if (!num_theirs) {
>                 strbuf_addf(sb,
> diff --git a/remote.h b/remote.h
> index cf56724..79e5adf 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -138,6 +138,10 @@ struct branch {
>         struct refspec **merge;
>         int merge_nr;
>         int merge_alloc;
> +
> +       const char *pushremote_name;
> +       const char *push_name;
> +       struct refspec push;
>  };
>
>  struct branch *branch_get(const char *name);
> --
> 1.8.4-337-g7358a66-dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
