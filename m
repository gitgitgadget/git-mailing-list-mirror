From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] name-rev: differentiate between tags and commits they point at
Date: Thu, 18 Jul 2013 15:16:07 -0700
Message-ID: <1374185768-7537-2-git-send-email-gitster@pobox.com>
References: <1374185768-7537-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 00:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzwUm-0007gJ-28
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 00:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434Ab3GRWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 18:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab3GRWQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 18:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A747E322D3
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MPT7
	IW8lrrMmJzFPGwHrZcBF/S4=; b=ez/bZ8F3ciSxaROJdcRxRSaRTiss5EAs6Pr+
	/fJrl036DS/mSwHCt3M7Xzh02dN6GNeDEZw88GOnxdwbRlQLLiqSjTjnDHBR8/p1
	+8hKLjYMQIe2Cz8jjL6T2RoCUDi2B6HMyYMaq5QnvgeQ5edTOjE8JMolF5ymgv9w
	PIrh/Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xnnC9w
	a5RVo28ir62JUaFEI1ePrcH5QKQNAj425eeni4Wo9DbLNb3ctHEHzaPgkzkYgwX6
	nMMHUmZsrO7KgdML/pmVAm+S+DC2HeJ0rYIbbJwPiIQbF09Y0WTSQ5jVjNWuaijA
	D4YQz5SB6gsMAE8Mj1eW2jbSw90XVQynQ09bw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E34F322D2
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97904322CF
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:12 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-992-gf0e5e44
In-Reply-To: <1374185768-7537-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A7D5DA90-EFF7-11E2-BF34-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230758>

"git name-rev --stdin" has been fixed to convert an object name that
points at a tag to a refname of the tag.  The codepath to handle its
command line arguments, however, fed the commit that the tag points
at to the underlying naming machinery.

With this fix, you will get this:

    $ git name-rev --refs=tags/\* --name-only $(git rev-parse v1.8.3 v1.8.3^0)
    v1.8.3
    v1.8.3^0

which is the same as what you would get from the fixed "--stdin" variant:

    $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --refs=tags/\* --name-only
    v1.8.3
    v1.8.3^0

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c  | 24 ++++++++++++++++--------
 t/t6120-describe.sh | 12 ++++++++++++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 29a6f56..4c7cc62 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -334,7 +334,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	for (; argc; argc--, argv++) {
 		unsigned char sha1[20];
-		struct object *o;
+		struct object *object;
 		struct commit *commit;
 
 		if (get_sha1(*argv, sha1)) {
@@ -343,17 +343,25 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		o = deref_tag(parse_object(sha1), *argv, 0);
-		if (!o || o->type != OBJ_COMMIT) {
-			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
+		commit = NULL;
+		object = parse_object(sha1);
+		if (object) {
+			struct object *peeled = deref_tag(object, *argv, 0);
+			if (peeled && peeled->type == OBJ_COMMIT)
+				commit = (struct commit *)peeled;
+		}
+
+		if (!object) {
+			fprintf(stderr, "Could not get object for %s. Skipping.\n",
 					*argv);
 			continue;
 		}
 
-		commit = (struct commit *)o;
-		if (cutoff > commit->date)
-			cutoff = commit->date;
-		add_object_array((struct object *)commit, *argv, &revs);
+		if (commit) {
+			if (cutoff > commit->date)
+				cutoff = commit->date;
+		}
+		add_object_array(object, *argv, &revs);
 	}
 
 	if (cutoff)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index a25729f..1d20854 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -174,4 +174,16 @@ check_describe "test2-lightweight-*" --tags --match="test2-*"
 
 check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
 
+test_expect_success 'name-rev with exact tags' '
+	echo A >expect &&
+	tag_object=$(git rev-parse refs/tags/A) &&
+	git name-rev --tags --name-only $tag_object >actual &&
+	test_cmp expect actual &&
+
+	echo "A^0" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	git name-rev --tags --name-only $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.3-992-gf0e5e44
