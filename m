From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] git-for-each-ref: add new field name "symbolic"
Date: Sat, 13 Feb 2010 00:55:18 -0500
Message-ID: <1266040518-11748-1-git-send-email-larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 07:03:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgB6M-0004Ey-QA
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 07:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891Ab0BMFzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 00:55:21 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:52440 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0BMFzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 00:55:21 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id D9847822216; Sat, 13 Feb 2010 00:55:19 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139774>

%(symbolic) will expand to "true" for symbolic refs, and "false" otherwise.
This is a lot faster than calling git-symbolic-ref on every single ref from your
shell script.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 Documentation/git-for-each-ref.txt |    3 +++
 builtin-for-each-ref.c             |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7e83288..c2a694f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,6 +92,9 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
 
+symbolic::
+	"true" for symbolic refs, "false" otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index a5a83f1..fd6973e 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -33,6 +33,7 @@ struct ref_sort {
 struct refinfo {
 	char *refname;
 	unsigned char objectname[20];
+	int flag;
 	struct atom_value *value;
 };
 
@@ -66,6 +67,7 @@ static struct {
 	{ "creatordate", FIELD_TIME },
 	{ "subject" },
 	{ "body" },
+	{ "symbolic" },
 	{ "contents" },
 	{ "upstream" },
 };
@@ -576,6 +578,8 @@ static void populate_value(struct refinfo *ref)
 
 		if (!prefixcmp(name, "refname"))
 			refname = ref->refname;
+		else if (!prefixcmp(name, "symbolic"))
+			refname = (ref->flag & REF_ISSYMREF) ? "true" : "false";
 		else if (!prefixcmp(name, "upstream")) {
 			struct branch *branch;
 			/* only local branches may have an upstream */
@@ -716,6 +720,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 * by maxcount logic.
 	 */
 	ref = xcalloc(1, sizeof(*ref));
+	ref->flag = flag;
 	ref->refname = xstrdup(refname);
 	hashcpy(ref->objectname, sha1);
 
-- 
1.7.0.rc2.40.g7d8aa
