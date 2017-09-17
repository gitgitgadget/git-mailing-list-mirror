Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEB820A26
	for <e@80x24.org>; Sun, 17 Sep 2017 01:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdIQB6P (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 21:58:15 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:53482 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdIQB6O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 21:58:14 -0400
Received: (qmail 26086 invoked from network); 17 Sep 2017 01:58:11 -0000
Received: from 107-131-85-42.lightspeed.tulsok.sbcglobal.net (HELO ?192.168.1.157?) (awilcox@wilcox-tech.com@107.131.85.42)
  by mail.wilcox-tech.com with ESMTPA; 17 Sep 2017 01:58:11 -0000
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
To:     Junio C Hamano <gitster@pobox.com>, musl@lists.openwall.com
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
 <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
 <59BCAF81.3090206@adelielinux.org>
 <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        git@vger.kernel.org
From:   "A. Wilcox" <awilfox@adelielinux.org>
X-Enigmail-Draft-Status: N1110
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <59BDD6AF.5090604@adelielinux.org>
Date:   Sat, 16 Sep 2017 20:58:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 16/09/17 19:36, Junio C Hamano wrote:
> "A. Wilcox" <awilfox@adelielinux.org> writes:
> 
>> While musl's reading is correct from an English grammar point of
>> view, it does not seem to be how any other implementation has
>> read the standard.
>> 
>> However!  It gets better.
>> 
>> The ISO C standard, committee draft version April 12, 2011,
>> states[4]:
>> 
>>> c    Matches a sequence of characters of exactly the number
>>> specified by the field width (1 if no field width is present in
>>> the directive).
>> ... Since Git is specifically attempting to read in a host name,
>> there may be a solution: while 'c' guarantees that any byte will
>> be read, and 's' will skip whitespace, RFCs 952 and 1123 §2.1[5]
>> specify that a network host name must never contain whitespace.
>> IDNA2008 §2.3.2.1[6] (and IDNA2003 before it) specifically
>> removes ASCII whitespace characters from the valid set of Unicode
>> codepoints for an IDNA host name[7]. Additionally, the buffer
>> `locking_host` is already defined as an array of char of size
>> HOST_NAME_MAX + 1, and the width specifier in fscanf is specified
>> as HOST_NAME_MAX.  Therefore, it should be safe to change git to
>> use the 's' type character.  Additionally, I can confirm that
>> this change (patch attached) allows the Git test suite to pass on
>> musl.
> 
> I did a quick scan for substring "scanf" and read through the 
> output, and it seems that this is the only one that wants to do
> the this many characters, e.g. "%42c", conversion.
> 
> I am a bit worried about the correctness of your conclusion,
> though.


%[width]s means read up to [width] non-ws characters.  It is exactly
what Git wants out of %[width]c, with the difference that 's' will
stop at whitespace.  Since hostnames cannot legally contain
whitespace, the difference is negligible.


> As long as we are reading from the file written by us, because the 
> string we write as the hostname part comes from what we prepare in 
> my_host[HOST_NAME_MAX+1] using xgethostname(), we may know it
> would fit in locking_host[HOST_NAME_MAX+1].  But because
> HOST_NAME_MAX on my platform may be shorter than what your platform
> uses, I'll run over the end of my buffer if I am reading the
> lockfile you write to notice that the repository is in use from
> your host.  After all, the reason why we write hostname in the file
> is because we expect the filesystem is shared across different
> hosts, so relying on HOST_NAME_MAX to be the same across platforms
> would not be a good way to go.


You cannot run over the buffer in any scenario: if the hostname is
longer than [width], then [width] + \0 will be written to the buffer.
 Since the buffer is HOST_NAME_MAX+1 and the width is HOST_NAME_MAX,
it stands to reason that you cannot overflow the buffer.


> So it seems to me that a real fix has to read the file ourselves
> and parse up to our HOST_NAME_MAX+1 to see if the hostname refers
> to us, and fscanf that cannot take "slurp up to this many bytes" is
> not useful tool to implementing that parsing.


Except that is *exactly* *what* *s* *does* (quoting C11 §7.21.6.2):

9   An input item is defined as the longest sequence of input
    characters which does not exceed any specified field width


s   Matches a sequence of non-white-space characters.



awilcox on elaine ~ $ cat -> myhost
elaine.foxkit.us
awilcox on elaine ~ $ cat -> test.c
#include <stdio.h>
int main(void) {
    char test[9];
    fscanf(fopen("myhost", "r"), "%8s", test);
    printf("result: %s\n", test);
    return 0;
}
awilcox on elaine ~ $ c99 -o test test.c
awilcox on elaine ~ $ ./test
result: elaine.f
awilcox on elaine ~ $ /usr/lib/libc.so
musl libc (powerpc)
Version 1.1.16


> The current scan_fmt variable comes from da25bdb7 ("use 
> HOST_NAME_MAX to size buffers for gethostname(2)", 2017-04-18),
> and before that, we used to use "%"SCNuMAX" %127c", which was
> already problematic.  The "%127c" part came from the very original
> of this codepath in 64a99eb4 ("gc: reject if another gc is running,
> unless --force is given", 2013-08-08), whose first appearance in
> released versions was in v1.8.5, it seems.  IOW, nobody tried to
> run Git with musl C in the past 4 years and you are the first one
> to notice?


Yes.  Yes I am.

Because this is the first version that has a *test* that *tests* this
behaviour.

The odds that someone:

* is using musl
* with a Git repository over a network file system
* with another platform with a different HOST_NAME_MAX
* both concurrently running `git gc`, or the non-musl one being killed
* with loose refs that they, for some reason, would notice not being
gc'd properly

is almost zero.  However, it is theoretically something that could
happen, and that is the point of a test suite: testing code paths that
are rarely used to ensure they are correct when needed.  And this test
has proven that this code is *not* correct and will *not* function as
intended when it is needed.

The fact that this code "hasn't caused issues until now" does not mean
that it is correct; it only means that you are lucky enough that
nobody has attempted to use it until now.

Like it or not, the ISO C standard states exactly how fscanf should
behave, and you are relying on non-standard behaviour for a *lock* file.

If you are uninterested in conforming to the standard of the language
in which the source control system is written in (C), then perhaps it
should be written in a different language.  Perhaps Perl, or Rust.

But if you're going to use C, you have to actually write C.

- --arw

- -- 
A. Wilcox (awilfox)
Project Lead, Adélie Linux
http://adelielinux.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZvdapAAoJEMspy1GSK50UbkAP/1oSkfp9oUMTchdWbrOrA/R5
V6zbXTzs2cUHFUwqTVG9I/L3bZoFkWJyzkh9YUIPbUa3YY9gTYZaH4bNEVzvF8cn
PbYbcJ/wdTy8HGyXs6SuVENd/MZmk2FrDgv0+LyKQLqkkx8b4LA30sXdfuhVflg2
2lRkKhrzlrEkV0Zp+YNaa8GJB4ewpRA9A3tkeTFTLq+Rj7cguaubKCFkkwguDF0d
tEy43hwHUbZ7GT/UjBFKeODJGVQKoHcJ45JHdo2gRp9OtvKXJkcH07kjKPF7Z8Nc
0ipGH9hvODT5tkkENexNiNCeWI9unbjqXjHsRg9Q5k5KsKlAhG33CAQxrEIVnBpT
RMhq3S1To33b+Je7BqdPBwxJvDAhz8Pe7MSB6m8HcLW0DsD1t72s7utwkpgjSHlO
4HRy68Nf7Q271OfulZtainVgLl7gU6HCbnm86dp+zk1WlJ/KOOtm5jz2NkruwrKV
8QbPfIkV7LasB7XDOg/Q7TbObSmFYId869BkZU9N1oOzvgHpNVh7qgRdW5u65hlE
YzZDwzdyWew3GjGnPLEi4hioqm4ZFdrahBujqWL+z4XUAblfm9i1gY5wDMb/ZYxm
oqDjguE3gnfrqpYVx5MBi6ow4Ykid/b1T2KfZQ4D92yLTdQ1SY9de435YsmkzZlU
D9sGiVVcRyLqeqqBj5lV
=ZJnT
-----END PGP SIGNATURE-----
