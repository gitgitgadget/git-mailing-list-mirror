From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] merge-recursive: respect core.autocrlf
Date: Mon, 9 Jun 2008 22:23:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806092223010.1783@racer>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net> <alpine.DEB.1.00.0806092221420.1783@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:26:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5os6-0004Ak-80
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 23:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759629AbYFIVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 17:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761039AbYFIVYg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 17:24:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:33589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759629AbYFIVYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 17:24:35 -0400
Received: (qmail invoked by alias); 09 Jun 2008 21:24:33 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 09 Jun 2008 23:24:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hxBUtZHXhMJb+/ilAuRLiVR8NdP7au4AIeTbzWg
	eOYmL/w1US32/p
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806092221420.1783@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84433>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-merge-recursive.c |    8 ++++++++
 t/t6033-merge-crlf.sh     |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 7643f17..edd023f 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -525,6 +525,7 @@ static void update_file_flags(const unsigned char *sha,
 		enum object_type type;
 		void *buf;
 		unsigned long size;
+		struct strbuf strbuf;
 
 		if (S_ISGITLINK(mode))
 			die("cannot read object %s '%s': It is a submodule!",
@@ -535,6 +536,12 @@ static void update_file_flags(const unsigned char *sha,
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
 		if (type != OBJ_BLOB)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
+		strbuf_init(&strbuf, 0);
+		if (convert_to_working_tree(path, buf, size, &strbuf)) {
+			free(buf);
+			size = strbuf.len;
+			buf = strbuf_detach(&strbuf, NULL);
+		}
 
 		if (make_room_for_path(path) < 0) {
 			update_wd = 0;
@@ -560,6 +567,7 @@ static void update_file_flags(const unsigned char *sha,
 		} else
 			die("do not know what to do with %06o %s '%s'",
 			    mode, sha1_to_hex(sha), path);
+		free(buf);
 	}
  update_index:
 	if (update_cache)
diff --git a/t/t6033-merge-crlf.sh b/t/t6033-merge-crlf.sh
index ea22837..75d9602 100755
--- a/t/t6033-merge-crlf.sh
+++ b/t/t6033-merge-crlf.sh
@@ -42,7 +42,7 @@ test_expect_success 'Check "ours" is CRLF' '
 	test_cmp file file.temp
 '
 
-test_expect_failure 'Check that conflict file is CRLF' '
+test_expect_success 'Check that conflict file is CRLF' '
 	git reset --hard a &&
 	test_must_fail git merge side &&
 	cat file | remove_cr | append_cr >file.temp &&
-- 
1.5.6.rc1.181.gb439d
