From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 03/20] Git.pm: stop assuming that absolute paths start
 with a slash
Date: Wed, 27 Jan 2016 17:19:16 +0100 (CET)
Message-ID: <af44eca2a1190be237429b4f02186d3a42208087.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSoY-0001uY-BP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933625AbcA0QTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:58582 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932599AbcA0QTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:20 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0McR00-1afzhF0uUS-00Hb9u; Wed, 27 Jan 2016 17:19:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Gni657GCxKK4MzDHxzHaBlyV+WJPi2tHIE4wleWcq4VCNvVL7hA
 lt57kjyYm1zjNkcgnT9D7Aat+teHriiRs1RbvNngdNjHMBd5khzKPpQjdcM93NYkCZuXEJ9
 7yLnS/EaIsyb+Z1VvG6mJwtBcCCA8naDbcrNsZYW14UFDEIb8rwcFhGb55HOD+QpgqT08C+
 O0OR1liKeASwclTCWyTtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BVS723SnwWU=:HXmNZf4M5iFWty6pJQOsoF
 cqZOMWTk2gBXaDfz2fPIwW38XWJ/3k49IyBOs2G8vy3/k3UWWn+x6ZfdX2AcjISHbUfY0DqYa
 19JJxFxpvSnMjHUm7qZSPbzL47NdkFko/OPsqWhRtX4pt0xMj7thC5LDNakYoNnEbrlTcuEOM
 AKO1lHrkI+b8eUGdPdM4HHLL3qNS88J5UM6hSql6vzirJlRJohK4ZT/H1kXEvWi5smPT9E/LB
 yJsi3QTuDDHP2o2LKN7yN1jPVk7Jm9/Nf+/uoQWufHjKCq02vjmveWQp5YwG41RZhaqK1bl5Y
 Vn6BTaI1fyEzAL53EUvO6gpKxj5hwuBjTVgSF1OrxT1Pg71nkorhLi3XSoPtD/fIf0dtdQQXy
 xMiklX9KxU+j3niKxCyG+SeqXgT66jghUpoZzhhieoNLBLd+YRF27LxDeawVa5/hCXbjabmxG
 JV0rBi3WY+pdf7njGhBGWANQWA6njCz4lNn34IXiBotVyMsPPtWfdYs9qwSEMLMy86zseSXd1
 reAwabzociWV4WOpAcTLpD1px6LRID7IgNQDEY+SAmwXnAsF5TlhaDSQJXi4B25bFLMb0qRSG
 ej72t54U5CGoSE7NwZvziBKvFcxSdCQd5ly1E5LE6hnLhyGI33Rf4DaWAEadpTfFu7qiISv9q
 Mefh2XiiUP+ppTXhz3PBMYY0zXQKbo7rPDMCsyDqgvRfACHHU1BefkEzGjEmX9RD5Mn2Q34XB
 3g+LtZf/cbtiRlY6+akxicXZqYOCqVqbMq5zLa1WxsSYU2TLxmtkKKzO0C/mjU15NvvBI981 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284919>

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
