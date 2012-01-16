From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] mailinfo: with -b, keep space after [foo]
Date: Mon, 16 Jan 2012 11:53:01 +0100
Message-ID: <9d2d51087ec58150bdf0d25c4321dc6b7e75b192.1326710194.git.trast@student.ethz.ch>
References: <a804650f805fd8c89a843302cb92bbbdf36b8c0b.1326710194.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 11:53:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmkBn-0004xs-Er
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 11:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab2APKxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 05:53:08 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:53873 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab2APKxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 05:53:06 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Jan
 2012 11:53:00 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Jan
 2012 11:53:02 +0100
X-Mailer: git-send-email 1.7.9.rc0.168.g3847c
In-Reply-To: <a804650f805fd8c89a843302cb92bbbdf36b8c0b.1326710194.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188627>

The logic for the -b mode, where [PATCH] is dropped but [foo] is not,
silently ate all spaces after the ].

Fix this by keeping the next isspace() character, if there is any.
Being more thorough is pointless, as the later cleanup_space() call
will normalize any sequence of whitespace to a single ' '.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Unchanged from last time.

 builtin/mailinfo.c |   11 ++++++++++-
 t/t4150-am.sh      |    2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index bfb32b7..eaf9e15 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -250,8 +250,17 @@ static void cleanup_subject(struct strbuf *subject)
 			    (7 <= remove &&
 			     memmem(subject->buf + at, remove, "PATCH", 5)))
 				strbuf_remove(subject, at, remove);
-			else
+			else {
 				at += remove;
+				/*
+				 * If the input had a space after the ], keep
+				 * it.  We don't bother with finding the end of
+				 * the space, since we later normalize it
+				 * anyway.
+				 */
+				if (isspace(subject->buf[at]))
+					at += 1;
+			}
 			continue;
 		}
 		break;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 7e7c83c..8807b60 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -262,7 +262,7 @@ test_expect_success 'am --keep really keeps the subject' '
 	grep "Re: Re: Re: \[PATCH 1/5 v2\] \[foo\] third" actual
 '
 
-test_expect_failure 'am --keep-non-patch really keeps the non-patch part' '
+test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout HEAD^ &&
-- 
1.7.9.rc0.168.g3847c
