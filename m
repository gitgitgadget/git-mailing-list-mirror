From: newren@gmail.com
Subject: [PATCHv3 2/7] fast-export: Omit tags that tag trees
Date: Thu, 25 Jun 2009 22:48:28 -0600
Message-ID: <1245991713-12782-3-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3PE-0003HF-JA
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbZFZEur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZFZEuq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:46 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:44971 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZFZEun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:43 -0400
Received: by mail-pz0-f202.google.com with SMTP id 40so3787pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+bNVQy5HoHj4lhhG65bGeF89jJOpTaZqtJgY+yUDQ8Y=;
        b=aA/DVWzOfTb+V1B1IWnnV0KOt75QI1k0yX6/gYVvkABqzEqJrTjrt29dABAQ2dDOYb
         9j9oduV9KG7s+0zV8mn586BjM1vns0MYGgjoizv0hDEtoeG1jVCRGm0W+VYi51xpEfB/
         pY9lAh2pgogHZfRQjvY5vhfo3e1esBICQbszw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CS5N/pDm2EsdJerjyOcTcI/M3kAw+I9Vta6GoWzM/tKumOj/fshUCdYl4pZU1CJ4cD
         1zYqDZqeRr9yOUiBZvVImbXFuBFDxNL4pgSXJLNH2kpFdG6aArk1D/oefYKK6+f3j2ww
         /4aHW3z7s/VhGvBEoTcpapwE1NVDg8jzCeqCI=
Received: by 10.142.80.16 with SMTP id d16mr1126907wfb.181.1245991846698;
        Thu, 25 Jun 2009 21:50:46 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122272>

From: Elijah Newren <newren@gmail.com>

Commit c0582c53bcf4e83bba70e1ad23abbad31f96ebc8 introduced logic to just
omit tags that point to tree objects.  However, these objects were still
being output and were pointing at "mark :0", which caused fast-import to
crash.  This patch makes sure such tags (including deeper nestings such
as tags of tags of trees), are omitted.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Since the last series, the code has been moved to the handle_tag
function, as suggested by Junio.  Also, it now correctly catches and
omits tags of tags of trees, tags of tags of tags of trees, etc.

 builtin-fast-export.c  |   15 +++++++++++++++
 t/t9301-fast-export.sh |    8 +++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index e0cfa60..8c90a2d 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -289,6 +289,21 @@ static void handle_tag(const char *name, struct tag *tag)
 	char *buf;
 	const char *tagger, *tagger_end, *message;
 	size_t message_size = 0;
+	struct object *tagged;
+
+	/* Trees have no identifer in fast-export output, thus we have no way
+	 * to output tags of trees, tags of tags of trees, etc.  Simply omit
+	 * such tags.
+	 */
+	tagged = tag->tagged;
+	while (tagged->type == OBJ_TAG) {
+		tagged = ((struct tag *)tagged)->tagged;
+	}
+	if (tagged->type == OBJ_TREE) {
+		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
+			sha1_to_hex(tag->object.sha1));
+		return;
+	}
 
 	buf = read_sha1_file(tag->object.sha1, &type, &size);
 	if (!buf)
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
1.6.3.2.323.geb889
