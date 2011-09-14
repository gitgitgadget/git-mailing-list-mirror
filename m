From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/7] refactor argv_array into generic code
Date: Wed, 14 Sep 2011 07:54:48 +0200
Message-ID: <CAP8UFD1vxP9ABgJpM99hxDWWLeGO_QW7QLVFq1f-teu1fiCftA@mail.gmail.com>
References: <20110913215026.GA26743@sigill.intra.peff.net>
	<20110913215757.GC24490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 07:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3iRI-0005Rk-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 07:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab1INFyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 01:54:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57238 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab1INFyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 01:54:49 -0400
Received: by wyh22 with SMTP id 22so1309666wyh.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 22:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TziJtWda/1LuT1DIEMIsq/vkBdgJHppv3Llph7tCFgg=;
        b=fnypSeOIIJ6Fbe+ehhYnEUWtW9GIDS3RUn2lGs1rsxZ66XYNLwkK4aeFsRDTqEtTWo
         oGHbTD3NUFr1LzExKRilqD2Kmk6Fc5e2PXNZfO36Gaf+13SdZbrmeIojLOdoUFLr5gEd
         PL/qF3Wx9ZMGP5IuRZHSloyYTQeGzIDs24zWk=
Received: by 10.227.24.136 with SMTP id v8mr552492wbb.28.1315979688063; Tue,
 13 Sep 2011 22:54:48 -0700 (PDT)
Received: by 10.180.96.229 with HTTP; Tue, 13 Sep 2011 22:54:48 -0700 (PDT)
In-Reply-To: <20110913215757.GC24490@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181338>

Hi Peff,

On Tue, Sep 13, 2011 at 11:57 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/argv-array.c b/argv-array.c
> new file mode 100644
> index 0000000..a50507a
> --- /dev/null
> +++ b/argv-array.c
> @@ -0,0 +1,52 @@
> +#include "cache.h"
> +#include "argv-array.h"
> +#include "strbuf.h"
> +
> +static const char *empty_argv_storage =3D NULL;
> +const char **empty_argv =3D &empty_argv_storage;
> +
> +void argv_array_init(struct argv_array *array)
> +{
> + =A0 =A0 =A0 array->argv =3D empty_argv;
> + =A0 =A0 =A0 array->argc =3D 0;
> + =A0 =A0 =A0 array->alloc =3D 0;
> +}
> +
> +static void argv_array_push_nodup(struct argv_array *array, const ch=
ar *value)
> +{
> + =A0 =A0 =A0 if (array->argv =3D=3D empty_argv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 array->argv =3D NULL;
> +
> + =A0 =A0 =A0 ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
> + =A0 =A0 =A0 array->argv[array->argc++] =3D value;
> + =A0 =A0 =A0 array->argv[array->argc] =3D NULL;
> +}
> +
> +void argv_array_push(struct argv_array *array, const char *value)
> +{
> + =A0 =A0 =A0 argv_array_push_nodup(array, xstrdup(value));
> +}
> +
> +void argv_array_pushf(struct argv_array *array, const char *fmt, ...=
)
> +{
> + =A0 =A0 =A0 va_list ap;
> + =A0 =A0 =A0 struct strbuf v =3D STRBUF_INIT;
> +
> + =A0 =A0 =A0 va_start(ap, fmt);
> + =A0 =A0 =A0 strbuf_vaddf(&v, fmt, ap);
> + =A0 =A0 =A0 va_end(ap);
> +
> + =A0 =A0 =A0 argv_array_push_nodup(array, strbuf_detach(&v, NULL));
> +}

In sha1-array you called the "push" function "sha1_array_append"
instead of "sha1_array_push", so I wonder why here you call them
"*_push*" instead of "*_append*"?

Thanks for doing this anyway,
Christian.
