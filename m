From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] pretty: add '*' modifier to add LF after non-empty
Date: Sat, 14 Apr 2012 23:01:26 +0300
Message-ID: <CAMP44s0E21sBMPMNGd7GZQbPHeEan+AK2MdGm+8FkWgWHi7sSA@mail.gmail.com>
References: <1330002637-9347-1-git-send-email-pionchon.luc@gmail.com>
	<7v7gzd498r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luc Pionchon <pionchon.luc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 22:01:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ9A5-0000F0-Ez
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 22:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab2DNUB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 16:01:28 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40977 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab2DNUB2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 16:01:28 -0400
Received: by eekc41 with SMTP id c41so1015179eek.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iq8AVxEW0to8KikOJqDr80B2cNp2KWTdaC45q3i0qJ0=;
        b=xi09mNByhxkxBzVYlDQ3RZX5zjLNQlrgIL4T6ePb/EiIV0Ii63piHtREsL+lxM6riF
         2gWSJ3HwzkWxeKRK3DkPpMY44wXl6+hYIZ2UCMK+12L9JeeKmSR0wOaQdxjTBZZj0VWH
         MzguWRt4dlBELl3FlV1V8YsRBdgakBEQeWI+Z36pktG+eqZuVyVtVDYC6chua8r7eyEY
         xUAWzzetchnh+bvuepneEeIOIkw1RKv+gFVsDcqeonMxw1B9YPRI7FM7T5wR5omDii13
         5nkEC1KW75n5KU03X4jal6YT8D7jXVjeiSYpMxmo6BwSvyrcLGda8bBqmgtxZtctSxm6
         MVdQ==
Received: by 10.213.104.132 with SMTP id p4mr418365ebo.101.1334433686915; Sat,
 14 Apr 2012 13:01:26 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 14 Apr 2012 13:01:26 -0700 (PDT)
In-Reply-To: <7v7gzd498r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195513>

On Thu, Feb 23, 2012 at 9:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Luc Pionchon <pionchon.luc@gmail.com> writes:
>
>> Add the '*' modifier, similar to the '+' modifier,
>> to add a line-feed after a non-empty placeholder.
>
> Hrm, I thought I designed the plus and minus fairly carefully so that
> nobody needs to add this later.
>
> Wouldn't it be sufficient to write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Foo%n%-d
>
> that says "We usually have LF after Foo, and write %d after that, but=
 we
> might not have anything interesting in %d at all, in which case we do=
n't
> add that %n"?
>
>> +test_expect_success 'add LF after non-empty (1) (empty)' '
>> + =C2=A0 =C2=A0 git show -s --pretty=3Dformat:"%*d%s%nfoo%n" HEAD^^ =
>actual &&
>
> Shouldn't this be equivalent to "%n%-d%s%nfoo%n", which in turn is co=
vered
> by one of the previous tests (del LF before empty)?

Nope.

Try this:

--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -208,6 +208,25 @@ test_expect_success 'add LF before non-empty (2)' =
'
        grep "^$" actual
 '

+test_expect_success 'add LF after non-empty (1) (empty)' '
+       git show -s --pretty=3Dformat:"%n%-d%s%nfoo%n" HEAD^^ >actual &=
&
+       cat >expect <<-EOF &&
+       added foo
+       foo
+       EOF
+       test_cmp expect actual
+'
+
+test_expect_success 'add LF after non-empty (2) (non empty)' '
+       git show -s --pretty=3Dformat:"%n%-d%s%nfoo%n" HEAD >actual &&
+       cat >expect <<-EOF &&
+        (HEAD, master)
+       Test printing of complex bodies
+       foo
+       EOF
+       test_cmp expect actual
+'
+
 test_expect_success 'add SP before non-empty (1)' '
        git show -s --pretty=3Dformat:"%s% bThanks" HEAD^^ >actual &&
        test $(wc -w <actual) =3D 2

Luc's patch makes these tests work.

I don't know if there's any way to have a format string that works
with the current code, but your suggestion doesn't seem to do the
trick.

Cheers.

--=20
=46elipe Contreras
