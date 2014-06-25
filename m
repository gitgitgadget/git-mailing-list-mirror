From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH V2] branch.c: replace git_config with git_config_get_string
Date: Wed, 25 Jun 2014 00:45:14 -0400
Message-ID: <CAPig+cTMWKtAjN931voVs7aY7JdEyaRVZj+-qDUiDk0C_Tq6-A@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzf5L-0003Bb-0X
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 06:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbaFYEpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 00:45:16 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:50294 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaFYEpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 00:45:15 -0400
Received: by mail-yk0-f172.google.com with SMTP id 142so794679ykq.31
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 21:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q6iqKylsbIhH8/QREKJaMYRvzteqq4Yor+k2sylnAN4=;
        b=kMpx33PWG4kUFzqUTyhMrgdfU9PlozsxjSdt6jFSOnYMvcfjcwcUe7IAeNzO1TVfMl
         +AGtuBaqKvR+7l6fq6pyUP/44fEhbyzCv+AaGDba4kaOlETJvFPOAeKcRiG+r5ACyFLh
         kQbISlgUmlZ1iWV7/kVvfvd5YOTX4DvtqfX2i1W///ZFrt4l9tuDv2P0VLDuAmIPDQB9
         LGqyn4W3QNngsjWgXqD07QLA9EwTcIAgsJ9gj/VSRQBXzQzrhKVoh3fD6dvSNe9CGlW7
         ZxwLWP6yIE45lYYpL0DZfgB8jPBG2xHJC13DFT/72sRk6OtK3NwUd8rHwO2h9tR/DxKD
         ulkQ==
X-Received: by 10.236.81.1 with SMTP id l1mr8028757yhe.27.1403671514820; Tue,
 24 Jun 2014 21:45:14 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Tue, 24 Jun 2014 21:45:14 -0700 (PDT)
In-Reply-To: <1403520105-23250-2-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: jtQUHsJwwWbYa_DfOSlPHw22sDE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252433>

On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use git_config_get_string instead of git_config to take advantage of
> the config hash-table api which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  branch.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 660097b..c9a2a0d 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -140,33 +140,25 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>         return 0;
>  }
>
> -struct branch_desc_cb {
> +struct branch_desc {
>         const char *config_name;
>         const char *value;
>  };

What is the purpose of retaining this structure? Following your
changes, it is never used outside of read_branch_desc(), and
'config_name' and 'value' would be more naturally declared as
variables local to that function.

> -static int read_branch_desc_cb(const char *var, const char *value, void *cb)
> -{
> -       struct branch_desc_cb *desc = cb;
> -       if (strcmp(desc->config_name, var))
> -               return 0;
> -       free((char *)desc->value);
> -       return git_config_string(&desc->value, var, value);
> -}
> -
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  {
> -       struct branch_desc_cb cb;
> +       const char *value = NULL;
> +       struct branch_desc desc;
>         struct strbuf name = STRBUF_INIT;
>         strbuf_addf(&name, "branch.%s.description", branch_name);
> -       cb.config_name = name.buf;
> -       cb.value = NULL;
> -       if (git_config(read_branch_desc_cb, &cb) < 0) {
> +       desc.config_name = name.buf;
> +       desc.value = NULL;
> +       git_config_get_string(desc.config_name, &value);
> +       if (git_config_string(&desc.value, desc.config_name, value) < 0) {

Although it works in this case, it's somewhat ugly that you ignore the
return value of git_config_get_string(), and a person reading the code
has to spend extra time digging into git_config_string() to figure out
why this is safe. If might be clearer for future readers by rephrasing
like this:

    if (git_config_get_string(desc.config_name, &value) < 0 ||
        git_config_string(&desc.value, desc.config_name, value) < 0) {

>                 strbuf_release(&name);
>                 return -1;
>         }
> -       if (cb.value)
> -               strbuf_addstr(buf, cb.value);
> +       strbuf_addstr(buf, desc.value);
>         strbuf_release(&name);
>         return 0;
>  }
> --
> 1.9.0.GIT
