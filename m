From: Ephrim Khong <dr.khong@gmail.com>
Subject: [PATCH v3] sha1_file: do not add own object directory as alternate
Date: Tue, 15 Jul 2014 13:29:45 +0200
Message-ID: <53C510A9.4010208@gmail.com>
References: <53BFB055.206@gmail.com> <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com> <53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com> <CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com> <53C3D2AD.9050204@gmail.com> <53C4BFC7.2000507@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 13:30:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X70w2-0006Ty-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 13:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbaGOLaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 07:30:11 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:62751 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758703AbaGOLaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 07:30:09 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so4826624wgh.32
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NwaiGE1zT5MYaH5SG3lUqe4YnTOkqv3qJk8N0KCUKL4=;
        b=tdtyDDSWqFT+F9DkNo2+5RxeuEOR+CGv3b4RH/1UprQG4DL3VPQevNC3ErfnRnVwoq
         MKW7YfWyvrVJR0djpvOlrQ5+Tw+xjiq3g6SavzwGnMcS5cliZGBUqPAd/SKHhGObz4aH
         ay1/ElvzSDOHRtoTE980pt8g2hAa8168ua291L+Id7cg64AMvAl9P2m9xlmdfYpZaYS/
         wMGxUGqhqYGrN25rzNX1I2SE7l/IwjIHnx716uIy+Q9zVG0VW3gOdNbKtr/dDs7mws/K
         ia8RDFYdHudUD6Dd3Sj1N5Gp+1w4G1SgozdTA6tf93XKUCnj/Y5BXf/OVp950XATavcb
         /fUg==
X-Received: by 10.180.198.173 with SMTP id jd13mr4998474wic.9.1405423807851;
        Tue, 15 Jul 2014 04:30:07 -0700 (PDT)
Received: from floh-wuff-book.local (valur.mvtec.com. [62.96.232.141])
        by mx.google.com with ESMTPSA id cj8sm32039356wjb.5.2014.07.15.04.29.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 04:30:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C4BFC7.2000507@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253554>

When adding alternate object directories, we try not to add the
directory of the current repository to avoid cycles.  Unfortunately,
that test was broken, since it compared an absolute with a relative
path.

Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
---
Since v2: Added Johannes' comments.

 sha1_file.c                        | 13 +++++++++----
 t/t7702-repack-cyclic-alternate.sh | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100755 t/t7702-repack-cyclic-alternate.sh

diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..88fd168 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -268,9 +268,9 @@ static struct alternate_object_database **alt_odb_tail;
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char *entry, const char *relative_base, int depth)
+static int link_alt_odb_entry(const char *entry, const char *relative_base,
+	int depth, const char *normalized_objdir)
 {
-	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
 	struct alternate_object_database *alt;
 	int pfxlen, entlen;
@@ -320,7 +320,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base, int
 			return -1;
 		}
 	}
-	if (!strcmp(ent->base, objdir)) {
+	if (!strcmp_icase(ent->base, normalized_objdir)) {
 		free(ent);
 		return -1;
 	}
@@ -344,6 +344,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 	struct string_list entries = STRING_LIST_INIT_NODUP;
 	char *alt_copy;
 	int i;
+	struct strbuf objdirbuf = STRBUF_INIT;

 	if (depth > 5) {
 		error("%s: ignoring alternate object stores, nesting too deep.",
@@ -351,6 +352,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		return;
 	}

+	strbuf_addstr(&objdirbuf, absolute_path(get_object_directory()));
+	normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
+
 	alt_copy = xmemdupz(alt, len);
 	string_list_split_in_place(&entries, alt_copy, sep, -1);
 	for (i = 0; i < entries.nr; i++) {
@@ -361,11 +365,12 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 			error("%s: ignoring relative alternate object store %s",
 					relative_base, entry);
 		} else {
-			link_alt_odb_entry(entry, relative_base, depth);
+			link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
 		}
 	}
 	string_list_clear(&entries, 0);
 	free(alt_copy);
+	strbuf_release(&objdirbuf);
 }

 void read_info_alternates(const char * relative_base, int depth)
diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
new file mode 100755
index 0000000..8341d46
--- /dev/null
+++ b/t/t7702-repack-cyclic-alternate.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Ephrim Khong
+#
+
+test_description='repack involving cyclic alternate'
+. ./test-lib.sh
+
+test_expect_success setup '
+	GIT_OBJECT_DIRECTORY=.git//../.git/objects &&
+	export GIT_OBJECT_DIRECTORY &&
+	touch a &&
+	git add a &&
+	git commit -m 1 &&
+	git repack -adl &&
+	echo "$(pwd)"/.git/objects/../objects >.git/objects/info/alternates
+'
+
+test_expect_success 're-packing repository with itsself as alternate' '
+	git repack -adl &&
+	git fsck
+'
+
+test_done
-- 
1.8.4.3
