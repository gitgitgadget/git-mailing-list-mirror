From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX)] gitweb: Fix "Use of uninitialized value" error in 'history' view
Date: Fri, 4 Apr 2008 15:23:42 +0100
Message-ID: <200804041623.44595.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 16:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhmqK-0007pV-3U
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 16:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYDDOXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 10:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYDDOXv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 10:23:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:44608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYDDOXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 10:23:50 -0400
Received: by ug-out-1314.google.com with SMTP id z38so50917ugc.16
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=L0CE64KDwNIDvyZyutFTMxvCHglwYNoIFGonOJHSvkc=;
        b=QTAHN54gMCEWY/qNeFPOQeU3G/7zGnCGRO/ofyilNt/EDAapW90Go6HYK1DpzwuhItqntDA6u3Jor9jKuvfbLKuMgwbXVlcp1D1X2+FdPwtQlhBwbmogPLP1M4UcP80Uop3ahYcM+1CCh2aXpaQd62BjdDhyNbVxWWh5QXZdpuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uHM/9r7nCv7pxjcy0qZggvaAINZwnYrqXSnXIvrsEjHgvyOkDFyWBxQLM6TGGSQNRTjavFSa2gooRQXTVOla5o/bIY7bfhGIwfKbItn6GeJ3U0ndYGQajiOYLX341itAu9F66CketLUnXO1ftug7gR/OClEX3RODM953HXTXP7k=
Received: by 10.67.115.17 with SMTP id s17mr778169ugm.56.1207319028785;
        Fri, 04 Apr 2008 07:23:48 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.217.217])
        by mx.google.com with ESMTPS id q40sm9811263ugc.70.2008.04.04.07.23.46
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Apr 2008 07:23:47 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78806>

When asked for history of a file with no $hash ('h') parameter set,
and which file is not present in current branch ("HEAD" or given by
$hash_hase ('hb') parameter), but is present deeper in the full
history of a branch, gitweb would spew multiple of "Use of
uninitialized value" warnings, and some links would be missing.
This commit fixes this bug.

This bug occurs in the rare cases when "git log -- <path>" is empty
and "git log --full-history -- <path>" is not.  Gitweb tried to get
file type (it means if it is 'tree' or 'blob' or even 'commit', as
'history' view is for single path which can be any of given types)
from the commit we start searching from, and not among found commits.

While we are it, return error if there is _no_ history; it means that
file or directory was not found (for given branch).  Also error out if
type of item could not be found: it should not happen now, but better
be sure.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There should be no noticeable changes in performance for situation
when bug described above does not occur; gitweb would use one git
command invocation than strictly necessary in the situation which
previosly generated bug.  As it should be rare situation (handcrafted
URL, or "current version" URL for file which got deleted) I think it
is not worth complicating the code to avoid it.

BTW. the t9500-gitweb-standalone-no-errors test does not catch this
bug, unfortunately...

 gitweb/gitweb.perl |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 50922bc..1be75c6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5238,14 +5238,26 @@ sub git_history {
 	my $refs = git_get_references();
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 
+	my @commitlist = parse_commits($hash_base, 101, (100 * $page),
+	                               $file_name, "--full-history");
+	if (!@commitlist) {
+		die_error(undef, "No such path");
+	}
+
 	if (!defined $hash && defined $file_name) {
-		$hash = git_get_hash_by_path($hash_base, $file_name);
+		# some commits could have deleted file in question,
+		# and not have it in tree, but one of them has to have it
+		for (my $i = 0; $i <= @commitlist; $i++) {
+			$hash = git_get_hash_by_path($commitlist[$i]{'id'}, $file_name);
+			last if defined $hash;
+		}
 	}
 	if (defined $hash) {
 		$ftype = git_get_type($hash);
 	}
-
-	my @commitlist = parse_commits($hash_base, 101, (100 * $page), $file_name, "--full-history");
+	if (!defined $ftype) {
+		die_error(undef, "Unknown type of object");
+	}
 
 	my $paging_nav = '';
 	if ($page > 0) {
-- 
1.5.4.4
