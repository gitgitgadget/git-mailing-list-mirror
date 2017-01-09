Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E899120756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935526AbdAIKwr (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:52:47 -0500
Received: from mail.foxkit.us ([45.32.83.9]:35120 "EHLO mail.wilcox-tech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965209AbdAIKvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:51:37 -0500
Received: (qmail 8091 invoked from network); 9 Jan 2017 10:51:33 -0000
Received: from ip68-13-242-69.ok.ok.cox.net (HELO ?10.1.1.57?) (awilcox@wilcox-tech.com@68.13.242.69)
  by mail.foxkit.us with ESMTPA; 9 Jan 2017 10:51:33 -0000
Subject: Re: Test failures when Git is built with libpcre and grep is built
 without it
To:     Jeff King <peff@peff.net>
References: <58688C9F.4000605@adelielinux.org>
 <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   "A. Wilcox" <awilfox@adelielinux.org>
X-Enigmail-Draft-Status: N1110
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <58736B2A.40003@adelielinux.org>
Date:   Mon, 9 Jan 2017 04:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lsAlx2Mp95IboticKEXhEWPhFuBbF94Ad"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lsAlx2Mp95IboticKEXhEWPhFuBbF94Ad
Content-Type: multipart/mixed;
 boundary="------------030003090509050607090305"

This is a multi-part message in MIME format.
--------------030003090509050607090305
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/17 00:53, Jeff King wrote:
> On Sat, Dec 31, 2016 at 10:59:11PM -0600, A. Wilcox wrote:
>=20
>> I'm attempting to package Git for our new Linux distribution and
>> I have run in to a failure on our PowerPC builder while running
>> the test suite.
>>=20
>> The PowerPC builder runs a tiny version of grep(1) that was not
>> built with PCRE.  As such, grep -P returns 2 and prints:
>>=20
>> grep: support for the -P option is not compiled into this -
>> --disable-perl-regexp binary
>>=20
>> However, our Git build *does* link against libpcre.  This causes
>> a tests numbered 142 and 143 to fail in t7810-grep.sh.
>=20
> If we are using "grep -P" in our test suite, it should definitely
> be marked with a prerequisite that is independent of the LIBPCRE
> one.
>=20
> But I can't find any such place in our test suite. [snip] Can you
> show us the output of "./t7810-grep.sh -v -i"?
>=20
> -Peff
>=20

The output of this command was almost 1400 lines, so I attached the log.

Interestingly enough, you seem to be right.  The failure is very
bizarre and has nothing to do with system /bin/grep:

test_must_fail: command succeeded: git grep -G -F -P -E a\x{2b}b\x{2a}c a=
b
not ok 142 - grep -G -F -P -E pattern
#
#               >empty &&
#               test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c"
ab >actual &&
#               test_cmp empty actual
#

However:

elaine trash directory.t7810-grep # git grep -G -F -P -E
a\x{2b}b\x{2a}c ab >actual
fatal: command line, 'ax{2b}bx{2a}c': Invalid contents of {}
elaine trash directory.t7810-grep # echo $?
128
elaine trash directory.t7810-grep # cat actual
elaine trash directory.t7810-grep #


I can reliably reproduce this on our x86_64 builder as well.  Note
that our distro is based on the musl libc, not glibc.  The shell is:

GNU bash, version 4.3.48(1)-release (powerpc-foxkit-linux-musl)

lrwxrwxrwx 1 root root 4 Dec 29 10:43 /bin/sh -> /bin/bash

Any further assistance would be greatly appreciated; this one really
has me stumped.

Best,
-arw


--=20
A. Wilcox (awilfox)
Project Lead, Ad=C3=A9lie Linux
http://adelielinux.org

--------------030003090509050607090305
Content-Type: text/x-log;
 name="test-failure.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test-failure.log"

elaine t # ./t7810-grep.sh -v -i
Initialized empty Git repository in /usr/src/dev-vcs/git-2.7.3-r1/work/gi=
t-2.7.3/t/trash directory.t7810-grep/.git/
expecting success:=20
        {
                echo foo mmap bar
                echo foo_mmap bar
                echo foo_mmap bar mmap
                echo foo mmap bar_mmap
                echo foo_mmap bar mmap baz
        } >file &&
        {
                echo Hello world
                echo HeLLo world
                echo Hello_world
                echo HeLLo_world
        } >hello_world &&
        {
                echo "a+b*c"
                echo "a+bc"
                echo "abc"
        } >ab &&
        echo vvv >v &&
        echo ww w >w &&
        echo x x xx x >x &&
        echo y yy >y &&
        echo zzz > z &&
        mkdir t &&
        echo test >t/t &&
        echo vvv >t/v &&
        mkdir t/a &&
        echo vvv >t/a/v &&
        {
                echo "line without leading space1"
                echo " line with leading space1"
                echo " line with leading space2"
                echo " line with leading space3"
                echo "line without leading space2"
        } >space &&
        git add . &&
        test_tick &&
        git commit -m initial

[master (root-commit) cfd9fd5] initial
 Author: A U Thor <author@example.com>
 13 files changed, 32 insertions(+)
 create mode 100644 ab
 create mode 100644 file
 create mode 100644 hello.c
 create mode 100644 hello_world
 create mode 100644 space
 create mode 100644 t/a/v
 create mode 100644 t/t
 create mode 100644 t/v
 create mode 100644 v
 create mode 100644 w
 create mode 100644 x
 create mode 100644 y
 create mode 100644 z
ok 1 - setup

expecting success:=20
        test_must_fail git grep "("

fatal: unmatched parenthesis
ok 2 - grep should not segfault with a bad input

expecting success:=20
                {
                        echo ${HC}file:1:foo mmap bar
                        echo ${HC}file:3:foo_mmap bar mmap
                        echo ${HC}file:4:foo mmap bar_mmap
                        echo ${HC}file:5:foo_mmap bar mmap baz
                } >expected &&
                git -c grep.linenumber=3Dfalse grep -n -w -e mmap $H >act=
ual &&
                test_cmp expected actual

ok 3 - grep -w HEAD

expecting success:=20
                {
                        echo ${HC}file:1:foo mmap bar
                        echo ${HC}file:3:foo_mmap bar mmap
                        echo ${HC}file:4:foo mmap bar_mmap
                        echo ${HC}file:5:foo_mmap bar mmap baz
                } >expected &&
                git -c grep.linenumber=3Dtrue grep -w -e mmap $H >actual =
&&
                test_cmp expected actual

ok 4 - grep -w HEAD

expecting success:=20
                {
                        echo ${HC}file:foo mmap bar
                        echo ${HC}file:foo_mmap bar mmap
                        echo ${HC}file:foo mmap bar_mmap
                        echo ${HC}file:foo_mmap bar mmap baz
                } >expected &&
                git -c grep.linenumber=3Dtrue grep --no-line-number -w -e=
 mmap $H >actual &&
                test_cmp expected actual

ok 5 - grep -w HEAD

expecting success:=20
                : >expected &&
                test_must_fail git grep -n -w -e "^w" $H >actual &&
                test_cmp expected actual

ok 6 - grep -w HEAD (w)

expecting success:=20
                {
                        echo ${HC}x:1:x x xx x
                } >expected &&
                git grep -n -w -e "x xx* x" $H >actual &&
                test_cmp expected actual

ok 7 - grep -w HEAD (x)

expecting success:=20
                {
                        echo ${HC}y:1:y yy
                } >expected &&
                git grep -n -w -e "^y" $H >actual &&
                test_cmp expected actual

ok 8 - grep -w HEAD (y-1)

expecting success:=20
                : >expected &&
                if git grep -n -w -e "^y y" $H >actual
                then
                        echo should not have matched
                        cat actual
                        false
                else
                        test_cmp expected actual
                fi

ok 9 - grep -w HEAD (y-2)

expecting success:=20
                : >expected &&
                if git grep -n -w -e "^z" $H >actual
                then
                        echo should not have matched
                        cat actual
                        false
                else
                        test_cmp expected actual
                fi

ok 10 - grep -w HEAD (z)

expecting success:=20
                echo "${HC}t/t:1:test" >expected &&
                git grep -n -e test $H >actual &&
                test_cmp expected actual

ok 11 - grep HEAD (t-1)

expecting success:=20
                echo "${HC}t:1:test" >expected &&
                (
                        cd t &&
                        git grep -n -e test $H
                ) >actual &&
                test_cmp expected actual

ok 12 - grep HEAD (t-2)

expecting success:=20
                echo "${HC}t/t:1:test" >expected &&
                (
                        cd t &&
                        git grep --full-name -n -e test $H
                ) >actual &&
                test_cmp expected actual

ok 13 - grep HEAD (t-3)

expecting success:=20
                ! git grep -c test $H | grep /dev/null
       =20
ok 14 - grep -c HEAD (no /dev/null)

expecting success:=20
                {
                        echo ${HC}t/a/v:1:vvv
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth -1 -n -e vvv $H >actual &&
                test_cmp expected actual

ok 15 - grep --max-depth -1 HEAD

expecting success:=20
                {
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H >actual &&
                test_cmp expected actual

ok 16 - grep --max-depth 0 HEAD

expecting success:=20
                {
                        echo ${HC}t/a/v:1:vvv
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- "*" >actual &&
                test_cmp expected actual

ok 17 - grep --max-depth 0 -- '*' HEAD

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 1 -n -e vvv $H >actual &&
                test_cmp expected actual

ok 18 - grep --max-depth 1 HEAD

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- t >actual &&
                test_cmp expected actual

ok 19 - grep --max-depth 0 -- t HEAD

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- . t >actual &&
                test_cmp expected actual

ok 20 - grep --max-depth 0 -- . t HEAD

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
                test_cmp expected actual

ok 21 - grep --max-depth 0 -- t . HEAD

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git -c grep.extendedRegexp=3Dfalse grep "a+b*c" $H ab >ac=
tual &&
                test_cmp expected actual

ok 22 - grep HEAD with grep.extendedRegexp=3Dfalse

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git -c grep.extendedRegexp=3Dtrue grep "a+b*c" $H ab >act=
ual &&
                test_cmp expected actual

ok 23 - grep HEAD with grep.extendedRegexp=3Dtrue

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git -c grep.patterntype=3Dbasic grep "a+b*c" $H ab >actua=
l &&
                test_cmp expected actual

ok 24 - grep HEAD with grep.patterntype=3Dbasic

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git -c grep.patterntype=3Dextended grep "a+b*c" $H ab >ac=
tual &&
                test_cmp expected actual

ok 25 - grep HEAD with grep.patterntype=3Dextended

expecting success:=20
                echo "${HC}ab:a+b*c" >expected &&
                git -c grep.patterntype=3Dfixed grep "a+b*c" $H ab >actua=
l &&
                test_cmp expected actual

ok 26 - grep HEAD with grep.patterntype=3Dfixed

expecting success:=20
                echo "${HC}ab:a+b*c" >expected &&
                git -c grep.patterntype=3Dperl grep "a\x{2b}b\x{2a}c" $H =
ab >actual &&
                test_cmp expected actual

ok 27 - grep HEAD with grep.patterntype=3Dperl

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.patternType=3Ddefault \
                        -c grep.extendedRegexp=3Dtrue \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 28 - grep HEAD with grep.patternType=3Ddefault and grep.extendedRegexp=
=3Dtrue

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.extendedRegexp=3Dtrue \
                        -c grep.patternType=3Ddefault \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 29 - grep HEAD with grep.extendedRegexp=3Dtrue and grep.patternType=3D=
default

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.patternType=3Dextended \
                        -c grep.extendedRegexp=3Dfalse \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 30 - grep HEAD with grep.patternType=3Dextended and grep.extendedRegex=
p=3Dfalse

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git \
                        -c grep.patternType=3Dbasic \
                        -c grep.extendedRegexp=3Dtrue \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 31 - grep HEAD with grep.patternType=3Dbasic and grep.extendedRegexp=3D=
true

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.extendedRegexp=3Dfalse \
                        -c grep.patternType=3Dextended \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 32 - grep HEAD with grep.extendedRegexp=3Dfalse and grep.patternType=3D=
extended

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git \
                        -c grep.extendedRegexp=3Dtrue \
                        -c grep.patternType=3Dbasic \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 33 - grep HEAD with grep.extendedRegexp=3Dtrue and grep.patternType=3D=
basic

expecting success:=20
                echo ${HC}ab:3 >expected &&
                git grep --count -e b $H -- ab >actual &&
                test_cmp expected actual

ok 34 - grep --count HEAD

expecting success:=20
                echo 3 >expected &&
                git grep --count -h -e b $H -- ab >actual &&
                test_cmp expected actual

ok 35 - grep --count -h HEAD

expecting success:=20
                {
                        echo ${HC}file:1:foo mmap bar
                        echo ${HC}file:3:foo_mmap bar mmap
                        echo ${HC}file:4:foo mmap bar_mmap
                        echo ${HC}file:5:foo_mmap bar mmap baz
                } >expected &&
                git -c grep.linenumber=3Dfalse grep -n -w -e mmap $H >act=
ual &&
                test_cmp expected actual

ok 36 - grep -w in working tree

expecting success:=20
                {
                        echo ${HC}file:1:foo mmap bar
                        echo ${HC}file:3:foo_mmap bar mmap
                        echo ${HC}file:4:foo mmap bar_mmap
                        echo ${HC}file:5:foo_mmap bar mmap baz
                } >expected &&
                git -c grep.linenumber=3Dtrue grep -w -e mmap $H >actual =
&&
                test_cmp expected actual

ok 37 - grep -w in working tree

expecting success:=20
                {
                        echo ${HC}file:foo mmap bar
                        echo ${HC}file:foo_mmap bar mmap
                        echo ${HC}file:foo mmap bar_mmap
                        echo ${HC}file:foo_mmap bar mmap baz
                } >expected &&
                git -c grep.linenumber=3Dtrue grep --no-line-number -w -e=
 mmap $H >actual &&
                test_cmp expected actual

ok 38 - grep -w in working tree

expecting success:=20
                : >expected &&
                test_must_fail git grep -n -w -e "^w" $H >actual &&
                test_cmp expected actual

ok 39 - grep -w in working tree (w)

expecting success:=20
                {
                        echo ${HC}x:1:x x xx x
                } >expected &&
                git grep -n -w -e "x xx* x" $H >actual &&
                test_cmp expected actual

ok 40 - grep -w in working tree (x)

expecting success:=20
                {
                        echo ${HC}y:1:y yy
                } >expected &&
                git grep -n -w -e "^y" $H >actual &&
                test_cmp expected actual

ok 41 - grep -w in working tree (y-1)

expecting success:=20
                : >expected &&
                if git grep -n -w -e "^y y" $H >actual
                then
                        echo should not have matched
                        cat actual
                        false
                else
                        test_cmp expected actual
                fi

ok 42 - grep -w in working tree (y-2)

expecting success:=20
                : >expected &&
                if git grep -n -w -e "^z" $H >actual
                then
                        echo should not have matched
                        cat actual
                        false
                else
                        test_cmp expected actual
                fi

ok 43 - grep -w in working tree (z)

expecting success:=20
                echo "${HC}t/t:1:test" >expected &&
                git grep -n -e test $H >actual &&
                test_cmp expected actual

ok 44 - grep in working tree (t-1)

expecting success:=20
                echo "${HC}t:1:test" >expected &&
                (
                        cd t &&
                        git grep -n -e test $H
                ) >actual &&
                test_cmp expected actual

ok 45 - grep in working tree (t-2)

expecting success:=20
                echo "${HC}t/t:1:test" >expected &&
                (
                        cd t &&
                        git grep --full-name -n -e test $H
                ) >actual &&
                test_cmp expected actual

ok 46 - grep in working tree (t-3)

expecting success:=20
                ! git grep -c test $H | grep /dev/null
       =20
ok 47 - grep -c in working tree (no /dev/null)

expecting success:=20
                {
                        echo ${HC}t/a/v:1:vvv
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth -1 -n -e vvv $H >actual &&
                test_cmp expected actual

ok 48 - grep --max-depth -1 in working tree

expecting success:=20
                {
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H >actual &&
                test_cmp expected actual

ok 49 - grep --max-depth 0 in working tree

expecting success:=20
                {
                        echo ${HC}t/a/v:1:vvv
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- "*" >actual &&
                test_cmp expected actual

ok 50 - grep --max-depth 0 -- '*' in working tree

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 1 -n -e vvv $H >actual &&
                test_cmp expected actual

ok 51 - grep --max-depth 1 in working tree

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- t >actual &&
                test_cmp expected actual

ok 52 - grep --max-depth 0 -- t in working tree

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- . t >actual &&
                test_cmp expected actual

ok 53 - grep --max-depth 0 -- . t in working tree

expecting success:=20
                {
                        echo ${HC}t/v:1:vvv
                        echo ${HC}v:1:vvv
                } >expected &&
                git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
                test_cmp expected actual

ok 54 - grep --max-depth 0 -- t . in working tree

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git -c grep.extendedRegexp=3Dfalse grep "a+b*c" $H ab >ac=
tual &&
                test_cmp expected actual

ok 55 - grep in working tree with grep.extendedRegexp=3Dfalse

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git -c grep.extendedRegexp=3Dtrue grep "a+b*c" $H ab >act=
ual &&
                test_cmp expected actual

ok 56 - grep in working tree with grep.extendedRegexp=3Dtrue

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git -c grep.patterntype=3Dbasic grep "a+b*c" $H ab >actua=
l &&
                test_cmp expected actual

ok 57 - grep in working tree with grep.patterntype=3Dbasic

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git -c grep.patterntype=3Dextended grep "a+b*c" $H ab >ac=
tual &&
                test_cmp expected actual

ok 58 - grep in working tree with grep.patterntype=3Dextended

expecting success:=20
                echo "${HC}ab:a+b*c" >expected &&
                git -c grep.patterntype=3Dfixed grep "a+b*c" $H ab >actua=
l &&
                test_cmp expected actual

ok 59 - grep in working tree with grep.patterntype=3Dfixed

expecting success:=20
                echo "${HC}ab:a+b*c" >expected &&
                git -c grep.patterntype=3Dperl grep "a\x{2b}b\x{2a}c" $H =
ab >actual &&
                test_cmp expected actual

ok 60 - grep in working tree with grep.patterntype=3Dperl

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.patternType=3Ddefault \
                        -c grep.extendedRegexp=3Dtrue \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 61 - grep in working tree with grep.patternType=3Ddefault and grep.ext=
endedRegexp=3Dtrue

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.extendedRegexp=3Dtrue \
                        -c grep.patternType=3Ddefault \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 62 - grep in working tree with grep.extendedRegexp=3Dtrue and grep.pat=
ternType=3Ddefault

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.patternType=3Dextended \
                        -c grep.extendedRegexp=3Dfalse \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 63 - grep in working tree with grep.patternType=3Dextended and grep.ex=
tendedRegexp=3Dfalse

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git \
                        -c grep.patternType=3Dbasic \
                        -c grep.extendedRegexp=3Dtrue \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 64 - grep in working tree with grep.patternType=3Dbasic and grep.exten=
dedRegexp=3Dtrue

expecting success:=20
                echo "${HC}ab:abc" >expected &&
                git \
                        -c grep.extendedRegexp=3Dfalse \
                        -c grep.patternType=3Dextended \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 65 - grep in working tree with grep.extendedRegexp=3Dfalse and grep.pa=
tternType=3Dextended

expecting success:=20
                echo "${HC}ab:a+bc" >expected &&
                git \
                        -c grep.extendedRegexp=3Dtrue \
                        -c grep.patternType=3Dbasic \
                        grep "a+b*c" $H ab >actual &&
                test_cmp expected actual

ok 66 - grep in working tree with grep.extendedRegexp=3Dtrue and grep.pat=
ternType=3Dbasic

expecting success:=20
                echo ${HC}ab:3 >expected &&
                git grep --count -e b $H -- ab >actual &&
                test_cmp expected actual

ok 67 - grep --count in working tree

expecting success:=20
                echo 3 >expected &&
                git grep --count -h -e b $H -- ab >actual &&
                test_cmp expected actual

ok 68 - grep --count -h in working tree

expecting success:=20
        git grep -l -C1 foo >actual &&
        test_cmp expected actual

ok 69 - grep -l -C

expecting success:=20
        git grep -c -C1 foo >actual &&
        test_cmp expected actual

ok 70 - grep -l -C

expecting success:=20
        git ls-files >expected &&
        git grep -L -C1 nonexistent_string >actual &&
        test_cmp expected actual

ok 71 - grep -L -C

expecting success:=20
        git grep -e "foo mmap" --and -e bar_mmap >actual &&
        test_cmp expected actual

ok 72 - grep -e A --and -e B

expecting success:=20
        git grep \( -e foo_ --or -e baz \) \
                --and -e " mmap" >actual &&
        test_cmp expected actual

ok 73 - grep ( -e A --or -e B ) --and -e B

expecting success:=20
        git grep -e "foo mmap" --and --not -e bar_mmap >actual &&
        test_cmp expected actual

ok 74 - grep -e A --and --not -e B

expecting success:=20
        GREP_OPTIONS=3D-v git grep " mmap bar\$" >actual &&
        test_cmp expected actual

ok 75 - grep should ignore GREP_OPTIONS

expecting success:=20
        test_must_fail git grep -f patterns

fatal: cannot open 'patterns': No such file or directory
ok 76 - grep -f, non-existent file

expecting success:=20
        git grep -f pattern >actual &&
        test_cmp expected actual

ok 77 - grep -f, one pattern

expecting success:=20
        git grep -f patterns >actual &&
        test_cmp expected actual

ok 78 - grep -f, multiple patterns

expecting success:=20
        git grep "$(cat patterns)" >actual &&
        test_cmp expected actual

ok 79 - grep, multiple patterns

expecting success:=20
        git grep -f patterns >actual &&
        test_cmp expected actual

ok 80 - grep -f, ignore empty lines

expecting success:=20
        git grep -f - <patterns >actual &&
        test_cmp expected actual

ok 81 - grep -f, ignore empty lines, read patterns from stdin

expecting success:=20
        >empty &&
        git grep -q mmap >actual &&
        test_cmp empty actual &&
        test_must_fail git grep -q qfwfq >actual &&
        test_cmp empty actual

ok 82 - grep -q, silently report matches

expecting success:=20
        git grep -C1 "^[yz]" >actual &&
        test_cmp expected actual

ok 83 - grep -C1 hunk mark between files

expecting success:=20
        echo a >>file &&
        test_tick &&
        GIT_AUTHOR_NAME=3D"With * Asterisk" \
        GIT_AUTHOR_EMAIL=3D"xyzzy@frotz.com" \
        git commit -a -m "second" &&

        echo a >>file &&
        test_tick &&
        git commit -a -m "third" &&

        echo a >>file &&
        test_tick &&
        GIT_AUTHOR_NAME=3D"Night Fall" \
        GIT_AUTHOR_EMAIL=3D"nitfol@frobozz.com" \
        git commit -a -m "fourth"

[master b39ecf0] second
 Author: With * Asterisk <xyzzy@frotz.com>
 1 file changed, 1 insertion(+)
[master 8f9afb5] third
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
[master 2d5652e] fourth
 Author: Night Fall <nitfol@frobozz.com>
 1 file changed, 1 insertion(+)
ok 84 - log grep setup

expecting success:=20
        git log --author=3Dauthor --pretty=3Dtformat:%s >actual &&
        {
                echo third && echo initial
        } >expect &&
        test_cmp expect actual

ok 85 - log grep (1)

expecting success:=20
        git log --author=3D" * " -F --pretty=3Dtformat:%s >actual &&
        {
                echo second
        } >expect &&
        test_cmp expect actual

ok 86 - log grep (2)

expecting success:=20
        git log --author=3D"^A U" --pretty=3Dtformat:%s >actual &&
        {
                echo third && echo initial
        } >expect &&
        test_cmp expect actual

ok 87 - log grep (3)

expecting success:=20
        git log --author=3D"frotz\.com>$" --pretty=3Dtformat:%s >actual &=
&
        {
                echo second
        } >expect &&
        test_cmp expect actual

ok 88 - log grep (4)

expecting success:=20
        git log --author=3DThor -F --pretty=3Dtformat:%s >actual &&
        {
                echo third && echo initial
        } >expect &&
        test_cmp expect actual

ok 89 - log grep (5)

expecting success:=20
        git log --author=3D-0700  --pretty=3Dtformat:%s >actual &&
        >expect &&
        test_cmp expect actual

ok 90 - log grep (6)

expecting success:=20
        git log -g --grep-reflog=3D"commit: third" --pretty=3Dtformat:%s =
>actual &&
        echo third >expect &&
        test_cmp expect actual

ok 91 - log grep (7)

expecting success:=20
        git log -g --grep-reflog=3D"commit: third" --grep-reflog=3D"commi=
t: second" --pretty=3Dtformat:%s >actual &&
        {
                echo third && echo second
        } >expect &&
        test_cmp expect actual

ok 92 - log grep (8)

expecting success:=20
        git log -g --grep-reflog=3D"commit: third" --author=3D"Thor" --pr=
etty=3Dtformat:%s >actual &&
        echo third >expect &&
        test_cmp expect actual

ok 93 - log grep (9)

expecting success:=20
        git log -g --grep-reflog=3D"commit: third" --author=3D"non-exista=
nt" --pretty=3Dtformat:%s >actual &&
        : >expect &&
        test_cmp expect actual

ok 94 - log grep (9)

expecting success:=20
        test_must_fail git log --grep-reflog=3D"commit: third"

fatal: cannot use --grep-reflog without --walk-reflogs
ok 95 - log --grep-reflog can only be used under -g

expecting success:=20
        git log --grep=3Di --grep=3Dr --format=3D%s >actual &&
        {
                echo fourth && echo third && echo initial
        } >expect &&
        test_cmp expect actual

ok 96 - log with multiple --grep uses union

expecting success:=20
        git log --all-match --grep=3Di --grep=3Dr --format=3D%s >actual &=
&
        {
                echo third
        } >expect &&
        test_cmp expect actual

ok 97 - log --all-match with multiple --grep uses intersection

expecting success:=20
        git log --author=3D"Thor" --author=3D"Aster" --format=3D%s >actua=
l &&
        {
            echo third && echo second && echo initial
        } >expect &&
        test_cmp expect actual

ok 98 - log with multiple --author uses union

expecting success:=20
        git log --all-match --author=3D"Thor" --author=3D"Aster" --format=
=3D%s >actual &&
        {
            echo third && echo second && echo initial
        } >expect &&
        test_cmp expect actual

ok 99 - log --all-match with multiple --author still uses union

expecting success:=20
        # grep matches only third and fourth
        # author matches only initial and third
        git log --author=3D"A U Thor" --grep=3Dr --format=3D%s >actual &&=

        {
                echo third
        } >expect &&
        test_cmp expect actual

ok 100 - log --grep --author uses intersection

expecting success:=20
        # grep matches initial and second but not third
        # author matches only initial and third
        git log --author=3D"A U Thor" --grep=3Ds --grep=3Dl --format=3D%s=
 >actual &&
        {
                echo initial
        } >expect &&
        test_cmp expect actual

ok 101 - log --grep --grep --author takes union of greps and intersects w=
ith author

expecting success:=20
        # grep matches only initial and third
        # author matches all but second
        git log --all-match --author=3D"Thor" --author=3D"Night" --grep=3D=
i --format=3D%s >actual &&
        {
            echo third && echo initial
        } >expect &&
        test_cmp expect actual

ok 102 - log ---all-match -grep --author --author still takes union of au=
thors and intersects with grep

expecting success:=20
        # grep matches only initial and third
        # author matches all but second
        git log --author=3D"Thor" --author=3D"Night" --grep=3Di --format=3D=
%s >actual &&
        {
            echo third && echo initial
        } >expect &&
        test_cmp expect actual

ok 103 - log --grep --author --author takes union of authors and intersec=
ts with grep

expecting success:=20
        # grep matches only third
        # author matches only initial and third
        git log --all-match --author=3D"A U Thor" --grep=3Di --grep=3Dr -=
-format=3D%s >actual &&
        {
                echo third
        } >expect &&
        test_cmp expect actual

ok 104 - log --all-match --grep --grep --author takes intersection

expecting success:=20
        : >expect &&
        git log --author=3D"$GIT_AUTHOR_DATE" >actual &&
        test_cmp expect actual

ok 105 - log --author does not search in timestamp

expecting success:=20
        : >expect &&
        git log --committer=3D"$GIT_COMMITTER_DATE" >actual &&
        test_cmp expect actual

ok 106 - log --committer does not search in timestamp

expecting success:=20
        git update-index --assume-unchanged t/t &&
        rm t/t &&
        test "$(git grep test)" =3D "t/t:test" &&
        git update-index --no-assume-unchanged t/t &&
        git checkout t/t

ok 107 - grep with CE_VALID file

expecting success:=20
        git config diff.custom.funcname "^#" &&
        echo "hello.c diff=3Dcustom" >.gitattributes &&
        git grep -p return >actual &&
        test_cmp expected actual

ok 108 - grep -p with userdiff

expecting success:=20
        rm -f .gitattributes &&
        git grep -p return >actual &&
        test_cmp expected actual

ok 109 - grep -p

expecting success:=20
        git grep -p -B5 return >actual &&
        test_cmp expected actual

ok 110 - grep -p -B5

expecting success:=20
        git grep -W return >actual &&
        test_cmp expected actual

ok 111 - grep -W

expecting success:=20
        test_when_finished "rm -f .gitattributes" &&
        git config diff.custom.xfuncname "(printf.*|})$" &&
        echo "hello.c diff=3Dcustom" >.gitattributes &&
        git grep -W return >actual &&
        test_cmp expected actual

ok 112 - grep -W with userdiff

expecting success:=20
        mkdir -p s &&
        (
                cd s && git grep "x x x" ..
        )

=2E./x:x x xx x
ok 113 - grep from a subdirectory to search wider area (1)

expecting success:=20
        mkdir -p s &&
        (
                cd s || exit 1
                ( git grep xxyyzz .. >out ; echo $? >status )
                ! test -s out &&
                test 1 =3D $(cat status)
        )

ok 114 - grep from a subdirectory to search wider area (2)

expecting success:=20
        git grep -Fi "CHAR *" >actual &&
        test_cmp expected actual

ok 115 - grep -Fi

expecting success:=20
        rm -fr non &&
        mkdir -p non/git/sub &&
        echo hello >non/git/file1 &&
        echo world >non/git/sub/file2 &&
        {
                echo file1:hello &&
                echo sub/file2:world
        } >non/expect.full &&
        echo file2:world >non/expect.sub &&
        (
                GIT_CEILING_DIRECTORIES=3D"$(pwd)/non/git" &&
                export GIT_CEILING_DIRECTORIES &&
                cd non/git &&
                test_must_fail git grep o &&
                git grep --no-index o >../actual.full &&
                test_cmp ../expect.full ../actual.full
                cd sub &&
                test_must_fail git grep o &&
                git grep --no-index o >../../actual.sub &&
                test_cmp ../../expect.sub ../../actual.sub
        ) &&

        echo ".*o*" >non/git/.gitignore &&
        (
                GIT_CEILING_DIRECTORIES=3D"$(pwd)/non/git" &&
                export GIT_CEILING_DIRECTORIES &&
                cd non/git &&
                test_must_fail git grep o &&
                git grep --no-index --exclude-standard o >../actual.full =
&&
                test_cmp ../expect.full ../actual.full &&

                {
                        echo ".gitignore:.*o*"
                        cat ../expect.full
                } >../expect.with.ignored &&
                git grep --no-index --no-exclude o >../actual.full &&
                test_cmp ../expect.with.ignored ../actual.full
        )

fatal: Not a git repository (or any of the parent directories): .git
ok 116 - outside of git repository

expecting success:=20
        rm -fr is &&
        mkdir -p is/git/sub &&
        echo hello >is/git/file1 &&
        echo world >is/git/sub/file2 &&
        echo ".*o*" >is/git/.gitignore &&
        {
                echo file1:hello &&
                echo sub/file2:world
        } >is/expect.unignored &&
        {
                echo ".gitignore:.*o*" &&
                cat is/expect.unignored
        } >is/expect.full &&
        : >is/expect.empty &&
        echo file2:world >is/expect.sub &&
        (
                cd is/git &&
                git init &&
                test_must_fail git grep o >../actual.full &&
                test_cmp ../expect.empty ../actual.full &&

                git grep --untracked o >../actual.unignored &&
                test_cmp ../expect.unignored ../actual.unignored &&

                git grep --no-index o >../actual.full &&
                test_cmp ../expect.full ../actual.full &&

                git grep --no-index --exclude-standard o >../actual.unign=
ored &&
                test_cmp ../expect.unignored ../actual.unignored &&

                cd sub &&
                test_must_fail git grep o >../../actual.sub &&
                test_cmp ../../expect.empty ../../actual.sub &&

                git grep --no-index o >../../actual.sub &&
                test_cmp ../../expect.sub ../../actual.sub &&

                git grep --untracked o >../../actual.sub &&
                test_cmp ../../expect.sub ../../actual.sub
        )

Initialized empty Git repository in /usr/src/dev-vcs/git-2.7.3-r1/work/gi=
t-2.7.3/t/trash directory.t7810-grep/is/git/.git/
ok 117 - inside git repository but with --no-index

expecting success:=20
cat >double-dash <<EOF &&
--
->
other
EOF
git add double-dash

ok 118 - setup double-dash tests

expecting success:=20
        git grep -- "->" >actual &&
        test_cmp expected actual

ok 119 - grep -- pattern

expecting success:=20
        git grep -- "->" -- double-dash >actual &&
        test_cmp expected actual

ok 120 - grep -- pattern -- pathspec

expecting success:=20
        git grep -e "->" -- double-dash >actual &&
        test_cmp expected actual

ok 121 - grep -e pattern -- path

expecting success:=20
        git grep -e -- -- double-dash >actual &&
        test_cmp expected actual

ok 122 - grep -e -- -- path

expecting success:=20
        git grep --perl-regexp "\p{Ps}.*?\p{Pe}" hello.c >actual &&
        test_cmp expected actual

ok 123 - grep --perl-regexp pattern

expecting success:=20
        git grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
        test_cmp expected actual

ok 124 - grep -P pattern

expecting success:=20
        >empty &&
        test_must_fail git -c grep.extendedregexp=3Dtrue \
                grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
        test_cmp empty actual

fatal: command line, '\p{Ps}.*?\p{Pe}': Invalid contents of {}
ok 125 - grep pattern with grep.extendedRegexp=3Dtrue

expecting success:=20
        git -c grep.extendedregexp=3Dtrue \
                grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
        test_cmp expected actual

ok 126 - grep -P pattern with grep.extendedRegexp=3Dtrue

expecting success:=20
        {
                echo "ab:a+b*c"
                echo "ab:a+bc"
        } >expected &&
        git grep -P -v "abc" ab >actual &&
        test_cmp expected actual

ok 127 - grep -P -v pattern

expecting success:=20
        cat >expected <<-EOF &&
        hello.c:        printf("Hello world.\n");
        EOF
        git grep -P -i "PRINTF\([^\d]+\)" hello.c >actual &&
        test_cmp expected actual

ok 128 - grep -P -i pattern

expecting success:=20
        {
                echo "hello_world:Hello world"
                echo "hello_world:HeLLo world"
        } >expected &&
        git grep -P -w "He((?i)ll)o" hello_world >actual &&
        test_cmp expected actual

ok 129 - grep -P -w pattern

expecting success:=20
        test_must_fail git grep -G "a["

fatal: command line, 'a[': Missing ']'
ok 130 - grep -G invalidpattern properly dies=20

expecting success:=20
        test_must_fail git -c grep.patterntype=3Dbasic grep "a["

fatal: command line, 'a[': Missing ']'
ok 131 - grep invalidpattern properly dies with grep.patternType=3Dbasic

expecting success:=20
        test_must_fail git grep -E "a["

fatal: command line, 'a[': Missing ']'
ok 132 - grep -E invalidpattern properly dies=20

expecting success:=20
        test_must_fail git -c grep.patterntype=3Dextended grep "a["

fatal: command line, 'a[': Missing ']'
ok 133 - grep invalidpattern properly dies with grep.patternType=3Dextend=
ed

expecting success:=20
        test_must_fail git grep -P "a["

fatal: command line, 'a[': missing terminating ] for character class
ok 134 - grep -P invalidpattern properly dies=20

expecting success:=20
        test_must_fail git -c grep.patterntype=3Dperl grep "a["

fatal: command line, 'a[': missing terminating ] for character class
ok 135 - grep invalidpattern properly dies with grep.patternType=3Dperl

expecting success:=20
        echo "ab:a+b*c" >expected &&
        git grep -G -E -F "a+b*c" ab >actual &&
        test_cmp expected actual

ok 136 - grep -G -E -F pattern

expecting success:=20
        echo "ab:a+b*c" >expected &&
        git \
                -c grep.patterntype=3Dbasic \
                -c grep.patterntype=3Dextended \
                -c grep.patterntype=3Dfixed \
                grep "a+b*c" ab >actual &&
        test_cmp expected actual

ok 137 - grep pattern with grep.patternType=3Dbasic, =3Dextended, =3Dfixe=
d

expecting success:=20
        echo "ab:a+bc" >expected &&
        git grep -E -F -G "a+b*c" ab >actual &&
        test_cmp expected actual

ok 138 - grep -E -F -G pattern

expecting success:=20
        echo "ab:a+bc" >expected &&
        git \
                -c grep.patterntype=3Dextended \
                -c grep.patterntype=3Dfixed \
                -c grep.patterntype=3Dbasic \
                grep "a+b*c" ab >actual &&
        test_cmp expected actual

ok 139 - grep pattern with grep.patternType=3Dextended, =3Dfixed, =3Dbasi=
c

expecting success:=20
        echo "ab:abc" >expected &&
        git grep -F -G -E "a+b*c" ab >actual &&
        test_cmp expected actual

ok 140 - grep -F -G -E pattern

expecting success:=20
        echo "ab:abc" >expected &&
        git \
                -c grep.patterntype=3Dfixed \
                -c grep.patterntype=3Dbasic \
                -c grep.patterntype=3Dextended \
                grep "a+b*c" ab >actual &&
        test_cmp expected actual

ok 141 - grep pattern with grep.patternType=3Dfixed, =3Dbasic, =3Dextende=
d

expecting success:=20
        >empty &&
        test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c" ab >actual =
&&
        test_cmp empty actual

test_must_fail: command succeeded: git grep -G -F -P -E a\x{2b}b\x{2a}c a=
b
not ok 142 - grep -G -F -P -E pattern
#
#               >empty &&
#               test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c" ab =
>actual &&
#               test_cmp empty actual
#
elaine t # elaine t # cd trash\ directory.t7810-grep/
elaine trash directory.t7810-grep # git grep -G -F -P -E a\x{2b}b\x{2a}c =
ab >actual
fatal: command line, 'ax{2b}bx{2a}c': Invalid contents of {}
elaine trash directory.t7810-grep # echo $?
128
elaine trash directory.t7810-grep # cat actual
elaine trash directory.t7810-grep # rm actual
elaine trash directory.t7810-grep #

--------------030003090509050607090305--

--lsAlx2Mp95IboticKEXhEWPhFuBbF94Ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYc2swAAoJEMspy1GSK50U3k8QAMwqXZG2Wf4YWwIePZjppKse
9Z1JqpopaSdC5rWgZ8nlp3dGG+9QGjYv/xDSKJ2c3tQHwYpKp6gjpUzii2zqFQKQ
JF3763xgwAc8MHsRh62qh5ynYH4USsuT5RZUciM1s6PgXavMjpoh+9Tg5ttH0sot
jGiKCLpEIN1fLdDAT4Xd3clLFdcKawyTIK4Svj5fHeihkEzwKdmJHHC2jDh3pOSY
82B+MF8A5PlW+Q5jeradM5wrI1HKZrWOmBMemQdhc8bXbQbF4IHViwFcu0Ty3x4u
E8N1iPddQ2FUm9Cc/n5HJNFDZUgD5xhBykQU1mxOU1SI0SdQL+kzkWzPUKT1R7la
X01lufkWCg+MQ7VB7wjwbFsGC86YDGRjvidtnjv5gbP3EC14Hn3IB93sEoF2y0vI
Nkb3CXNoZ1GUJwKuCYUIuPKTTNCv5mKHFVNLWoDsetUVwlAl6gBiMgnKr5Rnx7Em
Zc4HnrbogYglwJVe7Tz/9Hnq/lQRcl761nVGtCjMY5gMVC1jtH4khwBDSrdiSSEa
YTCE1goFgc24qyKaorf4RtNnsv8YkmcznUHkf3t51y4XOtgucXqoxGDaQsPIw7yC
8Pef32cTgVOV7f+cRe9S/9+PnnDIGboIuplDOFOshgiCRh30q49Y5te7lZsu6SDX
LjSbVYytaVq2TyJnMOAL
=rKad
-----END PGP SIGNATURE-----

--lsAlx2Mp95IboticKEXhEWPhFuBbF94Ad--
