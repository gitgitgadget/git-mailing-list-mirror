From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Wed, 31 Aug 2011 08:35:02 +0700
Message-ID: <CACsJy8BsnKQx2Z1bs3Sdx-1ROeFvCZQkwQT8bWnyzL9du-T3Fw@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-2-git-send-email-gitster@pobox.com> <CACsJy8CmZv7Fuhw+m6X2CVO4vWLYFQNmStu1jJmhVXSi4mPxJQ@mail.gmail.com>
 <7v39gi3ib6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 03:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyZiO-0002Og-TY
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 03:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab1HaBfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 21:35:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47158 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab1HaBfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 21:35:33 -0400
Received: by bke11 with SMTP id 11so244188bke.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XkAqAosK15iY9SPPWrgr9rqvUEm69DVV1MZBRcH2kMo=;
        b=KKPGYLCOMmfhuhubqZdJATJ9IAzByHRwN2ShzZGyDm/lPikpf63XoFTsJ1FDwOs6X5
         BKtrT5aOyv5szQmTZ7Y279lRlWMDbXzjA+BeYygr4sjpO4DrPlHtBDJQFjCRdHQkzlPc
         60wXcOhOsJ7nYf4X4x6o6a0jtAQcaZk89dK3w=
Received: by 10.204.132.18 with SMTP id z18mr548739bks.29.1314754532313; Tue,
 30 Aug 2011 18:35:32 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Tue, 30 Aug 2011 18:35:02 -0700 (PDT)
In-Reply-To: <7v39gi3ib6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180451>

On Wed, Aug 31, 2011 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t=
, struct traverse_info *info)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mask |=3D 1ul << i;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (S_ISDIR(entry[i].mode))
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirmask |=3D 1ul << i;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 e =3D &entry[i];
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> Why? "e" is not used in that loop or anywhere after that.
>
> This is trying to find _a_ surviving entry to be fed to prune_travers=
al()
> which in turn uses tree_entry_interesting(). At this point in the cod=
e, we
> are stuffing the entries of the same name from the input trees (and i=
f one
> tree is missing an entry of the chosen name, it will have NULL there)=
, so
> any non-empty entry would do. It corresponds to "first" but that is j=
ust a
> simple string and not a name_entry tree_entry_interesting() wants.

Ah yes. I only searched in old code, "e" is used in the new
prune_traversal() call.

>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mask)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D info->fn=
(n, mask, dirmask, entry, info);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error =3D ret;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!info->show_all_errors)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interesting =3D =
prune_traversal(e, info, &base, interesting);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (interesting =
< 0)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;
>>
>> I don't really understand this function to comment. But I guess when
>> interesting < 0, we only skip info->fn() and assume it returns "mask=
"
>> (its user unpack_callback() only returns either "mask" or -1).
>
> We consume the entries we have used in merging (which is actually
> "everything in entry[] array" as info->fn() returns "mask" itself) by
> saying "update_extended_entry()" and the purpose of doing so is to pr=
epare
> to process the next entry of the tree we are traversing.
>
> When tree_entry_interesting() returns negative, it tells us "no, and =
no
> subsequent entries will be either", meaning "we are done with this tr=
ee".
> As we are done, there is nothing to prepare for the next round; we ar=
e not
> walking the remaining entries in the trees we are looking at. Is ther=
e any
> point in calling update_extended_entry() I am missing?

No you're right again. Somehow I thought there would be another round
in the loop (ie. continue, not break). My bad.
--=20
Duy
