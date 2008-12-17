From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/5] builtin-blame.c: use strbuf_readlink()
Date: Wed, 17 Dec 2008 12:37:53 -0800
Message-ID: <7vbpvaleqm.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171044110.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3B0-0001Yq-EU
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYLQUh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbYLQUh7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:37:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYLQUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:37:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C2191A7FB;
	Wed, 17 Dec 2008 15:37:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 431E71A806; Wed,
 17 Dec 2008 15:37:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97266372-CC7A-11DD-A180-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103386>

When faking a commit out of the work tree contents, use strbuf_readlink()
to read the contents of symbolic links.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git i/builtin-blame.c w/builtin-blame.c
index a0d6014..aae14ef 100644
--- i/builtin-blame.c
+++ w/builtin-blame.c
@@ -1996,7 +1996,6 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
 		const char *read_from;
-		unsigned long fin_size;
 
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
@@ -2008,7 +2007,6 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 				die("Cannot lstat %s", path);
 			read_from = path;
 		}
-		fin_size = xsize_t(st.st_size);
 		mode = canon_mode(st.st_mode);
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
@@ -2016,9 +2014,8 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 				die("cannot open or read %s", read_from);
 			break;
 		case S_IFLNK:
-			if (readlink(read_from, buf.buf, buf.alloc) != fin_size)
+			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
 				die("cannot readlink %s", read_from);
-			buf.len = fin_size;
 			break;
 		default:
 			die("unsupported file type %s", read_from);
