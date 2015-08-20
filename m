From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] describe: make '--always' fallback work after '--exact-match' failed
Date: Thu, 20 Aug 2015 14:13:43 +0200
Message-ID: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 14:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSOjS-00013Q-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 14:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbbHTMOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 08:14:05 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58941 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363AbbHTMOE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2015 08:14:04 -0400
Received: from x590d6ed3.dyn.telefonica.de ([89.13.110.211] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZSOjF-0006Zp-Qx; Thu, 20 Aug 2015 14:13:59 +0200
X-Mailer: git-send-email 2.5.0.343.g6f38143
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440072839.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276236>

'git describe [...] --always' should always show the unique abbreviated
object name as a fallback when the given commit cannot be described wit=
h
the given set of options, see da2478dbb0 (describe --always: fall back
to showing an abbreviated object name, 2008-03-02).

However, this is not the case when the combination '--exact-match
--always' is given and the commit cannot be described, because in such
cases 'git describe' errors out, as if '--always' were not given at all=
=2E

Respect '--always' and print the unique abbreviated object name instead
of erroring out when the commit cannot be described with '--exact-match
--always'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 builtin/describe.c  | 2 +-
 t/t6120-describe.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index a36c829e57..ce36032b1f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -266,7 +266,7 @@ static void describe(const char *arg, int last_one)
 		return;
 	}
=20
-	if (!max_candidates)
+	if (!always && !max_candidates)
 		die(_("no tag exactly matches '%s'"), sha1_to_hex(cmit->object.sha1)=
);
 	if (debug)
 		fprintf(stderr, _("searching to describe %s\n"), arg);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c0e5b2a627..57d50156bb 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -113,6 +113,8 @@ check_describe A-3-* --long HEAD^^2
 check_describe c-7-* --tags
 check_describe e-3-* --first-parent --tags
=20
+check_describe $(git rev-parse --short HEAD) --exact-match --always HE=
AD
+
 : >err.expect
 check_describe A --all A^0
 test_expect_success 'no warning was displayed for A' '
--=20
2.5.0.343.g6f38143
