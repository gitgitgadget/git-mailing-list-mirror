From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] transport-helper.c: fix check for size_t < 0
Date: Fri, 4 Mar 2011 21:20:46 +0100
Message-ID: <AANLkTimc_iLDXxrV=tfZc+_dCkpx6897Lh8sZxkwbgDo@mail.gmail.com>
References: <20110304202834.2e74d56d@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Kaiser <nikai@nikai.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 21:20:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvbUc-00046C-F8
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 21:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab1CDUUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 15:20:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35573 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1CDUUr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 15:20:47 -0500
Received: by vws12 with SMTP id 12so2323596vws.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 12:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hg0C9yXj2TKX6mUQoUJHiWuGOu+sdfYvvlkaoVs9tOQ=;
        b=wGeBLdSbB98b9aoKi5fpBUPwi1b6kL5ffRc3i5a95B3V+uPvNhCaMDedNSZdWS0zql
         vM667FiecaDbaIEtY1DLhjkYFFxhiILwMA9L06iKwDf3/OaDm8Yk3Z+nHbbrrLV3N9WF
         tvXnmFlI1rMUg87TyPeK1euFR4e0YD7baOOlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FWsXPL8H29hYZgVdwnF8VDEV+bkktbQCJxq2WSgCrdNcGna75l6ElfYb0XpCUxBovi
         n5PmsV808RvSi3nPaVfy45j6XKrhTrlpZWQ/6kf2CzVtOGNM/ZvzYRCiI52SkbNUcFR1
         x481tYZIAGYvkIbJWxWqdTog1NZZCo5uGscCc=
Received: by 10.52.72.232 with SMTP id g8mr1647308vdv.108.1299270046172; Fri,
 04 Mar 2011 12:20:46 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Fri, 4 Mar 2011 12:20:46 -0800 (PST)
In-Reply-To: <20110304202834.2e74d56d@absol.kitzblitz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168466>

On Fri, Mar 4, 2011 at 8:28 PM, Nicolas Kaiser <nikai@nikai.net> wrote:
> 'bytes' is unsigned of type size_t, and can't be negative.
> But the assigned write() returns ssize_t, and -1 on error.
> For testing < 0, 'bytes' needs to be of a signed type.

You are right that, but the fix should be to use ssize_t not  plain "in=
t".
(udt_do_read() correctly uses ssize_t)

Not providing patch since the change is trivial.

>
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---
> Testsuite did not regress at my place.
>
> =A0transport-helper.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 4e4754c..710b6f1 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -973,7 +973,7 @@ static int udt_do_read(struct unidirectional_tran=
sfer *t)
> =A0*/
> =A0static int udt_do_write(struct unidirectional_transfer *t)
> =A0{
> - =A0 =A0 =A0 size_t bytes;
> + =A0 =A0 =A0 int bytes;
>
> =A0 =A0 =A0 =A0if (t->bufuse =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0; =A0 =A0 =A0 /* Nothing to wr=
ite. */
> @@ -989,7 +989,7 @@ static int udt_do_write(struct unidirectional_tra=
nsfer *t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->bufuse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memmove(t->buf, t->buf=
 + bytes, t->bufuse);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0transfer_debug("Wrote %i bytes to %s (=
buffer now at %i)",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (int)bytes, t->dest_nam=
e, (int)t->bufuse);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes, t->dest_name, (i=
nt)t->bufuse);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.3.4


--=20
Piotrek
