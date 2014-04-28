From: Marat Radchenko <marat@slonopotamus.org>
Subject: [RFC/PATCH v1] Towards MinGW(-W64) cross-compilation
Date: Mon, 28 Apr 2014 17:51:25 +0400
Message-ID: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:54:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wem15-00071k-BX
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbaD1Nvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:51:47 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56013 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaD1Nvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:46 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyA-0004qo-6g; Mon, 28 Apr 2014 17:51:42 +0400
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247338>

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
  make CROSS_COMPILE=i686-pc-mingw32- CC=i686-pc-mingw32-gcc NO_OPENSSL=1 MINGW=1 CURLDIR=/usr/i686-pc-mingw32/usr

MinGW-W64 (32 bit):

  crossdev -t i686-w64-mingw32
  ARCH=x86 emerge-i686-w64-mingw32 -u dev-libs/libiconv sys-libs/zlib net-misc/curl sys-devel/gettext expat
  cd <git>
  make CROSS_COMPILE=i686-w64-mingw32- CC=i686-w64-mingw32-gcc NO_OPENSSL=1 MINGW=1 CURLDIR=/usr/i686-w64-mingw32/usr

Debian/Ubuntu build instructions are WIP (xdeb is non-trivial at all).
