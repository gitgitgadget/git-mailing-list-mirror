From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Sat, 16 May 2015 13:06:36 -0700
Message-ID: <1431806796-28902-1-git-send-email-gjthill@gmail.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 22:06:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtiMH-00065q-SO
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 22:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbbEPUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 16:06:46 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36154 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbbEPUGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 16:06:46 -0400
Received: by igbpi8 with SMTP id pi8so21924322igb.1
        for <git@vger.kernel.org>; Sat, 16 May 2015 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=fYRg+UE1hXxSp+mUk3NK4GukO5mQ7t8mqlb2swQ6c8w=;
        b=Ya+g2qYrIErTRVHaRPeVztYGlq5XU2hsOf7o2fscjbwckNjw865jv5uNJfB+d94Uyj
         o+j6rMVJSD9wCCNk3zDR85cDes+iIqF5Pi0v5mSiq5EEi1UiCWYmRTLjXu0NiRFN2g8z
         nI6j44wKouMN3EhHEdzn3f+UOL+WpwM/17Z47Yer1gttS5huvBKhHG93D4oGu30H/6CA
         fAxWFpjq0a/vQLjSIA2OZifI7OQ1u46N2RqCm5ZcErCsRYDB1fklXAgscOqNct7VaIf2
         UxBqPe/CYrMgb8sqisBbynkUC+VuRpVzmbrj9eTBvu8k4YJykhdwRuhIoV7Lru4pBd6E
         aMhg==
X-Received: by 10.42.43.199 with SMTP id y7mr27428020ice.12.1431806805471;
        Sat, 16 May 2015 13:06:45 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id d4sm2034328igl.1.2015.05.16.13.06.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 May 2015 13:06:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.g08cda19
In-Reply-To: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269202>

`git add` of an empty file with a filter pops complaints from
`copy_fd` about a bad file descriptor.

This traces back to these lines in sha1_file.c:index_core:

	if (!size) {
		ret = index_mem(sha1, NULL, size, type, path, flags);

The problem here is that content to be added to the index can be
supplied from an fd, or from a memory buffer, or from a pathname. This
call is supplying a NULL buffer pointer and a zero size.

Downstream logic takes the complete absence of a buffer to mean the
data is to be found elsewhere -- for instance, these, from convert.c:

	if (params->src) {
		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
	} else {
		write_err = copy_fd(params->fd, child_process.in);
	}

~If there's a buffer, write from that, otherwise the data must be coming
from an open fd.~

Perfectly reasonable logic in a routine that's going to write from
either a buffer or an fd.

So change `index_core` to supply an empty buffer when indexing an empty
file.

There's a patch out there that instead changes the logic quoted above to
take a `-1` fd to mean "use the buffer", but it seems to me that the
distinction between a missing buffer and an empty one carries intrinsic
semantics, where the logic change is adapting the code to handle
incorrect arguments.

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
I promise to pay more attention to test quality in the future, thanks for the
patience.

 sha1_file.c           |  2 +-
 t/t0021-conversion.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index f860d67..61e2735 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3186,7 +3186,7 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 	int ret;
 
 	if (!size) {
-		ret = index_mem(sha1, NULL, size, type, path, flags);
+		ret = index_mem(sha1, "", size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index ca7d2a6..bf87e9b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -216,4 +216,30 @@ test_expect_success EXPENSIVE 'filter large file' '
 	! test -s err
 '
 
+test_expect_success "filter: clean empty file" '
+	git config filter.in-repo-header.clean  "echo cleaned && cat" &&
+	git config filter.in-repo-header.smudge "sed 1d" &&
+
+	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
+	>empty-in-worktree &&
+
+	echo cleaned >expected &&
+	git add empty-in-worktree &&
+	git show :empty-in-worktree >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success "filter: smudge empty file" '
+	git config filter.empty-in-repo.clean true &&
+	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
+
+	echo "empty-in-repo filter=empty-in-repo"  >>.gitattributes &&
+	echo dead data walking >empty-in-repo &&
+	git add empty-in-repo &&
+
+	echo smudged >expected &&
+	git checkout-index --prefix=filtered- empty-in-repo &&
+	test_cmp expected filtered-empty-in-repo
+'
+
 test_done
-- 
2.4.1.4.g08cda19
