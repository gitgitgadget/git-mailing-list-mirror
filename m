From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] gitweb: filter escapes from longer commit titles that break firefox
Date: Fri, 17 Apr 2009 12:24:33 -0400
Message-ID: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 18:27:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luqtu-0002LV-EF
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 18:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761413AbZDQQYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760836AbZDQQYr
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 12:24:47 -0400
Received: from mail.windriver.com ([147.11.1.11]:54636 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760409AbZDQQYq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 12:24:46 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n3HGOj7C008179
	for <git@vger.kernel.org>; Fri, 17 Apr 2009 09:24:45 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 17 Apr 2009 09:24:44 -0700
Received: from localhost.localdomain ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 17 Apr 2009 09:24:44 -0700
X-Mailer: git-send-email 1.6.2.3
X-OriginalArrivalTime: 17 Apr 2009 16:24:44.0719 (UTC) FILETIME=[04AD63F0:01C9BF79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116755>

If there is a commit that ends in ^X and is longer in length than
what will fit in title_short, then it doesn't get fed through
esc_html() and so the ^X will appear as-is in the page source.

When Firefox comes across this, it will fail to display the page,
and only display a couple lines of error messages that read like:

   XML Parsing Error: not well-formed
   Location: http://git ....

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33ef190..e686e82 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2470,7 +2470,7 @@ sub parse_commit_text {
 	foreach my $title (@commit_lines) {
 		$title =~ s/^    //;
 		if ($title ne "") {
-			$co{'title'} = chop_str($title, 80, 5);
+			$co{'title'} = chop_and_escape_str($title, 80, 5);
 			# remove leading stuff of merges to make the interesting part visible
 			if (length($title) > 50) {
 				$title =~ s/^Automatic //;
-- 
1.6.2.3
