From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] blame.c: Properly initialize strbuf after calling, textconv_object()
Date: Fri, 28 Oct 2011 17:28:28 +0200
Message-ID: <4EAACA1C.6020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 17:30:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJoOO-0006Ta-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 17:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab1J1Pao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 11:30:44 -0400
Received: from lo.gmane.org ([80.91.229.12]:42993 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637Ab1J1Pan (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 11:30:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJoOF-0006ML-Ov
	for git@vger.kernel.org; Fri, 28 Oct 2011 17:30:39 +0200
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 17:30:39 +0200
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 17:30:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184412>

For a plain string where only the length is known, strbuf.alloc needs to
be initialized to the length. Otherwise strbuf.alloc is 0 and a later
call to strbuf_setlen() will fail.

This bug surfaced when calling git blame under Windows on a *.doc file.
The *.doc file is converted to plain text by antiword via the textconv
mechanism. However, the plain text returned by antiword contains DOS line
endings instead of Unix line endings which triggered the strbuf_setlen()
which previous to this patch failed.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/blame.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 26a5d42..86c0537 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2113,8 +2113,10 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len))
+			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)) {
+				buf.alloc = buf_len;
 				buf.len = buf_len;
+			}
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
 			break;
-- 
1.7.7.msysgit.1.4.gcc6bb.dirty
