Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9ED820228
	for <e@80x24.org>; Wed,  3 Aug 2016 13:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbcHCNae (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 09:30:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:57804 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932237AbcHCNad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 09:30:33 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M8leW-1bPPvc3xQC-00CD6f; Wed, 03 Aug 2016 15:30:21
 +0200
Date:	Wed, 3 Aug 2016 15:30:20 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] import-tars: support hard links
Message-ID: <bb3b91403fae1964aa990fc16fd8a4e5f16885e6.1470230877.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:34Fz7v4YDPQqpDGALndE2Au3TmO7Ky0Oh4gweRsECYaffE8Ib1+
 Iw6YMec1+vj7dBz68aCOdQfdtD66iPJvrZ9hnuyXX0cFZuYQWZnaBd+JP/qfX7nYWj/ktSI
 YPUupfL5ShtL0DPQU0JVgkWymOwLZQo4qCPLLYJeIAeota7nd12xJH3RGXN/dqCIxMgw86k
 SA45CcL20FKbUYdYODmsg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Max1EK7may8=:GrdKgMk89EhQW1aCL8alGb
 xTRn6cT7wZM3+vLfFhp3Trjmef0RxlxIc2WsqPE1XSHiObwPJUsKIP6ZDSbNEInxs97nZ5wcG
 7HN2h+KoV3QP5rbeaUhy2EB5upkvaD2pd2PQM2tUj+e3vViugZy2OSKX8TWoHxeLyVdTM+20V
 yFuM+rUzTadiz1vSXLolLsWWhNSUwBwYHHO0BhoKgZ3VtEc/0eDc+tNQs4XWv4I+DqVFlEjiE
 /eMdSKwo24wpLIQxgdapynhUYeBHAPqn5PVEihMDkaUwnWj/05eNau5KEZ4/gXv8BnxeQKrMy
 Wtg1teIu6X5Qrkww+1bH/6RDhmBjmJk2cV8wXF/XuPs2KoHK622De/dG4O1xd+I7rwU7xO9vJ
 BEayVAPqtnuPwetR4pWNwcbUQ7WLRucHTpMYxi/wrJ8l+nh5hxgbcYRuvW4fV/Iph0v1dZnF+
 lw8LiDZBIqu/uhmBN84IKhZJvYOjyH77HvNBw1Y58FO2gH2kW2XnGXlWWhlAudkN2hVtmnefg
 LHKPoyW8rrbbbG7Ho0/vcz6Y+vcNnFTTXh+6AjUnnLqBpVbxVuHc+hPOukm/iriZXbRvwlOCJ
 17CJFhiZBGQyv82xF7yBP1KsSzRqI31rwL+8IQAY7GENGfXf6r3w0wnHrhe4VkmmaETjNxOzA
 SutghAEvdBY03eOsZpn9UIpGe5aHOzamKrLuAueaQgnU36c0pFgyM5+WGsGx+Mwhbfk28++j1
 1VTZML9DUNQYmYnsw/EPUXC/1zxLWN+wBbfkahLRX9xe8G29CMV0KMeZatGUu/gSK9j5CcHQB
 MrLGVWH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Previously, we simply treated hard links as if they were plain files
with size 0, ignoring the link type "1" and hence the link target.

What we should do instead, of course, is to use the link target to get
at the import mark for the contents, even if we cannot recreate the hard
link per se, as Git has no concept of hard links.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/import-tars-hardlink-v1
 contrib/fast-import/import-tars.perl | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 95438e1..d60b431 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -96,18 +96,21 @@ foreach my $tar_file (@ARGV)
 		$mtime = oct $mtime;
 		next if $typeflag == 5; # directory
 
-		print FI "blob\n", "mark :$next_mark\n";
-		if ($typeflag == 2) { # symbolic link
-			print FI "data ", length($linkname), "\n", $linkname;
-			$mode = 0120000;
-		} else {
-			print FI "data $size\n";
-			while ($size > 0 && read(I, $_, 512) == 512) {
-				print FI substr($_, 0, $size);
-				$size -= 512;
+		if ($typeflag != 1) { # handle hard links later
+			print FI "blob\n", "mark :$next_mark\n";
+			if ($typeflag == 2) { # symbolic link
+				print FI "data ", length($linkname), "\n",
+					$linkname;
+				$mode = 0120000;
+			} else {
+				print FI "data $size\n";
+				while ($size > 0 && read(I, $_, 512) == 512) {
+					print FI substr($_, 0, $size);
+					$size -= 512;
+				}
 			}
+			print FI "\n";
 		}
-		print FI "\n";
 
 		my $path;
 		if ($prefix) {
@@ -115,7 +118,13 @@ foreach my $tar_file (@ARGV)
 		} else {
 			$path = "$name";
 		}
-		$files{$path} = [$next_mark++, $mode];
+
+		if ($typeflag == 1) { # hard link
+			$linkname = "$prefix/$linkname" if $prefix;
+			$files{$path} = [ $files{$linkname}->[0], $mode ];
+		} else {
+			$files{$path} = [$next_mark++, $mode];
+		}
 
 		$author_time = $mtime if $mtime > $author_time;
 		$path =~ m,^([^/]+)/,;
-- 
2.9.0.281.g286a8d9

base-commit: f8f7adce9fc50a11a764d57815602dcb818d1816
