From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/6] transport-helper: update remote helper namespace
Date: Wed, 17 Apr 2013 23:14:15 -0500
Message-ID: <CAMP44s05XMWO=HTDj-tBiEpXozJk7Q9e3+9d0d0U5bseGWTyzg@mail.gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
	<1366243524-18202-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgEv-00006B-RG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab3DREOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:14:19 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:42158 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab3DREOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:14:16 -0400
Received: by mail-la0-f52.google.com with SMTP id ek20so2158037lab.11
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SAyq6fYqd5EmXbqDF+i37OuFu1N8xve8F/R8Jcp/dNk=;
        b=SM9iUVNTqtGFtDDE+YL2cZVXq2edGOH8UIoZK1QQCBuQ72uedVvBSz1fwYT++CHw3R
         hiOSobDOf0uJz9X/knyvfRFHReqEermKzwPbvnsW2LfO1W8GBWFUD8C/rCBNcX7ZSO1U
         5M+p0VB1jyg2phniWU/yHOilSY8ajQzSEk30qdBWYSKekijZRm9n6JzTRVNpzp5u0MRo
         Lpo0GvbXmYhuOJo4r5uswYxIn0EimrazAhQRa13xhkgYoxOTBN+GT2+6Rmubo6zS3AtG
         qgCT4piAB3ePVbrWzvgZHOVD7MYLrERTisg9TmZ48vF+ffijZylBNjSrfTSuVrB3efoq
         9dnw==
X-Received: by 10.152.18.164 with SMTP id x4mr4894364lad.38.1366258455083;
 Wed, 17 Apr 2013 21:14:15 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 21:14:15 -0700 (PDT)
In-Reply-To: <1366243524-18202-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221601>

On Wed, Apr 17, 2013 at 7:05 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -153,4 +153,16 @@ test_expect_success 'push ref with existing object' '
>         compare_refs local dup server dup
>  '
>
> +test_expect_success 'push update refs' '
> +       (cd local &&
> +       git checkout -b update master &&
> +       echo update >>file &&
> +       git commit -a -m update &&
> +       git push origin update
> +       git rev-parse --verify testgit/origin/heads/update >expect &&
> +       git rev-parse --verify remotes/origin/update >actual
> +       test_cmp expect actual

Slightly confusing and a bit buggy:

-       git rev-parse --verify testgit/origin/heads/update >expect &&
-       git rev-parse --verify remotes/origin/update >actual
+       git rev-parse --verify remotes/origin/update >expect &&
+       git rev-parse --verify testgit/origin/heads/update >actual &&

>  static void push_update_refs_status(struct helper_data *data,
> @@ -708,11 +710,21 @@ static void push_update_refs_status(struct helper_data *data,
>         struct strbuf buf = STRBUF_INIT;
>         struct ref *ref = remote_refs;
>         for (;;) {
> +               char *private;
> +
>                 recvline(data, &buf);
>                 if (!buf.len)
>                         break;
>
> -               push_update_ref_status(&buf, &ref, remote_refs);
> +               if (push_update_ref_status(&buf, &ref, remote_refs))
> +                       continue;

Actually, since this function is also used by push_with_push:

               if (!data->refspecs)
                       continue;

I had it in my previous series but removed it.


I'll reroll.

-- 
Felipe Contreras
