From: cheng renquan <crquan@gmail.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Fri, 8 Jun 2012 14:46:06 -0700
Message-ID: <CAH5vBdLGHpFCH3mWgNANTw4frzqSz=AO+kB12DSx55wn1hYJag@mail.gmail.com>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
	<CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
	<CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
	<7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
	<7v8vfzjbhi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd70Z-0002qk-LE
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 23:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914Ab2FHVqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 17:46:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59725 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964867Ab2FHVqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 17:46:08 -0400
Received: by weyu7 with SMTP id u7so873842wey.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Yz1NAm8+t/1rQ+IltUND1phuuhmS9Hh0MvU8tVeWG2Q=;
        b=1BMVbuw9+76gJzCEj0J2c1litCG0hibeSL9eNrValyQpfGVko6s8ou/YYqXD8OY0Lv
         9CG6OKj38Fk5W3LBbZ3g8I0vlwycBfoHpzuQvYJIAnjk0EFOoDcReiuSVcBgi3XgjGlY
         6h0rHaphkXu5wmUo5+AU506PVcKy4TA1mvEF+j7nwk8oLbTogwXmjZgvjCLNuEQfOfaO
         wfXeiBFZyOWoh6GPyj12WyUH+ai//Yro3uZMiam6BPNmHGpLsHDft/KXg51NslBeHaf2
         QckZ2b24HXTSEp7kHZnMUzXa4VFTXSn24DmECLg/rE+DX44HmSUOTWxDS0fzj89840fZ
         1bEA==
Received: by 10.216.196.218 with SMTP id r68mr2029050wen.122.1339191966931;
 Fri, 08 Jun 2012 14:46:06 -0700 (PDT)
Received: by 10.216.136.80 with HTTP; Fri, 8 Jun 2012 14:46:06 -0700 (PDT)
In-Reply-To: <7v8vfzjbhi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199534>

On Thu, Jun 7, 2012 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0* The auto-follow kicks in whenever you tell "fetch" to update =
some
> =C2=A0 refs locally. =C2=A0Maybe if we tweak the rule and auto-follow=
 kick in
> =C2=A0 only when you tell "fetch" to update some refs outside refs/ta=
gs
> =C2=A0 locally,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git fetch $over_there tag v1.0.0
>
> =C2=A0 will fetch and store _only_ the v1.0.0 tag.
>
> =C2=A0 Of course, any behaviour change is a regression, and if done
> =C2=A0 without an escape hatch, such a change robs people one useful
> =C2=A0 feature: grab tag v1.0.0 and others older than that tag in one
> =C2=A0 go.
>
> I won't be coding any of the above; just thinking aloud.

Here is the code to implement your 2nd approach,
and I don't think this behaviour change is a regression,
because if someone is really relying this fetch one tag actually fetch
all tags feature
he is relying on a broken feature, and should be corrected:
if one really need to fetch all tags, that's what explicit "--tags"
designed and documented for


diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..b6d7ef3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -158,7 +158,8 @@ static struct ref *get_ref_map(struct transport *tr=
ansport,
 	if (ref_count || tags =3D=3D TAGS_SET) {
 		for (i =3D 0; i < ref_count; i++) {
 			get_fetch_map(remote_refs, &refs[i], &tail, 0);
-			if (refs[i].dst && refs[i].dst[0])
+			if (refs[i].dst && refs[i].dst[0]
+			    && prefixcmp(refs[i].dst, "refs/tags/"))
 				*autotags =3D 1;
 		}
 		/* Merge everything on the command line, but not --tags */

--=20
cheng renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8)
