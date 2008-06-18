From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 07:37:04 -0600
Message-ID: <1213796224-995-1-git-send-email-michael@ndrix.org>
Cc: git@vger.kernel.org, Michael Hendricks <michael@ndrix.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 18 15:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8yA8-0001Cn-3t
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 15:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYFRN4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 09:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbYFRN4G
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 09:56:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38270 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750712AbYFRN4F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 09:56:05 -0400
X-Greylist: delayed 1136 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jun 2008 09:56:04 EDT
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 136BA1235E9;
	Wed, 18 Jun 2008 09:37:07 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 18 Jun 2008 09:37:07 -0400
X-Sasl-enc: qR2ZoTc4+aNEHtPOG6sMTFpf58QC5QiHgRszQeQ5mM9V 1213796226
Received: from ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FFBC39293;
	Wed, 18 Jun 2008 09:37:06 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.23.g2a5fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85379>

Instead of using IO::String to create an in-memory filehandle, use
open() with a scalar reference as the filename.  This feature has been
available since Perl 5.8.0 (which was released in 2002), so it should
be available pretty much everywhere by now.

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---

This patch should apply on top of Junio's lw/perlish branch.

 t/t9700/test.pl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 8318fec..e34c01e 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -9,7 +9,6 @@ use Test::More qw(no_plan);
 use Cwd;
 use File::Basename;
 use File::Temp;
-use IO::String;
 
 BEGIN { use_ok('Git') }
 
@@ -69,20 +68,21 @@ is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",
 
 # objects and hashes
 ok(our $file1hash = $r->command_oneline('rev-parse', "HEAD:file1"), "(get file hash)");
-our $iostring = IO::String->new;
+my $output;
+open our $iostring, '>', \$output;
 is($r->cat_blob($file1hash, $iostring), 15, "cat_blob: size");
-is(${$iostring->string_ref}, "changed file 1\n", "cat_blob: data");
+is($output, "changed file 1\n", "cat_blob: data");
 our $tmpfile = File::Temp->new();
-print $tmpfile ${$iostring->string_ref};
+print $tmpfile $output;
 is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
 $tmpfile = File::Temp->new();
 print $tmpfile my $test_text = "test blob, to be inserted\n";
 $tmpfile->close;
 like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
      "hash_and_insert_object: returns hash");
-$iostring = IO::String->new;
+open $iostring, '>', \$output;
 is($r->cat_blob($newhash, $iostring), length $test_text, "cat_blob: roundtrip size");
-is(${$iostring->string_ref}, $test_text, "cat_blob: roundtrip data");
+is($output, $test_text, "cat_blob: roundtrip data");
 
 # paths
 is($r->repo_path, "./.git", "repo_path");
-- 
1.5.5.23.g2a5fe
