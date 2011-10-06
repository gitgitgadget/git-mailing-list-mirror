From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] mingw: avoid using strbuf in syslog
Date: Thu, 6 Oct 2011 12:27:29 -0500
Message-ID: <CA+sFfMediaCnzFH6uKfVc_Bb+W+AA1nO+OdvB8vWjjrsD1kh9w@mail.gmail.com>
References: <1317920244-6320-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j.sixt@viscovery.net, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:27:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrjT-0004uR-St
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758790Ab1JFR1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 13:27:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46666 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758716Ab1JFR1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 13:27:32 -0400
Received: by bkbzt4 with SMTP id zt4so3734513bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ylX1qs+7Qdv2IwHk9dRw79noX0nISzCg20gddmFRAgA=;
        b=nQufuGijc7XkPT/ODrNz1wZVCDtt2Sw3WWpFYXaMWREZ70tILRLg0mSABwRUQw8anL
         fCRu+onzvGUo1X8h26nOwkctoVIX5SA/+NPSAyjQQv5+XHum+7Gd46vCZg4wT8QqNlhy
         kKRtklyCd900Y5xpwDUaQHIt8bKnwjYoTzPyo=
Received: by 10.223.75.137 with SMTP id y9mr4803327faj.14.1317922050390; Thu,
 06 Oct 2011 10:27:30 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 6 Oct 2011 10:27:29 -0700 (PDT)
In-Reply-To: <1317920244-6320-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182993>

On Thu, Oct 6, 2011 at 11:57 AM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> strbuf can call die, which again can call syslog from git-daemon.
>
> Endless recursion is no fun; fix it by hand-rolling the logic.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> Fixes the problem Brandon pointed out...

Actually, Johannes should get that credit.  He brought up the whole
recursion issue.

> =C2=A0compat/win32/syslog.c | =C2=A0 26 ++++++++++++++------------
> =C2=A01 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 42b95a9..3b8e2b7 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -1,5 +1,4 @@
> =C2=A0#include "../../git-compat-util.h"
> -#include "../../strbuf.h"
>
> =C2=A0static HANDLE ms_eventlog;
>
> @@ -16,13 +15,8 @@ void openlog(const char *ident, int logopt, int fa=
cility)
>
> =C2=A0void syslog(int priority, const char *fmt, ...)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 struct strbuf sb =3D STRBUF_INIT;
> - =C2=A0 =C2=A0 =C2=A0 struct strbuf_expand_dict_entry dict[] =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {"1", "% 1"},
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {NULL, NULL}
> - =C2=A0 =C2=A0 =C2=A0 };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WORD logtype;
> - =C2=A0 =C2=A0 =C2=A0 char *str;
> + =C2=A0 =C2=A0 =C2=A0 char *str, *pos;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int str_len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_list ap;
>
> @@ -39,11 +33,20 @@ void syslog(int priority, const char *fmt, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D malloc(str_len + 1);
> + =C2=A0 =C2=A0 =C2=A0 if (!str)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* no chan=
ce to report error */
> +

Just above this, warning() is used to at least print a message to
stderr if vsnprintf() fails.  It could be used here, and below when
realloc fails.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(ap, fmt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0vsnprintf(str, str_len + 1, fmt, ap);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(ap);
> - =C2=A0 =C2=A0 =C2=A0 strbuf_expand(&sb, str, strbuf_expand_dict_cb,=
 &dict);
> - =C2=A0 =C2=A0 =C2=A0 free(str);
> +
> + =C2=A0 =C2=A0 =C2=A0 while ((pos =3D strstr(str, "%1")) !=3D NULL) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D realloc(st=
r, ++str_len + 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!str)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(pos + 2, p=
os + 1, strlen(pos));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pos[1] =3D ' ';
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (priority) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case LOG_EMERG:

-Brandon
