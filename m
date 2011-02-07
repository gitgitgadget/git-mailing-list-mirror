From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] commit: fix memory-leak
Date: Mon, 7 Feb 2011 22:12:22 +0100
Message-ID: <AANLkTikr2+OVRU6n+0tA752_x80ir9dQh65RjUp3BxPR@mail.gmail.com>
References: <AANLkTikKZ+2qUMF1T5pP60cUd9Ya3n2mfhTkX6L32zmn@mail.gmail.com> <1297110111-7620-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: matthieu.moy@grenoble-inp.fr, msysgit@googlegroups.com,
	blees@dcon.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 22:12:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYO9-0006vH-4Y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab1BGVMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 16:12:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33129 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1BGVMn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 16:12:43 -0500
Received: by fxm20 with SMTP id 20so5353645fxm.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Er3BJnR8tvWI1yFPIZAQY3oBgc9mJViF8ezEQdqov24=;
        b=ib9e/wvBbs1QlNhmMTJKdjYkVZ7fJjzWHO9V9QGLj1ghUjeI+G43DDIV/06dicqhV2
         7N0xwq4ck27Mc6wUA1l2wt56QQhRVULCpn3uVlQ8g3MnChYal6fuF/0d1zlncLvhPpNd
         efPZtR2Ixm1GJ5OnapTM/iqRxkTggDnOJaPqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=GpuxKr9odjdjne7QGQH9Eq1eEIOY3rGdb2P3PaBejjVpHnivAxArg2RlxX6WoPyA83
         0xxSqeJ2hG3gqnZsaMgJLx2R93JwSrsvHpEd4N5atYEQYV8cc8QnQHdqcdZX2QLxVITC
         //MxS+b19f+9F94TbolUnCxoyRclX5uFLHnYI=
Received: by 10.223.83.208 with SMTP id g16mr767746fal.52.1297113162282; Mon,
 07 Feb 2011 13:12:42 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 7 Feb 2011 13:12:22 -0800 (PST)
In-Reply-To: <1297110111-7620-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166296>

On Mon, Feb 7, 2011 at 9:21 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> The name, email and date strings are some times allocated on the
> heap, but not free'd. Fix this by making sure they are allways
> heap-allocated, so we can safely free the memory.
>
> At the same time, this fixes a problem with strict-POSIX getenv
> implementations. POSIX says "The return value from getenv() may
> point to static data which may be overwritten by subsequent calls
> to getenv()", so not duplicating the strings is a potential bug.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> Fixed typo in commit message, as pointed out by Matthieu Moy.
>
> =A0builtin/commit.c =A0| =A0 =A09 ++++++---
> =A0git-compat-util.h | =A0 =A01 +
> =A0wrapper.c =A0 =A0 =A0 =A0 | =A0 =A06 ++++++
> =A03 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 03cff5a..e5a649e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -465,9 +465,9 @@ static void determine_author_info(struct strbuf *=
author_ident)
> =A0{
> =A0 =A0 =A0 =A0char *name, *email, *date;
>
> - =A0 =A0 =A0 name =3D getenv("GIT_AUTHOR_NAME");
> - =A0 =A0 =A0 email =3D getenv("GIT_AUTHOR_EMAIL");
> - =A0 =A0 =A0 date =3D getenv("GIT_AUTHOR_DATE");
> + =A0 =A0 =A0 name =3D xgetenv("GIT_AUTHOR_NAME");
> + =A0 =A0 =A0 email =3D xgetenv("GIT_AUTHOR_EMAIL");
> + =A0 =A0 =A0 date =3D xgetenv("GIT_AUTHOR_DATE");
>
> =A0 =A0 =A0 =A0if (use_message && !renew_authorship) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *a, *lb, *rb, *eol;
> @@ -507,6 +507,9 @@ static void determine_author_info(struct strbuf *=
author_ident)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0date =3D force_date;
> =A0 =A0 =A0 =A0strbuf_addstr(author_ident, fmt_ident(name, email, dat=
e,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0IDENT_ERROR_ON_NO_NAME));
> + =A0 =A0 =A0 free(name);
> + =A0 =A0 =A0 free(email);
> + =A0 =A0 =A0 free(date);

Hmm, but I'm getting a crash here on Linux. Guess I need to debug a bit=
=2E..
