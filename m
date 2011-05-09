From: Michael Schubert <mschub@elegosoft.com>
Subject: [RFC/PATCH] tag: disallow '-' as tag name
Date: Tue, 10 May 2011 00:56:19 +0200
Message-ID: <4DC87113.4030204@elegosoft.com>
References: <1304954496.11377.11.camel@kohr-ah> <7v39knpxbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Alex Vandiver <alex@chmrr.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:56:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZNK-0001I4-H4
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab1EIW4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:56:21 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:33199 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308Ab1EIW4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:56:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id C4140DE77E;
	Tue, 10 May 2011 00:56:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2nEmz7HgvGFd; Tue, 10 May 2011 00:56:19 +0200 (CEST)
Received: from [192.168.1.103] (g230120029.adsl.alicedsl.de [92.230.120.29])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 7989CDE779;
	Tue, 10 May 2011 00:56:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
In-Reply-To: <7v39knpxbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173282>

Add strbuf_check_tag_ref() as helper to check a refname for a tag.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/tag.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index b66b34a..f087a7f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -352,11 +352,26 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
+{
+	if (name[0] == '-')
+		return CHECK_REF_FORMAT_ERROR;
+
+	strbuf_reset(sb);
+	strbuf_add(sb, "refs/tags/", 10);
+	strbuf_add(sb, name, strlen(name));
+
+	if (sb->len > PATH_MAX)
+		die(_("tag name too long: %.*s..."), 50, name);
+
+	return check_ref_format(sb->buf);
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
-	char ref[PATH_MAX];
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
 
@@ -452,12 +467,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) > sizeof(ref) - 1)
-		die(_("tag name too long: %.*s..."), 50, tag);
-	if (check_ref_format(ref))
+	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
 
-	if (!resolve_ref(ref, prev, 1, NULL))
+	if (!resolve_ref(ref.buf, prev, 1, NULL))
 		hashclr(prev);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
@@ -466,14 +479,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		create_tag(object, tag, &buf, msg.given || msgfile,
 			   sign, prev, object);
 
-	lock = lock_any_ref_for_update(ref, prev, 0);
+	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-		die(_("%s: cannot lock the ref"), ref);
+		die(_("%s: cannot lock the ref"), ref.buf);
 	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref);
+		die(_("%s: cannot update the ref"), ref.buf);
 	if (force && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
 	strbuf_release(&buf);
+	strbuf_release(&ref);
 	return 0;
 }
-- 
1.7.5.1 
