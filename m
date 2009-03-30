From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 3/4] builtin-fast-export.c: fix crash on tagged trees
Date: Mon, 30 Mar 2009 11:08:56 +0200
Message-ID: <1238404137-6693-3-git-send-email-kusmabite@gmail.com>
References: <1238404137-6693-1-git-send-email-kusmabite@gmail.com>
 <1238404137-6693-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDVv-0001sG-7r
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbZC3JJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757752AbZC3JJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:09:09 -0400
Received: from mx.getmail.no ([84.208.15.66]:35517 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756764AbZC3JJE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:09:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB00J61AR0J440@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:09:00 +0200 (MEST)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB000Q8AQYPG60@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:09:00 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.30.84610
X-Mailer: git-send-email 1.6.2.1
In-reply-to: <1238404137-6693-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115116>

If a tag object points to a tree (or another unhandled type), the commit-
pointer is left uninitialized and later dereferenced. This patch adds a default
case to the switch that issues a warning and skips the object.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c  |    4 ++++
 t/t9301-fast-export.sh |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 027c4aa..2070288 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -376,6 +376,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
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
index 763dde5..b587feb 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -274,8 +274,8 @@ test_expect_success 'set-up a few more tags for tag export tests' '
 '
 
 # NEEDSWORK: not just check return status, but validate the output
-test_expect_failure 'tree_tag'        'git fast-export tree_tag'
-test_expect_failure 'tree_tag-obj'    'git fast-export tree_tag-obj'
+test_expect_success 'tree_tag'        'git fast-export tree_tag'
+test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_failure 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-- 
1.6.2.1
