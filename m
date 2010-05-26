From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 088/104] for-each-ref: Field with abbreviated objectname
Date: Wed, 26 May 2010 18:00:58 +1200
Message-ID: <1274853674-18521-88-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:06:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lB-0004LR-36
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958Ab0EZGGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:30 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933727Ab0EZGGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:24 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 5970533774;
	Wed, 26 May 2010 18:02:04 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksQnWq1IvZNo; Wed, 26 May 2010 18:02:00 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 5F2CF338D2;
	Wed, 26 May 2010 18:01:36 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147750>

From: Michael J Gruber <git@drmicha.warpmail.net>

Introduce a :short modifier to objectname which outputs the abbreviated
object name.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-for-each-ref.txt |    1 +
 builtin/for-each-ref.c             |    3 +++
 t/t6300-for-each-ref.sh            |    9 +++++++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7e83288..390d85c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -86,6 +86,7 @@ objectsize::
 
 objectname::
 	The object name (aka SHA-1).
+	For a non-ambiguous abbreviation of the object name append `:short`.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 62be1bb..3a97953 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -227,6 +227,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			strcpy(s, sha1_to_hex(obj->sha1));
 			v->s = s;
 		}
+		else if (!strcmp(name, "objectname:short")) {
+			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
+		}
 	}
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8052c86..7dc8a51 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -295,6 +295,15 @@ test_expect_success 'Check short upstream format' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+67a36f1
+EOF
+
+test_expect_success 'Check short objectname format' '
+	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
1.7.1.rc2.333.gb2668
