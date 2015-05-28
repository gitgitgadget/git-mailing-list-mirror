From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/WIP 4/8] am: split out mbox/maildir patches with git-mailsplit
Date: Thu, 28 May 2015 19:05:43 -0400
Message-ID: <CAPig+cSK_yEabXJFF4UvKkbcisgpZGV0aX7jExcnK=Q-Ozm-eg@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 01:05:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy6s1-0008KT-I1
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 01:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbbE1XFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 19:05:45 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34880 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbbE1XFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 19:05:44 -0400
Received: by igbyr2 with SMTP id yr2so1201804igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SV6e/SihGsxFWNJix8mYJslUborLpXEE5mCw335oNEA=;
        b=Zu1SSf6GqQlkqL+glTYpufjdJlSYQyzTuHLJYN7k63eibL02SOa+C2j4Ug8UZrXgPF
         OLGSGwvnvGBgn2b+v1Z27sTs1/MkmYuKkujCakpVw0pR54WKIWfD4LWcs71SleqzD7Z+
         HD7JKEI7SQDeMj4KaGNMbNtn4wT9EKpSi33aXgIBwSOWXGqBvhMMs0Xs4bPk5eg359Yy
         XSiSwfn2MSe6IEkImhCwaf5QSKjazr3Htp7FYqN6qf7LUpc+JvyI31XxAKyE6qCTu/Mp
         wrYi9S+GxAFIdODnBgxhqNN5QXTqS6MlJ00eoFdzsoKUCqIBqVQ14cPKifEX2pMmQxfr
         rU4Q==
X-Received: by 10.42.166.200 with SMTP id p8mr4510959icy.25.1432854343542;
 Thu, 28 May 2015 16:05:43 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 16:05:43 -0700 (PDT)
In-Reply-To: <1432733618-25629-5-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: naPSnwEafnZkowZB_4IYYpiNkS8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270205>

On Wed, May 27, 2015 at 9:33 AM, Paul Tan <pyokagan@gmail.com> wrote:
> git-am.sh supports mbox, stgit and mercurial patches. Re-implement
> support for splitting out mbox/maildirs using git-mailsplit, while also
> implementing the framework required to support other patch formats in
> the future.
>
> Re-implement support for the --patch-format option (since a5a6755
> (git-am foreign patch support: introduce patch_format, 2009-05-27)) to
> allow the user to choose between the different patch formats.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> @@ -128,13 +190,32 @@ static void am_next(struct am_state *state)
>   */
> +/**
> + * parse_options() callback that validates and sets opt->value to the
> + * PATCH_FORMAT_* enum value corresponding to `arg`.
> + */
> +static int parse_opt_patchformat(const struct option *opt, const char *arg, int unset)
> +{
> +       int *opt_value = opt->value;
> +
> +       if (!strcmp(arg, "mbox"))
> +               *opt_value = PATCH_FORMAT_MBOX;
> +       else
> +               return -1;
> +       return 0;
> +}
> +
>  struct am_state state;
> +int opt_patch_format;

Should these two variables be static?

>  static const char * const am_usage[] = {
>         N_("git am [options] [(<mbox>|<Maildir>)...]"),
