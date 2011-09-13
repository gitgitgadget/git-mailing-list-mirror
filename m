From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Tue, 13 Sep 2011 18:40:07 +0200
Message-ID: <CAP8UFD3ULs9YLCaaJYGo-_A=KqO4yFy3WHJmO5b_hyRSPzA-Vg@mail.gmail.com>
References: <20110912195652.GA27850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 18:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3W1y-0000cS-Lw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 18:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab1IMQkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 12:40:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53097 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab1IMQkJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 12:40:09 -0400
Received: by wwf22 with SMTP id 22so998891wwf.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0CiU5kWXIq4oFpVAwn71apVmjWz7BAQcbs/ffb8rdmQ=;
        b=CzGSVHFqT4JZxaNxRgW/Hd5VOPX1sopOG20dV5KFp0vfYAdhzjQ8HLINwwXyxM0A68
         0nd+qF7dP2aWiFLuzso4k37bbTrnNhQk8JtuGbxzR3WKVdDmitLs+d38+n8n0wiX4PMi
         QTbNHPLvUHNa+m7ggIQ0+iXW4wU9lCcokElPw=
Received: by 10.227.26.8 with SMTP id b8mr3328770wbc.28.1315932007873; Tue, 13
 Sep 2011 09:40:07 -0700 (PDT)
Received: by 10.180.96.229 with HTTP; Tue, 13 Sep 2011 09:40:07 -0700 (PDT)
In-Reply-To: <20110912195652.GA27850@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181290>

Hi Peff,

On Mon, Sep 12, 2011 at 9:56 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/submodule.c b/submodule.c
> index 7a76edf..00aeb71 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -8,12 +8,17 @@
> =A0#include "diffcore.h"
> =A0#include "refs.h"
> =A0#include "string-list.h"
> +#include "sha1-array.h"

Nice to see you reuse sha1-array!

[...]

> +struct argv_array {
> + =A0 =A0 =A0 const char **argv;
> + =A0 =A0 =A0 unsigned int argc;
> + =A0 =A0 =A0 unsigned int alloc;
> +};

But there is already such a struct in bisect.c!

> +static void init_argv(struct argv_array *array)
> +{
> + =A0 =A0 =A0 array->argv =3D NULL;
> + =A0 =A0 =A0 array->argc =3D 0;
> + =A0 =A0 =A0 array->alloc =3D 0;
> +}
> +
> +static void push_argv(struct argv_array *array, const char *value)
> +{
> + =A0 =A0 =A0 ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
> + =A0 =A0 =A0 array->argv[array->argc++] =3D xstrdup(value);
> + =A0 =A0 =A0 array->argv[array->argc] =3D NULL;
> +}
> +
> +static void clear_argv(struct argv_array *array)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 for (i =3D 0; i < array->argc; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free((char **)array->argv[i]);
> + =A0 =A0 =A0 free(array->argv);
> + =A0 =A0 =A0 init_argv(array);
> +}
> +
> +static void add_sha1_to_argv(const unsigned char sha1[20], void *dat=
a)
> +{
> + =A0 =A0 =A0 push_argv(data, sha1_to_hex(sha1));
> +}

So it would be nice if you could refactor this and the argv_array
functions in bisect.c in the same way you refactored sha1-array.

Thanks,
Christian.
