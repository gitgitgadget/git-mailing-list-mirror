From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/21] tree_entry_interesting(): support depth limit
Date: Sat, 29 Jan 2011 10:13:50 +0700
Message-ID: <AANLkTik_7FUuocoXa7Rk5DWSR4ie7FBfYNa0MSQzwnsZ@mail.gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-10-git-send-email-pclouds@gmail.com> <7vd3ngdaoa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 04:14:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj1Gp-0003QU-Nh
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 04:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab1A2DOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 22:14:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53936 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1A2DOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 22:14:22 -0500
Received: by wyb28 with SMTP id 28so3864934wyb.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 19:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=nHy6Sl/hH1lzY4uPP60UIE5+ehl2NBV3j7QoYQ55+Cg=;
        b=tIPCMTg+YBywXUPttVeDA9dV5qzUFZ2rHYQd57YesTZMTdYxWPcMOokis/E24ZQraf
         KFdVFm0PpWDqiAXOTXlXSYu5aJaETeJ81VZq0ZeoTyZa01IbW91fgh3dpwpCoeJQIULB
         zX3ok9C26UcckA/iVp+BVft3YFKX7oU3pY9Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PkLDzwOBrk+f5O0goRiQw13wQUjl5NpzXA+PahwQ2wHysmTp6IYJx0u9EsvPXxmmL0
         dVjGkoRAWMywa0Y5qtDcVuPFlgCfn1gHP3xjxTROdu13696I3BkyKZLx0EZTeKIEGKl0
         kx0Alws9slTb0HhPxgJA4vcnkTY9IO31cNFdY=
Received: by 10.216.52.134 with SMTP id e6mr3907157wec.49.1296270860850; Fri,
 28 Jan 2011 19:14:20 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Fri, 28 Jan 2011 19:13:50 -0800 (PST)
In-Reply-To: <7vd3ngdaoa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165651>

2011/1/29 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> =C2=A0static const char *get_mode(const char *str, unsigned int *mod=
ep)
>> @@ -557,8 +558,13 @@ int tree_entry_interesting(const struct name_en=
try *entry,
>> =C2=A0 =C2=A0 =C2=A0 int pathlen, baselen =3D base->len;
>> =C2=A0 =C2=A0 =C2=A0 int never_interesting =3D -1;
>>
>> - =C2=A0 =C2=A0 if (!ps || !ps->nr)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>> + =C2=A0 =C2=A0 if (!ps->nr) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ps->recursive || ps=
->max_depth =3D=3D -1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return !!within_depth(ba=
se->buf, baselen,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!S_ISDIR(entry->m=
ode),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ps->max_depth);
>> + =C2=A0 =C2=A0 }
>
> Back in 1d848f6 (tree_entry_interesting(): allow it to say "everythin=
g is
> interesting", 2007-03-21), a new return value "2" was introduced to a=
llow
> this function to tell the caller that all the remaining entries in th=
e
> tree object the caller is feeding the entries to this function _will_
> match. =C2=A0This was to optimize away expensive pathspec matching do=
ne by this
> function.
>
> In that version, "no pathspec" case wasn't changed to return 2 but st=
ill
> returned 1 ("I tell you that this does not match; call me with the ne=
xt
> entry"). =C2=A0We could have changed it to return 2, but the overhead=
 was only
> a call to a function that checks the number of pathspecs and was not =
so
> bad.
>
> But shouldn't we start returning 2 by now? =C2=A0It is not that retur=
ning 1 was
> a more correct thing to do to begin with.
>
> When depth check is in effect, the result depends on the mode of the
> entry, so we cannot short-circuit by returning 2, but at least we sho=
uld
> do so when (max_depth =3D=3D -1), no?

Yes, should be 2.
--=20
Duy
