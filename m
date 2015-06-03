From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 14/19] pull: set reflog message
Date: Wed,  3 Jun 2015 14:48:58 +0800
Message-ID: <1433314143-4478-15-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VZ-0004sO-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbbFCGuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:32 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36586 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbFCGu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:27 -0400
Received: by pabqy3 with SMTP id qy3so668080pab.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mNArqkac751hH2ylba6xsUk4QMXENOb/EVEa0bTIFUs=;
        b=0uhYbBDElbIwGWHKI/W1WDHbfutv6n/Ux4fNNppGbvfQB9RavSQ+s508N8RPLdic/0
         Tjah7E3aILp9nQ1BxbKM2d3k6ZYpL1I7xkr4Ew8kNdQLcfTe5cXBTWRLnOIMQGc+1Mkb
         1RkjE7ci/AgEEbYmOXcRkMlqMWd4+lHYYBhpMP2TzsLOtayYyK1DYVqox7k6Kqkwr5W0
         tA+X29+DBYeyvx2qD59E1M7RLgIVmMn6shLVBmQz4YpcNIdAX7jj75VJ5Mi/Lr8wiou1
         jip61eymMCkiZXUPk9LVrCOChD3jfq3i0u/ihMe4H+RvA8ugVEfVpoPj22m+CwI0uETK
         SVOA==
X-Received: by 10.70.94.98 with SMTP id db2mr57520027pdb.130.1433314226689;
        Tue, 02 Jun 2015 23:50:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270652>

f947413 (Use GIT_REFLOG_ACTION environment variable instead.,
2006-12-28) established git-pull's method for setting the reflog
message, which is to set the environment variable GIT_REFLOG_ACTION to
the evaluation of "pull${1+ $*}" if it has not already been set.

Re-implement this behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Don't use strbuf_rtrim().

 builtin/pull.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index f0d4710..c44cc90 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -169,6 +169,25 @@ static void argv_push_force(struct argv_array *arr)
 }
 
 /**
+ * Sets the GIT_REFLOG_ACTION environment variable to the concatenation of argv
+ */
+static void set_reflog_message(int argc, const char **argv)
+{
+	int i;
+	struct strbuf msg = STRBUF_INIT;
+
+	for (i = 0; i < argc; i++) {
+		if (i)
+			strbuf_addch(&msg, ' ');
+		strbuf_addstr(&msg, argv[i]);
+	}
+
+	setenv("GIT_REFLOG_ACTION", msg.buf, 0);
+
+	strbuf_release(&msg);
+}
+
+/*
  * If pull.ff is "true", sets sb to "--ff". If pull.ff is "false", sets sb to
  * "--no-ff". If pull.ff is "only", sets sb to "--ff-only". If pull.ff is
  * set to an invalid value, die with an error.
@@ -442,6 +461,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die_errno("could not exec %s", path);
 	}
 
+	if (!getenv("GIT_REFLOG_ACTION"))
+		set_reflog_message(argc, argv);
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
-- 
2.1.4
