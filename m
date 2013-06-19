From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH] peel_onion(): add support for <rev>^{tag}
Date: Tue, 18 Jun 2013 21:39:06 -0400
Message-ID: <1371605946-32565-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 19 03:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up7Mr-0008Gi-OS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 03:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029Ab3FSBjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 21:39:21 -0400
Received: from smtp.bbn.com ([128.33.0.80]:11999 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932687Ab3FSBjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 21:39:21 -0400
Received: from socket.bbn.com ([192.1.120.102]:40540)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Up7Ml-000OE2-KM; Tue, 18 Jun 2013 21:39:19 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 57CAC40761
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228323>

gitrevisions(7) implies that <rev>^{tag} should work, but before now
it did not:

    $ git rev-parse --verify v1.8.3.1^{tag}
    fatal: Needed a single revision

This commit fixes the omission:

    $ git rev-parse --verify v1.8.3.1^{tag}
    4bc068950abec778a02ebf3ee73cf0735affabb4

Other object type names work as expected:

    $ git rev-parse --verify v1.8.3.1^{commit}
    362de916c06521205276acb7f51c99f47db94727
    $ git rev-parse --verify v1.8.3.1^{tree}
    c1fef48675edd74e9af19405339e8bdaebd56b0c
    $ git rev-parse --verify v1.8.3.1^{blob}
    error: v1.8.3.1^{blob}: expected blob type, but the object dereferences to tree type
    fatal: Needed a single revision

Note that <rev>^{tag} is not the same as <rev>^{object} when <rev> is
not a tag:

    $ git rev-parse --verify v1.8.3.1^{}^{object}
    362de916c06521205276acb7f51c99f47db94727
    $ git rev-parse --verify v1.8.3.1^{}^{tag}
    error: v1.8.3.1^{}^{tag}: expected tag type, but the object dereferences to tree type
    fatal: Needed a single revision

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 sha1_name.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 90419ef..68fd0e4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -677,6 +677,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	sp++; /* beginning of type name, or closing brace for empty */
 	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
 		expected_type = OBJ_COMMIT;
+	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
+		expected_type = OBJ_TAG;
 	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
 		expected_type = OBJ_TREE;
 	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
-- 
1.8.3.1
