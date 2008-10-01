Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 21486 invoked by uid 111); 1 Oct 2008 20:13:22 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 01 Oct 2008 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYJAUNS (ORCPT <rfc822;peff@peff.net>);
	Wed, 1 Oct 2008 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbYJAUNS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:13:18 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:59307 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751915AbYJAUNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:13:17 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id B64C52AC8DE; Wed,  1 Oct 2008 22:13:02 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] config.c: Tolerate UTF8 BOM at the beginning of config file
Date:	Wed,  1 Oct 2008 22:13:02 +0200
Message-Id: <1222891982-24193-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Unfortunately, the abomination of Windows Notepad likes to scatted
non-sensical UTF8 BOM marks across text files it edits. This is
especially troublesome when editing the Git configuration file,
and it does not appear to be particularly harmful to teach Git
to deal with this poo in the configfile.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 config.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 53f04a0..1d30120 100644
--- a/config.c
+++ b/config.c
@@ -205,8 +205,27 @@ static int git_parse_file(config_fn_t fn, void *data)
 	int baselen = 0;
 	static char var[MAXNAME];
 
+	/* U+FEFF Byte Order Mark in UTF8 */
+	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
+	const unsigned char *bomptr = utf8_bom;
+
 	for (;;) {
 		int c = get_next_char();
+		if (bomptr && *bomptr) {
+			/* We are at the file beginning; skip UTF8-encoded BOM
+			 * if present. Sane editors won't put this in on their
+			 * own, but e.g. Windows Notepad will do it happily. */
+			if ((unsigned char) c == *bomptr) {
+				bomptr++;
+				continue;
+			} else {
+				/* Do not tolerate partial BOM. */
+				if (bomptr != utf8_bom)
+					break;
+				/* No BOM at file beginning. Cool. */
+				bomptr = NULL;
+			}
+		}
 		if (c == '\n') {
 			if (config_file_eof)
 				return 0;
-- 
tg: (9800c0d..) t/config/utf8-bom (depends on: vanilla/master)
