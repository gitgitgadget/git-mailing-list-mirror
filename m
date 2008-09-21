From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/6] gitweb: parse parent..current syntax from pathinfo
Date: Sun, 21 Sep 2008 22:57:40 +0200
Message-ID: <1222030663-22540-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW15-0002jI-VJ
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYIUU5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYIUU5k
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19442 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbYIUU5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so407275nfc.21
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Oi/fpGKmCP6igRokO8167dCR4mtAoaqhrjs3lfslPO4=;
        b=CA1ERC6TDgy/JN+GhgqxX5TIpVEI1hJ7RzjOk9lZjRqHNw0POS/5QmtS+GZ8cYrLpf
         NyPEjme84rPZmi9crrZjYhGdYBBMdksz5TJWu/18scr7Vyx5rNeGDNWR3zvij/mKr6KA
         +KNOAEOhCKqvCwW5Bac5/8tLV9m9iGCneDApw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mokpENf40UwhrexTMVTwgPPEzvhbT22lA9gMjLo6hCKYJjmfk04qUftJBekoOuuO4Q
         z1xt6l1SfVV+JfB0Rv2+2yr0n0ziOF59YkRPo3B5DAc+3bsoYQ61FD+jVXJB5sGayljc
         h3nb2fxsCrmLpncl7zXeO/fZoVmlhwA1bQzZQ=
Received: by 10.210.27.14 with SMTP id a14mr3838208eba.63.1222030657295;
        Sun, 21 Sep 2008 13:57:37 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 23sm6188891eya.7.2008.09.21.13.57.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96434>

This makes it possible to use an URL such as
$project/somebranch..otherbranch:/filename to get a diff between
different version of a file. Paths like
$project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
as well.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 18da484..9868bf4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -553,7 +553,9 @@ sub evaluate_path_info {
 		$action  = undef;
 	}
 
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	$path_info =~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?$/;
+	my ($parentrefname, $parentpathname, $refname, $pathname) = (
+		$2, $4, $5, $7);
 	if (defined $pathname) {
 		# we got "project.git/branch:filename" or "project.git/branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
@@ -562,7 +564,11 @@ sub evaluate_path_info {
 			$action  ||= "tree";
 			$pathname =~ s,/$,,;
 		} else {
-			$action  ||= "blob_plain";
+			if ($parentrefname) {
+				$action ||= "blobdiff_plain";
+			} else {
+				$action  ||= "blob_plain";
+			}
 		}
 		$hash_base ||= validate_refname($refname);
 		$file_name ||= validate_pathname($pathname);
@@ -573,6 +579,22 @@ sub evaluate_path_info {
 		$hash      ||= validate_refname($refname);
 		$hash_base ||= validate_refname($refname);
 	}
+	# the parent part might be missing the pathname, in which case we use the $file_name, if present
+	if (defined $parentrefname) {
+		$hash_parent_base ||= validate_refname($parentrefname);
+		if ($parentpathname) {
+			$parentpathname =~ s,^/+,,;
+			$parentpathname =~ s,/$,,;
+			$file_parent ||= validate_pathname($parentpathname);
+		} else {
+			$file_parent ||= $file_name
+		}
+		if (defined $file_parent) {
+			$hash_parent ||= git_get_hash_by_path($hash_parent_base, $file_parent);
+		} else {
+			$hash_parent ||= validate_refname($parentrefname);
+		}
+	}
 }
 evaluate_path_info();
 
-- 
1.5.6.5
