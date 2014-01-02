From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] Speed up is_git_command() by checking early for
 internal commands
Date: Thu, 2 Jan 2014 09:51:43 +0100
Message-ID: <CAP8UFD2uq5Q-2F4w2zwH582NTpo9JwiKyHPovQJW+7phbT-b-A@mail.gmail.com>
References: <52C1E028.8000004@gmail.com>
	<52C1E09A.8040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 09:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vye0L-0004Ex-9G
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 09:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbaABIvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 03:51:45 -0500
Received: from mail-vc0-f182.google.com ([209.85.220.182]:49701 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaABIvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 03:51:44 -0500
Received: by mail-vc0-f182.google.com with SMTP id lc6so7144447vcb.13
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FMZX9mNlsVbpKhv4yHO3DO8UorHfAMDhhfWFquqD7b4=;
        b=Lc+46uzSRIYewWHGvm2gBmHvAAPBaGtY+gDYceY91eHAc11Y7M7Dc7qhe/9zJyQyB0
         84pLaiTnXKpwbjnmF4X27tCyMtv+lC2iALSl8BiqVfrkn11EFjRxwsZjFFuCw9FNQhQK
         MhQJ7ypUhQW6WxmDv3RV+fjr8EHPSgLJeaVMXFOZicRtz0i+SQEgRc63XGdoYJUea6jA
         b/1ZNhb6+wytiRJuwUJY37Rz/+vai4zn69C5GqsgRsWoIDBdecxSaGzh0G6isny1Pjdg
         ZyAYuK9bmrwIZhDk0akhIfLSLN5UCok2lwmQ4ypemrmpA4L89+/wMyKO2NDLBOPYaS/M
         CbPw==
X-Received: by 10.220.189.2 with SMTP id dc2mr281033vcb.60.1388652703741; Thu,
 02 Jan 2014 00:51:43 -0800 (PST)
Received: by 10.59.7.2 with HTTP; Thu, 2 Jan 2014 00:51:43 -0800 (PST)
In-Reply-To: <52C1E09A.8040907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239851>

On Mon, Dec 30, 2013 at 10:07 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Since 2dce956 is_git_command() was a bit slow as it does file I/O in the
> call to list_commands_in_dir(). Avoid the file I/O by adding an early
> check for internal commands.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  builtin/help.c |   5 ++
>  git.c          | 242 ++++++++++++++++++++++++++++++---------------------------
>  2 files changed, 132 insertions(+), 115 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index b6fc15e..1f0261e 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -284,10 +284,15 @@ static int git_help_config(const char *var, const char *value, void *cb)
>         return git_default_config(var, value, cb);
>  }
>
> +extern int is_internal_command(const char *s);
> +

Starting the new year in keeping with the fine tradition of asking
people who add stuff to clean up what others left behind, I would
suggest moving all the code related to internal commands (or maybe all
commands) in a new pair of files like "internal-cmds.{c,h}". This way
git.c and builtin/help.c could include internal-cmds.h and you
wouldn't need such extern declaration.

Happy new year everyone,
Christian.
