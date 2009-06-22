From: newren@gmail.com
Subject: [PATCH v2] fast-export: Omit tags that tag trees
Date: Mon, 22 Jun 2009 07:06:36 -0600
Message-ID: <1245676001-14734-2-git-send-email-newren@gmail.com>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjGa-0004CR-Gm
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbZFVNIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 09:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbZFVNIt
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:08:49 -0400
Received: from mail-px0-f174.google.com ([209.85.216.174]:33488 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbZFVNIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 09:08:48 -0400
Received: by pxi4 with SMTP id 4so34643pxi.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/+nfixSxDdqjNQcGrRAYIRhMSYLQ1l3YvXu1Mud+N6U=;
        b=F9woHE0NT/fu25rfQnVevh24DPsZz10KlJZPwK/gIntpkmufV48OHxCfy1RNzalBbt
         fk+5oT64vMpw2cvO6r9JBDz+NF6cyskkY4ZvYRe31AxG9VsOn/cFNYF8nQJ7uXsJ/658
         6cK1ay2gvx/vbc4ZVl98jdcYTJS9ssK+TIiRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oKkHrzJzYBG2xwBhiclGpJSmK418tL1cCFxh12VknNj3c/cQMrh7/qCwO05YtXbWGx
         7SvZEC/H+CCPm/y8DHIE/ksK05rNyzxScefvOvymTYzP3X4Ir3ksgRPIDLRudLouNB6v
         DGkA2j1+fBlY9LmOPSzK1FCE7E3MFNJ/gQhcs=
Received: by 10.142.103.11 with SMTP id a11mr2720859wfc.303.1245676131338;
        Mon, 22 Jun 2009 06:08:51 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 28sm675507wfd.23.2009.06.22.06.08.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 06:08:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245676001-14734-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122036>

From: Elijah Newren <newren@gmail.com>

Commit c0582c53bcf4e83bba70e1ad23abbad31f96ebc8 introduced logic to just
omit tags that point to tree objects.  However, a case was missed
resulting in a tag being output which pointed at "mark :0", which would
cause fast-import to crash.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Includes changes suggested by Stephen Boyd (squashing commits together
and moving the NEEDSWORK comment to where it is still relevant) and
Johannes Sixt (fixing the testcase to remain in the right directory
even if git init fails and to catch failures in git fast-export).

 builtin-fast-export.c  |    8 +++++++-
 t/t9301-fast-export.sh |    8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6cef810..891e2d4 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -407,9 +407,15 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
 		const char *name = extra_refs->items[i].string;
 		struct object *object = extra_refs->items[i].util;
+		struct tag *tag;
 		switch (object->type) {
 		case OBJ_TAG:
-			handle_tag(name, (struct tag *)object);
+			tag = (struct tag *)object;
+			if (tag->tagged->type == OBJ_TREE) {
+				/* Ignore this tag altogether */
+				return;
+			}
+			handle_tag(name, tag);
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 8c8a9e6..3f13e6b 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -271,8 +271,14 @@ test_expect_success 'set-up a few more tags for tag export tests' '
 	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
 '
 
+test_expect_success 'tree_tag'        '
+	mkdir result &&
+	(cd result && git init) &&
+	git fast-export tree_tag > fe-stream &&
+	(cd result && git fast-import < ../fe-stream)
+'
+
 # NEEDSWORK: not just check return status, but validate the output
-test_expect_success 'tree_tag'        'git fast-export tree_tag'
 test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
-- 
1.6.0.6
