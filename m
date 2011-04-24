From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] diff.c: return filepair from diff_unmerge()
Date: Sun, 24 Apr 2011 13:51:27 -0700
Message-ID: <1303678289-27627-3-git-send-email-gitster@pobox.com>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6HY-00079d-Se
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab1DXUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:51:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773Ab1DXUvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:51:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C9BD46BF
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kS+k
	Gd98NtJoeOe6bSw5zV6x/Ho=; b=bRuTM6mkQjxjCm82iWVVD7naxNH8wv/Ss0dm
	5G1npUzgmef+HHLyFob5oeYdIRXKvfdSYEOcADVC1ld6224GG29lSYWFp1Mz+hdJ
	+JkDhAg5h7u0xz5fqhraWcb75nHRDQ1gFRMQGjIUb9I4YBn5rJ3sFO3aegRDM8jn
	cW1Cpks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=V7l62z
	qn9YvZClX0+0glswQhYAGOvsrcsZ5Zli2yyCuNcNBFZR3UNTgQJMs51Xg2hooAq9
	/aCI3wnoiSmLVZkpns7XG+HltwTfe/IRaei1rbpAEeejaLUNXz96XLC7coG/mVgP
	IXPbTim7+fik0OjGvLx/5J/amZsnrfGcp4osY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 755A746BE
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E084D46BD for
 <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1303678289-27627-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EDCE9B84-6EB4-11E0-871E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172001>

The underlying diff_queue() returns diff_filepair so that the caller can
further add information to it, and the helper function diff_unmerge()
utilizes the feature itself, but does not expose it to its callers, which
was kind of selfish.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   13 ++++++++-----
 diff.h |    2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 9a5c77c..4c34c64 100644
--- a/diff.c
+++ b/diff.c
@@ -4308,20 +4308,23 @@ void diff_change(struct diff_options *options,
 		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
-void diff_unmerge(struct diff_options *options,
-		  const char *path,
-		  unsigned mode, const unsigned char *sha1)
+struct diff_filepair *diff_unmerge(struct diff_options *options,
+				   const char *path,
+				   unsigned mode, const unsigned char *sha1)
 {
+	struct diff_filepair *pair;
 	struct diff_filespec *one, *two;
 
 	if (options->prefix &&
 	    strncmp(path, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(path);
 	two = alloc_filespec(path);
 	fill_filespec(one, sha1, mode);
-	diff_queue(&diff_queued_diff, one, two)->is_unmerged = 1;
+	pair = diff_queue(&diff_queued_diff, one, two);
+	pair->is_unmerged = 1;
+	return pair;
 }
 
 static char *run_textconv(const char *pgm, struct diff_filespec *spec,
diff --git a/diff.h b/diff.h
index bf2f44d..f51a8ee 100644
--- a/diff.h
+++ b/diff.h
@@ -209,7 +209,7 @@ extern void diff_change(struct diff_options *,
 			const char *fullpath,
 			unsigned dirty_submodule1, unsigned dirty_submodule2);
 
-extern void diff_unmerge(struct diff_options *,
+extern struct diff_filepair *diff_unmerge(struct diff_options *,
 			 const char *path,
 			 unsigned mode,
 			 const unsigned char *sha1);
-- 
1.7.5
