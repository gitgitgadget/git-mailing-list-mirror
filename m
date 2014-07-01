From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_file: avoid overrunning alternate object base string
Date: Tue, 01 Jul 2014 20:00:01 +0200
Message-ID: <53B2F721.3080800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 20:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X22Lo-0002RI-Np
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 20:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbaGASAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 14:00:10 -0400
Received: from mout.web.de ([212.227.17.12]:53703 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbaGASAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 14:00:09 -0400
Received: from [192.168.178.27] ([79.250.168.117]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Md4xS-1XJ10A30t8-00IABN; Tue, 01 Jul 2014 20:00:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:wosz5hzLYIKwih5/cFY6m8J2e5g/ovA4jAvuM0ExLXmdpZe2WeQ
 TjoludzAxIGwOQKZEet26a3m1EXmT4Fgs6+B1vlUfWh7TzPjLvUDYL1Pug38b65FYg5sTlI
 M03H78fmO2oZr9mNzkGZvbzBUMYeDPZ3Pua9cE2n0qOr9vpzebjmxHrdNo6VcahtqeII1OC
 FgRVPMCcJGhyjklAGkeiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252732>

While checking if a new alternate object database is a duplicate make
sure that old and new base paths have the same length before comparing
them with memcmp.  This avoids overrunning the buffer of the existing
entry if the new one is longer and it stops rejecting foobar/ after
foo/ was already added.

Signed-off-by: Rene Scharfe <ls.r@web.de>
---
 sha1_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8adab14..b7ad6c1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -315,7 +315,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base, int
 	 * thing twice, or object directory itself.
 	 */
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		if (!memcmp(ent->base, alt->base, pfxlen)) {
+		if (pfxlen == alt->name - alt->base - 1 &&
+		    !memcmp(ent->base, alt->base, pfxlen)) {
 			free(ent);
 			return -1;
 		}
-- 
2.0.0
