From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Fix errors in git_patchset_body for empty patches
Date: Sun,  7 Jan 2007 02:52:25 +0100
Message-ID: <11681347531023-git-send-email-jnareb@gmail.com>
References: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 07 02:52:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NDJ-0001C8-8A
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbXAGBwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbXAGBwe
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:52:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:5259 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbXAGBwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:52:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8960304nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 17:52:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gaTs+SmG3zvIdXfcCEnPPnQZgpK5PXWUQLhqIbkjIQLBP1WZpOTsdAdYCcBfRqQg+/gIt6FBvWn2TsoYPsXqBDwc0upAgxq+eKDfE2viBTkPrO403fdnBfiCANpCvzIWudGtdnAPvfc24pgZOohwU0MVrWuDHxpZQjTzydIbpsY=
Received: by 10.49.8.16 with SMTP id l16mr6727356nfi.1168134750447;
        Sat, 06 Jan 2007 17:52:30 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id x24sm101646208nfb.2007.01.06.17.52.30;
        Sat, 06 Jan 2007 17:52:30 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l071qXRZ007262;
	Sun, 7 Jan 2007 02:52:33 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l071qXkM007261;
	Sun, 7 Jan 2007 02:52:33 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36113>

We now do not skip over empty patches in git_patchset_body (where
empty means that they consist only of git diff header, and of extended
diff header, for example "pure rename" patch).  This means that after
extended diff header there can be next patch (i.e. /^diff /) or end of
patchset, and not necessary patch body (i.e. /^--- /).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b4a4c0..7ebdfbb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2403,7 +2403,7 @@ sub git_patchset_body {
 		while ($patch_line = <$fd>) {
 			chomp $patch_line;
 
-			last EXTENDED_HEADER if ($patch_line =~ m/^--- /);
+			last EXTENDED_HEADER if ($patch_line =~ m/^--- |^diff /);
 
 			if ($patch_line =~ m/^index ([0-9a-fA-F]{40})..([0-9a-fA-F]{40})/) {
 				$from_id = $1;
@@ -2522,6 +2522,8 @@ sub git_patchset_body {
 
 		# from-file/to-file diff header
 		$patch_line = $last_patch_line;
+		last PATCH unless $patch_line;
+		next PATCH if ($patch_line =~ m/^diff /);
 		#assert($patch_line =~ m/^---/) if DEBUG;
 		if ($from{'href'}) {
 			$patch_line = '--- a/' .
-- 
1.4.4.3
