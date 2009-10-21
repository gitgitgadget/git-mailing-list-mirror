From: Jeff Epler <jepler@unpythonic.net>
Subject: [RFC PATCH 1/2] Fix applying a line when all following lines are deletions
Date: Wed, 21 Oct 2009 16:20:22 -0500
Message-ID: <1256160023-29629-2-git-send-email-jepler@unpythonic.net>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
Cc: Jeff Epler <jepler@unpythonic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 23:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0igz-0002pD-9G
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbZJUVZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbZJUVZp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:25:45 -0400
Received: from zuul.dsndata.com ([162.40.127.30]:56409 "EHLO zuul.dsndata.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684AbZJUVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:25:44 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 17:25:43 EDT
Received: from lucky2.dsndata.com (lucky2.dsndata.com [198.183.6.22])
	by zuul.dsndata.com (8.13.8/8.13.8) with ESMTP id n9LLKSkE096232;
	Wed, 21 Oct 2009 16:20:28 -0500 (CDT)
	(envelope-from jepler@dsndata.com)
Received: from jepler by lucky2.dsndata.com with local (Exim 4.69)
	(envelope-from <jepler@lucky2.dsndata.com>)
	id 1N0ibb-0000C5-VQ; Wed, 21 Oct 2009 16:20:28 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (zuul.dsndata.com [162.40.127.30]); Wed, 21 Oct 2009 16:20:28 -0500 (CDT)
X-Scanned-By: MIMEDefang 2.61 on 162.40.127.30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130967>

If a diff looked like
 @@
  context
 -del1
 -del2
and you wanted to stage the deletion 'del1', the generated patch
wouldn't apply because it was missing the line 'del2' converted to
context, but this line was counted in the @@-line
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
1.6.5.rc1.49.ge970
