From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH] Speed up commands that use rev-list when max-count is specified.
Date: Sat, 20 Mar 2010 23:31:07 -0400
Message-ID: <1269142267-17127-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 04:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtBt1-0004fa-5U
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 04:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0CUDbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 23:31:22 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:56044
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752922Ab0CUDbV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 23:31:21 -0400
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id vfHm1d00217dt5G55fXMEU; Sun, 21 Mar 2010 03:31:21 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id vfXL1d00N0dnthT3ZfXMNK; Sun, 21 Mar 2010 03:31:21 +0000
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142787>

Many command have code similar to the following:

while ((commit = get_revision(rev)) != NULL) { ... }

This results in and extra call to get_revision that first finds the next
revision and then notices max-count is 0 and returns NULL.  Adding
a max-count check before any expensive work reduces the runtime of all
of the commands the have this pattern.

Depending on the use case this can have a big impact on the running time.

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 revision.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 490b484..4673d70 100644
--- a/revision.c
+++ b/revision.c
@@ -2058,6 +2058,9 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 
 struct commit *get_revision(struct rev_info *revs)
 {
+	if (revs->max_count == 0)
+		return NULL;
+
 	struct commit *c;
 	struct commit_list *reversed;
 
-- 
1.7.0.2
