From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] optimize path_relative()
Date: Sat, 5 Jun 2010 09:37:28 +0200
Message-ID: <20100605073728.GA19159@localhost>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost>
 <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
 <20100604074442.GA5117@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 09:38:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKnxW-00058Y-Sf
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 09:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab0FEHiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 03:38:16 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:65199 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab0FEHiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 03:38:15 -0400
Received: by ey-out-2122.google.com with SMTP id 25so131234eya.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=LGm5dLJzYe97D+o6Ar6aFq+tEkMDr0Dfr6SAw+qM7YE=;
        b=whWFpHxpLZ1hi73oPX+g97z99tYjIg4zPfIUmqUmSthLr3dETA4rtccmmMyQnBmII7
         O1PSlkyOfkcjR7IfLze5dRgVGy6EETuASajDZEobto16AFqapneebOnT9PnjWFZIvSr8
         96GEb3P+PiKDGgDxE8mCcUg2HZsey8f/70KIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Bh5pGgoVbOaW3z2j4etsgDVlhn5Y61GXdaWMVWS1kgm12MKVKJdg2yP13PWMXhYPnO
         KKP7hsqsKfVujY5HghIlLlfbOJR0GT/61LajedzLff7WOuvRfHUEqcsUr/Q/Qo3TPBsA
         wOTXalbHnwHuGbHR5srvm7gpLGW7Uk775SOUc=
Received: by 10.213.113.202 with SMTP id b10mr8851474ebq.77.1275723494080;
        Sat, 05 Jun 2010 00:38:14 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 15sm1190099ewy.0.2010.06.05.00.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 00:38:13 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKnwe-0000JL-Gz; Sat, 05 Jun 2010 09:37:28 +0200
Content-Disposition: inline
In-Reply-To: <20100604074442.GA5117@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148459>

Avoid copying to strbuf in case a subset of the original string can
be returned.

Since the strbuf is no longer guaranteed to be updated, this
function is different from quote_path_relative(). To avoid
confusion, do not export it.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Fri, Jun 04, 2010 at 09:44:43AM +0200, Clemens Buchacher wrote:

>  	if (prefix && prefix_len < 0)
>  		prefix_len = strlen(prefix);
[...]
> +	if (i == prefix_len)
> +		return in;

This should have been i >= prefix_len, in case prefix = NULL and
prefix_len = -1.  (Can only happen with git clean at the moment.)

 quote.c |   72 ++++++++++++++++++++++++++++++++++++--------------------------
 quote.h |    3 --
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/quote.c b/quote.c
index 2ae2c1f..63d3b01 100644
--- a/quote.c
+++ b/quote.c
@@ -295,62 +295,74 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
+static const char *path_relative(const char *in, int len,
+				 struct strbuf *sb, const char *prefix,
+				 int prefix_len);
+
 void write_name_quoted_relative(const char *name, size_t len,
 				const char *prefix, size_t prefix_len,
 				FILE *fp, int terminator)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	char *path = path_relative(name, len, &sb, prefix, prefix_len);
-	write_name_quoted(path, fp, terminator);
+	name = path_relative(name, len, &sb, prefix, prefix_len);
+	write_name_quoted(name, fp, terminator);
 
 	strbuf_release(&sb);
 }
 
-/* give path as relative to prefix */
-char *path_relative(const char *in, int len,
-		    struct strbuf *out, const char *prefix, int prefix_len)
+/*
+ * Give path as relative to prefix.
+ *
+ * The strbuf may or may not be used, so do not assume it contains the
+ * returned path.
+ */
+static const char *path_relative(const char *in, int len,
+				 struct strbuf *sb, const char *prefix,
+				 int prefix_len)
 {
+	int off, i;
+
 	if (len < 0)
 		len = strlen(in);
 	if (prefix && prefix_len < 0)
 		prefix_len = strlen(prefix);
 
-	strbuf_setlen(out, 0);
-	strbuf_grow(out, len);
+	off = 0;
+	i = 0;
+	while (i < prefix_len && i < len && prefix[i] == in[i]) {
+		if (prefix[i] == '/')
+			off = i + 1;
+		i++;
+	}
+	in += off;
+	len -= off;
 
-	if (prefix_len > 0) {
-		int off = 0, i = 0;
-		while (i < prefix_len && i < len && prefix[i] == in[i]) {
-			if (prefix[i] == '/')
-				off = i + 1;
-			i++;
-		}
-		in += off;
-		len -= off;
+	if (i >= prefix_len)
+		return in;
 
-		while (i < prefix_len) {
-			if (prefix[i] == '/')
-				strbuf_addstr(out, "../");
-			i++;
-		}
+	strbuf_reset(sb);
+	strbuf_grow(sb, len);
+
+	while (i < prefix_len) {
+		if (prefix[i] == '/')
+			strbuf_addstr(sb, "../");
+		i++;
 	}
-	strbuf_add(out, in, len);
+	strbuf_add(sb, in, len);
 
-	return out->buf;
+	return sb->buf;
 }
 
 /* quote path as relative to the given prefix */
 char *quote_path_relative(const char *in, int len,
 			  struct strbuf *out, const char *prefix)
 {
-	char *rel;
-	size_t rel_len;
-
-	path_relative(in, len, out, prefix, -1);
-	rel = strbuf_detach(out, &rel_len);
-	quote_c_style_counted(rel, rel_len, out, NULL, 0);
-	free(rel);
+	struct strbuf sb = STRBUF_INIT;
+	const char *rel = path_relative(in, len, &sb, prefix, -1);
+	strbuf_reset(out);
+	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
+	strbuf_release(&sb);
 
 	if (!out->len)
 		strbuf_addstr(out, "./");
diff --git a/quote.h b/quote.h
index e9e0221..38003bf 100644
--- a/quote.h
+++ b/quote.h
@@ -58,9 +58,6 @@ extern void write_name_quoted_relative(const char *name, size_t len,
 		const char *prefix, size_t prefix_len,
 		FILE *fp, int terminator);
 
-/* give path as relative to prefix */
-extern char *path_relative(const char *in, int len,
-		struct strbuf *out, const char *prefix, int prefix_len);
 /* quote path as relative to the given prefix */
 extern char *quote_path_relative(const char *in, int len,
 			  struct strbuf *out, const char *prefix);
-- 
1.7.1.2.ga1f6e
