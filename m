From: jepler@unpythonic.net
Subject: [PATCH 1/2] Fix applying a line when all following lines are deletions
Date: Mon,  7 Dec 2009 18:22:42 -0600
Message-ID: <1260231763-19194-2-git-send-email-jepler@unpythonic.net>
References: <1260231763-19194-1-git-send-email-jepler@unpythonic.net>
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Jeff Epler <jepler@unpythonic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHoJh-00023I-Jb
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 01:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbZLHAw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 19:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbZLHAw1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 19:52:27 -0500
Received: from zuul.dsndata.com ([162.40.127.30]:59024 "EHLO zuul.dsndata.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965271AbZLHAwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 19:52:25 -0500
X-Greylist: delayed 1770 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2009 19:52:24 EST
Received: from lucky2.dsndata.com (lucky2.dsndata.com [198.183.6.22])
	by zuul.dsndata.com (8.13.8/8.13.8) with ESMTP id nB80MpbV038319;
	Mon, 7 Dec 2009 18:22:51 -0600 (CST)
	(envelope-from jepler@dsndata.com)
Received: from jepler by lucky2.dsndata.com with local (Exim 4.69)
	(envelope-from <jepler@lucky2.dsndata.com>)
	id 1NHnqt-00050p-BS; Mon, 07 Dec 2009 18:22:51 -0600
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1260231763-19194-1-git-send-email-jepler@unpythonic.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (zuul.dsndata.com [162.40.127.30]); Mon, 07 Dec 2009 18:22:54 -0600 (CST)
X-Scanned-By: MIMEDefang 2.61 on 162.40.127.30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134795>

From: Jeff Epler <jepler@unpythonic.net>

If a diff looked like
 @@
  context
 -del1
 -del2
and you wanted to stage the deletion 'del1', the generated patch wouldn't
apply because it was missing the line 'del2' converted to context, but
this line was counted in the @@-line

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---
 lib/diff.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index bd5d189..066755b 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -664,6 +664,7 @@ proc apply_line {x y} {
 		}
 		set i_l $next_l
 	}
+	set patch "$patch$pre_context"
 	set patch "@@ -$hln,$n +$hln,[eval expr $n $sign 1] @@\n$patch"
 
 	if {[catch {
-- 
1.6.3.3
