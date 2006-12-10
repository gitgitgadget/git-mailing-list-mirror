X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 4/3] gitweb: SHA-1 in commit log message links to "object" view
Date: Sun, 10 Dec 2006 13:25:49 +0100
Message-ID: <11657536473295-git-send-email-jnareb@gmail.com>
References: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sun, 10 Dec 2006 12:25:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hhnZQ5/bt9Sj96vKh12yRwcTBMQk92eevutbYqXCoVeb05OL36ThTbPi0+8DiRWHyge3WKAfEBhDTJzoUr8PFEcHGaTI6w6ALLQCGGXadPCssWqMHDeaSFQMO7D5C/6aC6eVCqyRdLykh13urDMQG6ajYJ8d+auVbDzOq7JODX8=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33884>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtNkH-0001vh-A0 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 13:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758849AbWLJMZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 07:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbWLJMZ0
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 07:25:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22549 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758849AbWLJMZZ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 07:25:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1088384uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 04:25:25 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr1938294ugj.1165753524812; Sun, 10
 Dec 2006 04:25:24 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 54sm5686746ugp.2006.12.10.04.25.24; Sun, 10 Dec 2006 04:25:24 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBACRTHq025916; Sun, 10 Dec 2006 13:27:30 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBACRRSn025914; Sun, 10 Dec 2006 13:27:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Instead of checking if explicit SHA-1 in commit log message is sha1 of
commit and making link to "commit" view, make [fragment of] explicit
SHA-1 in commit log message link to "object" view.  While at it allow
to hyperlink also shortened SHA-1, from 8 characters up to full SHA-1,
instead of requiring full 40 characters of SHA-1.

This makes the following changes:

 * SHA-1 of objects which no longer exists, for example in commit
   cherry-picked from no longer existing temporary branch, or revert
   of commit in rebased branch, are no longer marked as such by not
   being made into hyperlink (and not having default hyperlink view:
   being underlined among others).  On the other hand it makes gitweb
   to not write error messages when object is not found to web serwer
   log; it also moves cost of getting type and SHA-1 validation to
   when link is clicked, and not only viewed.

 * SHA-1 of other objects: blobs, trees, tags are also hyperlinked
   and lead to appropriate view (although in the case of tags it is
   more natural to just use tag name).

 * You can put shortened SHA-1 of commit in the commit message, and it
   would be hyperlinked; it would be checked on clicking if abbrev is
   unique.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This follows the "lazy hyperlink" idea of symbolic link support in the
"tree" view.

It is an RFC (Requests For Comments) because I'm not sure if it
wouldn't be better to make dead SHA-1 marked in commit log message,
instead of finfing it out after clicking...

 gitweb/gitweb.perl |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6493311..7d24c10 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -828,14 +828,12 @@ sub format_log_line_html {
 	my $line = shift;
 
 	$line = esc_html($line, -nbsp=>1);
-	if ($line =~ m/([0-9a-fA-F]{40})/) {
+	if ($line =~ m/([0-9a-fA-F]{8,40})/) {
 		my $hash_text = $1;
-		if (git_get_type($hash_text) eq "commit") {
-			my $link =
-				$cgi->a({-href => href(action=>"commit", hash=>$hash_text),
-				        -class => "text"}, $hash_text);
-			$line =~ s/$hash_text/$link/;
-		}
+		my $link =
+			$cgi->a({-href => href(action=>"object", hash=>$hash_text),
+			        -class => "text"}, $hash_text);
+		$line =~ s/$hash_text/$link/;
 	}
 	return $line;
 }
-- 
1.4.4.1
