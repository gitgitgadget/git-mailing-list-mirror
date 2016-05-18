From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr: expose validity check for attribute names
Date: Wed, 18 May 2016 14:05:49 -0700
Message-ID: <xmqqh9dvqdoy.fsf_-_@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
	<xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
	<xmqqy477qfr2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:05:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b38fF-0007dh-FE
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbcERVFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:05:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753270AbcERVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:05:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BED8D1C56A;
	Wed, 18 May 2016 17:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YeW2OG6m7k0nY1bISvL6jIYNPkY=; b=gKZLGm
	u+ItZlltEH3+8R7X3U05TQ6u32fWPAIlzD9mEA4PFCnlcxlVb3dZJvHSDpud8fsg
	L2esjc2QH9EfQx58i032nb2MFd1z0GdYRdOLYjoWRGn73rOsDX7SH+NEWrSaZZ+N
	vwzG9fs8oz77MJbV+Qyhj7rB4jvUC+T8tyl4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKowmJ/gfDhuyhfULKRr/8xvxcFact2h
	4gLJdjt6TaaIR81RdrNaol0TiUR7AU+iv1QIoUliIYl48Va6BPgPTiS0XoiDnjpB
	vOPY/UN9kMcRyQXRkFX+4ObsFFULKlcA5b6fzl2bc5rL1QFsHHo+7o1UiiTi5CiW
	uSlqAD6f5so=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5DC71C569;
	Wed, 18 May 2016 17:05:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28DD11C568;
	Wed, 18 May 2016 17:05:51 -0400 (EDT)
In-Reply-To: <xmqqy477qfr2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 May 2016 13:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4D335C50-1D3C-11E6-914C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295011>

Export attr_name_valid() function, and a helper function that
returns the message to be given when a given <name, len> pair
is not a good name for an attribute.

We could later update the message to exactly spell out what the
rules for a good attribute name are, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And then finally the error message one.  I didn't change
   the message itself to spell out the rules here, though.

 attr.c | 39 +++++++++++++++++++++++++--------------
 attr.h |  3 +++
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 7f20e21..8f54871 100644
--- a/attr.c
+++ b/attr.c
@@ -59,23 +59,38 @@ static unsigned hash_name(const char *name, int namelen)
 	return val;
 }
 
-static int invalid_attr_name(const char *name, int namelen)
+int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
 	 * Attribute name cannot begin with '-' and must consist of
 	 * characters from [-A-Za-z0-9_.].
 	 */
 	if (namelen <= 0 || *name == '-')
-		return -1;
+		return 0;
 	while (namelen--) {
 		char ch = *name++;
 		if (! (ch == '-' || ch == '.' || ch == '_' ||
 		       ('0' <= ch && ch <= '9') ||
 		       ('a' <= ch && ch <= 'z') ||
 		       ('A' <= ch && ch <= 'Z')) )
-			return -1;
+			return 0;
 	}
-	return 0;
+	return -1;
+}
+
+void invalid_attr_name_message(struct strbuf *err, const char *name, int len)
+{
+	strbuf_addf(err, _("%.*s is not a valid attribute name"),
+		    len, name);
+}
+
+static void report_invalid_attr(const char *name, size_t len,
+				const char *src, int lineno)
+{
+	struct strbuf err = STRBUF_INIT;
+	invalid_attr_name_message(&err, name, len);
+	fprintf(stderr, "%s: %s:%d\n", err.buf, src, lineno);
+	strbuf_release(&err);
 }
 
 struct git_attr *git_attr_counted(const char *name, size_t len)
@@ -90,7 +105,7 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
 			return a;
 	}
 
-	if (invalid_attr_name(name, len))
+	if (!attr_name_valid(name, len))
 		return NULL;
 
 	FLEX_ALLOC_MEM(a, name, name, len);
@@ -176,17 +191,15 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			cp++;
 			len--;
 		}
-		if (invalid_attr_name(cp, len)) {
-			fprintf(stderr,
-				"%.*s is not a valid attribute name: %s:%d\n",
-				len, cp, src, lineno);
+		if (!attr_name_valid(cp, len)) {
+			report_invalid_attr(cp, len, src, lineno);
 			return NULL;
 		}
 	} else {
 		/*
 		 * As this function is always called twice, once with
 		 * e == NULL in the first pass and then e != NULL in
-		 * the second pass, no need for invalid_attr_name()
+		 * the second pass, no need for attr_name_valid()
 		 * check here.
 		 */
 		if (*cp == '-' || *cp == '!') {
@@ -229,10 +242,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
 		name += strspn(name, blank);
 		namelen = strcspn(name, blank);
-		if (invalid_attr_name(name, namelen)) {
-			fprintf(stderr,
-				"%.*s is not a valid attribute name: %s:%d\n",
-				namelen, name, src, lineno);
+		if (!attr_name_valid(name, namelen)) {
+			report_invalid_attr(name, namelen, src, lineno);
 			return NULL;
 		}
 	}
diff --git a/attr.h b/attr.h
index 78d6d5a..fc72030 100644
--- a/attr.h
+++ b/attr.h
@@ -13,6 +13,9 @@ extern struct git_attr *git_attr(const char *);
 /* The same, but with counted string */
 extern struct git_attr *git_attr_counted(const char *, size_t);
 
+extern int attr_name_valid(const char *name, size_t namelen);
+extern void invalid_attr_name_message(struct strbuf *, const char *, int);
+
 /* Internal use */
 extern const char git_attr__true[];
 extern const char git_attr__false[];
-- 
2.8.2-759-geb611ab
