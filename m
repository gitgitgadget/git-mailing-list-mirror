From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/14] setup_temporary_shallow(): use tempfile module
Date: Mon,  8 Jun 2015 11:07:40 +0200
Message-ID: <0570e039e6464ec9e0fdf20a7f50782ee19c006d.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2g-0002Yk-Lm
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbFHJIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:21 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60500 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752798AbbFHJIF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:05 -0400
X-AuditID: 1207440e-f79fc6d000000caf-5b-55755b721f71
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B4.15.03247.27B55755; Mon,  8 Jun 2015 05:08:03 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojX010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:02 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFscXRpq0L+EyaLrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd8XjZNaaC
	A/wVD1afYmxg/M3TxcjJISFgInHo+EVmCFtM4sK99WxdjFwcQgKXGSUOPr7CCuGcYJJY8W4+
	G0gVm4CuxKKeZiYQW0TAUeLEg+usIDazgIPE5s+NjCC2sICrxM0LK4HiHBwsAqoSE/9kg4R5
	BaIkJi56zgixTE7i/PGfYIs5BSwkfn3dxQRSLiRgLvFjLusERt4FjAyrGOUSc0pzdXMTM3OK
	U5N1i5MT8/JSi3SN9XIzS/RSU0o3MUKCh28HY/t6mUOMAhyMSjy8BxaVhAqxJpYVV+YeYpTk
	YFIS5f0YURoqxJeUn1KZkVicEV9UmpNafIhRgoNZSYSXyQIox5uSWFmVWpQPk5LmYFES51Vb
	ou4nJJCeWJKanZpakFoEk5Xh4FCS4P0RCdQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRY
	WpIRD4qL+GJgZICkeID2ngJp5y0uSMwFikK0nmJUlBLnNYoCSgiAJDJK8+DGwlLCK0ZxoC+F
	eW1AqniA6QSu+xXQYCagwd+/FoMMLklESEk1MC5daP3p0t11h/57P10/9akr78NZ3TV+5yPc
	K9s+vWtJ3GXqrPvAcwPrprTXb+cLVMw5rha5281p+W2D9//OavdxKs/Tjkl7e/xr7Y/yGJ7n
	sodrJk2xdPoddW7qC9k3TFL8EpLes7ekvD7veSMxN5XhjXX0pE2Z9QdycqM/7FH3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271002>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 shallow.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/shallow.c b/shallow.c
index 59ee321..311ba9b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -209,50 +209,28 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
 
-static struct strbuf temporary_shallow = STRBUF_INIT;
-
-static void remove_temporary_shallow(void)
-{
-	if (temporary_shallow.len) {
-		unlink_or_warn(temporary_shallow.buf);
-		strbuf_reset(&temporary_shallow);
-	}
-}
-
-static void remove_temporary_shallow_on_signal(int signo)
-{
-	remove_temporary_shallow();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static struct tempfile temporary_shallow;
 
 const char *setup_temporary_shallow(const struct sha1_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	if (temporary_shallow.len)
-		die("BUG: attempt to create two temporary shallow files");
-
 	if (write_shallow_commits(&sb, 0, extra)) {
-		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
-		fd = xmkstemp(temporary_shallow.buf);
-
-		atexit(remove_temporary_shallow);
-		sigchain_push_common(remove_temporary_shallow_on_signal);
+		fd = xmks_tempfile(&temporary_shallow, git_path("shallow_XXXXXX"));
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  temporary_shallow.buf);
-		close(fd);
+				  temporary_shallow.filename.buf);
+		close_tempfile(&temporary_shallow);
 		strbuf_release(&sb);
-		return temporary_shallow.buf;
+		return temporary_shallow.filename.buf;
 	}
 	/*
 	 * is_repository_shallow() sees empty string as "no shallow
 	 * file".
 	 */
-	return temporary_shallow.buf;
+	return temporary_shallow.filename.buf;
 }
 
 void setup_alternate_shallow(struct lock_file *shallow_lock,
-- 
2.1.4
