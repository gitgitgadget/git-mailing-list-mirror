From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: git checkout --orphan skips reflogging
Date: Wed, 14 Sep 2011 17:55:40 +0600
Message-ID: <CA+gfSn8fHYEdQHzamyWqQ0zCvMCTdnVnJM_dxaq9D_hjq7x1zQ@mail.gmail.com>
References: <CA+gfSn-tVgj=FYiVGK7kmH4gpnXF3HUbs+f=DfRey6GrpadVYg@mail.gmail.com>
	<7vaaa8vyc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 13:55:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3o4A-00045G-J2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 13:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab1INLzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 07:55:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55291 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315Ab1INLzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 07:55:41 -0400
Received: by qwj8 with SMTP id 8so49459qwj.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tzSipRCHr4IiMjHuu79N6fzDY5QdFuDnW3VAJTCbNzM=;
        b=i+BS4cJStTs78sANPMeKw7Tn5CG+422BGcyA5kWCHzp9Wdc2BrYX+ZFRmZKAnRTOOo
         SSAE4xO8rwf6HOBzJAY8Hq9+ZKuD71Oga0qE1oBRiWG9lZ3XS05MEbvYsvzry9q0s7nK
         elGcpVGIfsgq4FnQTCnzNgfSIRX3PP7xI03vA=
Received: by 10.229.70.130 with SMTP id d2mr1925539qcj.130.1316001340907; Wed,
 14 Sep 2011 04:55:40 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Wed, 14 Sep 2011 04:55:40 -0700 (PDT)
In-Reply-To: <7vaaa8vyc8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181353>

On Wed, Sep 14, 2011 at 5:04 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dmitry Ivankov <divanorama@gmail.com> writes:
>
>> In short, git checkout --orphan doesn't write
>> HEAD_sha1 -> 00000
>> entry to logs/HEAD, while git-comit will write
>> 00000 -> new_orphan_HEAD_sha1
>> entry. And then reflog backward walk will stop on 000 -> entry and
>> won't see earlier history.
>
> Funny. From the point of view of the _current_ branch, it sort of mak=
es
> sense to stop the traversal at that point, but I agree for HEAD reflo=
g
> that records branch switching, the traversal should not stop.
>
> I am not sure if recording 0{40} after --orphan is the right thing to=
 do
> either (for that matter, I do not necessarily think running --orphan =
is a
> sane thing to do, but that is a separate issue).
In fact, my purpose is more like finding out what branches I were recen=
tly
on, most of the time even what branches I've updated recently. So, bein=
g
able to see chronologically (by ref modification time) ordered list of =
refs
may be a better way (than git log -g --decorate).

>> Isn't =A0it also a bug in reflog walking that we rely on each old_sh=
a1
>> being new_sha1 of a previous entry?
>
> I am not all that familiar with the reflog walking (which is admitted=
ly a
> bolted-on hack that injects commits with fake ancestry) code, but I t=
hink
> it assumes the old sha1 field on the current entry matches the new sh=
a1
> field on the previous entry, and we could change it to be a bit more
> robust.
>
> The attached patch _may_ (I didn't even compile test it) remove the
> dependency on osha1[] and make the code consistently use nsha1[], but=
 I
> think stopping at the 0{40} is pretty much fundamental in the revisio=
n
> walking machinery the reflog walking code is piggy-backing on, and I =
do
> not think this patch would change that.
The patch compiles fine, and walks past osha1 =3D=3D 0{40}. Probably os=
ha1
becomes completely hidden from the walking machinery, and since nsha1 i=
s
never 0{40} (for now) whole history is walked.
