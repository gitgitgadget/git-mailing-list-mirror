From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] optimize path_relative()
Date: Fri, 4 Jun 2010 09:44:43 +0200
Message-ID: <20100604074442.GA5117@localhost>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost>
 <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 09:45:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKRaw-0004ZX-Sd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 09:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab0FDHpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 03:45:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:41615 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0FDHp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 03:45:29 -0400
Received: by fg-out-1718.google.com with SMTP id d23so726736fga.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=S1d4RzaEn6L/ubn7PAz0EylOXlUK3EykBcyZ4oRO9OM=;
        b=CX88AmEFhomwHRiWEw8rb0dY0Y0W+NhN3uIQl00+noUSYyflxHY9FGBfGH9EzrLDOb
         KRg9NB6LhgH9G1XH+1bclF57fJT9hcngzdwNALe8ivPZRbkhvqc1pQFES0oyUwoA2dfX
         9BBBs/VqlNsRXhtbq1uEsyLZ7nPkWQ+/5qMEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=uxwq15C0AQw1+PKYsb0EuM9n7fLNLNw/qsjjKFzzIWyUHVQgMbVOdYbKBzEVSGb/SE
         n/6VpLpiH3LwPeiuHKQaub4CTb0SgSCWGFTRmW74dMTHn2dUOxp9CGQa39wsZJsm0Q54
         mRQK4KrkCwZ8ox4fPP2kDlzZPFnXljuEBLE24=
Received: by 10.86.124.8 with SMTP id w8mr17177030fgc.8.1275637527356;
        Fri, 04 Jun 2010 00:45:27 -0700 (PDT)
Received: from darc.lan (p549A7CEC.dip.t-dialin.net [84.154.124.236])
        by mx.google.com with ESMTPS id 26sm1275698fks.22.2010.06.04.00.45.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 00:45:26 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKRa7-0001N3-1j; Fri, 04 Jun 2010 09:44:43 +0200
Content-Disposition: inline
In-Reply-To: <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148382>

Avoid copying to strbuf in case a subset of the original string can
be returned.

Since the strbuf is no longer guaranteed to be updated, this
function is different from quote_path_relative(). To avoid
confusion, do not export it.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Thu, Jun 03, 2010 at 03:16:33PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>
> > +	strbuf_add(out, in, len);
> > +
> > +	return out->buf;
> > +}
> 
> Hmm...  I wonder if we really want to always make a copy of the string in
> the majority of the case where there is no need to add ../ and the path
> does not have any funny characters that needs quoting.

Right. Implemented below. I noticed a few more redundancies along
the way, so the following could be squashed into 1/2 "separate
quoting and relative path generation" or applied on top of the
existing two patches.

Please let me know if you'd rather have a resend.

Clemens

 quote.c |   72 ++++++++++++++++++++++++++++++++++++--------------------------
 quote.h |    3 --
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/quote.c b/quote.c
index 2ae2c1f..481541a 100644
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
+	if (i == prefix_len)
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
