From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 4/5] gitweb: parse parent..current syntax from PATH_INFO
Date: Thu, 16 Oct 2008 22:27:10 +0200
Message-ID: <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZSN-0000ID-0F
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbYJPU1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbYJPU1N
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:27:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:37082 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbYJPU1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:27:11 -0400
Received: by ey-out-2122.google.com with SMTP id 6so78348eyi.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6+mwhejpzTL2p/OI4mtVSkaNvjhVPhontbYjwvopQvA=;
        b=jm3j3jqJ/19b7dTnldbiztp0mnmMY+TF1Bg+5tHB/2ZHaAhtg/IXhJOkJAzjKc7cY+
         mu3/GU9hhwsVPFFDXJqROX07j29jO6HgrJ+xdjkuzMz/GFMgTGCul/wcpK0tJWWTGunE
         kNXrw3xuKHkU7ibqfvcH9i75Vww8dvrFbSTUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Pbi79zZ/vtnpMVa6MyKJ2g/uldvbiHs3Z/R+tSJci9583JbEXjxVjlPJPbonNb4n4G
         F9UUx15Rah56yZ2fXwJ36VFJwmK2pyc4ZVnE0wQtXZ6v/Y+eC726Pb76PkSsAadT5E7b
         FmPgU5N2nDTXk2ID9jjfcAlWN14ylFLo4NHhQ=
Received: by 10.210.67.4 with SMTP id p4mr3392971eba.174.1224188829376;
        Thu, 16 Oct 2008 13:27:09 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 3sm2504820eyj.3.2008.10.16.13.27.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:27:08 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98414>

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
+			grep {$input_params{'action'} eq $_} @wants_base) {
+			$input_params{'hash_parent_base'} ||= $parentrefname;
+		} else {
+			$input_params{'hash_parent'} ||= $parentrefname;
+		}
+	}
 }
 evaluate_path_info();
 
-- 
1.5.6.5
