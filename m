From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v2] MinGW(-W64) cross-compilation
Date: Tue, 29 Apr 2014 13:11:54 +0400
Message-ID: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:12:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf45Y-0005GE-L1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863AbaD2JMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:23 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:44853 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaD2JMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:16 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45B-0006BN-GD; Tue, 29 Apr 2014 13:12:09 +0400
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247537>

Differences with v1:
 - Dropped "MINGW: compat/bswap.h: include stdint.h", it isn't needed after
   "MINGW: git-compat-util.h: use inttypes.h for printf macros"
 - Split "MINGW: config.mak.uname allow using CURL for non-msysGit builds"
   into "MINGW: config.mak.uname: allow using cURL for non-msysGit builds"
   and "MINGW: fix main() signature in http-fetch.c and remote-curl.c"
 - Reworded "MINGW: git-compat-util.h: use inttypes.h for printf macros"
 - Reworded "MINGW: config.mak.uname: reorganize MINGW settings"
 - Rewrote "MINGW: config.mak.uname: drop -DNOGDI" into
   "MINGW: compat/poll/poll.c: undef NOGDI"
 - Rewrote "MINGW: config.mak.uname: drop USE_NED_ALLOCATOR" into
   "compat/nedmalloc/malloc.c.h: fix compilation under MinGW-W64"
 - Reworded "Makefile: introduce CROSS_COMPILE variable"
 - Reordeder commits (1-5 are Acked by: Eric Faye-Lund <kusmabite@gmail.com>)

=====================================

This patch series fixes building on modern MinGW and (32bit only yet) MinGW-W64.

*Compilation* tested on:
 - MSVC (via WinGit environment)
 - msysGit environment
 - Linux cross-toolchain i686-pc-mingw32 (4.8.2) with mingw-runtime-3.20.2
 - Linux cross-toolchain i686-w64-mingw32 (4.8.2) with mingw64-runtime-3.1.0

Stuff still required to make Git build with x86_64 MinGW-W64 toolchain:

1. Drop -D_USE_32BIT_TIME_T that was added in fa93bb to config.mak.uname
because time_t cannot be 32bit on x86_64. I haven't yet figured out what
should break if this define is removed (pointers are welcome) and why it was
added in the first place.

2. Stop passing --large-address-aware to linker. I wonder if it does anything
for 32bit MinGW builds.

3. Fix several places with mismatched pointer size casts.

Building it from Gentoo Linux:

MinGW:

  crossdev -t i686-pc-mingw32
  ARCH=x86 emerge-i686-pc-mingw32 -u dev-libs/libiconv sys-libs/zlib net-misc/curl sys-devel/gettext expat
  cd <git>
  make CROSS_COMPILE=i686-pc-mingw32- NO_OPENSSL=1 MINGW=1 CURLDIR=/usr/i686-pc-mingw32/usr

MinGW-W64 (32 bit):

  crossdev -t i686-w64-mingw32
  ARCH=x86 emerge-i686-w64-mingw32 -u dev-libs/libiconv sys-libs/zlib net-misc/curl sys-devel/gettext expat
  cd <git>
  make CROSS_COMPILE=i686-w64-mingw32- NO_OPENSSL=1 MINGW=1 CURLDIR=/usr/i686-w64-mingw32/usr
