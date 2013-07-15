From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/9] mailmap: do not lose single-letter names
Date: Mon, 15 Jul 2013 02:54:06 -0400
Message-ID: <1373871253-96480-3-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycgG-0003vz-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab3GOGyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:40 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:50518 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:40 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so25323488ieb.30
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=exWdOYon5T8kN/wmUZKcKBgmOg422800A568/HfxBNA=;
        b=UEPrA3Ny8KADxrTtZejnIcElJ4zVpd+ouLTVEhKcCNt8rEzsKikf7jf//uDZ01ut2K
         uEGaYCbzhDSNW+SNyO8F95KBJmWsjY6OaxahUJvGiZw1wKsowKWVCZk+jJ6NB+t0sRSb
         46xZIP/66BBiULXiF7x7jGRA2lO78u77M9R7VJWtSingXYwg66JnKQErcLrWK9WVdorU
         tFeNUOFk9LmuocGXUs3sTvHjRbqbiKGMnZbTvDds6bidhEUCiTVkgS9nFYyLNCvkgmTM
         DZYfPR0X70GreZX/3AAVB+mWlED16I3t/ppv2Q8kr01iSw3kw+d5rbdHRRenFPT/bZ+K
         TdUA==
X-Received: by 10.43.9.4 with SMTP id ou4mr17386857icb.53.1373871279700;
        Sun, 14 Jul 2013 23:54:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230427>

From: Junio C Hamano <gitster@pobox.com>

In parse_name_and_email() function, there is this line:

	*name = (nstart < nend ? nstart : NULL);

When the function is given a buffer "A <A@example.org> <old@x.z>",
nstart scans from the beginning of the buffer, skipping whitespaces
(there isn't any, so nstart points at the buffer), while nend starts
from one byte before the first '<' and skips whitespaces backwards
and stops at the first non-whitespace (i.e. it hits "A" at the
beginning of the buffer).  nstart == nend in this case for a
single-letter name, and an off-by-one error makes it fail to pick up
the name, which makes the entry equivalent to

	<A@example.org> <old@x.z>

without the name.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c          | 2 +-
 t/t4203-mailmap.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 2a7b366..418081e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -122,7 +122,7 @@ static char *parse_name_and_email(char *buffer, char **name,
 	while (nend > nstart && isspace(*nend))
 		--nend;
 
-	*name = (nstart < nend ? nstart : NULL);
+	*name = (nstart <= nend ? nstart : NULL);
 	*email = left+1;
 	*(nend+1) = '\0';
 	*right++ = '\0';
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 27f8f86..8583724 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -247,7 +247,7 @@ test_expect_success 'cleanup after mailmap.blob tests' '
 	rm -f .mailmap
 '
 
-test_expect_failure 'single-character name' '
+test_expect_success 'single-character name' '
 	echo "     1	A <author@example.com>" >expect &&
 	echo "     1	nick1 <bugs@company.xx>" >>expect &&
 	echo "A <author@example.com>" >.mailmap &&
-- 
1.8.3.2.804.g0da7a53
