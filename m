Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A69C433FE
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiAQV41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 16:56:27 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:35366 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiAQV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 16:56:23 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AED835B236;
        Mon, 17 Jan 2022 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642456582;
        bh=TvQwZQkGPkqwk1rv5jnyXn3FCmnuxgnLPQ4Q8BLV0do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=mMk6wMFySNr3u35A4QvP5B9DLkzyvL5vaouVO70l9EfPwdtVUM2rVVPxN+klzkl6L
         yqpx6zjMJbn0t52n7FYwNV1MsbZqrOuCqLWV7BmByb1DbkazGmR3VEMK4LS37FNHy3
         AJb/KYsLsuPsQ4xpLdOjiy7FphSQiZZnoW1H5tl49fVE5xmys0T1j47NEIs9MW8d0O
         +60TZkQfec1Bh5snqyRdnaLA0UOi+3mBsB1PZ3ncDUj+J6L29EiQSnazce6Z9ZheOe
         cMhoczvHcxjGqb1riygTrt/yrNbU7qlDBwFP6H9ViTUfHvc4ku+F60aLL43dcHtclT
         +Wqk95lmmMpIc9bbj8jWPpWKRZujyFroCdLl01ZH7g7ei+w3PxufOLnghuMxnzEjHK
         /WdZ/P3Hept6z7WcAE3VqLVWsoRjCV6qkmAoMRxGyCxGa0krOQsPwDXHWEff8ertbi
         M/R0NXhZGJ8yxtT6NvcgqUzy6W6Nj/Q+SDaQjWnpp+3aFWHbS1+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 0/2] Generate temporary files using a CSPRNG
Date:   Mon, 17 Jan 2022 21:56:15 +0000
Message-Id: <20220117215617.843190-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when we generate a temporary file name, we use the seconds,
microseconds, and the PID to generate a unique value.  The resulting
value, while changing frequently, is actually predictable and on some
systems, it may be possible to cause a DoS by creating all potential
temporary files when the temporary file is being created in TMPDIR.

The solution to this is to use the system CSPRNG to generate the
temporary file name.  This is the approach taken by FreeBSD, NetBSD, and
OpenBSD, and glibc also recently switched to this approach from an
approach that resembled ours in many ways.

Even if this is not practically exploitable on many systems, it seems
prudent to be at least as careful about temporary file generation as
libc is.

In this round, I've switched to allow multiple values for the makefile
variable to make our usage in autoconf easier.  I have not submitted any
changes to the autoconf code, since the defaults are fine for most
situations, and even a fallback to /dev/urandom should be okay in most
places.

I also haven't included multiple values in config.mak.uname since
there's little reason to do so: the BSDs all have had arc4random for a
long time, Windows and NonStop have only one good option, and no other
systems have a value set.

A range-diff appears below for your convenience.

Changes from v2:
* Switch from a single option in the makefile variable to multiple
  options.
* Change the name of the libbsd option to "libbsd" so it doesn't share a
  substring with other options due to the function we use.

Changes from v1:
* Remove the automatic testing using buckets because it didn't seem to
  add much.
* Switch to a single makefile variable.
* Add support for OpenSSL CSPRNG.
* Add more defaults for various systems, including macOS and NonStop.
* Add an arc4random-libbsd variant for improved testing of the
  arc4random code paths on Linux.  The only difference is the inclusion
  of an additional header.
* Print a more useful error message than before, indicating that the
  CSPRNG failed.

brian m. carlson (2):
  wrapper: add a helper to generate numbers from a CSPRNG
  wrapper: use a CSPRNG to generate random file names

 Makefile                            | 34 ++++++++++++
 compat/winansi.c                    |  6 +++
 config.mak.uname                    |  8 +++
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 19 +++++++
 t/helper/test-csprng.c              | 29 +++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 wrapper.c                           | 81 +++++++++++++++++++++++++----
 9 files changed, 169 insertions(+), 12 deletions(-)
 create mode 100644 t/helper/test-csprng.c

Diff-intervalle contre v2 :
1:  edd623bd9a ! 1:  6644235af2 wrapper: add a helper to generate numbers from a CSPRNG
    @@ Commit message
         requested, or we fail.  We don't return partial data because the caller
         will almost never find that to be a useful behavior.
     
    -    Specify a makefile knob which users can use to specify their preferred
    -    CSPRNG, and turn the multiple string options into a set of defines,
    -    since we cannot match on strings in the preprocessor.
    +    Specify a makefile knob which users can use to specify one or more
    +    suitable CSPRNGs, and turn the multiple string options into a set of
    +    defines, since we cannot match on strings in the preprocessor.  We allow
    +    multiple options to make the job of handling this in autoconf easier.
     
    -    The order of suggested options is important here.  On systems with
    -    arc4random, which is most of the BSDs, we suggest that, since, except on
    -    MirBSD and macOS, it uses ChaCha20, which is extremely fast, and sits
    -    entirely in userspace, avoiding a system call.  We then prefer getrandom
    -    over getentropy, because the former has been available longer on Linux,
    -    and then OpenSSL. Finally, if none of those are available, we use
    +    The order of options is important here.  On systems with arc4random,
    +    which is most of the BSDs, we use that, since, except on MirBSD and
    +    macOS, it uses ChaCha20, which is extremely fast, and sits entirely in
    +    userspace, avoiding a system call.  We then prefer getrandom over
    +    getentropy, because the former has been available longer on Linux, and
    +    then OpenSSL. Finally, if none of those are available, we use
         /dev/urandom, because most Unix-like operating systems provide that API.
    -    We prefer to suggest options that don't involve device files when
    -    possible because those work in some restricted environments where device
    -    files may not be available.
    +    We prefer options that don't involve device files when possible because
    +    those work in some restricted environments where device files may not be
    +    available.
     
         Set the configuration variables appropriately for Linux and the BSDs,
         including macOS, as well as Windows and NonStop.  We specifically only
    @@ Makefile: all::
      # the executable mode bit, but doesn't really do so.
      #
     +# Define CSPRNG_METHOD to "arc4random" if your system has arc4random and
    -+# arc4random_buf, "arc4random-libbsd" if your system has those functions from
    -+# libbsd, "getrandom" if your system has getrandom, "getentropy" if your
    -+# system has getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or
    -+# "openssl" if you'd want to use the OpenSSL CSPRNG.  If unset or set to
    ++# arc4random_buf, "libbsd" if your system has those functions from libbsd,
    ++# "getrandom" if your system has getrandom, "getentropy" if your system has
    ++# getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or "openssl" if
    ++# you'd want to use the OpenSSL CSPRNG.  You may set multiple options with
    ++# spaces, in which case a suitable option will be chosen.  If unset or set to
     +# anything else, defaults to using "/dev/urandom".
     +#
      # Define NEEDS_MODE_TRANSLATION if your OS strays from the typical file type
    @@ Makefile: ifdef HAVE_GETDELIM
      	BASIC_CFLAGS += -DHAVE_GETDELIM
      endif
      
    -+ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
    ++ifneq ($(findstring arc4random,$(CSPRNG_METHOD)),)
     +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
     +endif
     +
    -+ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
    ++ifneq ($(findstring libbsd,$(CSPRNG_METHOD)),)
     +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
     +	EXTLIBS += -lbsd
     +endif
     +
    -+ifeq ($(strip $(CSPRNG_METHOD)),getrandom)
    ++ifneq ($(findstring getrandom,$(CSPRNG_METHOD)),)
     +	BASIC_CFLAGS += -DHAVE_GETRANDOM
     +endif
     +
    -+ifeq ($(strip $(CSPRNG_METHOD)),getentropy)
    ++ifneq ($(findstring getentropy,$(CSPRNG_METHOD)),)
     +	BASIC_CFLAGS += -DHAVE_GETENTROPY
     +endif
     +
    -+ifeq ($(strip $(CSPRNG_METHOD)),rtlgenrandom)
    ++ifneq ($(findstring rtlgenrandom,$(CSPRNG_METHOD)),)
     +	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
     +endif
     +
    -+ifeq ($(strip $(CSPRNG_METHOD)),openssl)
    ++ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
     +	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
     +endif
     +
2:  b4cd8700e3 = 2:  c6d7d686f2 wrapper: use a CSPRNG to generate random file names
