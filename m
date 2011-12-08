From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] index-pack: eliminate unlimited recursion in get_delta_base()
Date: Wed, 7 Dec 2011 19:02:29 -0800
Message-ID: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
References: <7vvcpthh97.fsf@alter.siamese.dyndns.org> <1323280223-7990-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 04:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYUG8-0005S6-0R
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 04:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab1LHDCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 22:02:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41696 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637Ab1LHDCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 22:02:50 -0500
Received: by iakc1 with SMTP id c1so1861105iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 19:02:50 -0800 (PST)
Received: by 10.42.159.195 with SMTP id m3mr1646257icx.33.1323313370162; Wed,
 07 Dec 2011 19:02:50 -0800 (PST)
Received: by 10.50.171.39 with HTTP; Wed, 7 Dec 2011 19:02:29 -0800 (PST)
In-Reply-To: <1323280223-7990-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186527>

2011/12/7 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Revert the order of delta applying so that by the time a delta is
> applied, its base is either non-delta or already inflated.
> get_delta_base() is still recursive, but because base's data is alway=
s
> ready, the inner get_delta_base() call never has any chance to call
> itself again.
=2E..
> @@ -508,10 +508,25 @@ static void *get_base_data(struct base_data *c)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!c->data) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct object_=
entry *obj =3D c->obj;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct base_data *=
*delta =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int delta_nr =3D 0=
, delta_alloc =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_delta_type(=
obj->type)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 void *base =3D get_base_data(c->base);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 void *raw =3D get_data_from_pack(obj);

I think you missed the critical recursion. The real work is the
recursion within find_unresolved_deltas(). This little helper
get_base_data() shouldn't be tripping over these cases unless we have
run out of delta_base_cache_limit and released objects near the base
end of the delta chain, in which case this will restore them.

Maybe this is useful on its own, but in my opinion its not an
interesting patch to consider without first fixing
find_unresolved_deltas's recursion.
