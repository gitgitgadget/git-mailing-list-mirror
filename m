From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH?] Fix 'git show' on signed tag of signed tag of commit
Date: Tue,  1 Jul 2008 11:47:04 +0200
Message-ID: <1214905624-29517-1-git-send-email-trast@student.ethz.ch>
Cc: gitster@pobox.com, Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 11:48:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcSu-0003Zw-P9
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYGAJqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYGAJqx
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:46:53 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:10295 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbYGAJqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:46:52 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Jul 2008 11:46:50 +0200
Received: from localhost.localdomain ([129.132.149.71]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Jul 2008 11:46:50 +0200
X-Mailer: git-send-email 1.5.6.1.246.g5fc88.dirty
X-OriginalArrivalTime: 01 Jul 2008 09:46:50.0118 (UTC) FILETIME=[6282E260:01C8DB5F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87017>

The cmd_show loop resolves tags by showing them, then pointing the
object to the 'tagged' member.  However, this object is not fully
initialized; it only contains the SHA1.  (This resulted in a segfault
if there were two levels of tags.)  We apply parse_object to get a
full object.

Noticed by Kalle Olavi Niemitalo on IRC.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I'm not 100% sure this is the right fix; I just had a quick stab at
the code, made a fix and tested it.  It probably leaks memory too, not
sure if this is a problem.

- Thomas


 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 9817d6f..9979e37 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -360,7 +360,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			ret = show_object(o->sha1, 1, &rev);
-			objects[i].item = (struct object *)t->tagged;
+			objects[i].item = parse_object(t->tagged->sha1);
 			i--;
 			break;
 		}
-- 
1.5.6.1.246.g5fc88.dirty
