From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: Support comparing blobs with different names
Date: Sun, 25 Mar 2007 22:34:18 +0200
Message-ID: <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZQ5-0003Ft-71
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbXCYUeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXCYUeZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:34:25 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60103 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbXCYUeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 98BF7735D74D;
	Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qf2eMxK4KzDD; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 565B6735D744; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43064>

Currently, blobdiff can only compare blobs with diffenrent file
names, if no hb/hpb parameters are present.

This patch adds support for comparing two blobs specified by hb/f
and hpb/fp.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fbadab4..e3c2918 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3882,9 +3882,34 @@ sub git_blobdiff {
 	my %diffinfo;
 	my $expires;
 
+	if (defined $hash_base && defined $hash_parent_base &&
+	    defined $file_name && defined $file_parent) {
+
+		$diffinfo{'from_mode'} = $diffinfo{'to_mode'} = "blob";
+		$diffinfo{'from_file'} = $file_parent;
+		$diffinfo{'to_file'}   = $file_name;
+		$diffinfo{'status'} = '2';
+
+		if (defined $hash) {
+		    $diffinfo{'to_id'}   = $hash;
+		} else {
+		    $diffinfo{'to_id'}   = git_get_hash_by_path($hash_base, $file_name);
+		}
+		if (defined $hash_parent) {
+		    $diffinfo{'from_id'}   = $hash_parent;
+		} else {
+		    $diffinfo{'from_id'}   = git_get_hash_by_path($hash_parent_base, $file_parent);
+		}
+
+		# open patch output
+		open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts,
+			$hash_parent_base.":".$file_parent, $hash_base.":".$file_name, "--"
+			or die_error(undef, "Open git-diff failed");
+	}
+
 	# preparing $fd and %diffinfo for git_patchset_body
 	# new style URI
-	if (defined $hash_base && defined $hash_parent_base) {
+	if (defined $hash_base && defined $hash_parent_base && !%diffinfo) {
 		if (defined $file_name) {
 			# read raw output
 			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
1.5.1.rc1.51.gb08b-dirty
