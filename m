From: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>
Subject: Re: [RFH] gcc constant expression warning...
Date: Sun, 28 Oct 2007 10:37:27 +0000 (UTC)
Message-ID: <slrnfi8pj7.mb4.antti-juhani@kukkaseppele.kaijanaho.fi>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 12:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im6Bq-0003db-KV
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 12:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXJ1LUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2007 07:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbXJ1LUJ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 07:20:09 -0400
Received: from main.gmane.org ([80.91.229.2]:54710 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbXJ1LUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 07:20:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Im6BW-0005Zo-Ov
	for git@vger.kernel.org; Sun, 28 Oct 2007 11:20:02 +0000
Received: from e82-103-193-248.elisa-laajakaista.fi ([82.103.193.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 11:20:02 +0000
Received: from antti-juhani by e82-103-193-248.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 11:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: e82-103-193-248.elisa-laajakaista.fi
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62557>

Junio C Hamano <gitster@pobox.com> kirjoitti 28.10.2007:
> With the recent gcc, we get:
>
> sha1_file.c: In check_packed_git_:
> sha1_file.c:527: warning: assuming signed overflow does not
> occur when assuming that (X + c) < X is always false
> sha1_file.c:527: warning: assuming signed overflow does not
> occur when assuming that (X + c) < X is always false
>
> when compiling with
>
>     -O2 -Werror -Wall -Wold-style-definition \
>     -ansi -pedantic -std=3Dc99 -Wdeclaration-after-statement

-ansi and -std=3Dc99 in the same command line is a bit weird, BTW :)

> The offending lines are:
>
>         if (idx_size !=3D min_size) {
>                 /* make sure we can deal with large pack offsets */
>                 off_t x =3D 0x7fffffffUL, y =3D 0xffffffffUL;
>                 if (x > (x + 1) || y > (y + 1)) {
>                         munmap(idx_map, idx_size);

The second if line invokes undefined behavior if off_t cannot represent
0x7fffffffUL + 1.  GCC apparently takes that as a license to ignore
overflow and rewrite that if as "if (0) { ...".

A fast fix is to compile with -fwrapv or with -fno-strict-overflow:

-fstrict-overflow
    Allow the compiler to assume strict signed overflow rules, dependin=
g
    on the language being compiled. For C (and C++) this means that
    overflow when doing arithmetic with signed numbers is undefined,
    which means that the compiler may assume that it will not happen.
    This permits various optimizations. For example, the compiler will
    assume that an expression like i + 10 > i will always be true for
    signed i. This assumption is only valid if signed overflow is
    undefined, as the expression is false if i + 10 overflows when usin=
g
    twos complement arithmetic. When this option is in effect any
    attempt to determine whether an operation on signed numbers will
    overflow must be written carefully to not actually involve overflow=
=2E

    See also the -fwrapv option. Using -fwrapv means that signed
    overflow is fully defined: it wraps. When -fwrapv is used, there is
    no difference between -fstrict-overflow and -fno-strict-overflow.
    With -fwrapv certain types of overflow are permitted. For example,
    if the compiler gets an overflow when doing arithmetic on constants=
,
    the overflowed value can still be used with -fwrapv, but not
    otherwise.

    The -fstrict-overflow option is enabled at levels -O2, -O3, -Os.=20

-fwrapv
    This option instructs the compiler to assume that signed arithmetic
    overflow of addition, subtraction and multiplication wraps around
    using twos-complement representation. This flag enables some
    optimizations and disables others. This option is enabled by defaul=
t
    for the Java front-end, as required by the Java language
    specification.=20

(From the GCC 4.2.2 manual.)

A correct fix would be to check for the size of off_t in some other (an=
d
defined) manner, but I don't know off_t well enough to suggest one.
Considering that the size of off_t won't change at runtime, the test
ought to be compile (or configure) time.  Reading POSIX, there seem to
be some rather cumbersome sysconf stuff one could test for, and of
course CHAR_BIT * sizeof(off_t) also tells one something.  GNU autoconf
might also have a solution at hand.

--=20
Antti-Juhani Kaijanaho, Jyv=E4skyl=E4, Finland
