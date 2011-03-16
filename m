From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Wed, 16 Mar 2011 16:58:03 +0100
Message-ID: <AANLkTinEMzezKdfGUrwKv7sJ+tSK5duYM6XZMvBa-yj3@mail.gmail.com>
References: <20110314200958.GC22602@sigill.intra.peff.net> <1300274770-4798-1-git-send-email-cmn@elego.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:08:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PztHM-0006Y5-IX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab1CPQIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:08:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48945 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1CPQIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 12:08:51 -0400
Received: by fxm17 with SMTP id 17so1813953fxm.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jYibp/eP2NU8U6hMJEyyVNkfdkcSbRFez1bGwkp8AaM=;
        b=rj7DDEEPNei43CQbwYZHbdyJ73ksIGfyyCBENoSkaSyUohw6VlGO93hLtjiNb8PyAW
         b/7T5rCpyhUGOHpbJP+wH83zmN0UDG2ddYXSZdNGYT5g+t5MCGDjFG3eRaJ6qaXs9taB
         wGtJb2kIVU0+/Ktvqe5jBd3Hc1fV8hHTkxsKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=cicvL9BwyclJwfBMeYV2ILRAYOfC/yrpLxU5kdUdIGksnssGQK9gIQvoBW24aaQRv1
         HIhVKHOR8mS2p96KYmnmUE7EA6k/AE4qoICXSQPQHJdpUtzgIuG22Hj9cjXqPJz4GkYA
         KGRdRBB0+dSdCFisZcSjpupVCmQdhh5kKtiok=
Received: by 10.223.77.16 with SMTP id e16mr159751fak.87.1300291140184; Wed,
 16 Mar 2011 08:59:00 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Wed, 16 Mar 2011 08:58:03 -0700 (PDT)
In-Reply-To: <1300274770-4798-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169167>

On Wed, Mar 16, 2011 at 12:26 PM, Carlos Mart=EDn Nieto <cmn@elego.de> =
wrote:
> Make system_path behave like the other path functions by using a
> static buffer, fixing a memory leak.
>
> Also make sure the prefix pointer is always initialized to either
> PREFIX or NULL.
>
> Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
> ---
>
> This fixes the leak I was trying to fix with my original patch, but
> this seems much cleaner
>
> =A0exec_cmd.c | =A0 =A09 ++++-----
> =A01 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 38545e8..12ce017 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -9,11 +9,11 @@ static const char *argv0_path;
> =A0const char *system_path(const char *path)
> =A0{
> =A0#ifdef RUNTIME_PREFIX
> - =A0 =A0 =A0 static const char *prefix;
> + =A0 =A0 =A0 static const char *prefix =3D NULL;
> =A0#else
> =A0 =A0 =A0 =A0static const char *prefix =3D PREFIX;
> =A0#endif
> - =A0 =A0 =A0 struct strbuf d =3D STRBUF_INIT;
> + =A0 =A0 =A0 static char buf[PATH_MAX+1];

Why PATH_MAX + 1? POSIX says that PATH_MAX includes the null-terminatio=
n...

> @@ -33,9 +33,8 @@ const char *system_path(const char *path)
> =A0 =A0 =A0 =A0}
> =A0#endif
>
> - =A0 =A0 =A0 strbuf_addf(&d, "%s/%s", prefix, path);
> - =A0 =A0 =A0 path =3D strbuf_detach(&d, NULL);
> - =A0 =A0 =A0 return path;
> + =A0 =A0 =A0 snprintf(buf, PATH_MAX, "%s/%s", prefix, path);

Perhaps "snprintf(buf, sizeof(buf) - 1, "%s/%s", prefix, path);" instea=
d?
