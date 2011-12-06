From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 22:30:30 +0700
Message-ID: <CACsJy8Btwn0=PGS+PJV-6DqYBmzOp7LTB2=R_kCx4SJHA2YDRw@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com> <4EDE2C95.5040804@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 06 16:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXwzD-0008I7-K8
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 16:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab1LFPbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 10:31:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44495 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043Ab1LFPbC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 10:31:02 -0500
Received: by eaak14 with SMTP id k14so5229116eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 07:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lFwy9XrMVvyz2aIJy9UciMJvEUOHtNGCYiesXCHAj80=;
        b=WlxtU69+79xNNCYmZnZGb5LxD9gZfF54nUle1w8kOSstN+J8P+N6On3HdF+KnZOwOu
         h/kmXEh3b/hJ+dmtSs8ROFR/5aXtT21z3ydE92f4mdv55N59cfhc4BTD/LuaUShlTslb
         8Kl2hgZzgLPGlOFR+KtSwHW/wuIA0Uiv8EYh0=
Received: by 10.213.108.138 with SMTP id f10mr2535477ebp.84.1323185461572;
 Tue, 06 Dec 2011 07:31:01 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 07:30:30 -0800 (PST)
In-Reply-To: <4EDE2C95.5040804@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186352>

2011/12/6 Michael Haggerty <mhagger@alum.mit.edu>:
> On 12/06/2011 01:17 PM, Erik Faye-Lund wrote:
>> 2011/12/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>>> Too deep delta chains can cause stack overflow in get_base_data(). =
Set
>>> a hard limit so that index-pack does not run out of stack. Also sto=
p
>>> people from producing such a long delta chains using "pack-object
>>> --depth=3D<too large>"
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> =C2=A0I used to make very long delta chains and triggered this in i=
ndex-pack.
>>> =C2=A0I did not care reporting because it's my fault anyway. Think =
again,
>>> =C2=A0index-pack is called at server side and a malicious client ca=
n
>>> =C2=A0trigger this. This patch does not improve the situation much,=
 but at
>>> =C2=A0least we won't get sigsegv at server side.
>>
>> Wouldn't it make more sense to make the limit a config option rather
>> than a hard-coded value of 128 (which seems arbitrary to me)? After
>> all, different platforms have different stack-limitations...
>
> I'm confused: is the data only ever read by the same host that genera=
ted
> it?

index-pack is called at server side as part of a push. So in theory
the sending side can generate very long delta chains and bring down
the server side.

> =C2=A0Because if not, then the "creator" had better never be configur=
ed
> to use a chain depth that the "reader" cannot handle.

Normal creators (i.e. C Git) use default depth 50 so we should be safe.

> =C2=A0This in turn
> imply that there should be a common limit that is supported by all gi=
t
> clients and is a documented part of the protocol. =C2=A0(Or the code =
has to
> be rewritten to use an explicit stack instead of recursion.)

It's the implementation limitation, not the protocol. If the server
propagates error messages from index-pack back to client (I'm not
sure), then users can adjust --depth to be accepted by server. We
could negotiate the limit over the protocol but not sure we would want
to go that route.

The troubled code could be rewritten to avoid recursion. However long
delta chains may degrade performance, I'd rather have support to split
long chains (which can be done with --depth at client already) instead
of just recursion elimination. This patch is simpler, so it would be
easier to back port it if someone wants to do so.
--=20
Duy
