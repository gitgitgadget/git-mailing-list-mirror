From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] test: mailmap can change author name without changing
 email
Date: Tue, 14 Feb 2012 14:35:19 -0600
Message-ID: <20120214203519.GC13210@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP66-0000Al-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760838Ab2BNUfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:35:30 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63761 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213Ab2BNUfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:35:30 -0500
Received: by iacb35 with SMTP id b35so390817iac.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 12:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+3RdAx/BLhQphyotKBLMARJ4zxEgj7bmf0ysN3uEZpc=;
        b=VYqPfodORmkYY+o7TTi6wsjEegKsOEJDgVBXjwzs7i+ui/7uqesINz7bHD450onxqC
         bOZglGanKHWKR6qEqx8bWO/VYFk+K0QyYXMx07xxQm6H+tOgt62m7gUNhmCiWu1MURo6
         c0Qzg++7Exou4MPMDkuTMwGUD1femZdB1jAlE=
Received: by 10.50.170.41 with SMTP id aj9mr37530006igc.0.1329251728962;
        Tue, 14 Feb 2012 12:35:28 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm870864ibh.11.2012.02.14.12.35.28
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 12:35:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120214203431.GB13210@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190754>

From: Felipe Contreras <felipe.contreras@gmail.com>

A mailmap entry of the format 'A U Thor <email@example.com>' has two
effects: (1) 'A U Thor' becomes the canonical author name for commits
with author address 'email@example.com', and (2) 'email@example.com'
becomes the canonical author email for commits with author name 'A U
Thor'.

We already have tests for the effect (1) in the committer name, but
not in the author name, so the tests do not cover the shortlog and
blame codepaths as they should.  Fix that.

[jn: simplified by reusing Committer mailmap entry, clarified
 description]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4203-mailmap.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f61..45526395 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -157,6 +157,9 @@ A U Thor <author@example.com> (1):
 CTO <cto@company.xx> (1):
       seventh
 
+Committed <committer@example.com> (1):
+      eighth
+
 Other Author <other@author.xx> (2):
       third
       fourth
@@ -196,6 +199,11 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	test_tick &&
 	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
 
+	echo eight >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "C O Mitter <committer@example.com>" -m eighth &&
+
 	mkdir -p internal_mailmap &&
 	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
 	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
@@ -212,6 +220,9 @@ test_expect_success 'Shortlog output (complex mapping)' '
 
 # git log with --pretty format which uses the name and email mailmap placemarkers
 cat >expect <<\EOF
+Author C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
 Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
 Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
 
@@ -248,6 +259,7 @@ OBJID (Other Author DATE 4) four
 OBJID (Santa Claus  DATE 5) five
 OBJID (Santa Claus  DATE 6) six
 OBJID (CTO          DATE 7) seven
+OBJID (Committed    DATE 8) eight
 EOF
 test_expect_success 'Blame output (complex mapping)' '
 	git blame one >actual &&
-- 
1.7.9
