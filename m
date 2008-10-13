From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 4/5] gitweb: parse parent..current syntax from PATH_INFO
Date: Mon, 13 Oct 2008 12:19:24 +0200
Message-ID: <1223893165-26022-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 12:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpKYf-0003xi-Bq
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763855AbYJMKTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763189AbYJMKTd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:19:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:25739 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763412AbYJMKTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:19:30 -0400
Received: by ey-out-2122.google.com with SMTP id 6so551093eyi.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pZtrCo6nX/nTab6rLltUO+ge6Y6loTdrMdKEUA+9FB0=;
        b=EKdWSli+mOdtZbSxZpcUnc8M/p1T8KLc7ZRHwaua+lwviB0udjJOU9DevK9bREvmQ1
         DqK+bWXUgxyxXDGgtUUcbTB4aS2xQZXkW8L/FVpN8fGlj5mykm4i446Vueh03KFDn3Br
         oRcOU0+FbDX0o/6BBgrjCdlv69JreEMjpFsCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iTp8WZfG5xBs/V3kzrsmakTj95Tcy7IeTFUR/T9ewYtJAEK0c0hA6XcU7ZztZHmVN1
         3JSiZ2adzSIDRwmIjxfTlJ4IXXOxti0OHm7B0AeCnYlnRsLvKQp9lDpE/grU+Mobr0Gh
         G5xS5qQs83oCjP4aswsuo9bgumqvKb24SEPBI=
Received: by 10.210.67.20 with SMTP id p20mr5262516eba.116.1223893169190;
        Mon, 13 Oct 2008 03:19:29 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id 5sm9630911eyf.8.2008.10.13.03.19.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 03:19:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1223893165-26022-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98106>

This patch makes it possible to use an URL such as
$project/somebranch..otherbranch:/filename to get a diff between
different version of a file. Paths like
$project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
as well.

All '*diff' actions and in general actions that use $hash_parent[_base]
and $file_parent can now get all of their parameters from PATH_INFO

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 49730f3..1a7b0b9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -548,7 +548,12 @@ sub evaluate_path_info {
 		'history',
 	);
 
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	# horrible regexp to catch
+	# [$hash_parent_base[:$file_parent]..]$hash_parent[:$file_name]
+	my ($parentrefname, $parentpathname, $refname, $pathname) = 
+		($path_info =~ /^(?:(.+?)(?::(.+))?\.\.)?(.+?)(?::(.+))?$/);
+
+	# first, analyze the 'current' part
 	if (defined $pathname) {
 		# we got "branch:filename" or "branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
@@ -557,7 +562,13 @@ sub evaluate_path_info {
 			$input_params{'action'} ||= "tree";
 			$pathname =~ s,/$,,;
 		} else {
-			$input_params{'action'} ||= "blob_plain";
+			# the default action depends on whether we had parent info
+			# or not
+			if ($parentrefname) {
+				$input_params{'action'} ||= "blobdiff_plain";
+			} else {
+				$input_params{'action'} ||= "blob_plain";
+			}
 		}
 		$input_params{'hash_base'} ||= $refname;
 		$input_params{'file_name'} ||= $pathname;
@@ -577,6 +588,27 @@ sub evaluate_path_info {
 			$input_params{'hash'} ||= $refname;
 		}
 	}
+
+	# next, handle the 'parent' part, if present
+	if (defined $parentrefname) {
+		# a missing pathspec defaults to the 'current' filename, allowing e.g.
+		# someproject/blobdiff/oldrev..newrev:/filename
+		if ($parentpathname) {
+			$parentpathname =~ s,^/+,,;
+			$parentpathname =~ s,/$,,;
+			$input_params{'file_parent'} ||= $parentpathname;
+		} else {
+			$input_params{'file_parent'} ||= $input_params{'file_name'};
+		}
+		# we assume that hash_parent_base is wanted if a path was specified,
+		# or if the action wants hash_base instead of hash
+		if (defined $input_params{'file_parent'} ||
+			grep($input_params{'action'}, @wants_base)) {
+			$input_params{'hash_parent_base'} ||= $parentrefname;
+		} else {
+			$input_params{'hash_parent'} ||= $parentrefname;
+		}
+	}
 }
 evaluate_path_info();
 
-- 
1.5.6.5
