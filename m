From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] merge-recursive: respect core.autocrlf
Date: Mon, 9 Jun 2008 23:59:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806092305430.1783@racer>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net> <alpine.DEB.1.00.0806092221420.1783@racer> <alpine.DEB.1.00.0806092223010.1783@racer> <7vod6affz6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qMy-0003bq-N0
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYFIXAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbYFIXAv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:00:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:54060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752208AbYFIXAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:00:51 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:00:48 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 10 Jun 2008 01:00:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VLU41f2xVxaulaMtmofhrk7ydtf7svw9b6JGgTg
	RNeKBw+lI3G6rk
X-X-Sender: gene099@racer
In-Reply-To: <7vod6affz6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84447>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 9 Jun 2008, Junio C Hamano wrote:

	> Fairly straightforward fix, except that I suspect this needs to 
	> be done only for regular files and not symlinks.
	> 
	> I think entry.c:write_entry() shows how this should be done.

	Right.  And the relevant clause is actually already there.  D'oh.

 builtin-merge-recursive.c |   12 +++++++++++-
 t/t6033-merge-crlf.sh     |    2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 7643f17..1fbff3a 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -535,13 +535,22 @@ static void update_file_flags(const unsigned char *sha,
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
 		if (type != OBJ_BLOB)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
-
 		if (make_room_for_path(path) < 0) {
 			update_wd = 0;
 			goto update_index;
 		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
+			struct strbuf strbuf;
+
+			strbuf_init(&strbuf, 0);
+			if (convert_to_working_tree(path, buf, size, &strbuf)) {
+				size_t newsize = 0;
+				free(buf);
+				buf = strbuf_detach(&strbuf, &newsize);
+				size = newsize;
+			}
+
 			if (mode & 0100)
 				mode = 0777;
 			else
@@ -560,6 +569,7 @@ static void update_file_flags(const unsigned char *sha,
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
