From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] gitweb: parse parent..current syntax from pathinfo
Date: Sat,  2 Aug 2008 00:17:10 +0200
Message-ID: <1217629031-14894-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1217622913-9747-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 00:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2wh-00056c-Ur
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbYHAWQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbYHAWQ6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:16:58 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:44727 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbYHAWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 18:16:57 -0400
Received: by qb-out-0506.google.com with SMTP id a16so1189432qbd.17
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LzK4Im0GDubK39AAl65pal6Mp4Nz9Nhpeg7nUVHilKI=;
        b=UYT17ySAKyxy9oVc89JLBQwPFW+bTrk8/So2LFOp6U04Z7bjYnQC2JhzewfPVaUfrj
         fwdA6iG3ehvcx4SXUDSLCdG+Vdf+LA54fewyfWWgdVmo7x0TkH9HMQfEQnDVTXsIqZFj
         o7tJTlqGC7Qnffvu5GLm98G8wS1mWzGaE2yH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PegnTCkbylYruQg800RBwVindXzFe3lEbcGnNNiO2JfDSdNDrk9BY+ncq5zX+c4e4K
         LrnbV0UOytGLYAzMmapjC7OGY3ynLsVr+JT5OPvruTOn2zheFLiA7YZORKK2fEYL3t+c
         FQvH7prwRBWm0+wCSMdS6Azj+mJNbkJSTiNn0=
Received: by 10.181.2.2 with SMTP id e2mr4257824bki.49.1217629015865;
        Fri, 01 Aug 2008 15:16:55 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id 28sm1780083fkx.1.2008.08.01.15.16.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 15:16:55 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1217622913-9747-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91109>

This makes it possible to use an URL such as
$project/somebranch..otherbranch:/filename to get a diff between
different version of a file. Paths like
$project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
as well.
---

This patch and the next apply on top of my previous two
gitweb pathinfo patches. 

I realize that these patches of mine coming through in burst
can get pretty annoying, but I honestly wasn't planning of
making so many changes to the path info feature. So let me
know if it's better to resend the patches in a series.

Hopefully, with this patch and the next the series should be
complete, as most commands will now be able to get all of
their parameters from the path without using CGI parameters.

 gitweb/gitweb.perl |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9e90017..8364b71 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -578,7 +578,9 @@ sub evaluate_path_info {
 		$action  = undef;
 	}
 
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	$path_info =~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?$/;
+	my ($parentrefname, $parentpathname, $refname, $pathname) = (
+		$2, $4, $5, $7);
 	if (defined $pathname) {
 		# we got "project.git/branch:filename" or "project.git/branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
@@ -587,11 +589,27 @@ sub evaluate_path_info {
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
 		$hash      ||= git_get_hash_by_path($hash_base, $file_name);
+
+		if ($parentrefname) {
+			$hash_parent_base ||= validate_refname($parentrefname);
+			if ($parentpathname) {
+				$parentpathname =~ s,^/+,,;
+				$parentpathname =~ s,/$,,;
+				$file_parent ||= validate_pathname($parentpathname);
+			} else {
+				$file_parent ||= $file_name
+			}
+			$hash_parent ||= git_get_hash_by_path($hash_parent_base, $file_parent);
+		}
 	} elsif (defined $refname) {
 		# we got "project.git/branch"
 		$action    ||= "shortlog";
-- 
1.5.6.3
