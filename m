From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Tue, 04 Mar 2014 10:18:26 +0100
Message-ID: <87txbeiaot.fsf@fencepost.gnu.org>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
	<xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
	<xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
	<CACsJy8ASBeravdk67pbOJbrFUbwg21JwYcLtSbDDMJOu9-F=yA@mail.gmail.com>
	<877g8akenw.fsf@fencepost.gnu.org>
	<20140304015819.GA10643@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Siddharth Goel <siddharth98391@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKlUl-0006Ao-Os
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 10:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbaCDJSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 04:18:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:43516 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbaCDJS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 04:18:28 -0500
Received: from localhost ([127.0.0.1]:42556 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKlUY-0001PS-Nc; Tue, 04 Mar 2014 04:18:27 -0500
Received: by lola (Postfix, from userid 1000)
	id 59894DF3DC; Tue,  4 Mar 2014 10:18:26 +0100 (CET)
In-Reply-To: <20140304015819.GA10643@duynguyen-vnpc.dek-tpc.internal> (Duy
	Nguyen's message of "Tue, 4 Mar 2014 08:58:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243332>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 04, 2014 at 01:09:39AM +0100, David Kastrup wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>=20
>> > On Tue, Mar 4, 2014 at 5:43 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>> >> diff --git a/git-compat-util.h b/git-compat-util.h
>> >> index cbd86c3..68ffaef 100644
>> >> --- a/git-compat-util.h
>> >> +++ b/git-compat-util.h
>> >> @@ -357,8 +357,14 @@ extern int suffixcmp(const char *str, const =
char *suffix);
>> >>
>> >>  static inline const char *skip_prefix(const char *str, const cha=
r *prefix)
>> >>  {
>> >> -       size_t len =3D strlen(prefix);
>> >> -       return strncmp(str, prefix, len) ? NULL : str + len;
>> >
>> > Just a note. gcc does optimize strlen("abcdef") to 6, and with tha=
t
>> > information at compile time built-in strncmp might do better.
>>=20
>> Indeed, most (but not all) of the calls have a constant string as
>> prefix.  However, strncmp in each iteration checks for both *str as =
well
>> as *prefix to be different from '\0' independently (and it appears
>> unlikely to me that the optimizer will figure out that it's unnecess=
ary
>> for either) _and_ compares them for equality so it's not likely to b=
e
>> faster than the open-coded loop.
>>=20
>> One could, however, use memcmp instead of strncmp.  I'm just not sur=
e
>> whether memcmp is guaranteed not to peek beyond the first mismatchin=
g
>> byte even if the count would allow for more.  It could lead to undef=
ined
>> behavior if the first mismatching byte would be the ending NUL byte =
of
>> str.
>
> It turns out gcc does not generate a call to strncmp either. It
> inlines repz cmpsb instead.

Oh wow.  So it _does_ know that it's not necessary to check for a NUL
byte when the length of one argument is already known.  I am seriously
impressed.

> I recall we had a discussion long ago about the inefficiency of repz
> and and open-coded loop is preferred,

I think that this mostly applies for Pentium I, possibly also the
dead-ended Pentium=A0Pro architecture (that sort-of translated the x86
opcodes into RISC instructions).  I think that later processor variants
(and AMD anyway) got those instructions back to usable shape.

One thing where there was a _lot_ of performance difference between
open-coding and builtin was using memcpy (repz movb) for copying
well-aligned data bytewise rather than copying, say, integer arrays
element-wise.

But since that was egg-on-face material, the hardware got better at it.

And anyway, GCC should know what to pick here.  So with GCC being as
smart as that (using the equivalent of memcmp on its own initiative
instead of the full strncmp), I don't think we have a reasonable chance
to beat its performance with an open-coded variant.

> produces this assembly with gcc -O2 (on x86, apparently)
>
> -- 8< --
> 00000000 <main>:
>    0:   55                      push   %ebp
>    1:   b9 03 00 00 00          mov    $0x3,%ecx
>    6:   89 e5                   mov    %esp,%ebp
>    8:   57                      push   %edi
>    9:   bf 00 00 00 00          mov    $0x0,%edi
>    e:   56                      push   %esi
>    f:   53                      push   %ebx
>   10:   83 e4 f0                and    $0xfffffff0,%esp
>   13:   83 ec 10                sub    $0x10,%esp
>   16:   8b 45 0c                mov    0xc(%ebp),%eax
>   19:   8b 40 04                mov    0x4(%eax),%eax
>   1c:   89 c6                   mov    %eax,%esi
>   1e:   f3 a6                   repz cmpsb %es:(%edi),%ds:(%esi)
>   20:   0f 97 c3                seta   %bl
>   23:   0f 92 c1                setb   %cl
>   26:   83 c0 03                add    $0x3,%eax
>   29:   31 d2                   xor    %edx,%edx
>   2b:   38 cb                   cmp    %cl,%bl
>   2d:   0f 44 d0                cmove  %eax,%edx

More like i686 than x86 here.

>   30:   89 14 24                mov    %edx,(%esp)
>   33:   e8 fc ff ff ff          call   34 <main+0x34>
>   38:   8d 65 f4                lea    -0xc(%ebp),%esp
>   3b:   31 c0                   xor    %eax,%eax
>   3d:   5b                      pop    %ebx
>   3e:   5e                      pop    %esi
>   3f:   5f                      pop    %edi
>   40:   5d                      pop    %ebp
>   41:   c3                      ret

Well, we won't beat this here.

--=20
David Kastrup
