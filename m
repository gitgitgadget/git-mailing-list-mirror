From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] Forbid DEL characters in reference names
Date: Sat, 27 Aug 2011 06:12:44 +0200
Message-ID: <1314418364-2532-3-git-send-email-mhagger@alum.mit.edu>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 06:13:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxAHJ-0006ji-2X
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 06:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab1H0ENs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 00:13:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35079 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1H0ENr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 00:13:47 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED1A9.dip.t-dialin.net [84.190.209.169])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7R4DCBX009101;
	Sat, 27 Aug 2011 06:13:34 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180219>

DEL is an ASCII control character and therefore should not be
permitted in reference names.  Add tests for this and other unusual
characters.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Please check that the uses of "printf" in the test script are portable
and quoted correctly.

 refs.c                      |    2 +-
 t/t1402-check-ref-format.sh |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 3a8789d..0fa8dcf 100644
--- a/refs.c
+++ b/refs.c
@@ -837,7 +837,7 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 
 static inline int bad_ref_char(int ch)
 {
-	if (((unsigned) ch) <= ' ' ||
+	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
 	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
 		return 1;
 	/* 2.13 Pattern Matching Notation */
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 7563043..ed4275a 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -30,6 +30,9 @@ invalid_ref 'heads/foo.lock'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
+invalid_ref "$(printf 'heads/foo\t')"
+invalid_ref "$(printf 'heads/foo\177')"
+valid_ref "$(printf 'heads/fu\303\237')"
 
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
-- 
1.7.6.8.gd2879
