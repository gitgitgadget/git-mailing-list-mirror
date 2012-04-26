From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 18:21:33 +0200
Message-ID: <CAKPyHN1mFGiZd7dDH-stUmr3H1JHwxcP1DkjCYNXZd6Bt-P7+w@mail.gmail.com>
References: <87ty0jbt5p.fsf@rho.meyering.net>
	<20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
	<xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, Marcus Karlsson <mk@acc.umu.se>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNRRs-0001qC-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 18:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113Ab2DZQVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 12:21:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47662 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab2DZQVf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 12:21:35 -0400
Received: by vcqp1 with SMTP id p1so1055278vcq.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HgNaNzUz/z2KvktDpr7XfG8AWA93Em6QikhcKomBDw4=;
        b=qJHZrBGksczwqIdLzetw/pLCIMoYw/C4CyywXQwB/gkWhL/A/cX+QOSmtO83ejZM4Z
         4Hj8OhO5o46HOMUROUiGcRkBgLqo9My315pldW85ZJNN2buOuGPCB1toZyeHy3MgC69Y
         L0A+gG76iUruMR557YEZUCKvzcUyZfY+ptmAPVs4JjHShXMapRg1IG2m7wmgzbjFiTdK
         fD4Gz40P6CLElb9ysAUWDSDx0p+737Zu82M7R1AavZH1SAiqn/3YWHIOYYrg3ppzUsyv
         L5csHqp8pF1CKjps37dPPGSSQxd9ddcidyg7+zUxCnRCad7e98wFaCg5cUn85JF02+Z7
         jfKA==
Received: by 10.52.75.105 with SMTP id b9mr6716520vdw.26.1335457293270; Thu,
 26 Apr 2012 09:21:33 -0700 (PDT)
Received: by 10.52.185.33 with HTTP; Thu, 26 Apr 2012 09:21:33 -0700 (PDT)
In-Reply-To: <xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196378>

On Thu, Apr 26, 2012 at 18:13, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jim Meyering <jim@meyering.net> writes:
>
>> What do you think about replacing those two append-if-needed two-lin=
ers:
>>
>> =C2=A0 =C2=A0 if (buffer2.len && buffer2.buf[buffer2.len - 1] !=3D '=
/')
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addch(&buffer2, '/'=
);
>>
>> by something that readably encapsulates the idiom:
>>
>> =C2=A0 =C2=A0 strbuf_append_if_absent (&buffer2, '/');
>>
>> (though the name isn't particularly apt, because you might
>> take "absent" to mean "not anywhere in the string," so maybe
>> =C2=A0 strbuf_append_if_not_already_at_end (ugly) or
>> =C2=A0 strbuf_append_uniq
>> )
>
> I am not good at names, but strbuf_terminate_with(&buffer2, '/')
> perhaps?

strbuf_ensure_terminator(struct strbuf* buf, int term, int always)?

>
>> There are several other uses that would benefit from such a transfor=
mation:
>> To find the easy ones, I ran this:
>>
>> =C2=A0 git grep -B1 "strbuf_addch.*'"|grep -A1 '!=3D'
>>
>> I've manually marked/separated the ones that don't apply.
>>
>> ------------------------------------
>> builtin/branch.c-     if (!buf.len || buf.buf[buf.len-1] !=3D '\n')
>> builtin/branch.c:             strbuf_addch(&buf, '\n');
>> --
>> strbuf.h-     if (sb->len && sb->buf[sb->len - 1] !=3D '\n')
>> strbuf.h:             strbuf_addch(sb, '\n');

Please note, that while they are checking the .len, they both behave
differently if .len =3D=3D 0 or not.
The first always append a '\n', the latter only, if the string isn't em=
pty.

Bert
