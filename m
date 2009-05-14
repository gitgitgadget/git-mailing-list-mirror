From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 3/3] improved validation of entry type in mktree
Date: Thu, 14 May 2009 15:49:10 -0700
Message-ID: <a644352c0905141549q495973dfn664bdad80629ac17@mail.gmail.com>
References: <loom.20090514T050424-673@post.gmane.org>
	 <loom.20090514T051052-920@post.gmane.org>
	 <7vd4acxkug.fsf@alter.siamese.dyndns.org>
	 <a644352c0905141546w4193d45aq4940e72bbb4bda1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Micich <josh.micich@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 00:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jkf-0002bB-FE
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760656AbZENWtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760695AbZENWtM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:49:12 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:35122 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759680AbZENWtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 18:49:11 -0400
Received: by gxk10 with SMTP id 10so3021434gxk.13
        for <git@vger.kernel.org>; Thu, 14 May 2009 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QCQPViTP/LAH8XvKe07pqVQApmaoK9wTgnEySyJ1b3U=;
        b=Rv6jE59wvXtIR8XXwRv0ddmI5gduKeKQ0gjL++4fZXwVCed/tTkI4+hsZ6RxpvHueJ
         G0Xwu/ia8sj5Ih+7Pe9vZulPhZp64JMUUPp8ZmO6jXuDsjoJrPt7Rxf4DVTxnbahrQym
         90QZZD/cwz/K2ocUMFV/Y2Kwl9Pc3iX/oovzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CNMRywofx2bwUmCjhNEXs9rJ3Fyt2JWLy2brg6fewU5OpTY2ymthLL5zpBCs/zddeX
         ePdrtL3lC/AeKCPinBsRzP89kKOeWVE5LYGkT16AwnGG5rjiJYmbtYJ0WY6pT8SfFeMI
         N1GMML52H2dlTquAwMemg84EtaTOZ6Fl+r9nc=
Received: by 10.100.10.15 with SMTP id 15mr3670910anj.117.1242341350996; Thu, 
	14 May 2009 15:49:10 -0700 (PDT)
In-Reply-To: <a644352c0905141546w4193d45aq4940e72bbb4bda1c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119236>

Previously mktree would accept tree entries which had a mismatch
between the declared type and the actual type of object identified by
the sha.

Signed-off-by: Josh Micich <josh.micich@gmail.com>
---
 builtin-mktree.c |   43 +++++++++++++++++++++++++++++++++----------
 1 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/builtin-mktree.c b/builtin-mktree.c
index 73b0abb..dc4f1a7 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -71,7 +71,8 @@ static void mktree_line(char *buf, size_t len, int
line_termination, int allow_m
 {
 	char *ptr, *ntr;
 	unsigned mode;
-	enum object_type type;
+	enum object_type mode_type; /* object type derived from mode */
+	enum object_type obj_type; /* object type derived from sha */
 	char *path;
 	unsigned char sha1[20];

@@ -94,17 +95,8 @@ static void mktree_line(char *buf, size_t len, int
line_termination, int allow_m
 	if (S_ISGITLINK(mode))
 		allow_missing = 1;

-	if (!allow_missing)
-		type = sha1_object_info(sha1, NULL);
-	else
-		type = object_type(mode);
-
-	if (type < 0)
-		die("object %s unavailable", sha1_to_hex(sha1));

 	*ntr++ = 0; /* now at the beginning of SHA1 */
-	if (type != type_from_string(ptr))
-		die("object type %s mismatch (%s)", ptr, typename(type));

 	path = ntr + 41;  /* at the beginning of name */
 	if (line_termination && path[0] == '"') {
@@ -113,6 +105,37 @@ static void mktree_line(char *buf, size_t len,
int line_termination, int allow_m
 			die("invalid quoting");
 		path = strbuf_detach(&p_uq, NULL);
 	}
+
+	/*
+	 * Object type is redundantly derivable three ways.
+	 * These should all agree.
+	 */
+	mode_type = object_type(mode);
+	if (mode_type != type_from_string(ptr)) {
+		die("entry '%s' object type (%s) doesn't match mode type (%s)",
+			path, ptr, typename(mode_type));
+	}
+
+	/* Check the type of object identified by sha1 */
+	obj_type = sha1_object_info(sha1, NULL);
+	if (obj_type < 0) {
+		if (allow_missing) {
+			; /* no problem - missing objects are presumed to be of the right type */
+		} else {
+			die("entry '%s' object %s is unavailable", path, sha1_to_hex(sha1));
+		}
+	} else {
+		if (obj_type != mode_type) {
+			/*
+			 * The object exists but is of the wrong type.
+			 * This is a problem regardless of allow_missing
+			 * because the new tree entry will never be correct.
+			 */
+			die("entry '%s' object %s is a %s but specified type was (%s)",
+				path, sha1_to_hex(sha1), typename(obj_type), typename(mode_type));
+		}
+	}
+
 	append_to_tree(mode, sha1, path);
 }

-- 
1.6.3.1.181.gfc9b3.dirty
