From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] fetch.c: clear errno before calling functions that
 might set it
Date: Wed, 23 Apr 2014 16:12:03 -0400
Message-ID: <CAPig+cTu4hUCF4r6wAHnGpfcoQP9SqDUWgA2SjjKbjDNrDG8fg@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<1398192327-21302-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:12:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3Wg-00079s-8n
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbaDWUMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:12:06 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:58753 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbaDWUME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:12:04 -0400
Received: by mail-yh0-f46.google.com with SMTP id c41so133191yho.33
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3d8lwbuezVQgxTOAKPbVsxPXndpcQ9trw7/HCzeNzLg=;
        b=AGhE8dK/JEGDfOQjp5I5WxTwMQJ9ai8Pr7jrz/JO9iRqMlO+L+3a0aEtNAo4+YqUoZ
         ORBpa0HQao3OymMHg+5mQ1NbyUuBQ2qpO7cChS4QnVMDpE2ufVSY4TTBU0TF/Bddm5yg
         z89dOUgLegvecFnsvdcHSyxGwCS5GVopEWIFk/vTfVMPboh546CHpeAeY+gdOLla4Tc9
         5TVQLhGMirckClrnpB6zpPhN8xtTYyXvh4bHo0/jjdQg/cer+9QEMklQ/dwrIGefh0By
         cAZ/vnQyBi+DRE7fpCwLRMO1SSNYqbLwS20RQwEHEaC/PnwJFfznRXxYlVuojlyuSEdA
         oYFg==
X-Received: by 10.236.194.169 with SMTP id m29mr14833897yhn.121.1398283923146;
 Wed, 23 Apr 2014 13:12:03 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Wed, 23 Apr 2014 13:12:03 -0700 (PDT)
In-Reply-To: <1398192327-21302-2-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: 3DxMrFtfhSRBhgmYJ9j_oGNoakI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246882>

On Tue, Apr 22, 2014 at 2:45 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> In s_update_ref there are two calls that when they fail we return an error
> based on the errno value. In particular we want to return a specific error
> if ENOTDIR happened. Both these functions do have failure modes where they
> may return an error without updating errno, in which case a previous and
> unrelated ENOTDIT may cause us to return the wrong error. Clear errno before
> calling any functions if we check errno afterwards.
>
> Also skip initializing a static variable to 0. Sstatics live in .bss and

s/Sstatics/Statics/

> are all automatically initialized to 0.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/fetch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 55f457c..a93c893 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -44,7 +44,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static const char *recurse_submodules_default;
> -static int shown_url = 0;
> +static int shown_url;
>
>  static int option_parse_recurse_submodules(const struct option *opt,
>                                    const char *arg, int unset)
> @@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
>         if (!rla)
>                 rla = default_rla.buf;
>         snprintf(msg, sizeof(msg), "%s: %s", rla, action);
> +
> +       errno = 0;
>         lock = lock_any_ref_for_update(ref->name,
>                                        check_old ? ref->old_sha1 : NULL,
>                                        0, NULL);
> --
> 1.9.1.518.g16976cb.dirty
