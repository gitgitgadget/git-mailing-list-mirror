From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t9700/test.pl: backwards compatibility improvements
Date: Tue, 22 Jul 2008 16:16:05 -0500
Message-ID: <k-pcfapbFwwISYvjf34W3d-E7j-DCb9tf-MW1z8rFObaPKgPJEmD7Q@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPEn-0007b1-FF
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbYGVVQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756574AbYGVVQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:16:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54003 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbYGVVQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:16:23 -0400
Received: by mail.nrlssc.navy.mil id m6MLG52l020373; Tue, 22 Jul 2008 16:16:05 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:16:05.0629 (UTC) FILETIME=[26FDD2D0:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89534>

Some versions of perl complain when 'STDERR' is used as the third argument
in the 3-argument form of open(). Convert to the 2-argument form which is
described for duping STDERR in my second edition camel book.

The object oriented version of File::Temp is a rather new incarnation it
seems. The File::Temp man page for v5.8.0 says "(NOT YET IMPLEMENTED)" in
the 'Objects' section. These can be converted to use File::Temp::tempfile().

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9700/test.pl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 4d23125..70f9836 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -38,7 +38,7 @@ is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Failure cases for config:
 # Save and restore STDERR; we will probably extract this into a
 # "dies_ok" method and possibly move the STDERR handling to Git.pm.
-open our $tmpstderr, ">&", STDERR or die "cannot save STDERR"; close STDERR;
+open our $tmpstderr, ">&STDERR" or die "cannot save STDERR"; close STDERR;
 eval { $r->config("test.dupstring") };
 ok($@, "config: duplicate entry in scalar context fails");
 eval { $r->config_bool("test.boolother") };
@@ -69,18 +69,18 @@ is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",
 
 # objects and hashes
 ok(our $file1hash = $r->command_oneline('rev-parse', "HEAD:file1"), "(get file hash)");
-our $tmpfile = File::Temp->new;
+our ($tmpfile, $tmpnam) = File::Temp::tempfile();
 is($r->cat_blob($file1hash, $tmpfile), 15, "cat_blob: size");
 our $blobcontents;
 { local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
 is($blobcontents, "changed file 1\n", "cat_blob: data");
 seek $tmpfile, 0, 0;
-is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
-$tmpfile = File::Temp->new();
+is(Git::hash_object("blob", $tmpnam), $file1hash, "hash_object: roundtrip");
+($tmpfile, $tmpnam) = File::Temp::tempfile();
 print $tmpfile my $test_text = "test blob, to be inserted\n";
-like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
+like(our $newhash = $r->hash_and_insert_object($tmpnam), qr/[0-9a-fA-F]{40}/,
      "hash_and_insert_object: returns hash");
-$tmpfile = File::Temp->new;
+$tmpfile = File::Temp::tempfile();
 is($r->cat_blob($newhash, $tmpfile), length $test_text, "cat_blob: roundtrip size");
 { local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
 is($blobcontents, $test_text, "cat_blob: roundtrip data");
-- 
1.6.0.rc0.38.g8b8fb7
