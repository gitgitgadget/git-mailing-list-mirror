From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 15:07:15 -0500
Message-ID: <CAPig+cS11fQMUkn2D=3oqac=NA2wRp9rap_XOk=Jfj4pPGWP+Q@mail.gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
	<1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
	<xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
	<87sih9en65.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 21:07:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsdRa-0008M3-Ts
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 21:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbaKWUHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 15:07:17 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:58506 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbaKWUHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 15:07:16 -0500
Received: by mail-yk0-f173.google.com with SMTP id 19so3666308ykq.18
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 12:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Jq/d3eG/N95orUp+YW+4hcUdp4hdBk3HOVFioegPvwQ=;
        b=EBW8Y3oAaM5sIJLvuBa5UO1rBkDjmwpl13CUHU5TimUxr/J234J2DWGUito1UxXFak
         Dg6gDSGwMpxcOQRpI7dnR+CbnHLw+YcFuSNjLMQs8NJwvlhzlYqQJo3WzYnmYYbU6i+V
         cKNdjm3Dg9y+HWZ6252fjoaJC9er3F5xAhX8kOZveEVFzzKouZOhXhGy0hA7S7UFbh4C
         lKZ9GTEDnZtB+iE6Z8torZrhQbEW7elStawFRWILCNscT7Pi16Wfpuc+7pE+zAU1Xvyk
         z/2kMR+UBIJQliqbhQufsQjnOSIJJCwqm8uWG/Ri8NBe9yo3+J4X0E7DEE2uEM9nmxoc
         1yzQ==
X-Received: by 10.170.78.130 with SMTP id u124mr15057418yku.91.1416773235665;
 Sun, 23 Nov 2014 12:07:15 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sun, 23 Nov 2014 12:07:15 -0800 (PST)
In-Reply-To: <87sih9en65.fsf@gmail.com>
X-Google-Sender-Auth: mKZSUAYDme-CP7Tx0P47_6YUSKo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260104>

On Sun, Nov 23, 2014 at 2:19 PM, Alex Kuleshov <kuleshovmail@gmail.com> wrote:
>
> Signed-off-by: Alex Kuleshov <kuleshovmail@gmail.com>
> ---
>  exec_cmd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 698e752..7ed9bcc 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -13,7 +13,7 @@ const char *system_path(const char *path)
>  #else
>         static const char *prefix = PREFIX;
>  #endif
> -       struct strbuf d = STRBUF_INIT;
> +       static struct strbuf d = STRBUF_INIT;

Curious. Did the unit tests pass with this change?

In the original code, the strbuf starts out empty each time
system_path() is called, and strbuf_addf() populates it. After your
change, the strbuf starts empty only on the very first call, and
subsequent calls append more content rather than replacing it. At the
very least, to fix, you now need to invoke strbuf_reset() before
invoking strbuf_addf().

>         if (is_absolute_path(path))
>                 return path;
> @@ -34,8 +34,7 @@ const char *system_path(const char *path)
>  #endif
>
>         strbuf_addf(&d, "%s/%s", prefix, path);
> -       path = strbuf_detach(&d, NULL);
> -       return path;
> +       return d.buf;
>  }
>
>  const char *git_extract_argv0_path(const char *argv0)
> @@ -94,7 +93,7 @@ static void add_path(struct strbuf *out, const char *path)
>  void setup_path(void)
>  {
>         const char *old_path = getenv("PATH");
> -       struct strbuf new_path = STRBUF_INIT;
> +       static struct strbuf new_path = STRBUF_INIT;
>
>         add_path(&new_path, git_exec_path());
>         add_path(&new_path, argv0_path);

Not sure what this change is about. The last couple lines of this function are:

    setenv("PATH", new_path.buf, 1);
    strbuf_release(&new_path);

which means that the buffer held by the strbuf is being released
anyhow, whether static or not.
