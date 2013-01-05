From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid overwrites
Date: Sat, 5 Jan 2013 09:45:40 +0700
Message-ID: <CACsJy8BeuV8esGTWsQiT_G9pZE28s5KJxH6+dzdhioLgmSiNVg@mail.gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 03:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrJmb-0000cS-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 03:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab3AECq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 21:46:28 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36556 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab3AECqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 21:46:12 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so15016445obb.7
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 18:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M1AtXZxzYwGfwAt+SbNTQcDuStV65agueclyIzNZ5H0=;
        b=UzL64fUVN5sVBODHDl8fijjNURW7R0QCQWDwhzKyP2xqO+v1PpL/rV6XxioQJpmODT
         6NDvOf9B6ofhnP2eJVwi1HvwwlHF3pPvemFZBZPTSuEAJDm3Wuq7Ttv2raJ/scRFU/Hs
         kKqHaRUFXYUT5zQxDGmO/AGEU1OKB9gxRc75prrikDg0AHzyD3e4r9Uz/i9bLKjSwSVn
         hUvk8P3d0R/nyjOZTBZAnfvLnsuXdVktQ4fdF+BCUMLIyqjPdv3nXg3fzPoW2g7nUNtC
         dv+qmAtgZIS+iyOd3yfq6M/Fkrkt+zjb7vTj+a6j8u7Jt4tuS9cfaK9DZWGq6lsjZDFX
         D5Cg==
Received: by 10.182.109.101 with SMTP id hr5mr39869666obb.84.1357353971684;
 Fri, 04 Jan 2013 18:46:11 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 4 Jan 2013 18:45:40 -0800 (PST)
In-Reply-To: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212660>

On Sat, Jan 5, 2013 at 7:35 AM, David Michael <fedora.dm0@gmail.com> wrote:
> -    if (gitdirenv)
> -        return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
> +    if (gitdirenv) {
> +        gitdirenv = xstrdup(gitdirenv);
> +        ret = setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
> +        free(gitdirenv);
> +        return ret;
> +    }

Maybe we could all this into a wrapper? If getenv() here has a
problem, many other places may have the same problem too. This
simplifies the change. But one has to check that getenv() must not be
used in threaded code.

char *git_getenv(const char *env)
{
   static int bufno;
   static char *buf[4];
   bufno = (bufno + 1) % 4;
   free(buf[bufno]);
   buf[bufno] = xstrdup(getenv(env));
   return buf[bufno];
}
#define getenv(x) git_getenv(x)

-- 
Duy
