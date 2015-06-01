From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] format-patch: dereference tags with --ignore-if-in-upstream
Date: Mon,  1 Jun 2015 01:03:13 +0000
Message-ID: <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 03:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzE8b-0007qS-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 03:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbFABDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 21:03:30 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:57444 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232AbbFABD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2015 21:03:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A1DAE2808F;
	Mon,  1 Jun 2015 01:03:26 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270371>

format-patch would segfault if provided a tag as one of the range
endpoints in conjunction with --ignore-if-in-upstream, as it assumed the
object was a commit and attempted to cast it to struct commit.
Dereference the tag as soon as possible to prevent this, but not until
after copying the necessary flags.

Reported-by: Bruce Korb <bruce.korb@gmail.com>
Diagnosed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/log.c           |  6 ++++++
 t/t4014-format-patch.sh | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..e0465ba 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -807,6 +807,12 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	o2 = rev->pending.objects[1].item;
 	flags2 = o2->flags;
 
+	o1 = deref_tag(o1, NULL, 0);
+	o2 = deref_tag(o2, NULL, 0);
+
+	if (!o1 || !o2)
+		die(_("Invalid tag."));
+
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c39e500..60b9875 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -57,6 +57,16 @@ test_expect_success "format-patch --ignore-if-in-upstream" '
 
 '
 
+test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
+
+	git tag -a v1 -m tag side &&
+	git format-patch --stdout \
+		--ignore-if-in-upstream master..v1 >patch1 &&
+	cnt=$(grep "^From " patch1 | wc -l) &&
+	test $cnt = 2
+
+'
+
 test_expect_success "format-patch doesn't consider merge commits" '
 
 	git checkout -b slave master &&
-- 
2.4.0
