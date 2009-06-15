From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 10:45:22 +0200
Message-ID: <81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
References: <87bpoqoavp.fsf@meyering.net>
	 <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	 <87fxe2lybr.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG7ov-0000HD-I3
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 10:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660AbZFOIpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZFOIpX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 04:45:23 -0400
Received: from mail-fx0-f206.google.com ([209.85.220.206]:64871 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256AbZFOIpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 04:45:22 -0400
Received: by fxm2 with SMTP id 2so119290fxm.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7RCXSmgU9VeARKLwF9GDnvit4kEaiGr0IOnEiITACkY=;
        b=I5JLIQMmF5sPi5O4o/QINUFbbJxvxMTP35PG7gH5TFTUFlyPC8FdtGyks8g95+wGYH
         fExK99zqjE9Zm/ebkVsjhyfpKI+NLB4OTa8Ib4Cj934rhwbd7W9rYTPxPj2eaNb687qQ
         hZZrX7yE+c8NdVIUNRuTUfA0pBwVVIoLopa3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=szkKLE5nTEIqudgY1PKQfrJNRJBSbMu9u66U9SyRPRTutu6SbYgIR8JZUhai6Ocwlp
         fS12NdbmCUVgLpccMcmOfG18Xu0JAdniPLBx6xzbcxPyANhEKkGpRyiVbT2sm2wuMRMf
         vKFojy4d/D3nGrzEotksr9a1BnKJbbyuiuw1g=
Received: by 10.204.69.66 with SMTP id y2mr6848161bki.49.1245055522949; Mon, 
	15 Jun 2009 01:45:22 -0700 (PDT)
In-Reply-To: <87fxe2lybr.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121592>

2009/6/15 Jim Meyering <jim@meyering.net>:
> Alex Riesen wrote:
>> 2009/6/14 Jim Meyering <jim@meyering.net>:
>>> @@ -231,7 +231,7 @@ static int read_merge_config(const char *var, c=
onst char *value, void *cb)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(var, "merge.default")) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_ll_merge =3D strdup(value);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_ll_merge =3D xstrdup(value);
>>
>> read_merge_config has a failure mode (where it returns -1), why not =
use it?
>
> I didn't even consider it, because it would be inconsistent with
> the other heap-allocation functions used there (xcalloc, xmemdupz).
>
> However, now that I do, it looks like that would mean adding four tim=
es
> the same code (including conditionals and code to generate a diagnost=
ic via
> a call to error -- or a goto). Why bother, when all of that is alread=
y
> encapsulated in xmalloc?

So that a useful error message can be given in the _caller_ (it knows
more about context)?

Otherwise the error message ("Out of memory, strdup failed") does not
have anything about the place nor situation in it. As the situations
when a modern system really runs out of memory are very rare,
mostly such reports just point at some inconsistency elsewhere
(like bloody stupid memory management in system support libraries
on an OS-not-to-be-named-again or the usual corruption of heap
control structures).

Besides, xstrdup does more then just allocation: it tries to free globa=
l
list of cached pack chunks. This does not play very well with the effor=
ts
to make a library out of the modern Git code.

> Maybe because you want to be able to continue after an allocation fai=
lure?

No.

> If a small strdup allocation fails, odds are good that the code won't
> be able to do anything useful, so when not in library code, cleanest =
is
> simply to exit.

Doubt it (because you better describe _why_ you "simply" interrupted
users workflow, so the said user can do something about it).

> In addition, if you insist on using strdup, you'll probably want to
> be consistent and use calloc and memdupz, too. =C2=A0Adding all of th=
e code
> required to recover from those failures and to avoid leaks would be m=
essy.

I don't insist on that. I should have said in the first message about
more elaborate explanation of the error to user. Sorry.
