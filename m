From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/16] prepare_tempfile_object(): new function, extracted from create_tempfile()
Date: Mon, 10 Aug 2015 11:47:42 +0200
Message-ID: <29cc87f510f6bc171c3ed76767b68f67ef403223.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjgl-0001vA-6W
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbbHJJsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47209 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754697AbbHJJsG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:06 -0400
X-AuditID: 12074414-f794f6d000007852-42-55c87354fc4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 18.33.30802.45378C55; Mon, 10 Aug 2015 05:48:04 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswv021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:03 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqBtSfCLUYOFLOYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGb+Wn2Mq
	OChYMWXPB6YGxjV8XYycHBICJhLvns9lgrDFJC7cW8/WxcjFISRwmVHi3/nZ7BDOCSaJlSdO
	sIFUsQnoSizqaQbrEBFQk5jYdogFxGYWSJc4saAdzBYWSJZoergNrIZFQFXix682MJtXIEri
	1vce1i5GDqBtchILLqSDhDkFLCS2N25gBbGFBMwlHs87zz6BkXcBI8MqRrnEnNJc3dzEzJzi
	1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJDwEdnBeOSk3CFGAQ5GJR7eGZuPhwqxJpYVV+YeYpTk
	YFIS5bXIPxEqxJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3PgMox5uSWFmVWpQPk5LmYFES5/22
	WN1PSCA9sSQ1OzW1ILUIJivDwaEkwXuvEKhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSix
	tCQjHhQZ8cXA2ABJ8QDtPQLSzltckJgLFIVoPcWoKCXOuw8kIQCSyCjNgxsLSwqvGMWBvhTm
	3QNSxQNMKHDdr4AGMwENtgsEG1ySiJCSamCctN76U4/v3V16l+Tdlypddbr74/W2S/JbddTm
	Tbxqb1Myt2CrisKlYs64+au35kVecjmUwH/S+uzvgs+1CZ+vfZh8o5Xh5s7UKinF7fOag82P
	flU/W+kiofxzvdGBa6HBh7cwcXwqa4+K7ZVLeVoY4X3DUuH3vuPp1jmBN0Uc98gu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275591>

This makes the next step easier.

The old code used to use "path" to set the initial length of
tempfile->filename. This was not helpful because path was usually
relative whereas the value stored to filename will be absolute. So
just initialize the length to 0.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 tempfile.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index d835818..d840f04 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -85,11 +85,11 @@ static void remove_tempfiles_on_signal(int signo)
 	raise(signo);
 }
 
-/* Make sure errno contains a meaningful value on error */
-int create_tempfile(struct tempfile *tempfile, const char *path)
+/*
+ * Initialize *tempfile if necessary and add it to tempfile_list.
+ */
+static void prepare_tempfile_object(struct tempfile *tempfile)
 {
-	size_t pathlen = strlen(path);
-
 	if (!tempfile_list) {
 		/* One-time initialization */
 		sigchain_push_common(remove_tempfiles_on_signal);
@@ -97,21 +97,27 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	}
 
 	if (tempfile->active)
-		die("BUG: create_tempfile called for active object");
+		die("BUG: prepare_tempfile_object called for active object");
 	if (!tempfile->on_list) {
 		/* Initialize *tempfile and add it to tempfile_list: */
 		tempfile->fd = -1;
 		tempfile->fp = NULL;
 		tempfile->active = 0;
 		tempfile->owner = 0;
-		strbuf_init(&tempfile->filename, pathlen);
+		strbuf_init(&tempfile->filename, 0);
 		tempfile->next = tempfile_list;
 		tempfile_list = tempfile;
 		tempfile->on_list = 1;
 	} else if (tempfile->filename.len) {
 		/* This shouldn't happen, but better safe than sorry. */
-		die("BUG: create_tempfile called for improperly-reset object");
+		die("BUG: prepare_tempfile_object called for improperly-reset object");
 	}
+}
+
+/* Make sure errno contains a meaningful value on error */
+int create_tempfile(struct tempfile *tempfile, const char *path)
+{
+	prepare_tempfile_object(tempfile);
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
-- 
2.5.0
