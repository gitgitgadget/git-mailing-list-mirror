From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 03/19] Git.pm: stop assuming that absolute paths start with
 a slash
Date: Sun, 24 Jan 2016 16:43:26 +0100 (CET)
Message-ID: <75e3562d45097de8b166b57ff6f475bb87666ce0.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMpe-0000ZT-Nj
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbcAXPn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:43:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:64489 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbcAXPnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:43:33 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MMpYB-1aTgjx3sYZ-008XZI; Sun, 24 Jan 2016 16:43:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:y7+CD5BQ2UukbHDdpkVjJDRI5IcISZDF6c6mzlbaxfMpO1vv8bq
 QIfVpGWqanroBl4fLJiCzagcomAZRC0YHnE7V82yd4Z5O+rW9KHvWyb81raNJdJBs8zRCC0
 YwtJ3yWkQJ7vE8fx8kv2OjrtFgTPMuTd27x9ta2VGXF5EMcCFJo3ia8Mk6T+SXJRKxnIpKM
 58Yxi6icjmYhhJaSlHM0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oxokWyhfCSY=:8vL+zY9DJ7t9jAePQw0Wee
 pBZ9TAMhTBiMagBFVvoaxL0sEnJIm3G9fjdmyAi5bL7Wg1TStY4hE+BuUUyvPXMTAjgvXTc+l
 qilIosmurhRVsXZbpNobsDTUEQxwg2PsqVduJh2c//jbDFCNVTKLVQu7Nz55cuZcqCg2J9oo/
 ipZcDlPW7ZH+nAG09fv7fKPhXmVJkv794uNOEuBLG/OD5pyCQFzQCgEBPrvnqU+y7b2YEqkYA
 ph2LaStnhAn/7QJynk0upzPaA4VFUcsEFlNzILLs8emmgMtmjrzkiz8Q/qLgLkk5uJcQzl5oK
 e73c/0A+N7ZPZ7h0EYmDC7No3gTvO48JEym+YZY5szOfMF1HAEeXpWhaVvOKV36+YAV6DQv1O
 nB/1YSZEcfO6olWAJ8SXdCXN0ttXhquCcsmJUrx/hMHDr0fDR9Yq35sqQ1lpzcGoPH1FFO8j1
 l4G9mDPxBkq3al0TgBn0Vn76ktpW2T5hw/v9WE44//21Hp5EFcQsO7HrcX9EeoIaXykHpXjX2
 gMYPrPXEiYR0NYOrfiehsqgxsSCzC1L8hE+A/QnUQ3GWVH3Mkxw9e992YCewEN/jp+RNdvSAK
 lRwDoaYAsdoG/C8qZ0lLw0Juiu2BqDIsMovAe+JKlxB3ogaBSqJSXVi1saWpxmm4Y7chMSufs
 AQhN4rHkerJXbUC067o5srrmyK1uiWyMtI6jPM/FF69XeX39cq72Gjky0psu6cD10uWWElSWw
 Vv6tqFF+lEegRiYEVXPWRUyfRubeiUuEDHFIxd93HwkHauoLiHUuBw4osBF5eGlHaZp+kF6M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284668>

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
