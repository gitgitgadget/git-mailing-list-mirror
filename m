From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] refs: add ref_type function
Date: Wed, 29 Jul 2015 02:32:46 -0400
Message-ID: <CAPig+cSRsrmKPLshfn2vpwbk3PV9vJzmTndQT9AHfsVaMmMKug@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 08:32:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKKvC-00072J-RX
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 08:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbG2Gcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 02:32:48 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33807 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbbG2Gcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 02:32:47 -0400
Received: by ykax123 with SMTP id x123so338610yka.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 23:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LeG2xaqE2DW5ygwl2DzBpN7rQZuNt3KtCFJMZDjDxgE=;
        b=HRIzluJAIDOWapnjWx9oSu645ut3YAtzMrWJiWq4JATf65F1QODW6fjQ9Es+QIBW96
         3hBpnyIoOcqs1ralxxlyXNxdknfXewh/leJFQH42rUm4q+vgg5ey1UOfGnuUSTIPGjsc
         6AA6jFlfF2TSI0huDfFo3VXTTkoyBNdMstv775lDe8eB3ymHq4AOkJNdQC+6zkykJGSa
         vBwT35jgmK/GLNexPywRP/gssKPM8+SATi5Y273RS0wWcNZ9s3XUk8lGF0vuz/Jx9Aee
         27mUzO99KfE9R0RZCrAlG5azQm3nVYlXk4ndGl7FHFYAMunZPdmHLYtMMQt3h2Kia4sg
         V1lQ==
X-Received: by 10.129.70.69 with SMTP id t66mr42039941ywa.4.1438151567050;
 Tue, 28 Jul 2015 23:32:47 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 23:32:46 -0700 (PDT)
In-Reply-To: <1438107144-24293-4-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: 23748OYiB8EYLh3zzOuHvl0tUoY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274883>

On Tue, Jul 28, 2015 at 2:12 PM, David Turner <dturner@twopensource.com> wrote:
> Add a function ref_type, which categorizes refs as per-worktree,
> pseudoref, or normal ref.
>
> Later, we will use this in refs.c to treat pseudorefs specially.
> Alternate ref backends may use it to treat both pseudorefs and
> per-worktree refs differently.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/refs.c b/refs.c
> index 0b96ece..553ae8b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2848,6 +2848,35 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>         return 0;
>  }
>
> +static int is_per_worktree_ref(const char *refname)
> +{
> +       return !strcmp(refname, "HEAD");
> +}
> +
> +static int is_pseudoref_syntax(const char *refname)
> +{
> +       const char *c;
> +
> +       if (strchr(refname, '/'))
> +               return 0;

Isn't this redundant? Won't the below for-loop already return 0 if it
encounters a slash?

> +       for (c = refname; *c; ++c) {

Style: c++

> +               if (!isupper(*c) && *c != '-' && *c != '_')
> +                       return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +enum ref_type ref_type(const char *refname)
> +{
> +       if (is_per_worktree_ref(refname))
> +               return REF_TYPE_PER_WORKTREE;
> +       if (is_pseudoref_syntax(refname))
> +               return REF_TYPE_PSEUDOREF;
> +       return REF_TYPE_NORMAL;
> +}
