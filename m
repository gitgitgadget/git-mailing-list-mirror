From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: parse parent..current syntax from pathinfo
Date: Mon, 29 Sep 2008 17:26:56 +0200
Message-ID: <1222702017-4496-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222702017-4496-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222702017-4496-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222702017-4496-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 17:28:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKfD-0003R0-VJ
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYI2P0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbYI2P0o
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:26:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbYI2P0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:26:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1465125fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4KPAL9q3H9GqFAxeL97w8xw6ABKlgO+XgFKuXSmjf8Y=;
        b=yAudFGUPHHRQHnulWyR55Ri4Uo2pJq+yjbu48XB8dITGKpss+GHKd5QrUgHrqCTt2o
         aWFYzspCV5QoFUfs53HICKnykxHtpgOrNPOdRZR3ABDcOQbjngxoO54Ata2qeXQ3fTCc
         3Z7kLGI2PU7nxDshzYsJjBw1ZmHevU8216kjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nkHbzbfLYmVkzNmvSTuawmtwhHyShYUdDpJUMHJ+fH0GdBTAQ8w176weV6I0uKghlf
         EFeVHJtC9YWGla/gGJLIPwHZ7xVLOuWcDpjpfTSDRzkeKzfuKvq2IUdJK5ovSBzaDllk
         9sgFexMzdfVPnnvzgXe1RE31uzEnGiwn6y2Sw=
Received: by 10.181.2.2 with SMTP id e2mr2449367bki.3.1222702002269;
        Mon, 29 Sep 2008 08:26:42 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id b17sm312573fka.7.2008.09.29.08.26.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 08:26:41 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222702017-4496-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97021>

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
index 75d4178..7b4f2d3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -560,7 +560,9 @@ sub evaluate_path_info {
 		$action  = undef;
 	}
 
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	$path_info =~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?$/;
+	my ($parentrefname, $parentpathname, $refname, $pathname) = (
+		$2, $4, $5, $7);
 	if (defined $pathname) {
 		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
@@ -569,7 +571,11 @@ sub evaluate_path_info {
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
@@ -579,6 +585,22 @@ sub evaluate_path_info {
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
