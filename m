From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: [PATCH v2] sha1_file: do not add own object directory as alternate
Date: Mon, 14 Jul 2014 14:53:01 +0200
Message-ID: <53C3D2AD.9050204@gmail.com>
References: <53BFB055.206@gmail.com> <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com> <53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com> <CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:52:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6fkQ-0001Gv-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 14:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872AbaGNMwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 08:52:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55797 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaGNMwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 08:52:45 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2468561wib.11
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ie3ChSlGdqm0kM1nXD3qGxmrFDO2di3xLWmYRjtzC/Q=;
        b=dIe8tkfkowiE95wpxxzz6885nR32mPAQ9axFuXWaDeMQUtH+lkoiEfbwBz37eoyAh5
         aX8BhqHhyomyYzO9mcgO38vwYiEJMxYzf/uiMUTHKshKwFw5xGYpJ/S1iBL2cCQp5vkU
         l5+tSRTKoucKk1YVuxQBPU4EmT1uHfVvZVByAESbfoODzMOWHk5arTllx54VDPzn2H7q
         Z4S7uNMjnkaLO8/ri9wnp2A1v+vp/Kk1cCynfmi+ZcgVcn9rPpIy5OFiLk5P4XTJ+3Qj
         5UKi7M3D6L1nzEs1TnXzLSBmHuYqb7K+jSy80m6mW8LzFXALSpRs8xomigMAaU4wbbYt
         qBOg==
X-Received: by 10.194.219.225 with SMTP id pr1mr19614604wjc.34.1405342363501;
        Mon, 14 Jul 2014 05:52:43 -0700 (PDT)
Received: from floh-wuff-book.speedport_w723_v_typ_a_1_01_001 (p57B36443.dip0.t-ipconnect.de. [87.179.100.67])
        by mx.google.com with ESMTPSA id ei3sm30880596wib.13.2014.07.14.05.52.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 05:52:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253490>

When adding alternate object directories, we try not to add the
directory of the current repository to avoid cycles.  Unfortunately,
that test was broken, since it compared an absolute with a relative
path.

Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
---
As proposed by Duy, v2 of the patch normalizes the object directory,
uses strcmp_icase for case-insensitive file systems, and moves the
path normalization to link_alt_odb_entries to save some cycles.

Additionally, the test is now more compact by using the already
prepared git repository instead of a new one, and tests if the
path normalization for both objectdir and alternate works.

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
index 0000000..3771613
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
+	echo $PWD/.git/objects/../objects > .git/objects/info/alternates
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
