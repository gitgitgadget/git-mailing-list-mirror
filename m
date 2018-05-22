Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2F21F42D
	for <e@80x24.org>; Tue, 22 May 2018 10:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEVKGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 06:06:16 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49773 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVKGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 06:06:15 -0400
Received: from [141.131.2.3] (helo=ausnb752738.ad.cirrus.com)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fL4BI-00049M-W1; Tue, 22 May 2018 11:06:13 +0100
From:   Pedro Alvarez <pedro.alvarez@codethink.co.uk>
To:     git@vger.kernel.org
Cc:     Pedro Alvarez Piedehierro <palvarez89@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add initial support for pax extended attributes
Date:   Tue, 22 May 2018 11:05:48 +0100
Message-Id: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pedro Alvarez Piedehierro <palvarez89@gmail.com>

Sometimes the tar files will contain pax extended attributes to deal
with cases where the information needed doesn't fit in a standard
ustar entry.

One of these cases is when the path is larger than 100 characters. A
pax entry will appear containing two standard ustart entries. The first
entry will have an 'x' typeflag, and contain the the extended attributes.

The pax extended attributes contain one or multiple records constructed as
follows:

    "%d %s=%s\n", <length>, <keyword>, <value>

This commit makes sure that we always read the extended attibutes from
pax entries, and in the case of finding one, we parse its records
looking for 'path' information. If this information is found, it's
stored to be used in the next ustar entry.

Information about the Pax Interchange Format can be found at:

    https://www.freebsd.org/cgi/man.cgi?manpath=FreeBSD+8-current&query=tar&sektion=5.

Before this change, importing gcc tarballs[1] would fail with the
following error:

    fast-import crash report:
        fast-import process: 82899
        parent process     : 82897
        at 2018-05-21 12:35:27 +0000

    fatal: Unsupported command: 29 atime=1516870168.93527949

    Most Recent Commands Before Crash
    ---------------------------------
      M 644 :22495 gcc-7.3.0/libstdc++-v3/testsuite/20_util/duration/PaxHeaders.4467/comparison_operators
      M 644 :140367 gcc-7.3.0/gcc/ada/s-gloloc-mingw.adb
      M 644 :75143 gcc-7.3.0/gcc/testsuite/gcc.c-torture/execute/builtins/PaxHeaders.4467/strncat-chk-lib.c

      <snip>

      M 644 :135585 gcc-7.3.0/gcc/testsuite/c-c++-common/attr-warn-unused-result.c
      M 644 :54956 gcc-7.3.0/gcc/testsuite/go.test/test/fixedbugs/PaxHeaders.4467/bug335.dir
      M 644 :20632 27 mtime=1483272463.905435
    * 29 atime=1516870168.93527949

[1]: http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz

Signed-off-by: Pedro Alvarez <palvarez89@gmail.com>
---
 contrib/fast-import/import-tars.perl | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index d60b4315ed..c2e54ec7a3 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -63,6 +63,8 @@ foreach my $tar_file (@ARGV)
 	my $have_top_dir = 1;
 	my ($top_dir, %files);
 
+	my $next_path = '';
+
 	while (read(I, $_, 512) == 512) {
 		my ($name, $mode, $uid, $gid, $size, $mtime,
 			$chksum, $typeflag, $linkname, $magic,
@@ -70,6 +72,13 @@ foreach my $tar_file (@ARGV)
 			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
 			Z8 Z1 Z100 Z6
 			Z2 Z32 Z32 Z8 Z8 Z*', $_;
+
+		unless ($next_path eq '') {
+			# Recover name from previous extended header
+			$name = $next_path;
+			$next_path = '';
+		}
+
 		last unless length($name);
 		if ($name eq '././@LongLink') {
 			# GNU tar extension
@@ -90,13 +99,32 @@ foreach my $tar_file (@ARGV)
 			Z8 Z1 Z100 Z6
 			Z2 Z32 Z32 Z8 Z8 Z*', $_;
 		}
-		next if $name =~ m{/\z};
 		$mode = oct $mode;
 		$size = oct $size;
 		$mtime = oct $mtime;
 		next if $typeflag == 5; # directory
 
-		if ($typeflag != 1) { # handle hard links later
+		if ($typeflag eq 'x') { # extended header
+			# If extended header, check for path
+			my $pax_header = '';
+			while ($size > 0 && read(I, $_, 512) == 512) {
+				$pax_header = $pax_header . substr($_, 0, $size);
+				$size -= 512;
+			}
+
+			my @lines = split /\n/, $pax_header;
+			foreach my $line (@lines) {
+				my ($len, $entry) = split / /, $line;
+				my ($key, $value) = split /=/, $entry;
+				if ($key eq 'path') {
+					$next_path = $value;
+				}
+			}
+			next;
+		} elsif ($name =~ m{/\z}) {
+			# If it's a folder, ignore
+			next;
+		} elsif ($typeflag != 1) { # handle hard links later
 			print FI "blob\n", "mark :$next_mark\n";
 			if ($typeflag == 2) { # symbolic link
 				print FI "data ", length($linkname), "\n",
-- 
2.11.0

