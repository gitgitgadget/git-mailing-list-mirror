From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Sat, 3 Mar 2012 17:09:05 +0700
Message-ID: <CACsJy8ANF+tqMzXrYamSHv0N==6Wc2sVbQwJO40+=f+R+HMnbA@mail.gmail.com>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org> <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
 <7v1upagb8z.fsf@alter.siamese.dyndns.org> <CACsJy8B7u-rvnFZKi4t2CoB=J3Ra8pWxK4439NTdnHQDhm2ibQ@mail.gmail.com>
 <7vfwdq8914.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 11:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3luI-0000O3-Ta
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 11:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab2CCKJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 05:09:37 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:51347 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab2CCKJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2012 05:09:36 -0500
Received: by wejx9 with SMTP id x9so1494516wej.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 02:09:35 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.24.7 as permitted sender) client-ip=10.180.24.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.24.7 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.24.7])
        by 10.180.24.7 with SMTP id q7mr3102412wif.14.1330769375467 (num_hops = 1);
        Sat, 03 Mar 2012 02:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+Yt6LSOfSb48G44XaK7SVA1dp9mAtLhANpoeCs16CFU=;
        b=imeLYi0BR4fDtogYrYmjgGMd7IY3TCMmQTSS7fJTk/q9Zuc4Py1r0ntNS55vlFs/fQ
         emT+pgeYZLGDNazQ6ciTcR8GdP9O+EU8ivDZ/6Y/Xx499/d4tthG1aQLB9vABiv7la/v
         fYrSnTlwzWa4pTLxYZGmik3Ku/hWs0Vu0ExIzdE4deZsx4WgfuCEX1yP5yX2WRdDV86K
         T9eJAbFlLVogpSuiKNOFmTKy3lpAdeLbarjIBMPTA9wl/Wblv5n+MJ7x3Ld2pscUeoDa
         VRHi4ZwD7ypnPO6VJ9M/VFjLGISX8IlMGzAxVETmDRtUrPDgAoan1wDxlnUwJ+PW2JwH
         bVNg==
Received: by 10.180.24.7 with SMTP id q7mr2455136wif.14.1330769375285; Sat, 03
 Mar 2012 02:09:35 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sat, 3 Mar 2012 02:09:05 -0800 (PST)
In-Reply-To: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192102>

On Sat, Mar 3, 2012 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> I also suspect that more than trivial amount of computation is need=
ed to
>>> determine if a given object exists only in a single pack, so the en=
d
>>> result may not be that much cheaper than the current --verify-objec=
t code.
>>
>> Objects can exist in multiple packs right now if they are base
>> objects. I'm not sure why you need to check for object existence in =
a
>> single pack.
>
> What I meant to say was not "it is in this pack and nowhere else", bu=
t
> about a check like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static void finish_object(struct object *o=
bj, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct packed_=
git *fetched_pack =3D cb_data->fetched_pack;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (obj->type =
=3D=3D OBJ_BLOB && !has_sha1_file(obj->sha1))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("missing");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info->rev=
s->verify_objects)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (find_pack_=
entry_one(obj->sha1, fetched_pack))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return; /* we just fetched and ran index-pack on it */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj->pars=
ed && obj->type !=3D OBJ_COMMIT)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0parse_object(obj->sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> I think this is the kind of "passing identity down the callchain" bot=
h of
> us have in mind. =C2=A0I was trying to say that find_pack_entry() may=
 not be
> trivially cheap. =C2=A0But probably I am being worried too much.

This is after index-pack is run and .idx file created, I think
determining object's storage type should be relatively cheap compared
to rehashing. We'll know when I update the patch.

> But now you brought it up, I think we may also need to worry about a
> corrupt pre-existing loose blob object. =C2=A0In general, we tend to =
always
> favor reading objects from packs over loose objects, but I do not kno=
w
> offhand what repacking would do when there are two places it can read=
 the
> same object from (it should be allowed to pick whichever is easier to
> read).

=2E. which should be pack for pack-objects/repack because they can do a
straight copy from pack to pack. --no-reuse-objects delegates object
reading back to read_sha1_file(), and this one prefers packs too.
--=20
Duy
