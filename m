From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] gitweb: Simplify fixed string search
Date: Tue, 26 Feb 2008 13:22:07 +0100
Message-ID: <1204028528-18941-4-git-send-email-jnareb@gmail.com>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 13:23:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTypn-0001rJ-02
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbYBZMWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbYBZMWW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:22:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:13287 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYBZMWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:22:21 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1094884nfb.21
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bhv8hmRjz5S5Fzq/FT4mVzpObFElYvE10+0DStn/vyE=;
        b=Dg/VsQjsdMRDdmDDwqa+NcTFlyoii5iyB/O+K17nGbvndKEuQU+vvEkT8o7JTMo0sBWgNyeRgMDvl9T7y3JNgxGspE9qTwHz91T7MoOJ93f+lRu49ePG5zXcdD2T7xGnwB9u6LbVbXLr5ztGCmCdwWJDmC3+NBPbtlaFmp5NNtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tmnBz9slAVkjU1dJicHyGDGJ6cnYDtr9RfAV/IBVJX6UjZHYd/AhChcGZYAuWYx2Bk3SkSsC2PEnj+oF1bpAcrJRJB5Dd7YigCsvsoSU9D1ICCLyI9HQHa9JtEjbMmrhB4p7dOBswPEr3BGjK0rHTlt8lWKBrbhIwlRaM8Gs0MY=
Received: by 10.82.163.13 with SMTP id l13mr8713158bue.1.1204028539780;
        Tue, 26 Feb 2008 04:22:19 -0800 (PST)
Received: from localhost.localdomain ( [83.8.218.226])
        by mx.google.com with ESMTPS id c24sm10974988ika.10.2008.02.26.04.22.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 04:22:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1QCMBJH018972;
	Tue, 26 Feb 2008 13:22:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1QCMBjX018971;
	Tue, 26 Feb 2008 13:22:11 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75127>

Use '--fixed-strings' option to git-rev-list to simplify and improve
searching commit messages (commit search).  It allows to search for
example for "don't" successfully.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The second part of this chunk follows "correct style in neighborhood
of changes" idea.

 gitweb/gitweb.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b4b15a..90cf78e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5254,14 +5254,16 @@ sub git_search {
 		} elsif ($searchtype eq 'committer') {
 			$greptype = "--committer=";
 		}
-		$greptype .= $search_regexp;
-		my @commitlist = parse_commits($hash, 101, (100 * $page), undef, $greptype);
+		$greptype .= $searchtext;
+		my @commitlist = parse_commits($hash, 101, (100 * $page), undef,
+		                               $greptype, '--fixed-strings');
 
 		my $paging_nav = '';
 		if ($page > 0) {
 			$paging_nav .=
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
-				                       searchtext=>$searchtext, searchtype=>$searchtype)},
+				                       searchtext=>$searchtext,
+				                       searchtype=>$searchtype)},
 				        "first");
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(-replay=>1, page=>$page-1),
-- 
1.5.4.2
