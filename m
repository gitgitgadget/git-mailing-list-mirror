From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] t9700/test.pl: remove File::Temp requirement
Date: Mon, 15 Sep 2008 11:25:22 -0500
Message-ID: <dQSOPLs4uHkUBp4B1ZT4QbBf2xm6SluHuVl0M4fikzSgHUtgDcJXiQ@cipher.nrlssc.navy.mil>
References: <uWiPWIPu6IKkVafz9wdZ-sRK84QZuJQNOZM80bkfw24NxsVT-Z3J9g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 18:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfGuK-0005i2-LR
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbYIOQZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbYIOQZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:25:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56942 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbYIOQZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 12:25:25 -0400
Received: by mail.nrlssc.navy.mil id m8FGPMQC008329; Mon, 15 Sep 2008 11:25:22 -0500
In-Reply-To: <uWiPWIPu6IKkVafz9wdZ-sRK84QZuJQNOZM80bkfw24NxsVT-Z3J9g@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Sep 2008 16:25:22.0725 (UTC) FILETIME=[A6EE2550:01C9174F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95918>

The object oriented version of File::Temp is a rather new incarnation it
seems. The File::Temp man page for v5.8.0 says "(NOT YET IMPLEMENTED)" in
the 'Objects' section. Instead of creating a file with a unique name in
the system TMPDIR, we can create our own temporary file with a static
name and use that instead.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9700/test.pl |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index f777b08..9908109 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -8,7 +8,6 @@ use strict;
 use Test::More qw(no_plan);
 
 use Cwd;
-use File::Temp;
 
 BEGIN { use_ok('Git') }
 
@@ -65,21 +64,25 @@ is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",
 
 # objects and hashes
 ok(our $file1hash = $r->command_oneline('rev-parse', "HEAD:file1"), "(get file hash)");
-our $tmpfile = File::Temp->new;
-is($r->cat_blob($file1hash, $tmpfile), 15, "cat_blob: size");
+my $tmpfile = "file.tmp";
+open TEMPFILE, "+>$tmpfile" or die "Can't open $tmpfile: $!";
+is($r->cat_blob($file1hash, \*TEMPFILE), 15, "cat_blob: size");
 our $blobcontents;
-{ local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
+{ local $/; seek TEMPFILE, 0, 0; $blobcontents = <TEMPFILE>; }
 is($blobcontents, "changed file 1\n", "cat_blob: data");
-seek $tmpfile, 0, 0;
+close TEMPFILE or die "Failed writing to $tmpfile: $!";
 is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
-$tmpfile = File::Temp->new();
-print $tmpfile my $test_text = "test blob, to be inserted\n";
+open TEMPFILE, ">$tmpfile" or die "Can't open $tmpfile: $!";
+print TEMPFILE my $test_text = "test blob, to be inserted\n";
+close TEMPFILE or die "Failed writing to $tmpfile: $!";
 like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
      "hash_and_insert_object: returns hash");
-$tmpfile = File::Temp->new;
-is($r->cat_blob($newhash, $tmpfile), length $test_text, "cat_blob: roundtrip size");
-{ local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
+open TEMPFILE, "+>$tmpfile" or die "Can't open $tmpfile: $!";
+is($r->cat_blob($newhash, \*TEMPFILE), length $test_text, "cat_blob: roundtrip size");
+{ local $/; seek TEMPFILE, 0, 0; $blobcontents = <TEMPFILE>; }
 is($blobcontents, $test_text, "cat_blob: roundtrip data");
+close TEMPFILE;
+unlink $tmpfile;
 
 # paths
 is($r->repo_path, "./.git", "repo_path");
-- 
1.6.0.1.244.gdc19
