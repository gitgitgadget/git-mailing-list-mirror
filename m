From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 6/7] gitweb: pass root directory as empty file parameter
Date: Sun, 15 Apr 2007 22:46:09 +0200
Message-ID: <11766699714077-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at> <1176669971694-git-send-email-mkoegler@auto.tuwien.ac.at> <1176669971921-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBcP-00044c-2Y
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbXDOUqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbXDOUqU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:46:20 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58496 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbXDOUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D016A7A4D1A3;
	Sun, 15 Apr 2007 22:46:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkZznMt5kQ-x; Sun, 15 Apr 2007 22:46:12 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2F3AC7A4D1A6; Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <1176669971921-git-send-email-mkoegler@auto.tuwien.ac.at>
Message-Id: <083c27614411a8fd7edafef8f5cba91625c88453.1176659095.git.mkoegler@auto.tuwien.ac.at>
In-Reply-To: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch add the automatic propagation of the file name from f to fp
for git_treeview, if fp is undefined. To distinguish it from the root
directory, allow an empty string for this in f/fp.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---

It was requested, that git_treediff should propagate f to fp, if the fp
parameter is missing. So I created this patch.

As any other path could be a valid blob, I use the empty string for
the root directory.

As I personally don't like this, I have split this change into a
seperate patch:

* As git_treediff is new code, not propagating f->fp would not break any
  existing urls. 

* The f->fp propagation currently only happens in blobdiff (The only
  place, where fp is used). Is this enough to make it the standard
  gitweb parameter convention?

* The root tree is specified in git_tree with an missing f parameter.

* I don't know all security implication, if an empty file name is
  passed to all existing git function.

So I would like to drop this patch and pass the root directory as
missing f/fp parameter, which does not allow propagating f to fp.

Comments from other on this topic?

 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 769e755..e4d3f8f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -310,14 +310,14 @@ if (defined $project) {
 }
 
 our $file_name = $cgi->param('f');
-if (defined $file_name) {
+if (defined $file_name && $file_name ne '') {
 	if (!validate_pathname($file_name)) {
 		die_error(undef, "Invalid file parameter");
 	}
 }
 
 our $file_parent = $cgi->param('fp');
-if (defined $file_parent) {
+if (defined $file_parent && $file_parent ne '') {
 	if (!validate_pathname($file_parent)) {
 		die_error(undef, "Invalid file parent parameter");
 	}
@@ -4203,6 +4203,10 @@ sub git_treediff {
 					"raw");
 	}
 
+	$file_parent = $file_name if (!defined $file_parent);
+	$file_name = undef if(defined $file_name && $file_name eq '');
+	$file_parent = undef if(defined $file_parent && $file_parent eq '');
+
 	if (!defined $hash) {
 		if (!defined $hash_base) {
 			die_error(undef,'tree parameter missing');
-- 
1.5.1.1.85.gf1888
