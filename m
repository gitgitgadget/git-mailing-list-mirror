From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] config: don't segfault when given --path with a missing value
Date: Tue, 13 Nov 2012 20:50:04 -0800
Message-ID: <1352868604-20459-1-git-send-email-cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 05:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYUw5-0001Wx-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 05:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab2KNEuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 23:50:10 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:59741 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932391Ab2KNEuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 23:50:09 -0500
Received: from cmartin.tk (204-16-157-26-static.ipnetworksinc.net [204.16.157.26])
	by hessy.dwim.me (Postfix) with ESMTPA id C869A814A5
	for <git@vger.kernel.org>; Wed, 14 Nov 2012 05:50:05 +0100 (CET)
Received: (nullmailer pid 20495 invoked by uid 1000);
	Wed, 14 Nov 2012 04:50:04 -0000
X-Mailer: git-send-email 1.8.0.316.g291341c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209696>

When given a variable without a value, such as '[section] var' and
asking git-config to treat it as a path, git_config_pathname returns
an error and doesn't modify its output parameter. show_config assumes
that the call is always successful and sets a variable to indicate
that vptr should be freed. In case of an error however, trying to do
this will cause the program to be killed, as it's pointing to memory
in the stack.

Set the must_free_vptr flag depending on the return value of
git_config_pathname so it's accurate.
---
 builtin/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 442ccc2..60220d5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -129,8 +129,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 		else
 			sprintf(value, "%d", v);
 	} else if (types == TYPE_PATH) {
-		git_config_pathname(&vptr, key_, value_);
-		must_free_vptr = 1;
+		must_free_vptr = !git_config_pathname(&vptr, key_, value_);
 	} else if (value_) {
 		vptr = value_;
 	} else {
-- 
1.8.0.316.g291341c
