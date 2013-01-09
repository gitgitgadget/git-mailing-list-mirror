From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] add warning for depth=0 in git clone.
Date: Wed, 9 Jan 2013 07:57:43 +0700
Message-ID: <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 01:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsk02-0002xq-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 01:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab3AIA6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 19:58:14 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38008 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab3AIA6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 19:58:14 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so1620224obc.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L9xfyYCafvc62oUF16NUykntXm1XjNRyG3sm07vaTuA=;
        b=1HQfm9X4f2S6mLcUkzSCQ8IfmFBzbLncXXR6VPx5iXpOJ5V1xpcoOlxiCKDTHQt89o
         8MW6/yVmjx7KFNXNsyqGFcZOI/QCcjjpk2qOKBQbfLkTRCa51l9gHPowdPR7v8hkqxED
         FuB4lASm+qTCv/w2dDhy5WY7YZxtLoeLN0NUZF5g14g16pygVBlhZphUBS3bgj8zplDq
         onBJ623eqSYI0QwMzhaHG6Qh84iUaYJ+RUXryyzmKFczy/5Cg9pNEUrVQFoPIq+uiMqR
         36LPTxJauPJi7O94Xisv+L9SrvXPzJaUkDvwLkNrraiFV8tdQgICwbz9Co11+02cZpwn
         28CQ==
Received: by 10.60.29.66 with SMTP id i2mr36970135oeh.2.1357693093589; Tue, 08
 Jan 2013 16:58:13 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 8 Jan 2013 16:57:43 -0800 (PST)
In-Reply-To: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213020>

On Tue, Jan 8, 2013 at 3:07 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> ---
>  builtin/clone.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ec2f75b..5e91c1e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -818,6 +818,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>         remote = remote_get(option_origin);
>         transport = transport_get(remote, remote->url[0]);
>
> +       if (option_depth && transport->smart_options->depth < 1)
> +               die(_("--depth less or equal 0 makes no sense; read manpage."));
> +

Isn't this too early for the check? The following code is

>         if (!is_local) {
>                 if (!transport->get_refs_list || !transport->fetch)
>                         die(_("Don't know how to clone %s"), transport->url);

		transport_set_option(transport, TRANS_OPT_KEEP, "yes");

		if (option_depth)
			transport_set_option(transport, TRANS_OPT_DEPTH,
					     option_depth);


where transport_set_option() calls set_git_option() to initialize
transport->smart_options->depth. A check should be done after this
point.
-- 
Duy
