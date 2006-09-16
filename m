From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sat, 16 Sep 2006 23:09:33 +0200
Message-ID: <20060916210933.GX17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 16 23:09:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOhPv-000130-7n
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 23:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWIPVJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWIPVJg
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 17:09:36 -0400
Received: from agent.admingilde.org ([213.95.21.5]:63627 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751817AbWIPVJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 17:09:35 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GOhPp-00071Z-VC
	for git@vger.kernel.org; Sat, 16 Sep 2006 23:09:33 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27135>

Match the last part of the filename agains the extention from the
mime database instead of insisting that it starts at the first dot.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ee561c6..7501251 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1106,7 +1106,6 @@ sub mimetype_guess_file {
 	my $mimemap = shift;
 	-r $mimemap or return undef;
 
-	my %mimemap;
 	open(MIME, $mimemap) or return undef;
 	while (<MIME>) {
 		next if m/^#/; # skip comments
@@ -1114,14 +1113,16 @@ sub mimetype_guess_file {
 		if (defined $exts) {
 			my @exts = split(/\s+/, $exts);
 			foreach my $ext (@exts) {
-				$mimemap{$ext} = $mime;
+				if ($filename =~ /\.$ext$/) {
+					close(MIME);
+					return $mime;
+				}
 			}
 		}
 	}
 	close(MIME);
 
-	$filename =~ /\.(.*?)$/;
-	return $mimemap{$1};
+	return undef;
 }
 
 sub mimetype_guess {
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
