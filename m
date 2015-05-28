From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] config.c: fix mmap leak when writing config
Date: Thu, 28 May 2015 03:54:43 -0400
Message-ID: <20150528075443.GB23395@peff.net>
References: <20150528075142.GB3688@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:54:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxseQ-0008WU-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 09:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbE1Hyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 03:54:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:37102 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752159AbbE1Hyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 03:54:46 -0400
Received: (qmail 15940 invoked by uid 102); 28 May 2015 07:54:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 02:54:46 -0500
Received: (qmail 14094 invoked by uid 107); 28 May 2015 07:54:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 03:54:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 03:54:43 -0400
Content-Disposition: inline
In-Reply-To: <20150528075142.GB3688@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270130>

We mmap the existing config file, but fail to unmap it if we
hit an error. The function already has a shared exit path,
so we can fix this by moving the mmap pointer to the
function scope and clearing it in the shared exit.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index ab46462..6917100 100644
--- a/config.c
+++ b/config.c
@@ -1939,6 +1939,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	int ret;
 	struct lock_file *lock = NULL;
 	char *filename_buf = NULL;
+	char *contents = NULL;
+	size_t contents_sz;
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
@@ -1988,8 +1990,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			goto write_err_out;
 	} else {
 		struct stat st;
-		char *contents;
-		size_t contents_sz, copy_begin, copy_end;
+		size_t copy_begin, copy_end;
 		int i, new_line = 0;
 
 		if (value_regex == NULL)
@@ -2108,8 +2109,6 @@ int git_config_set_multivar_in_file(const char *config_filename,
 					  contents_sz - copy_begin) <
 			    contents_sz - copy_begin)
 				goto write_err_out;
-
-		munmap(contents, contents_sz);
 	}
 
 	if (commit_lock_file(lock) < 0) {
@@ -2135,6 +2134,8 @@ out_free:
 	if (lock)
 		rollback_lock_file(lock);
 	free(filename_buf);
+	if (contents)
+		munmap(contents, contents_sz);
 	return ret;
 
 write_err_out:
-- 
2.4.2.668.gc3b1ade.dirty
