From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] git-config: git-config --list fixed when GIT_CONFIG
 value starts with ~/
Date: Fri, 14 Nov 2014 14:19:41 -0500
Message-ID: <CAPig+cTpUyfKYj4VTK1AT-ga6UvupJrERsTHWTEzNP-Ogc4ujQ@mail.gmail.com>
References: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alex Kuleshov <kuleshovmail@gmial.com>
To: 0xAX <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMPO-0005Di-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161795AbaKNTTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:19:44 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:55065 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161586AbaKNTTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:19:42 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so8576153yhl.23
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LVoDJlOZWxhYgQmDGCNlkvYh5XbBYjl26odKUeqCdr8=;
        b=BocgsIaH5fzVDnYyDY2JC+9MUrFIxo4pnYu7+gezpSi3YYR+mCyqdVNZ5wQQQmqAEz
         HQ+ebAKPW824rExe7boWf5J+7uCmOIdcGRQ8aU8QsdWO39DPs0CLoC3esf5W09AUQr67
         c8rg313b7fclGLT16SEWon5CaoMv53QXDnuV3lL+w+qcORFdvyntArwzj5ASKUyckgnA
         MRaoLkiEOMl2VklNFEGab4O6I3G4uDXxuDb66uUCLwaqzGn7wUGT9ThHevr7cKr9Tqpw
         J/Oyh8b+vqOO1Lfmb+0NvKyaxR7UzgTP3fwMjoOYswUeUODproISBkKYiV4fNzBNq5FG
         y/Ow==
X-Received: by 10.170.78.6 with SMTP id u6mr8397031yku.103.1415992782031; Fri,
 14 Nov 2014 11:19:42 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Fri, 14 Nov 2014 11:19:41 -0800 (PST)
In-Reply-To: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: _tgymSLpRyCU-m5Zxn7ta89JemY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 1:29 PM, 0xAX <kuleshovmail@gmail.com> wrote:
> When we execute git config --list and $GIT_CONFIG value starts with home
> prefix - ~/ it produces folowing error - fatal: unable to read config
> file '~/.gitconfig': No such file or directory. This patch fixed it with
> expand_user_path for configuration file path before git-config --list
> call.

Is this special case really warranted? Elsewhere, GIT_CONFIG does not
get this sort of special treatment. Moreover, it appears that no other
GIT_* environment variable is subject to such special treatment. (And,
generally speaking, on Unix, it is generally assumed that a path
assigned to an environment variable is to be used as-is.)

> Signed-off-by: Alex Kuleshov <kuleshovmail@gmial.com>

s/gmial/gmail/

> Signed-off-by: 0xAX <kuleshovmail@gmail.com>
> ---
>  builtin/config.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 7bba516..df1bee0 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -540,6 +540,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>
>         if (actions == ACTION_LIST) {
>                 check_argc(argc, 0, 0);
> +               const char* newpath = expand_user_path(given_config_source.file);
> +               given_config_source.file = newpath;

A few issues:

(1) Style: s/char* /char */

(2) Avoid declaration (of 'newpath') after statement.

(3) You can drop 'newpath' altogether and just assign the result of
expand_user_path() directly to given_config_source.file.

This code is potentially leaking the old value of
given_config_source.file, and (later) the new value, however, as
given_config_source.file is already being leaked elsewhere, it
probably does not make the situation much worse.

>                 if (git_config_with_options(show_all_config, NULL,
>                                             &given_config_source,
>                                             respect_includes) < 0) {
> --
> 2.1.3.17.g7fa1365.dirty
