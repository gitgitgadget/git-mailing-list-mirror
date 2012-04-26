From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 18:53:07 +0200
Message-ID: <CAKPyHN2VkBo6OKgbhTNSu-LFwabGkFFKAF595rJuXbhWwdte+g@mail.gmail.com>
References: <87ty0jbt5p.fsf@rho.meyering.net>
	<20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
	<xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
	<CAKPyHN1mFGiZd7dDH-stUmr3H1JHwxcP1DkjCYNXZd6Bt-P7+w@mail.gmail.com>
	<87y5piwjay.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:53:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNRwQ-0005wu-Np
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 18:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401Ab2DZQxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 12:53:09 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43734 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab2DZQxI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 12:53:08 -0400
Received: by vbbff1 with SMTP id ff1so1086992vbb.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9TUpv8947+IC2CXL7mNLnveYz7BJXfPn2NYzVbVa9cw=;
        b=0DL6btLPy/Uai13RkgVSSZHDnoUGQYqscDme4p9e/NfE2mJVdcnkuQKzRtEehhN+ii
         5GXBT2VDBfMiT8xP0CwosFlWy/SwnTehxfzM9EU+xINy14tsBDU0jAv3IRFZ2x5Cbc4P
         Q3P8nO/eJwRyo6AaN1m1/9clGjMBvrFKuIuwGqCB+bHS/1w7GUFu4ZPcgEX5todH7kpQ
         d+Ki9KrZNaJHKP0cmZD1DJmoFNZq31UJlQ7yGuwMmu3n0d7e+tvauv+aXZ5PgCmYRhid
         TXB0pNsabLtQQsFcu1ziViiM0cmNFDeLIF5SxaNoba9E51YGwaCPU52V7OiSlzGY6S0N
         /iPg==
Received: by 10.52.69.69 with SMTP id c5mr6608969vdu.43.1335459187411; Thu, 26
 Apr 2012 09:53:07 -0700 (PDT)
Received: by 10.52.185.33 with HTTP; Thu, 26 Apr 2012 09:53:07 -0700 (PDT)
In-Reply-To: <87y5piwjay.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196383>

On Thu, Apr 26, 2012 at 18:26, Jim Meyering <jim@meyering.net> wrote:
> Bert Wesarg wrote:
>> On Thu, Apr 26, 2012 at 18:13, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> Jim Meyering <jim@meyering.net> writes:
>> strbuf_ensure_terminator(struct strbuf* buf, int term, int always)?
>
> Nice! =C2=A0So far, that's the name I prefer.
> But why the third parameter?

See the second part of my reply:

>>> ------------------------------------
>>> builtin/branch.c-     if (!buf.len || buf.buf[buf.len-1] !=3D '\n')
>>> builtin/branch.c:             strbuf_addch(&buf, '\n');
>>> --
>>> strbuf.h-     if (sb->len && sb->buf[sb->len - 1] !=3D '\n')
>>> strbuf.h:             strbuf_addch(sb, '\n');
>
> Please note, that while they are checking the .len, they both behave
> differently if .len =3D=3D 0 or not.
> The first always append a '\n', the latter only, if the string isn't =
empty.
