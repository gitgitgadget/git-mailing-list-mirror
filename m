From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 4/5] gitweb: parse parent..current syntax from PATH_INFO
Date: Tue, 21 Oct 2008 21:34:53 +0200
Message-ID: <1224617694-29277-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:36:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsN1l-0004hL-UZ
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYJUTeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYJUTeo
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:34:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:6888 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYJUTen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:34:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so43301fgg.17
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0py4CPamgbWfldfNW3eKvhDWh9zO7H3sbewIFBuDKkc=;
        b=n6KzRoN6sBR9UtMHbuRzayNEDnDgHnyNBdoo4nCEOuB9p4G6Pb/uQ1TGwgK0vOo+4m
         vRQ0YWeBJX8e953pByavd+8axCvBO26FQoKbC2We/SQ3OEk8PtVWmeF+6C0bSpAoISkr
         oDieoiskr4BzTphG3lZMBJ6VbcVESUpTWHADU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eEJKi2oXNApaDsbuAMlgnhqloBJB1FiSLVhHa6DVn2/1KiVSxf1l/ilCYOA1YL1CDo
         azMm8OgFknyR0GCZ+/aud1i0iSiTm5JhoDUvtXgxByUl3/8RKPjEJPyoT+3serFvaXfu
         w+/VMY3QkgmTyioxcXZGmYBU2VHf2HGYwkoB0=
Received: by 10.180.250.5 with SMTP id x5mr1269464bkh.145.1224617682164;
        Tue, 21 Oct 2008 12:34:42 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 22sm17427187fkr.4.2008.10.21.12.34.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 12:34:41 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224617694-29277-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98808>

This patch makes it possible to use an URL such as
project/action/somebranch..otherbranch:/filename to get a diff between
different version of a file. Paths like
project/action/somebranch:/somefile..otherbranch:/otherfile are parsed
as well.

All '*diff' actions and in general actions that use $hash_parent[_base]
and $file_parent (e.g. 'shortlog') can now get all of their parameters
from PATH_INFO

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9da547d..59449de 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -549,7 +549,12 @@ sub evaluate_path_info {
 		'history',
 	);
 
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	# we want to catch
+	# [$hash_parent_base[:$file_parent]..]$hash_parent[:$file_name]
+	my ($parentrefname, $parentpathname, $refname, $pathname) =
+		($path_info =~ /^(?:(.+?)(?::(.+))?\.\.)?(.+?)(?::(.+))?$/);
+
+	# first, analyze the 'current' part
 	if (defined $pathname) {
 		# we got "branch:filename" or "branch:dir/"
 		# we could use git_get_type(branch:pathname), but:
@@ -564,7 +569,13 @@ sub evaluate_path_info {
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
@@ -584,6 +595,27 @@ sub evaluate_path_info {
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
+			grep { $_ eq $input_params{'action'} } @wants_base) {
+			$input_params{'hash_parent_base'} ||= $parentrefname;
+		} else {
+			$input_params{'hash_parent'} ||= $parentrefname;
+		}
+	}
 }
 evaluate_path_info();
 
-- 
1.5.6.5
