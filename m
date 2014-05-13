From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH] git format-patch --signature <string | file>
Date: Tue, 13 May 2014 01:21:36 -0700
Message-ID: <1399969296-31598-1-git-send-email-jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 10:21:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk7yF-0003ck-4a
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 10:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759414AbaEMIVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 04:21:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33086 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEMIVq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 04:21:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3107pbb.5
        for <git@vger.kernel.org>; Tue, 13 May 2014 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iaMs3J1WOjv3AUymqFE9iTC1lKokWQh1kNNTNRKLZrg=;
        b=eYyTJ8gmCeJ+HcPfgZ++W+v2LgM8V7eVMXBCHjssk7f8P7m0EGa1x7U/TFGZxYa2ML
         pbHnGPVVffsQ5yrFeeOLlriMPEhxFnmcU25THQHIwuXdwKxo/6yP06ScG8SiB8LbtjTL
         f4pW0EkVAIkhqAdHZRBHrmnPJJ1WFxhC3NhhCuXQhOqGog+86CY0KQxf+VC0chkm3fZM
         RbUfdq+5sNQ8AhfwvQ1E20/zj4wdcaZLRNJHn0f/zh0YnBmmJ+UmeaMlYOKAUkuhvBJV
         gbEgLocj9PtNMwFD3FkqfWgF6ocEp5R09T5sDa5bpaRSj3nYjzlzCAeQyjbiaXeZPXNR
         6bwQ==
X-Received: by 10.69.20.10 with SMTP id gy10mr3544362pbd.162.1399969305749;
        Tue, 13 May 2014 01:21:45 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id it4sm26863212pbc.39.2014.05.13.01.21.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 01:21:44 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 13 May 2014 01:21:41 -0700
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248755>

Improved format-patch --signature option so that it can
read from a file as well as from a string.

  # from a string
  $ git format-patch --signature "from a string" origin

  # or from a file
  $ git format-patch --signature ~/.signature origin

Now signatures with newlines or other special characters
can be easily included.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/log.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..5988f8f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1147,6 +1147,27 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int signature_callback(const struct option *opt, const char *arg,
+							int unset)
+{
+	const char **signature = opt->value;
+	static char buf[1024];
+	size_t sz;
+	FILE *fp;
+
+	fp = fopen(arg, "r");
+	if (fp) {
+		sz = sizeof(buf);
+		sz = fread(buf, 1, sz - 1, fp);
+		buf[sz] = '\0';
+		*signature = buf;
+		fclose(fp);
+	} else {
+		*signature = arg;
+	}
+	return 0;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1228,8 +1249,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "thread", &thread, N_("style"),
 			    N_("enable message threading, styles: shallow, deep"),
 			    PARSE_OPT_OPTARG, thread_callback },
-		OPT_STRING(0, "signature", &signature, N_("signature"),
-			    N_("add a signature")),
+		{ OPTION_CALLBACK, 0, "signature", &signature, N_("signature-file"),
+				N_("add a signature from a string or a file"),
+			    PARSE_OPT_NONEG, signature_callback },
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
