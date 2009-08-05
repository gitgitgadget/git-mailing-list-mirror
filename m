From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] gitk: fix direction of symmetric difference in optimized mode
Date: Wed, 5 Aug 2009 23:15:36 +0200
Message-ID: <8a2113bfa2f1eaf6a13587cadfbaae81c8914947.1249506383.git.trast@student.ethz.ch>
References: <0fd5fc0f09779bb04c02b54d6ec8f43087a51bca.1249130587.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	<git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnqR-0008De-UJ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbZHEVQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZHEVQL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:16:11 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:57592 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbZHEVQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:16:10 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 23:16:11 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 23:15:48 +0200
X-Mailer: git-send-email 1.6.4.87.g49c86
In-Reply-To: <0fd5fc0f09779bb04c02b54d6ec8f43087a51bca.1249130587.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124986>

ee66e08 (gitk: Make updates go faster, 2008-05-09) implemented an
optimized mode where gitk parses the arguments with rev-parse, and
manually reads history in chunks.  As mentioned in the commit message,
symmetric differences are a problem there:

    One wrinkle is that we have to turn symmetric diff arguments (of the
    form a...b) back into symmetric diff form so that --left-right still
    works, as git rev parse turns a...b into a b ^merge_base(a,b).

However, git-rev-parse returns a...b in the swapped order

    b a ^merge_base(a,b)

This has been the case since at least 1f8115b (the state of master at
the time of the abovementioned ee66e08; Merge branch 'maint',
2008-05-08).  So gitk flipped the sides of symmetric differences
whenever it was in optimized mode.

Fix this by swapping the sides of the reconstruction code.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This supersedes the older patch, which was simply wrong; the triangle
directions in the affected section are correct.

The confusing part of this, but also how I stumbled across the real
bug, was that I was playing with --show-all and that flipped the
direction *again*.  Turns out the option is not recognized by gitk and
lets it go back to unoptimized mode, where the bug does not exist.


 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..e103dab 100755
--- a/gitk
+++ b/gitk
@@ -288,7 +288,7 @@ proc parseviewrevs {view revs} {
 	    if {$sdm != 2} {
 		lappend ret $id
 	    } else {
-		lset ret end [lindex $ret end]...$id
+		lset ret end $id...[lindex $ret end]
 	    }
 	    lappend pos $id
 	}
-- 
1.6.4.96.g577b
