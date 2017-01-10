Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD1620A93
	for <e@80x24.org>; Tue, 10 Jan 2017 10:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756205AbdAJKhC (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 05:37:02 -0500
Received: from mail.foxkit.us ([45.32.83.9]:51016 "EHLO mail.wilcox-tech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756123AbdAJKhA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 05:37:00 -0500
Received: (qmail 9657 invoked from network); 10 Jan 2017 10:36:58 -0000
Received: from ip68-13-242-69.ok.ok.cox.net (HELO ?10.1.1.57?) (awilcox@wilcox-tech.com@68.13.242.69)
  by mail.foxkit.us with ESMTPA; 10 Jan 2017 10:36:58 -0000
Subject: Re: Test failures when Git is built with libpcre and grep is built
 without it
To:     Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>
References: <58688C9F.4000605@adelielinux.org>
 <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
 <58736B2A.40003@adelielinux.org> <871swcjsd3.fsf@linux-m68k.org>
 <20170109213303.4rupe5cqwejfp6af@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, musl@lists.openwall.com
From:   "A. Wilcox" <awilfox@adelielinux.org>
X-Enigmail-Draft-Status: N1110
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <5874B942.7070402@adelielinux.org>
Date:   Tue, 10 Jan 2017 04:36:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20170109213303.4rupe5cqwejfp6af@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

(Hi, musl developers!  Read on for some information regarding what
began as a test failure during packaging of Git 2.7.3 that appears to
be related to musl's regexp library.)


On 09/01/17 05:27, Jeff King wrote:
> Are you trying with a version of git older than v2.7.x?


We are using 2.7.3.  I will admit the version is a bit old, but it is
working on all other arches (and it took an inordinate amount of time
to spin up PowerPC - hooray for toolchain issues).


On 09/01/17 15:33, Jeff King wrote:
> On Mon, Jan 09, 2017 at 02:05:44PM +0100, Andreas Schwab wrote:
>> You need to quote the regexp argument, see the line starting
>> with "test_must_fail" above.
> 
> Oh, duh. I checked that the line in the test was quoted


Guilty of this as well.  Sorry about that.  With the proper
invocation, I receive a success:


elaine trash directory.t7810-grep # git grep -G -F -P -E
"a\x{2b}b\x{2a}c" ab
error: cannot run less: No such file or directory
ab:a+b*c
elaine trash directory.t7810-grep # echo $?
0


Haven't managed to build less(1) for PowerPC yet, but it does seem to
work when quoted.  Yikes!


> The problem is that we are expecting the regex "\x{2b}" to complain
> in regcomp() (as an ERE), but it doesn't. And that probably _is_
> related to musl, which is providing the libc regex (I know this
> looks like a pcre test, but it's checking that "-P -E" overrides
> the pcre option with "-E").
> 
> I'm not sure if musl is wrong for failing to complain about a
> bogus regex. Generally making something that would break into
> something that works is an OK way to extend the standard. So our
> test is at fault for assuming that the regex will fail. I guess
> we'd need to find some more exotic syntax that pcre supports, but
> that ERE doesn't. Maybe "(?:)" or something.
> 
> -Peff
> 


I am cc:ing in the musl development list to see what their thoughts are.

Thanks for the help so far; I really appreciate it.  Hopefully we can
resolve this in a way that makes musl and Git's test suite both more
correct, if necessary.

Happy new year!

- --arw


- -- 
A. Wilcox (awilfox)
Project Lead, Adélie Linux
http://adelielinux.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdLk+AAoJEMspy1GSK50Uz9kP/2JUSzSSXkKLy3788aAjgBOq
aTPBqKXLCvnTeBpsymXoGueaJzgDnYP6Xi9tUb/j4JAXqaJKGHXTgz8ixsFQJ4SJ
p7NN1JZXsIVGKWQHcxvEXEIRmBK7T9BQ2Hq6qUuk3n4PM6lbD1Ur3G1rUqIM/z76
5cSkvwgvGuOVYXLwSTTprb6EbbZc6WTgcDECFIl4z7eJ3GihChg+EgH4cTDt3xLD
9VHx++hWoEZXued0g0myENjBMeCiFOpYw1bzxn7d2s8masx/If2TkK0CLdexy2ti
hFV/F7g8etgZSdmrmiaJIudTsY6p46/sm/VmGm+8yPIeR8/8EOBlyhKhz4EidNtA
2dpUUJW/RD4uz9yVNjmWhIHaL10weuNLQLd/Tt5O/0dG422vhJxOwwJL9Vhxw70y
1PprD11+ZUJeWsz91C/Bl9CqHqljDP00QX8w/dbHCDsjeKgfUdksy2iKlHBG0sx3
CbL0EcHeE9BLmqmJi9ED7w78cTmNryemK29WFHUGSwzR99Rv9QlMn+4GCF1s0O3N
UKPCueLpPcNvRK+1WHkAwUC0iV97Un3WI6kyExs9khygIHRd1y/yRhbpxibbz337
FJfOTcT7e/YqML8Nb8EdwECRhdGX5u1tKqaOfBwLC62SKGTPi5qXpjaSPPJcJsrZ
phxFt6a45PPECV3ZsEO1
=PMkh
-----END PGP SIGNATURE-----
