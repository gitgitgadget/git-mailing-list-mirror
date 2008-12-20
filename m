From: Junio C Hamano <gitster@pobox.com>
Subject: [Security] gitweb local privilege escalation (fix)
Date: Fri, 19 Dec 2008 22:46:51 -0800
Message-ID: <7vhc4z1gys.fsf@gitster.siamese.dyndns.org>
References: <7vljub1h92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753697AbYLTGrW@vger.kernel.org Sat Dec 20 07:49:01 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753697AbYLTGrW@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvdp-0002DW-3R
	for glk-linux-kernel-3@gmane.org; Sat, 20 Dec 2008 07:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYLTGrW (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 20 Dec 2008 01:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYLTGrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2008 01:47:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbYLTGrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2008 01:47:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 789B089D71;
	Sat, 20 Dec 2008 01:46:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B6CFC89D70; Sat,
 20 Dec 2008 01:46:53 -0500 (EST)
In-Reply-To: <7vljub1h92.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Dec 2008 22:40:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00199D3E-CE62-11DD-9A9C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103624>

--=-=-=

Current gitweb has a possible local privilege escalation bug that allows a
malicious repository owner to run a command of his choice by specifying
diff.external configuration variable in his repository and running a
crafted gitweb query.

Recent (post 1.4.3) gitweb itself never generates a link that would result
in such a query, and the safest and cleanest fix to this issue is to
simply drop the support for it.  Maintenance release v1.6.0.6, v1.5.6.6,
v1.5.5.6 and v1.5.4.7 are already available at k.org (see the announcement
for v1.6.0.6 I sent out a few minutes ago), and the master branch and
others pushed out tonight have the same fix.

This message contains two patches (credits go to Matt McCutchen, Jeff King
and Jakub Narebski) to do the fix yourself:

 (1) for Git 1.5.4.X, 1.5.5.X, and 1.5.6.X, and

 (2) for Git 1.6.0.X.

Distro packagers and people on the vendor security list have been notified
about this fix earlier this week; people running gitweb from vendor
supplied binaries should be able to get updates from them as well.


--=-=-=
Content-Disposition: attachment; filename=0001-hotfix-1.5.456.X.txt
Content-Description: gitweb hotfix for 1.5.[456].X series

>From dfff4b7aa42de7e7d58caeebe2c6128449f09b76 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 16 Dec 2008 19:42:02 -0800
Subject: [PATCH] gitweb: do not run "git diff" that is Porcelain

Jakub says that legacy-style URI to view two blob differences are never
generated since 1.4.3.  This codepath runs "git diff" Porcelain from the
gitweb, which is a no-no.  It can trigger diff.external command that is
specified in the configuration file of the repository being viewed.

This patch applies to v1.5.4 and later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |   38 ++------------------------------------
 1 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b582332..86a6ced 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4809,43 +4809,9 @@ sub git_blobdiff {
 			or die_error(undef, "Open git-diff-tree failed");
 	}
 
-	# old/legacy style URI
-	if (!%diffinfo && # if new style URI failed
-	    defined $hash && defined $hash_parent) {
-		# fake git-diff-tree raw output
-		$diffinfo{'from_mode'} = $diffinfo{'to_mode'} = "blob";
-		$diffinfo{'from_id'} = $hash_parent;
-		$diffinfo{'to_id'}   = $hash;
-		if (defined $file_name) {
-			if (defined $file_parent) {
-				$diffinfo{'status'} = '2';
-				$diffinfo{'from_file'} = $file_parent;
-				$diffinfo{'to_file'}   = $file_name;
-			} else { # assume not renamed
-				$diffinfo{'status'} = '1';
-				$diffinfo{'from_file'} = $file_name;
-				$diffinfo{'to_file'}   = $file_name;
-			}
-		} else { # no filename given
-			$diffinfo{'status'} = '2';
-			$diffinfo{'from_file'} = $hash_parent;
-			$diffinfo{'to_file'}   = $hash;
-		}
-
-		# non-textual hash id's can be cached
-		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
-
-		# open patch output
-		open $fd, "-|", git_cmd(), "diff", @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent, $hash, "--"
-			or die_error(undef, "Open git-diff failed");
-	} else  {
+	# old/legacy style URI -- not generated anymore since 1.4.3.
+	if (!%diffinfo) {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
-			unless %diffinfo;
 	}
 
 	# header
-- 
1.6.1.rc3.19.g66a9


--=-=-=
Content-Disposition: attachment; filename=0002-gitweb-hotfix-1.6.0.X.txt
Content-Description: gitweb hotfix for 1.6.0.X series

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ced7bb7..804670c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4863,43 +4863,9 @@ sub git_blobdiff {
 			or die_error(500, "Open git-diff-tree failed");
 	}
 
-	# old/legacy style URI
-	if (!%diffinfo && # if new style URI failed
-	    defined $hash && defined $hash_parent) {
-		# fake git-diff-tree raw output
-		$diffinfo{'from_mode'} = $diffinfo{'to_mode'} = "blob";
-		$diffinfo{'from_id'} = $hash_parent;
-		$diffinfo{'to_id'}   = $hash;
-		if (defined $file_name) {
-			if (defined $file_parent) {
-				$diffinfo{'status'} = '2';
-				$diffinfo{'from_file'} = $file_parent;
-				$diffinfo{'to_file'}   = $file_name;
-			} else { # assume not renamed
-				$diffinfo{'status'} = '1';
-				$diffinfo{'from_file'} = $file_name;
-				$diffinfo{'to_file'}   = $file_name;
-			}
-		} else { # no filename given
-			$diffinfo{'status'} = '2';
-			$diffinfo{'from_file'} = $hash_parent;
-			$diffinfo{'to_file'}   = $hash;
-		}
-
-		# non-textual hash id's can be cached
-		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
-
-		# open patch output
-		open $fd, "-|", git_cmd(), "diff", @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent, $hash, "--"
-			or die_error(500, "Open git-diff failed");
-	} else  {
-		die_error(400, "Missing one of the blob diff parameters")
-			unless %diffinfo;
+	# old/legacy style URI -- not generated anymore since 1.4.3.
+	if (!%diffinfo) {
+		die_error('404 Not Found', "Missing one of the blob diff parameters")
 	}
 
 	# header

--=-=-=--
