Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64716201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 09:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdCMJbB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 05:31:01 -0400
Received: from ober.noekeon.org ([91.134.133.203]:48710 "EHLO ober.noekeon.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbdCMJa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 05:30:59 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Mar 2017 05:30:59 EDT
Received: from [127.0.0.1] (prime.immie.org [91.134.134.85])
        by ober.noekeon.org (Postfix) with ESMTPSA id 4DC822226C;
        Mon, 13 Mar 2017 10:24:26 +0100 (CET)
Subject: Re: RFC: Another proposed hash function transition plan
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     sbeller@google.com, bmwill@google.com, jonathantanmy@google.com,
        peff@peff.net, Linus Torvalds <torvalds@linux-foundation.org>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
From:   The Keccak Team <keccak@noekeon.org>
Message-ID: <91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org>
Date:   Mon, 13 Mar 2017 10:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170304011251.GA26789@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We have read your transition plan to move away from SHA-1 and noticed
your intent to use SHA3-256 as the new hash function in the new Git
repository format and protocol. Although this is a valid choice, we
think that the new SHA-3 standard proposes alternatives that may also be
interesting for your use cases.  As designers of the Keccak function
family, we thought we could jump in the mail thread and present these
alternatives.


SHA3-256, standardized in FIPS 202 [1], is a fixed-length hash function
that provides the same interface and security level as SHA-256 (FIPS
180-4). SHA3-256's primary goal is to be drop-in compatible with the
previous standard, and to allow a fast transition for applications that
would already use SHA-256.

Since your application did not use SHA-256, you are free to choose one
of the alternatives listed below.


* SHAKE128

  SHAKE128, defined in FIPS 202, is an eXtendable-Output Function (XOF)
  that generates digests of any size. In your case, you would use
  SHAKE128 the same way you would use SHA3-256, just truncating the
  output at 256 bits. In that case, SHAKE128 provides a security level
  of 128 bits against all generic attacks, including collisions,
  preimages, etc. We think this security level is appropriate for your
  application since this is the maximum you can get with 256-bit tags in
  the case of collision attacks, and this level is beyond computation
  reach for any adversary in the foreseeable future.

  The immediate benefit of using SHAKE128 versus SHA3-256 is a
  performance gain of roughly 20%, both for SW and HW implementations.
  On Intel Core i5-6500, SHAKE128 throughput is 430MiB/s.


* ParallelHash128

  ParallelHash128 (PH128), defined in NIST Special Publication 800-185
  (SP800-185, SHA-3 Derived Functions [2]), is a XOF implementing a tree
  hash mode on top of SHAKE128 (in fact cSHAKE128) to provide higher
  performance for large-file hashing. The tree mode is designed to
  exploit any available parallelism on the CPU, either through vector
  instructions or availability of multiple cores. Note that the chosen
  level of parallelism does not impact the final result, which improves
  interoperability.

  PH128 offers the same security level and interface as SHAKE128. So
  likewise, you just truncate the output at 256 bits.

  The net advantage of using PH128 over SHAKE128 is a huge performance
  boost when hashing big files.  The advantage depends of course on the
  number of cores used for hashing and their architecture. On an Intel
  Core i5-6500 (Skylake), with a single-core, PH128 is faster than
  SHAKE128 by a factor 3 and than SHA-1 by a factor 1.5 over long
  messages, with a throughput of 1320MiB/s.


* KangarooTwelve

  KangarooTwelve (K12) [3] is a very fast parallel and secure XOF we
  defined for applications that require higher performance that the FIPS
  202 and SP800-185 functions provide, while retaining the same
  flexibility and basis of security.

  K12 is very similar to PH128. It uses the same cryptographic primitive
  (Keccak-p, defined in FIPS 202), the same sponge construction, a
  similar tree hashing mode, and targets the same generic security level
  (128 bits). The main differences are the number of rounds for the
  inner permutation, which is reduced to 12, and the tree mode
  parameters, which are optimized for both small and long messages.

  Again, the benefit of using K12 over PH128 is performance. K12 is
  twice as fast as SHAKE128 for short messages, i.e. 820MiB/s on Intel
  Core i5-6500, and twice as fast as PH128 over long messages, i.e.
  2500MiB/s on the same platform.


If performance is not your primary concern, we suggest to use SHAKE128
as the default hash function, and optionally use ParallelHash128 for
hashing big files. Both functions offer a considerable security margin
and are standardized algorithms. On the longer term, provided HW
acceleration, SHAKE128 alone would easily outperform SHA-1 thanks to its
design.

If however you value first performance, or if you would like to promote
adoption of the new repository format by offering higher performance,
then KangarooTwelve is the right candidate. On modern CPU, K12 offers
equal performance as SHA-1 for small messages and outperforms it by a
factor 3 for long messages.  Regarding security, although K12 offers of
course a smaller security margin than other alternatives, it inherits
the security assurance built up for Keccak and the FIPS 202 functions.
As of today, the best practical attack broke 6 rounds of Keccak-p, with
2^50 computation effort. The 12 rounds of K12 offers then a comfortable
security margin [4].


Lately, we made a presentation at FOSDEM covering the latest development
over the Keccak family [5].  You can find reference and optimized
implementations of the algorithms listed above in the Keccak Code
Package [6]. Also, if you have questions, don't hesitate to contact us.


Kind regards,
The Keccak Team

Links
 [1]   FIPS 202,
       http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf.
 [2]   NIST SP 800-185,

http://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-185.pdf.
 [3]   KangarooTwelve, http://keccak.noekeon.org/kangarootwelve.html.
 [4]   Keccak Crunchy Crypto Collision and Pre-image Contest,
       http://keccak.noekeon.org/crunchy_contest.html.
 [5]   FOSDEM 2017, Portfolio of optimized cryptographic functions based
       on Keccak, https://fosdem.org/2017/schedule/event/keccak/.
 [6]   Keccak Code Package, https://github.com/gvanas/KeccakCodePackage.


