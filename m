From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: parse parent..current syntax from pathinfo
Date: Wed,  3 Sep 2008 11:57:17 +0200
Message-ID: <1220435839-29360-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kap8Q-0000SL-IJ
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYICJ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYICJ5h
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:57:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:39013 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYICJ5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:57:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2146168fkq.5
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0jCMaNyA17xTuAcnrjAaVPQpDTQ1etN0IUK0f0MknPo=;
        b=B0hdDmb0n9TbCrWiSZUWF4rph6BouTad09AcsR4R0v/aJ5MW3jjGqZDcm3VogeorSX
         RWe7dLq4I6bJ5LktDTzXi97K3E7Hz6nGgzYjRjHpuq9ENCddurirKhgSsIEF4vmZ1XQO
         kzv7YsaS+XJlJZ5QGlIK5r9dQnl+SzmrvlSZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i3phmdsfM2YCeQrYywZKoA8IWxTlWKxBLTiu0hqaKHV3EFPlsurhFiPzDc4yxc6n9x
         WJankRbJE0P5um0oL7LkwBOV5YlCIhX06vTKNuA9oL5iemxt0lx4wUZrMblYloXtyCGk
         Klgxh6ZZZ4H8ZCaLuR8KkxRofnPZdy2N/HH10=
Received: by 10.180.252.8 with SMTP id z8mr6723711bkh.82.1220435854008;
        Wed, 03 Sep 2008 02:57:34 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id k5sm47758306nfh.0.2008.09.03.02.57.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:57:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1220435839-29360-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94777>

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
index 9d4952f..3d21624 100755
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
