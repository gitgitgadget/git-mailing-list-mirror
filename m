From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict
 for connectivity check
Date: Fri, 3 May 2013 04:16:46 -0400
Message-ID: <CAPig+cRRHhiKwc5bPd36xWv-43JoEVU4OaqwxvKMWh0Bv35dOQ@mail.gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-5-git-send-email-pclouds@gmail.com>
	<7vvc722s0h.fsf@alter.siamese.dyndns.org>
	<CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
	<7vvc711h4m.fsf@alter.siamese.dyndns.org>
	<CACsJy8AXe-5o7EyEp_aFB=+Ny8GoqrObxzwbAhGD4w9h7Jhmog@mail.gmail.com>
	<7vk3ngzi6o.fsf@alter.siamese.dyndns.org>
	<7vbo8szh4y.fsf@alter.siamese.dyndns.org>
	<20130503070938.GA5239@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 10:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYBAq-0000jV-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 10:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060Ab3ECIQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 04:16:54 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:44368 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933033Ab3ECIQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 May 2013 04:16:48 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so1284964lbj.24
        for <git@vger.kernel.org>; Fri, 03 May 2013 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/25vDcGYpZ0q5g54MKqvHPqr6Gs30C5B2oEKq1HCU/Y=;
        b=EgHk6XGSkY6Mhyg2FMH9fc9sW5psf9ZH2j4mCieksRe8JyPT0vVGGKUjS/MPLzTRhR
         JlNfoMBWDv/ItUhMqoMWIjnCopEVg1WvwMPdv9pqb4yKSADWAG/zRIeWozWx3m/mAyWp
         bQV6omMFRJ/GgZ2hQDwSfqSWAWV0G7AnZkNYFE3buQRMEpNE0wsoIslbzAC3wvL4QP6P
         M+J+nb8oXMuuR/jBaKLPcvORYj+kh7pTTf1orPoa7nNYu0x3zEvd31n/bq8x5qMBFjdl
         lHnB4nTb4B+AOSEgPGRcCajJpwQ2kX3X0b1+DL06M+n+U8zrmJDuBHLZ41+QU0Ww2OFI
         ft6A==
X-Received: by 10.112.180.233 with SMTP id dr9mr3824366lbc.110.1367569006945;
 Fri, 03 May 2013 01:16:46 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Fri, 3 May 2013 01:16:46 -0700 (PDT)
In-Reply-To: <20130503070938.GA5239@duynguyen-vnpc.dek-tpc.internal>
X-Google-Sender-Auth: mKXz8xl-0SlhiDVZc1hOtuyG8t4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223295>

On Fri, May 3, 2013 at 3:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Subject: [PATCH] clone: open a shortcut for connectivity check
>
> In order to make sure the cloned repository is good, we run "rev-list
> --objects --not --all $new_refs" on the repository. This is expensive
> on large repositories. This patch attempts to mitigate the impact in
> this special case.
>
> In the "good" clone case, we only have one pack. If all of the
> following are met, we can be sure that all objects reachable from the
> new refs exist, which is the intention of running "rev-list ...":
>
>  - all refs point to an object in the pack
>  - there are no dangling pointers in any object in the pack
>  - all objects in the pack does not point to objects outside the pack

"no objects in the pack point to..."

>
> The second and third checks can be done with the help of index-pack a=
s
> a slight modification of --strict check (which introduces a new
> condition for the shortcut: pack transfer must be used and the number
> of objects large enough to call index-pack). The first is checked in
> check_everything_connected after we get an "ok" from index-pack.
>
> "index-pack + new checks" is still faster than "index-pack + rev-list=
"
> currently, which is the whole point of this patch. If any of the
> conditions fails, we fall back to good old and expensive "rev-list
> ..". In that case it's even more expensive because we have to pay for
> the new checks in index-pack.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
