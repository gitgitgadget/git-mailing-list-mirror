From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] name-ref: factor out name shortening logic from name_ref()
Date: Sun,  7 Jul 2013 15:33:41 -0700
Message-ID: <1373236424-25617-2-git-send-email-gitster@pobox.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:34:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxWv-00050T-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab3GGWdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:33:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab3GGWds (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:33:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DE472EA6C
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+vKQ
	qa3M3KMD9NahEACqjbyTUG4=; b=gikrIZty1F92HyFBkVNHu+Se7NiKnV+GTnw4
	Wd0DRpI1BzPpn2cH+ety9mWld9eNcnffa3n114/PhS4uFkbdjiNHz4bRprxRaIvf
	Z6W8lB6sF6WpjsPzza0IhswJuK2UvZdA7pEt1lqUujFXpgtW+Zf83AizF3qKamnv
	lSZD5Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iwVSw4
	8tozElMbJUVMhTVL1c7X5bsOnS2F2m6a8ChkL8seFr2WePlL6p5BiJzwUV9dM9md
	UlTt5kv+GekYhsYqcPyPx91ngnMjFevHQHB8z05XYJ5vOWv1x1Q/foWX+OykePb5
	qEZnjBDRu03Jtk0cg5xITdxQ2kH0FqPJCragg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34A1D2EA6B
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD9562EA65
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:47 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-853-ga8cbcc9
In-Reply-To: <1373236424-25617-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4A2C5C52-E755-11E2-8124-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229813>

The logic will be used in a new codepath for showing exact matches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 87d4854..1234ebb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -96,6 +96,17 @@ static int subpath_matches(const char *path, const char *filter)
 	return -1;
 }
 
+static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
+{
+	if (shorten_unambiguous)
+		refname = shorten_unambiguous_ref(refname, 0);
+	else if (!prefixcmp(refname, "refs/heads/"))
+		refname = refname + 11;
+	else if (!prefixcmp(refname, "refs/"))
+		refname = refname + 5;
+	return refname;
+}
+
 struct name_ref_data {
 	int tags_only;
 	int name_only;
@@ -134,13 +145,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
-		if (can_abbreviate_output)
-			path = shorten_unambiguous_ref(path, 0);
-		else if (!prefixcmp(path, "refs/heads/"))
-			path = path + 11;
-		else if (!prefixcmp(path, "refs/"))
-			path = path + 5;
-
+		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), 0, 0, deref);
 	}
 	return 0;
-- 
1.8.3.2-853-ga8cbcc9
