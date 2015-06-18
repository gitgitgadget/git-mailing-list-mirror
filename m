From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 09/19] fsck: Handle multiple authors in commits specially
Date: Thu, 18 Jun 2015 22:08:49 +0200
Organization: gmx
Message-ID: <e6966c2a80fef10a249537b76045e2672ad02ba2.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g7N-00031A-EH
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbbFRUIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:08:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:51093 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756949AbbFRUIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:08:51 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MQhyf-1ZZ8fv1omD-00TzLH; Thu, 18 Jun 2015 22:08:50
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:kP8rzqW57N/ETvKNesIOegP4GlYN9uT+lifizYPBwYOlZHHajLa
 8LTDvcY72RUsxqpn4309hk3tgSb47Plg81qCy6PFQLW+JQFWe6cu08NphzbA4Eic884EtfS
 a5zbCHKAlVlHRwlCSEsBcyna2nKWWdQYZOJT7aCdbeWs4ftk/R9lxdWrCQWcDO1lnWhSdP0
 oDmuj11WYeBCv++k+MW0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mOkoG/caxRk=:E3Z51/+K3Uqg9MLT54zift
 T/xsqxquEZHtGh8hjMt6DVu31ZSby6SwF4nNgY3weZjWtau6B1yQaA6Wc3JEV5Rjs7iD1uGv+
 J+ztIMaN2aMdtB5Y4N3ClD4Y888aXLapRPPqBMEMMqWpHhVszJDEFQpcwudJH7jWt1KQpqSPK
 vNY/GwFKZdLH/q+yHDPpS6gorYmvlr3Sk+Z3cuOVJYZbq9ha84zUHub2hqwScfStuZZUOIKRq
 Z6C1FKnaHggsuuA7pX3mndzBnz0sN/1Hh5K4hUUkhSdKtHpkCTwnsWYVgXsmwpor7OGuXH7Jj
 /cDDxkDv601HK+J/mH9C5SdrS1y0l4NfvCc48wgQrGKw/EsTacTerVHmfG5uu928Eg7Nwt1AM
 IvNrBar7adpUofpfBz8RqhzJHFZi84jGS+fhE6K5HZis8/BsjlWy7djwUCRMm13a+7QNxL33g
 Rk+/Mppt629oSdAreVdWkC6w/9idcLL6IW4+WuLxHnloOzLpikGimQ7OsGMVrFiGe6N1u+H/R
 +50gQKo8ISGyBni+JhOzmLa155/HPGjVF4gOvvr3xowZtptbW2q/JlbsVsKJos6plTkjfFWt8
 MjfzS6qTAcxgtDwCBoLzg/kWLC53Aj6pXmiyZzILQ/uBcE4yqIXZA4NB2oaE+Ezbs0XTYPDzE
 l11rEhzV4Ow3biSj+0/sfijdW32GENpawg9/1Y+xc+Dl5b5zfl0F8iyMDBvpSjVXWv9c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272050>

This problem has been detected in the wild, and is the primary reason
to introduce an option to demote certain fsck errors to warnings. Let's
offer to ignore this particular problem specifically.

Technically, we could handle such repositories by setting
receive.fsck.<msg-id> to missingcommitter=warn, but that could hide
missing tree objects in the same commit because we cannot continue
verifying any commit object after encountering a missing committer line,
while we can continue in the case of multiple author lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fsck.c b/fsck.c
index 31d218d..856221d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -38,6 +38,7 @@
 	FUNC(MISSING_TREE, ERROR) \
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
+	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(NOT_SORTED, ERROR) \
 	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
@@ -571,6 +572,14 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
+	while (skip_prefix(buffer, "author ", &buffer)) {
+		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		if (err)
+			return err;
+		err = fsck_ident(&buffer, &commit->object, options);
+		if (err)
+			return err;
+	}
 	if (!skip_prefix(buffer, "committer ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, options);
-- 
2.3.1.windows.1.9.g8c01ab4
