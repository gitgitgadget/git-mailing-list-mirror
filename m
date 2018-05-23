Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803441F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935016AbeEWWyf (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:54:35 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34138 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934895AbeEWWye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:54:34 -0400
Received: from 79-74-250-18.dynamic.dsl.as9105.com ([79.74.250.18] helo=localhost.localdomain)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fLceO-0003md-J5; Wed, 23 May 2018 23:54:32 +0100
From:   Pedro Alvarez <pedro.alvarez@codethink.co.uk>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Pedro Alvarez Piedehierro <palvarez89@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/1] import-tars: read overlong names from pax extended header
Date:   Wed, 23 May 2018 23:54:17 +0100
Message-Id: <20180523225417.10165-2-pedro.alvarez@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523225417.10165-1-pedro.alvarez@codethink.co.uk>
References: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
 <20180523225417.10165-1-pedro.alvarez@codethink.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pedro Alvarez Piedehierro <palvarez89@gmail.com>

Importing gcc tarballs[1] with import-tars script (in contrib) fails
when hitting a pax extended header.

Make sure we always read the extended attributes from the pax entries,
and store the 'path' value if found to be used in the next ustar entry.

The code to parse pax extended headers was written consulting the Pax
Pax Interchange Format documentation [2].

[1] http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz
[2] https://www.freebsd.org/cgi/man.cgi?manpath=FreeBSD+8-current&query=tar&sektion=5

Signed-off-by: Pedro Alvarez <palvarez89@gmail.com>
---
 contrib/fast-import/import-tars.perl | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index d60b4315ed..e800d9f5c9 100755
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
@@ -90,13 +99,31 @@ foreach my $tar_file (@ARGV)
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
+		} elsif ($name =~ m{/\z}) { # directory
+			next;
+		} elsif ($typeflag != 1) { # handle hard links later
 			print FI "blob\n", "mark :$next_mark\n";
 			if ($typeflag == 2) { # symbolic link
 				print FI "data ", length($linkname), "\n",
-- 
2.11.0

