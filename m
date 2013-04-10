From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] test-lint-duplicates: consider only numbered test cases
Date: Wed, 10 Apr 2013 16:22:57 +0200
Message-ID: <201304101622.58688.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 16:23:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPvvj-0003Uu-DD
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 16:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936875Ab3DJOXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 10:23:12 -0400
Received: from mout.web.de ([212.227.17.12]:50642 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936770Ab3DJOXM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 10:23:12 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M4Zlk-1Un5S02N6S-00yjmw; Wed, 10 Apr 2013 16:23:06 +0200
X-Provags-ID: V02:K0:+aa2LZ0+497k9viejvNbseKwwmY4hbdMKNa6BE/XokQ
 tqFAYlhahPLUmiS+UBUnzt53WERWZ9iTkvUI3tCz6dZ0mf/L3m
 YpFmG3dCX2LdgarLI7/86+9DMoJF/CXFjP6k1Bc3UStlw6MbjK
 Tri4hTpbNMCBCUEu0g9hqjHmz5Of0sg5wQpojQ9vryG2xzuitt
 kwKGTXJEwTgPcK9KvwAgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220691>

Running make inside contrib/remote-helpers may fail in "test-lint-dupli=
cates"

This was because the regexp checking for duplicate numbers strips every=
thing
after the first "-" in the filename, including the prefix.

As a result, 2 pathnames like
"xxxx/contrib/remote-helpers/test-XX.sh" and
"xxxx/contrib/remote-helpers/test-YY.sh"

are both converted into
"xxxx/contrib/remote", and reported as duplicate.

Improve the regexp:
- strip the leading path and look only at the basename
- only look at files which have tNNNN- (where N stand for a digit) in t=
he name

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

http://comments.gmane.org/gmane.comp.version-control.git/214194

 t/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 1923cc1..cfd6d5a 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,7 +48,9 @@ clean: clean-except-prove-cache
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-s=
yntax
=20
 test-lint-duplicates:
-	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
+	@dups=3D`echo $(T) | tr ' ' '\n' | \
+		sed -e 's,.*/,,' -ne 's|\(.*/\)*t\([0-9][0-9][0-9][0-9]\)-.*|\2|p' |=
 \
+		sort | uniq -d` && \
 		test -z "$$dups" || { \
 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
=20
--=20
1.8.2.282.g4bc7171
