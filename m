From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 03/19] Git.pm: stop assuming that absolute paths start
 with a slash
Date: Tue, 26 Jan 2016 15:34:35 +0100 (CET)
Message-ID: <1e53f292003d0e3ab81a5e26be63eb80bfd6cda7.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4hv-0004XC-L7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966160AbcAZOep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:34:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:51666 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966274AbcAZOek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:40 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lj1Cw-1ZpIe53TsU-00dCM4; Tue, 26 Jan 2016 15:34:35
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KFEdTJ5wrXdmS2/VUwnqcLrpng2ja4vlyZCE/dkVSYFPHult1Rg
 GCn2ce7+GKkyBUDfihREG7AAVZ1A541dM4IO3bysByp2RET4Lqa5Vynn3sPZvsOQ5CILP02
 hzKIjNmv6skV9FMZDq4qtLc2uF8CVHbyIEx1fDf2pGQvvNhRv411gZNltgTPAJfro4BZ58Q
 2ywON2cuIoe/QQ6aNOC0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jyBRC9Y62KY=:CSFJUoeuYt2viWXpt3vhsk
 2TgPUg2sLtFgdu6T73G9YqsM3caTsyr5wSDVnzl2qxVjH16X5rAWxDk19WUyQjpBQ1VTQxDJh
 AbgDhMbNLwiFGG+P9tbESsJ1epzKyYxSU6dxM+87lm1BZSn9TyJtG7i18ydACoNuA7xYyuzpw
 hvxZbkSzZVAQcfoasmRGtLQz7ZG6rAfCWeDMbadZlAk+BltAnsC4MONbv7pS6tnCwXsKfSEBp
 i4vxleOJRKDLkdtoTyj2S8RYnGPiTbDQE9uavIvrBjZvnYv20u57Ci6XWSM+CavNCDE5dtJI5
 BPRMKmCWpwQhi5W5csYv8XjQKmxeD2C9DSBp3YhItlpOZ6Z5SsGjs7BtjhswkLnzRaCnBf+od
 6YqdCJHuwJiFVFom79ae5AGgjsjmoOnAKJr3BlaY12JqBor6fY4d7FY4cUTlt2Pxiazg3n7oF
 GKKt58TcZ4vGOmYhTYhSkW+pC0GZwNXoWBiEU8PMkWv6hMivMPdLfsFWty1u21c3RYfZqsH8T
 hpUp3xdOvaAp9siRq37J1GKWaE8ICG7PlCnGtPUUgTZJWCLrCZ8nMvD4BsYS1Pr2WxWYOJ/8a
 Tp6v/UzOjlIkA6tUC24U9tTsOGF0orxsteQRMHEX6QKX/eAdF9UFbblwKHeigg/lTCBeKexc3
 DpMdoNgsbLcg9R0B4AtcYdIS/aWeny3is3CW8e/sJE2CWx1V7SdnxvqMfri4OebE/kUk1xklF
 3cdIZHVKf8Pdj7iLT3OzS4oXN+VW3wQ9wFOyy01Ow9OVWAJEZ2LxJUcrAd2IIxyqvSZW3Q+f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284818>

On Windows, absolute paths never start with a slash, unless a POSIX
emulation layer is used. The latter is the case for MSYS2's Perl that
Git for Windows leverages. However, in the tests we also go through
plain `git.exe`, which does *not* leverage the POSIX emulation layer,
and therefore the paths we pass to Perl may actually be DOS-style paths
such as C:/Program Files/Git.

So let's just use Perl's own way to test whether a given path is
absolute or not instead of home-brewing our own.

This patch partially fixes t7800 and t9700 when running in Git for
Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 perl/Git.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 19ef081..49eb88a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -188,7 +188,8 @@ sub repository {
 		};
 
 		if ($dir) {
-			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
+			_verify_require();
+			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
 			$opts{Repository} = abs_path($dir);
 
 			# If --git-dir went ok, this shouldn't die either.
-- 
2.7.0.windows.1.7.g55a05c8
