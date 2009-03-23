From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 3/4] builtin-fast-export.c: fix crash on tagged trees
Date: Mon, 23 Mar 2009 12:53:08 +0000
Message-ID: <1237812789-1360-3-git-send-email-kusmabite@gmail.com>
References: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
 <1237812789-1360-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 13:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lljfu-0006Lx-Ia
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbZCWMxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755850AbZCWMxM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:53:12 -0400
Received: from mx.getmail.no ([84.208.15.66]:47911 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754238AbZCWMxH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 08:53:07 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGY00LU2MGF4E70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 13:53:04 +0100 (MET)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGY00AGTMGCW510@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 13:53:03 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.23.123715
X-Mailer: git-send-email 1.6.2.GIT
In-reply-to: <1237812789-1360-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114297>

If a tag object points to a tree (or another unhandled type), the commit-
pointer is left uninitialized and later dereferenced. This patch adds a default
case to the switch that issues a warning and skips the object.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c  |    4 ++++
 t/t9301-fast-export.sh |    5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 02bad1f..e716eee 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -375,6 +375,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			case OBJ_BLOB:
 				handle_object(tag->object.sha1);
 				continue;
+			default:
+				warning("Tag points to object of unexpected type %s, skipping.",
+				        typename(tag->object.type));
+				continue;
 			}
 			break;
 		default:
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index db4b0b3..79ca832 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -265,9 +265,8 @@ test_expect_success 'cope with tagger-less tags' '
 '
 
 # NEEDSWORK: not just check return status, but validate the output
-# two tests commented out due to crash and thus unreliable return code
-#test_expect_success 'tree_tag'        'git fast-export tree_tag'
-#test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
+test_expect_success 'tree_tag'        'git fast-export tree_tag'
+test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_failure 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-- 
1.6.2.1.225.g9a4a0.dirty
