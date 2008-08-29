From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] for-each-ref: new 'refshort' format
Date: Fri, 29 Aug 2008 23:41:56 +0200
Message-ID: <1220046116-23703-1-git-send-email-bert.wesarg@googlemail.com>
References: <36ca99e90808291121j7b202917r2308719970668be3@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: szeder@ira.uka.de
X-From: git-owner@vger.kernel.org Fri Aug 29 23:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZBkM-0007AM-BR
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbYH2VmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbYH2VmD
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:42:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:5606 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486AbYH2VmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 17:42:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so646642fgg.17
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4aXuWS6HicF9qfeyD1v9zNKBsL9CGOZj7mezL7SuHds=;
        b=LnaZQko2vliRAzl5crPyFi2WaagJ6buMDSQUv3FaIhVZOaSf54QGPzzjrrnl5Dcf42
         9uw9M/fotIsw5g7gIlUi0ZFLx0zi97/foETik20+oTocjw3o0KIEROhl//wqZw06SvDr
         yBkdTH+ypKR/ScFww/4rW2dh4Rw1rXoQhRZMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bbUsi/6anYQ3Vpq71/+/tu/uVaGtzinq+sqUcxSTMhV+0y3YN1TITgnz97j5o1dx3b
         ywBc7BZ/ORqpAvqK4XQoPqV/nnYTY4SMKiyqQXF/266UyDTIOUpdkv/tkU6VoMuWz8iJ
         tcK3tliKx2B9g1mErVTo4Y/As8Hajmgejii1k=
Received: by 10.86.66.11 with SMTP id o11mr2470098fga.25.1220046119310;
        Fri, 29 Aug 2008 14:41:59 -0700 (PDT)
Received: from localhost ( [91.15.92.135])
        by mx.google.com with ESMTPS id d4sm3301081fga.5.2008.08.29.14.41.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Aug 2008 14:41:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <36ca99e90808291121j7b202917r2308719970668be3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94331>

Here is a first sketch for this idea.

This strips from the refname the common prefix with the matched pattern.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

I think we should use a ':short' modifier to 'reflog' and '*reflog'.

 builtin-for-each-ref.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..b80d753 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -31,6 +31,7 @@ struct ref_sort {
 
 struct refinfo {
 	char *refname;
+	const char *pattern; /* the pattern which matched this ref */
 	unsigned char objectname[20];
 	struct atom_value *value;
 };
@@ -66,6 +67,7 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "refshort" },
 };
 
 /*
@@ -546,6 +548,36 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 }
 
 /*
+ * Use the matched pattern from ref to shorten the refname
+ */
+static char *get_short_ref(struct refinfo *ref)
+{
+	int rlen, plen, len = 0;
+
+	if (!ref->pattern)
+		return ref->refname;
+
+	rlen = strlen(ref->refname);
+	plen = strlen(ref->pattern);
+
+	if ((plen <= rlen) &&
+	    !strncmp(ref->refname, ref->pattern, plen) &&
+	    (ref->refname[plen] == '\0' ||
+	     ref->refname[plen] == '/' ||
+	     ref->pattern[plen - 1] == '/')) {
+		len = plen + (ref->refname[plen] == '/');
+	} else {
+		len = strcspn(ref->pattern, "*?[");
+		while (len >= 0 && ref->pattern[len] != '/')
+			--len;
+		len++;
+	}
+
+	return ref->refname + len;
+}
+
+
+/*
  * Parse the object referred by ref, and grab needed value.
  */
 static void populate_value(struct refinfo *ref)
@@ -577,6 +609,8 @@ static void populate_value(struct refinfo *ref)
 			char *s = xmalloc(len + 4);
 			sprintf(s, "%s^{}", ref->refname);
 			v->s = s;
+		} else if (!strcmp(name, "refshort")) {
+			v->s = get_short_ref(ref);
 		}
 	}
 
@@ -641,9 +675,9 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
 	int cnt;
+	const char **pattern = cb->grab_pattern;
 
-	if (*cb->grab_pattern) {
-		const char **pattern;
+	if (*pattern) {
 		int namelen = strlen(refname);
 		for (pattern = cb->grab_pattern; *pattern; pattern++) {
 			const char *p = *pattern;
@@ -668,6 +702,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = xcalloc(1, sizeof(*ref));
 	ref->refname = xstrdup(refname);
+	ref->pattern = *pattern;
 	hashcpy(ref->objectname, sha1);
 
 	cnt = cb->grab_cnt;
-- 
1.6.0
