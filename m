Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92D11FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 04:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758032AbcLAE0y convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 30 Nov 2016 23:26:54 -0500
Received: from dmz-mailsec-scanner-2.mit.edu ([18.9.25.13]:45550 "EHLO
        dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757998AbcLAE0x (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Nov 2016 23:26:53 -0500
X-AuditID: 1209190d-8f7ff7000000320f-74-583fa686a785
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 96.54.12815.686AF385; Wed, 30 Nov 2016 23:26:47 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id uB14QkCR000754;
        Wed, 30 Nov 2016 23:26:46 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id uB14QhxM019398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 30 Nov 2016 23:26:44 -0500
Date:   Wed, 30 Nov 2016 23:26:43 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] xdiff: Do not enable XDL_FAST_HASH by default
Message-ID: <alpine.DEB.2.10.1611302310240.20145@buzzword-bingo.mit.edu>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixG6notu+zD7C4NdtdYuuK91MFg29V5gt
        frT0MFus3LWQyYHF41nvHkaPi5eUPeZ+WsTq8XmTXABLFJdNSmpOZllqkb5dAldGS9Md1oJ3
        khX3OqcwNjBOFu1i5OSQEDCROPnjAGsXIxeHkEAbk8SvLRcYIZyNjBKbt/+Gyuxmklj+6Cw7
        SAuLgLbExmYIm01ATeLD0a+sILaIgKzE98MbGUFsZoFMiXmH1rGB2MICdhLnVp9hAbF5BTwk
        7l5eARYXFdCVOPTvDxtEXFDi5MwnLBC96hIHPl2EmqMtcf9mG9sERr5ZSMpmISmbhaRsASPz
        KkbZlNwq3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjKDw5JTk3cH4767XIUYBDkYlHt6E
        23YRQqyJZcWVuYcYJTmYlER5y0rsI4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8L5bApTjTUms
        rEotyodJSXOwKInz/nf7Gi4kkJ5YkpqdmlqQWgSTleHgUJLgbQBpFCxKTU+tSMvMKUFIM3Fw
        ggznARoetRhkeHFBYm5xZjpE/hSjLsebXS8fMAmx5OXnpUqJ8xaDDBIAKcoozYObA04rnA4S
        rxjFgd4S5j0FUsUDTElwk14BLWECWvL2tTXIkpJEhJRUA+PVW3EqX7/fuRNtdiz75Ce/FWIG
        a65k1RTO/LluZe6+7l8WVR9qnu3PYL2aaZ2kt+F4H4eOcNndUinhKt9LrkZfZdb8n7ekvvD6
        ktZQ/QcLzrw/uKZnX0We3iK+4/PT9V1TLKuy1zgtjp6rXaecHVdQI/j9KduXk0febfkxSY3d
        i/GNvWr9hLVKLMUZiYZazEXFiQCdtWMBBgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although XDL_FAST_HASH computes hashes slightly faster on some
architectures, its collision characteristics are much worse, resulting
in some pathological diffs running over 100x slower
(http://public-inbox.org/git/20141222041944.GA441@peff.net/).

Furthermore, it was being enabled when ‘uname -m’ returns x86_64, even
if we are cross-compiling for a different architecture.  This mistake
was also causing the Debian build reproducibility test to fail
(https://tests.reproducible-builds.org/debian/index_variations.html).
Future architecture-specific definitions should be based on compiler
macros such as __x86_64__ rather than uname.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---

On Wed, 30 Nov 2016, Jeff King wrote:
> However, I think this might be the tip of the iceberg. There are lots of
> Makefile knobs whose defaults are tweaked based on uname output. This
> one caught you because you are cross-compiling across architectures, but
> in theory you could cross-compile for FreeBSD from Linux, or whatever.
> 
> So I suspect a better strategy in general is to just override the
> uname_* variables when cross-compiling.

The specific case of an i386 userspace on an x86_64 kernel is important 
independently of the general cross compilation problem (in fact, the words 
“cross compilation” may not even really apply here).  And I don’t think 
one should have to manually tweak the build for this setup, especially 
since the compiler already has the needed information.

> All that being said, I actually think an easier fix for this particular
> case might be to drop XDL_FAST_HASH entirely.

Works for me.

Anders

 Makefile         | 1 -
 config.mak.uname | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index f53fcc90d..c237d4f91 100644
--- a/Makefile
+++ b/Makefile
@@ -341,7 +341,6 @@ all::
 # Define XDL_FAST_HASH to use an alternative line-hashing method in
 # the diff algorithm.  It gives a nice speedup if your processor has
 # fast unaligned word loads.  Does NOT work on big-endian systems!
-# Enabled by default on x86_64.
 #
 # Define GIT_USER_AGENT if you want to change how git identifies itself during
 # network interactions.  The default is "git/$(GIT_VERSION)".
diff --git a/config.mak.uname b/config.mak.uname
index b232908f8..2831a68c3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -1,10 +1,8 @@
 # Platform specific Makefile tweaks based on uname detection
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
-uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
 ifdef MSVC
@@ -17,9 +15,6 @@ endif
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
-ifeq ($(uname_M),x86_64)
-	XDL_FAST_HASH = YesPlease
-endif
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
-- 
2.11.0

