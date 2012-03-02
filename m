From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Fri, 2 Mar 2012 21:05:09 +0700
Message-ID: <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3T7I-00068T-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab2CBOFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 09:05:42 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:62562 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab2CBOFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 09:05:41 -0500
Received: by wejx9 with SMTP id x9so1059505wej.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3PFmfQP66RrO9thUoXn9+HijrKIu0kei7xx39zIgIz4=;
        b=z+4eLI425Q7H6BYyJKUcysZJM/VpQXc1Q/RnJlwVDZwbymA6SowgDMGRW7LOcQHINV
         pFr7yEChbu2WLKQj2yInlBdQB9E8GCcIzjkRfE2XOQF9O0/3vHdurYaublS3tA04P5e8
         ozR9+YUc79tXnYsxtyIAJOpeeAyFLU1BPE6Jd1t81XVSauCayjydKPR2orSmE61wvg2f
         SGoLzV3exjhLeXaATlCV+4ZZYoQa53Jvsa7mIcG7EdxS/wag1/NSd6SnGUdXV6s7T5mV
         CTIZcBaHXbZfzDkI4oSbIpeuBXfftsQ/nXVglwgqTxWCiudb2O1IE9ljFxy+5fJJPgt+
         i8Dw==
Received: by 10.180.99.65 with SMTP id eo1mr4532429wib.13.1330697140343; Fri,
 02 Mar 2012 06:05:40 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 06:05:09 -0800 (PST)
In-Reply-To: <7vwr73h6td.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192043>

2012/3/2 Junio C Hamano <gitster@pobox.com>:
> Consider a case where you have this history
>
>
> =C2=A0 =C2=A0---T =C2=A0 =C2=A0 =C2=A0 o---o---o
>
> where 'T' is the tip of your ref (everything reachable from it is kno=
wn to
> be good), and 'o' are "isolated islands" commits that somehow exist i=
n
> your repository but are not complete for whatever reason.
>
> The global history may look like this, where 'X' is the tip the other=
 end
> advertised, and '.' are commits that are new to your repository.
>
> =C2=A0 =C2=A0---T---.---o---o---o---.---X
>
> Upon seeing 'X' advertised and noticing 'T' is the current tip, you w=
ould
> ask for everything that is needed, i.e. "rev-list --objects T..X", to=
 be
> sent to you.
>
> But the other end could send all the trees and commits for 'X' and '.=
' but
> nothing for 'o'. =C2=A0You will end up with a corrupt history but the=
 loosened
> "rev-list --objects T..X" you run after the object transfer will not =
catch
> it. =C2=A0You need --verify-objects if you want to catch this mode of=
 attack.

OK I think I get what you are trying to say. With "rev-list --objects
T..X" we could check commit connectivity from X to T fine. But some
trees in those 'o' commits are bad, but well-formed. As a result,
rev-list goes well and we blindly accept bad trees/blobs. By checking
for tree and blob integrity, we would catch these bad guys. Is that
correct?

The bad islands may be injected from somewhere and cannot be trusted
until they get connectivity with the main DAG.

> Admittedly, in order to mount such an attack successfully, the attack=
er
> needs to know what "isolated islands" you happen to have in the recei=
ving
> repository, which makes it much harder than a simpler attack (e.g. se=
nding
> only X but nothing else) that would have worked before we introduced =
the
> connectivity check after object transfer.
>
> But we need to realize that the reasoning expressed in your log messa=
ge
> "we received new objects by pack, so everything must validate fine" i=
s not
> valid, and we are loosening ourselves to new attacks when we evaluate=
 this
> patch. =C2=A0This is because the completion of the history may be usi=
ng objects
> that did not come from the other side (i.e. commits 'o' and all the t=
rees
> necessary for them, but their blobs may be corrupt).

Not everything is valid, then. Objects from new packs are, existing
ones may be guilty. If there is a way to mark new packs trusted, then
we only need to validate the other objects, which should be the
minority or even empty unless an attack is mounted.
--=20
Duy
