From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH] Support copy and rename detection in fast-export.
Date: Mon, 21 Jul 2008 12:16:00 +0400
Organization: TEPKOM
Message-ID: <200807211216.01694.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 10:17:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqa4-00063w-0F
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbYGUIQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 04:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbYGUIQQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:16:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27501 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbYGUIQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 04:16:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so595754fgg.17
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=u2qsx6hdU+IqHMPijsqGTeneFhS+7YxWk2sKoGGsa/A=;
        b=TU1fmglEgi5yTp8/DKZ7qxdsSv0O6DGsODWip2jT+KfyCmFoxtC7ZeMtUmLTM7R6VH
         /wmEinYPCAPUEhkazzNd84kZ0tnpPLjIpvRZ/lXDKxwIvfjxukJK4lMTxZK1kMlHrIWw
         TjD8PlcmiajUQCGR244VAL57DqefriFYh1hig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=VjgCwmFO0W3x865pKPXX53nJEnVDlu5H/LF4shOb7QBAVSSOwKCc3d3LjrLfXiyshg
         B9sbLHg7e5G35mh8Dyeq7XKBzMcBy6etGvkS6CfHJVjJvVsrbBru1esIn8TBEDpy3rSU
         WeguMKRS9NWUR8hEkJXvZuz5+FebTp8y+baXE=
Received: by 10.86.92.7 with SMTP id p7mr4465257fgb.72.1216628170729;
        Mon, 21 Jul 2008 01:16:10 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id e20sm1245502fga.1.2008.07.21.01.16.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 01:16:09 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89320>

Although it does not matter for Git itself, tools that
export to systems that explicitly track copies and
renames can benefit from such information.

This patch makes fast-export output correct action
logs when -M or -C are enabled.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I'm thinking about Git->SVN conversion, like http://repo.or.cz/w/git2svn.git

	The trouble with this patch is that old versions of fast-export
	accept -M and -C, but produce garbage if they are specified.
	So the only way for the users to ensure that it is supported is
	to check the git version (or directly test it).

	As a somewhat related question, in which order does fast-export
	output the commits, beside topological? In particular, does it order
	commits on parrallel branches (i.e. not topologically dependent) by date?
	
	-- Alexander

 builtin-fast-export.c  |   28 ++++++++++++++++++++++++++--
 t/t9301-fast-export.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 8bea269..3225e8f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -118,10 +118,27 @@ static void show_filemodify(struct diff_queue_struct *q,
 {
 	int i;
 	for (i = 0; i < q->nr; i++) {
+		struct diff_filespec *ospec = q->queue[i]->one;
 		struct diff_filespec *spec = q->queue[i]->two;
-		if (is_null_sha1(spec->sha1))
+
+		switch (q->queue[i]->status) {
+		case DIFF_STATUS_DELETED:
 			printf("D %s\n", spec->path);
-		else {
+			break;
+
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			printf("%c \"%s\" \"%s\"\n", q->queue[i]->status,
+			       ospec->path, spec->path);
+
+			if (!hashcmp(ospec->sha1, spec->sha1) &&
+			    ospec->mode == spec->mode)
+				break;
+			/* fallthrough */
+
+		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_ADDED:
 			/*
 			 * Links refer to objects in another repositories;
 			 * output the SHA-1 verbatim.
@@ -134,6 +151,13 @@ static void show_filemodify(struct diff_queue_struct *q,
 				printf("M %06o :%d %s\n", spec->mode,
 				       get_object_mark(object), spec->path);
 			}
+			break;
+
+		default:
+			die("Unexpected comparison status '%c' for %s, %s",
+				q->queue[i]->status,
+				ospec->path ? ospec->path : "none",
+				spec->path ? spec->path : "none");
 		}
 	}
 }
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index f18eec9..bb595b7 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -162,4 +162,50 @@ test_expect_success 'submodule fast-export | fast-import' '
 
 '
 
+export GIT_AUTHOR_NAME='A U Thor'
+export GIT_COMMITTER_NAME='C O Mitter'
+
+test_expect_success 'setup copies' '
+
+	git config --unset i18n.commitencoding &&
+	git checkout -b copy rein &&
+	git mv file file3 &&
+	git commit -m move1 &&
+	test_tick &&
+	cp file2 file4 &&
+	git add file4 &&
+	git mv file2 file5 &&
+	git commit -m copy1 &&
+	test_tick &&
+	cp file3 file6 &&
+	git add file6 &&
+	git commit -m copy2 &&
+	test_tick &&
+	echo more text >> file6 &&
+	echo even more text >> file6 &&
+	git add file6 &&
+	git commit -m modify &&
+	test_tick &&
+	cp file6 file7 &&
+	echo test >> file7 &&
+	git add file7 &&
+	git commit -m copy_modify
+
+'
+
+test_expect_success 'fast-export -C -C | fast-import' '
+
+	ENTRY=$(git rev-parse --verify copy) &&
+	rm -rf new &&
+	mkdir new &&
+	git --git-dir=new/.git init &&
+	git fast-export -C -C --signed-tags=strip --all > output &&
+	grep "^C \"file6\" \"file7\"\$" output &&
+	cat output |
+	(cd new &&
+	 git fast-import &&
+	 test $ENTRY = $(git rev-parse --verify refs/heads/copy))
+
+'
+
 test_done
-- 
1.5.6.3.18.gfe82
