From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 0/3] pass credential.* to submodules
Date: Fri, 26 Feb 2016 16:13:17 -0800
Message-ID: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 01:13:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZSVk-0006yT-HA
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 01:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbcB0ANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 19:13:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:38260 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcB0ANX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 19:13:23 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 26 Feb 2016 16:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,506,1449561600"; 
   d="scan'208";a="924835107"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by fmsmga002.fm.intel.com with ESMTP; 26 Feb 2016 16:13:22 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287647>

From: Jacob Keller <jacob.keller@gmail.com>

This version of the series fixes up a few issues and implements
sq_quotef function to help make intent more clear in the code. I also
chose to use Jeff's implementation for the test fix since I think it
works better and I prefer the consistency of implementation.

Interdiff between v4 and v5:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c6c0a3b06e27..43943eef81b4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -147,16 +147,7 @@ static int sanitize_submodule_config(const char *var, const char *value, void *d
 		if (out->len)
 			strbuf_addch(out, ' ');
 
-		/*
-		 * The GIT_CONFIG_PARAMETERS parser is a bit picky and
-		 * requires that each var=value pair be quoted as a single
-		 * unit.
-		 */
-		strbuf_addstr(&quoted, var);
-		strbuf_addch(&quoted, '=');
-		strbuf_addstr(&quoted, value);
-
-		sq_quote_buf(out, quoted.buf);
+		sq_quotef(out, "%s=%s", var, value);
 	}
 
 	strbuf_release(&quoted);
diff --git a/quote.c b/quote.c
index fe884d24521f..b281a8fe454e 100644
--- a/quote.c
+++ b/quote.c
@@ -43,6 +43,19 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }
 
+void sq_quotef(struct strbuf *dst, const char *fmt, ...)
+{
+	struct strbuf src = STRBUF_INIT;
+
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&src, fmt, ap);
+	va_end(ap);
+
+	sq_quote_buf(dst, src.buf);
+	strbuf_release(&src);
+}
+
 void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 {
 	int i;
diff --git a/quote.h b/quote.h
index 99e04d34bf22..6c53a2cc66c4 100644
--- a/quote.h
+++ b/quote.h
@@ -25,10 +25,13 @@ struct strbuf;
  * sq_quote_buf() writes to an existing buffer of specified size; it
  * will return the number of characters that would have been written
  * excluding the final null regardless of the buffer size.
+ *
+ * sq_quotef() quotes the entire formatted string as a single result.
  */
 
 extern void sq_quote_buf(struct strbuf *, const char *src);
 extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
+extern void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
index 9d937de8b224..149d42864f29 100755
--- a/t/t7412-submodule--helper.sh
+++ b/t/t7412-submodule--helper.sh
@@ -16,12 +16,11 @@ test_expect_success 'sanitize-config clears configuration' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'sanitize-config keeps credential.helper' "
+sq="'"
+test_expect_success 'sanitize-config keeps credential.helper' '
 	git -c credential.helper=helper submodule--helper sanitize-config >actual &&
-	cat >expect <<-EOF &&
-	'credential.helper=helper'
-	EOF
+	echo "${sq}credential.helper=helper${sq}" >expect &&
 	test_cmp expect actual
-"
+'
 
 test_done

Jacob Keller (3):
  sumodule--helper: fix submodule--helper clone usage and check argc
    count
  quote: implement sq_quotef()
  git: submodule honor -c credential.* from command line

 builtin/submodule--helper.c  | 73 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh             | 40 +++++++++++++++---------
 quote.c                      | 13 ++++++++
 quote.h                      |  3 ++
 t/t5550-http-fetch-dumb.sh   | 17 +++++++++++
 t/t7412-submodule--helper.sh | 26 ++++++++++++++++
 6 files changed, 155 insertions(+), 17 deletions(-)
 create mode 100755 t/t7412-submodule--helper.sh

-- 
2.7.1.429.g45cd78e
