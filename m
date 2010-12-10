From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/10] vcs-svn: do not rely on marks for old blobs
Date: Fri, 10 Dec 2010 04:26:19 -0600
Message-ID: <20101210102619.GF26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR0BX-0004IT-Gk
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0LJK0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:26:37 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:39609 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0LJK0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:26:36 -0500
Received: by gwb20 with SMTP id 20so2886441gwb.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bwxdJZBFSY5fBtUcD9gMmrHLD9copwBXrpioj4deuKA=;
        b=kYMwXnXEwJt7sda6JiiS8M72dFBQk4ET2L4GxX6G3BOf5XDiCVYdJ0dQVCLmf5sdyp
         NuroBUkNAHCYIuQpQpqi+OxhIwQAJkeLOclHmSQbzH638KK0vyo164qpYQyFH3EtJ7mp
         rJNDNLEiC/RIqYsfFXb4ib75Rwv+o7QScEKck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WFY3QZlJ6CZofDRjXrPli4q3cl+qBQuFTp3xGg9GNS8nl1ynrwpKa6thzFmW1qFnOg
         utkKjZV+fd15Ue4Fycpy/QojhoDElrapUO9NyltuVqx0r8IQKH/lH+5zufGFDYduWXAk
         7s43sMGyPxoq9uvZo+d3/RCD+dsvErp6FPiWI=
Received: by 10.151.7.10 with SMTP id k10mr1057622ybi.433.1291976796124;
        Fri, 10 Dec 2010 02:26:36 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id v8sm1368783ybe.1.2010.12.10.02.26.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:26:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163401>

Retrieve old blobs by name and revision number from fast-import.
One step closer to bounded memory usage in svn-fe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Superfluous except that it shows how to parse 'ls' responses.
A demo.

 vcs-svn/fast_export.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/fast_export.h |    3 ++
 vcs-svn/string_pool.c |    2 +-
 vcs-svn/string_pool.h |    2 +-
 vcs-svn/svndump.c     |    6 +++++
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 960b252..cca9810 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -88,6 +88,21 @@ static int ends_with(const char *s, size_t len, const char *suffix)
 	return !memcmp(s + len - suffixlen, suffix, suffixlen);
 }
 
+static int parse_ls_response_line(const char *line, struct strbuf *objnam)
+{
+	const char *end = line + strlen(line);
+	const char *name, *tab;
+
+	if (end - line < strlen("100644 blob "))
+		return error("ls response too short: %s", line);
+	name = line + strlen("100644 blob ");
+	tab = memchr(name, '\t', end - name);
+	if (!tab)
+		return error("ls response does not contain tab: %s", line);
+	strbuf_add(objnam, name, tab - name);
+	return 0;
+}
+
 static int parse_cat_response_line(const char *header, off_t *len)
 {
 	size_t headerlen = strlen(header);
@@ -129,6 +144,31 @@ static off_t cat_mark(uint32_t mark)
 	return length;
 }
 
+static off_t cat_from_rev(uint32_t rev, const uint32_t *path)
+{
+	const char *response;
+	off_t length = length;
+	struct strbuf blob_name = STRBUF_INIT;
+
+	/* ls :5 "path/to/old/file" */
+	printf("ls :%"PRIu32" \"", rev);
+	pool_print_seq(REPO_MAX_PATH_DEPTH, path, '/', stdout);
+	printf("\"\n");
+	fflush(stdout);
+
+	response = get_response_line();
+	if (parse_ls_response_line(response, &blob_name))
+		die("invalid ls response: %s", response);
+
+	printf("cat-blob %s\n", blob_name.buf);
+	fflush(stdout);
+	response = get_response_line();
+	if (parse_cat_response_line(response, &length))
+		die("invalid cat-blob response: %s", response);
+	strbuf_release(&blob_name);
+	return length;
+}
+
 static long delta_apply(uint32_t mark, off_t len, struct line_buffer *input,
 			off_t preimage_len, uint32_t old_mode)
 {
@@ -195,3 +235,16 @@ void fast_export_blob_delta(uint32_t mode, uint32_t mark,
 						old_mode);
 	record_postimage(mark, mode, postimage_len);
 }
+
+void fast_export_blob_delta_rev(uint32_t mode, uint32_t mark, uint32_t old_mode,
+				uint32_t old_rev, const uint32_t *old_path,
+				uint32_t len, struct line_buffer *input)
+{
+	long postimage_len;
+	if (len > maximum_signed_value_of_type(off_t))
+		die("enormous delta");
+	postimage_len = delta_apply(mark, (off_t) len, input,
+					cat_from_rev(old_rev, old_path),
+					old_mode);
+	record_postimage(mark, mode, postimage_len);
+}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 6f77c3b..487d3d4 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -13,5 +13,8 @@ void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 void fast_export_blob_delta(uint32_t mode, uint32_t mark,
 			uint32_t old_mode, uint32_t old_mark,
 			uint32_t len, struct line_buffer *input);
+void fast_export_blob_delta_rev(uint32_t mode, uint32_t mark, uint32_t old_mode,
+			uint32_t old_rev, const uint32_t *old_path,
+			uint32_t len, struct line_buffer *input);
 
 #endif
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index f5b1da8..c08abac 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -65,7 +65,7 @@ uint32_t pool_tok_r(char *str, const char *delim, char **saveptr)
 	return token ? pool_intern(token) : ~0;
 }
 
-void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream)
+void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
 {
 	uint32_t i;
 	for (i = 0; i < len && ~seq[i]; i++) {
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
index 222fb66..3720cf8 100644
--- a/vcs-svn/string_pool.h
+++ b/vcs-svn/string_pool.h
@@ -4,7 +4,7 @@
 uint32_t pool_intern(const char *key);
 const char *pool_fetch(uint32_t entry);
 uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
-void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream);
+void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str);
 void pool_reset(void);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c6d6337..da968fa 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -259,6 +259,12 @@ static void handle_node(void)
 		fast_export_blob(node_ctx.type, mark, node_ctx.textLength, &input);
 		return;
 	}
+	if (node_ctx.srcRev) {
+		fast_export_blob_delta_rev(node_ctx.type, mark, old_mode,
+					node_ctx.srcRev, node_ctx.src,
+					node_ctx.textLength, &input);
+		return;
+	}
 	fast_export_blob_delta(node_ctx.type, mark, old_mode, old_mark,
 				node_ctx.textLength, &input);
 }
-- 
1.7.2.4
