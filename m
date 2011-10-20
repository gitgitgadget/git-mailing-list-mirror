From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 18:27:44 +1100
Message-ID: <CACsJy8BObsN3=uQ=RA-Am4X+WPYnP87mrmY+MbotDL9-VFb3TA@mail.gmail.com>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net> <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org> <20111020043448.GA7628@sigill.intra.peff.net>
 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 09:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGn45-0001P5-E7
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 09:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1JTH2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 03:28:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56316 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1JTH2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 03:28:15 -0400
Received: by bkbzt19 with SMTP id zt19so3183668bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GM8kNHUCXMe44FNDMebHnGkRlTOPYJAOc/z/h68kw1M=;
        b=o+eYtctiiN+7CpqKNj3EAnREcSxK+CF5Kam7QfHejrKs37qKvzqmuhiUr+AGHI7Ga3
         v0MoJjHlfhAwzZXKBMRp2bgTpsqQWDGYl5+eBsNT7+xHr+fhlc1OlqJUEIBrg+aHjj2t
         5f5FP1345iNKc6dXYyJ7f8ehtc2ltfzoyP2Ug=
Received: by 10.204.133.77 with SMTP id e13mr7135122bkt.94.1319095694173; Thu,
 20 Oct 2011 00:28:14 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Thu, 20 Oct 2011 00:27:44 -0700 (PDT)
In-Reply-To: <7vr5289mlu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184012>

On Thu, Oct 20, 2011 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> Agreed. Having hidden cruft makes birthday collision attacks easier =
(or
>> it will, if sha1 ever gets broken to that point). =C2=A0Unfortunatel=
y, there
>> is a _ton_ of code which assumes that commit messages are
>> NUL-terminated, as they always have been since e871b64 (2005-05-25).
>
> I think that commit is irrelevant, as long as read_sha1_file() return=
s the
> contents as <ptr,len> pair, which has been the case forever. It's jus=
t the
> matter of propagating the length back up the callchain.
>
> A na=C3=AFve implementation to add "len" member to struct commit woul=
d increase
> the size of the in-core commit object by sizeof(unsigned long), which=
 we
> may want to avoid. Traversals that care nothing but the topology of t=
he
> history would have to waste that memory and these things tend to add =
up
> (8-byte ulong * 250k commits =3D 2MB).

Or write commit_length(struct commit *c) that calculates SHA-1 from
c->buf and checks against c->object.sha1. If it does not match,
consider NUL part of the message and move to the next NUL. This
function would be expensive so we may not call frequently though.

Or store length in ((int*)c->buf)[-1].
--=20
Duy
