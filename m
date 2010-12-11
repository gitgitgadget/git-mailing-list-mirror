From: David Michael Barr <david.barr@cordelta.com>
Subject: [PATCH 12/10] vcs-svn: quote paths correctly for ls command
Date: Sun, 12 Dec 2010 10:04:39 +1100
Message-ID: <DD24C01C-19FD-424B-B602-E9BB1A930805@cordelta.com>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 00:07:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRYXF-0004Tz-1v
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 00:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0LKXEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 18:04:45 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:56625
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751909Ab0LKXEo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 18:04:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EALeRA03LWHsF/2dsb2JhbACkBgh4txyIToVKBA
X-IronPort-AV: E=Sophos;i="4.59,330,1288530000"; 
   d="scan'208";a="302583505"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 12 Dec 2010 10:04:42 +1100
Received: (qmail 9281 invoked from network); 12 Dec 2010 10:04:41 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 12 Dec 2010 10:04:41 +1100
In-Reply-To: <20101210102007.GA26298@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163463>

From: David Barr <david.barr@cordelta.com>
Date: Sun, 12 Dec 2010 03:59:31 +1100
Subject: [PATCH] vcs-svn: quote paths correctly for ls command

This bug was found while importing rev 601865 of ASF.

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/fast_export.c |    4 ++--
 vcs-svn/string_pool.c |   11 +++++++++++
 vcs-svn/string_pool.h |    1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index c798f6d..d2397d8 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -100,7 +100,7 @@ static void ls_from_rev(uint32_t rev, const uint32_t *path)
 {
 	/* ls :5 "path/to/old/file" */
 	printf("ls :%"PRIu32" \"", rev);
-	pool_print_seq(REPO_MAX_PATH_DEPTH, path, '/', stdout);
+	pool_print_seq_q(REPO_MAX_PATH_DEPTH, path, '/', stdout);
 	printf("\"\n");
 	fflush(stdout);
 }
@@ -149,7 +149,7 @@ void fast_export_ls(const uint32_t *path,
 				uint32_t *mode, struct strbuf *dataref)
 {
 	printf("ls \"");
-	pool_print_seq(REPO_MAX_PATH_DEPTH, path, '/', stdout);
+	pool_print_seq_q(REPO_MAX_PATH_DEPTH, path, '/', stdout);
 	printf("\"\n");
 	fflush(stdout);
 	parse_ls_response(get_response_line(), mode, dataref);
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index c08abac..a03f5a4 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -4,6 +4,8 @@
  */
 
 #include "git-compat-util.h"
+#include "strbuf.h"
+#include "quote.h"
 #include "trp.h"
 #include "obj_pool.h"
 #include "string_pool.h"
@@ -75,6 +77,15 @@ void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
 	}
 }
 
+void pool_print_seq_q(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
+{
+	uint32_t i;
+	for (i = 0; i < len && ~seq[i]; i++) {
+		quote_c_style(pool_fetch(seq[i]), NULL, stream, 1);
+		if (i < len - 1 && ~seq[i + 1])
+			fputc(delim, stream);
+	}
+}
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str)
 {
 	char *context = NULL;
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
index 3720cf8..96e501d 100644
--- a/vcs-svn/string_pool.h
+++ b/vcs-svn/string_pool.h
@@ -5,6 +5,7 @@ uint32_t pool_intern(const char *key);
 const char *pool_fetch(uint32_t entry);
 uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
 void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
+void pool_print_seq_q(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str);
 void pool_reset(void);
 
-- 
1.7.3.2.846.gf4b062
