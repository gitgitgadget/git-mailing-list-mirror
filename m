From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 5/6] fast-export: Fix output order of D/F changes
Date: Fri,  9 Jul 2010 07:10:55 -0600
Message-ID: <1278681056-31460-6-git-send-email-newren@gmail.com>
References: <1278681056-31460-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 09 15:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDEw-000077-Ck
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202Ab0GINDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:03:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40579 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab0GINDK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:03:10 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so433270pzk.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=E++VJN5NKtzQGDcVxlO/D5Gfe5FK8TnN9DQFZsiA3Fc=;
        b=eqYqCS8jeZVeLWpFD9yIvnsQ+m/e3N26WAwnUV7UdBfdQJn6oCYmli5RJQ+uhMPDMZ
         P8xgAYXHc7LApyQXRDavLifwXxUQxzvvm8vH4QxKPJIqx2aOsYQ/QKgxrZJPdJJ6GIxD
         adDssx/zV1L0qhfWygfUcGcPhZ1jM1MhxR7Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dFcfCb9rfCWdKh5iiKu4M+qnKypInZHM7royOeBhfcWbUHWnOkLMvOn5T5SKlyhuxB
         VIrWiq7MCXeiLZ3+KetVXATTX+7xS3G1J9IYX62PSer+k5Kf0ScNZXyNwSH1+TrhAbxs
         EOVPMClOL8T2CsaWalWE/Mm6O96U2ECeqVWEg=
Received: by 10.142.199.20 with SMTP id w20mr11324713wff.251.1278680590482;
        Fri, 09 Jul 2010 06:03:10 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id b1sm700259rvn.2.2010.07.09.06.03.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:03:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.23.gafea6
In-Reply-To: <1278681056-31460-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150662>

The fast-import stream format requires incremental changes which take place
immediately, meaning that for D->F conversions all files below the relevant
directory must be deleted before the resulting file of the same name is
created.  Reversing the order can result in fast-import silently deleting
the file right after creating it, resulting in the file missing from the
resulting repository.

We correct this by first sorting the diff_queue_struct in depth-first
order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Email from Junio:
> If all you want is to force a particular order of paths in the output
> (e.g. depth first) in this one single application, the cleanest way might
> be to let the diffcore do its work and at the very end sort the elements
> in the diff_queued_diff to your liking (c.f. diffcore_fix_diff_index()
> that uses diffnamecmp() to sort the list).
This patch is my attempt to do precisely that.

 builtin/fast-export.c  |   29 +++++++++++++++++++++++++++++
 t/t9350-fast-export.sh |    2 +-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..965e90e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -147,10 +147,39 @@ static void handle_object(const unsigned char *sha1)
 	free(buf);
 }
 
+static int depth_first(const void *a_, const void *b_)
+{
+	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
+	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
+	const char *name_a, *name_b;
+	int len_a, len_b, len;
+	int cmp;
+
+	name_a = a->one ? a->one->path : a->two->path;
+	name_b = b->one ? b->one->path : b->two->path;
+
+	len_a = strlen(name_a);
+	len_b = strlen(name_b);
+	len = (len_a < len_b) ? len_a : len_b;
+
+	/* strcmp will sort 'd' before 'd/e', we want 'd/e' before 'd' */
+	cmp = memcmp(name_a, name_b, len);
+	if (cmp)
+		return cmp;
+	return (len_b - len_a);
+}
+
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
 	int i;
+
+	/*
+	 * Handle files below a directory first, in case they are all deleted
+	 * and the directory changes to a file or symlink.
+	 */
+	qsort(q->queue, q->nr, sizeof(q->queue[0]), depth_first);
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *ospec = q->queue[i]->one;
 		struct diff_filespec *spec = q->queue[i]->two;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 69179c6..1ee1461 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,7 +376,7 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-test_expect_failure 'directory becomes symlink'        '
+test_expect_success 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
 	(
-- 
1.7.1.1.23.gafea6
