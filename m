From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] pack-write: simplify index_pack_lockfile using skip_prefix()
 and xstrfmt()
Date: Sat, 30 Aug 2014 11:47:19 +0200
Message-ID: <54019DA7.2050002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNfGG-000224-Ht
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 11:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbaH3Jrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 05:47:52 -0400
Received: from mout.web.de ([212.227.17.12]:54481 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaH3Jrw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 05:47:52 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MgwZQ-1XjiNS2T7w-00LzyQ; Sat, 30 Aug 2014 11:47:34
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:CElVq5wDTzdpVqmZmrM7OWDL4vBXmUxbqopVU4hnilJWF9U4oe4
 N/7l5+PHDoqjFj8SAz4r35QuRV6keFL81ZrGi0wPPzYV83HdKH2eMj6lt97PwhgwIvBfRG/
 wAD3mYdIgCT24i2C8PqZPbMIc+u1NM7fnVOQyFfEWOzFt5x39/t4/ilsD+UfJsk5e8XYEol
 KlyT11WDHdMSeJVMVj27w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256245>

Get rid of magic string length constants by using skip_prefix() instead
of memcmp() and use xstrfmt() for building a string instead of a
PATH_MAX-sized buffer, snprintf() and xstrdup().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 pack-write.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 9ccf804..33293ce 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -288,13 +288,12 @@ char *index_pack_lockfile(int ip_out)
 	 * case, we need it to remove the corresponding .keep file
 	 * later on.  If we don't get that then tough luck with it.
 	 */
-	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n' &&
-	    memcmp(packname, "keep\t", 5) == 0) {
-		char path[PATH_MAX];
+	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n') {
+		const char *name;
 		packname[45] = 0;
-		snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
-			 get_object_directory(), packname + 5);
-		return xstrdup(path);
+		if (skip_prefix(packname, "keep\t", &name))
+			return xstrfmt("%s/pack/pack-%s.keep",
+				       get_object_directory(), name);
 	}
 	return NULL;
 }
-- 
2.1.0
