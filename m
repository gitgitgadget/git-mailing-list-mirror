From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] status: don't say 'HEAD detached at HEAD'
Date: Sun, 27 Sep 2015 17:13:42 +0200
Message-ID: <1443366822-1753-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1443366822-1753-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 27 17:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgDee-00023l-SC
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 17:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbbI0POQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 11:14:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55989 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbbI0PON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 11:14:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8RFE3dv004332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 27 Sep 2015 17:14:03 +0200
Received: from estrop.imag.fr (estrop.imag.fr [129.88.7.56])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8RFE50l011740;
	Sun, 27 Sep 2015 17:14:05 +0200
Received: from moy by estrop.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZgDeP-0000VQ-Ki; Sun, 27 Sep 2015 17:14:05 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1443366822-1753-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 27 Sep 2015 17:14:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8RFE3dv004332
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443971647.54948@nyClf5GpjMQN6SFQ+g5UBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278707>

After using "git checkout --detach", the reflog is left with an entry
like

  checkout: moving from ... to HEAD

This message is parsed to generate the 'HEAD detached at' message in
'git branch' and 'git status', which leads to the not-so-useful message
'HEAD detached at HEAD'.

Instead, when parsing such reflog entry, resolve HEAD to the
corresponding commit in the reflog, so that the message becomes 'HEAD
detached at $sha1'.
---
Another possible fix is to avoid creating such reflog entry. But
anyway, this patch remains a good thing to do and it does fix the
issue.

I won't have time to work on fixing the reflog soon, but it may be a
nice microproject.

 t/t3203-branch-output.sh | 2 +-
 wt-status.c              | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index bf24dbf..16efe7a 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -106,7 +106,7 @@ EOF
 	test_i18ncmp expect actual
 '
 
-test_expect_failure 'git branch shows detached HEAD properly after checkout --detach' '
+test_expect_success 'git branch shows detached HEAD properly after checkout --detach' '
 	git checkout master &&
 	cat >expect <<EOF &&
 * (HEAD detached at $(git rev-parse --short HEAD^0))
diff --git a/wt-status.c b/wt-status.c
index c327fe8..3e3b8c0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1319,6 +1319,12 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	hashcpy(cb->nsha1, nsha1);
 	for (end = target; *end && *end != '\n'; end++)
 		;
+	if (!memcmp(target, "HEAD", end - target)) {
+		/* HEAD is relative. Resolve it to the right reflog entry. */
+		strbuf_addstr(&cb->buf,
+			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
+		return 1;
+	}
 	strbuf_add(&cb->buf, target, end - target);
 	return 1;
 }
-- 
2.5.0.402.g8854c44
