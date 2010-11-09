From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] status: Quote paths with spaces in short format
Date: Mon,  8 Nov 2010 18:44:38 -0800
Message-ID: <1289270678-89237-1-git-send-email-kevin@sb.org>
References: <A2E979E4-899B-4295-A8CF-72EF8E585D3A@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 03:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFeCc-0003zU-CV
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 03:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab0KICor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 21:44:47 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64437 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab0KICoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 21:44:46 -0500
Received: by pzk28 with SMTP id 28so1187332pzk.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 18:44:45 -0800 (PST)
Received: by 10.142.211.16 with SMTP id j16mr5703827wfg.283.1289270685868;
        Mon, 08 Nov 2010 18:44:45 -0800 (PST)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm815472wfg.20.2010.11.08.18.44.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 18:44:45 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.203.ge51db
In-Reply-To: <A2E979E4-899B-4295-A8CF-72EF8E585D3A@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161011>

According to the documentation for git-status, in short-format mode,
paths with spaces or unprintable characters are quoted. However
28fba29 (Do not quote SP., 2005-10-17) removed the behavior that quotes
paths that have spaces but not unprintable characters. Unfortunately this
makes the output of `git status --porcelain` non-parseable in certain
(rather unusual) edge cases. In the interest of removing ambiguity when
parsing the output of `git status --porcelain`, restore the behavior of
quoting paths with spaces in git-status's short-format mode.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---

This patch was originally attached via scissors to message id
<A2E979E4-899B-4295-A8CF-72EF8E585D3A@sb.org> but it appears to have
been overlooked.

 wt-status.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index fc2438f..9624865 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -744,10 +744,20 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 		const char *one;
 		if (d->head_path) {
 			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
+			if (*one != '"' && strchr(one, ' ') != NULL) {
+				putchar('"');
+				strbuf_addch(&onebuf, '"');
+				one = onebuf.buf;
+			}
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
 		}
 		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		if (*one != '"' && strchr(one, ' ') != NULL) {
+			putchar('"');
+			strbuf_addch(&onebuf, '"');
+			one = onebuf.buf;
+		}
 		printf("%s\n", one);
 		strbuf_release(&onebuf);
 	}
-- 
1.7.3.2.203.ge51db
