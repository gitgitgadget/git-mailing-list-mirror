From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2a] pretty: detect missing \n\n in commit message
Date: Tue, 28 Feb 2012 11:37:00 +0100
Message-ID: <5234ba4babd28d9430750d227d629b4d4386b131.1330425111.git.trast@student.ethz.ch>
References: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 11:37:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2KQo-0007aX-Qe
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 11:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab2B1KhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 05:37:10 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:27110 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354Ab2B1KhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 05:37:06 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 11:37:01 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 11:37:01 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191708>

get_header()'s exit condition is finding the \n\n that separates the
commit header from its message.  If such a double newline is not
present, it segfaults.  Catch this case and die().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This would be the minimal fix to the pretty machinery so that 'git
rev-list --pretty=something HEAD' works when there are such broken
commits.

If 2b goes in, there isn't really any point as we would never get this
far on such a commit.


 pretty.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 8688b8f..b7f097d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -440,7 +440,10 @@ static char *get_header(const struct commit *commit, const char *key)
 	const char *line = commit->buffer;
 
 	for (;;) {
-		const char *eol = strchr(line, '\n'), *next;
+		const char *eol, *next;
+		if (!line)
+			die (_("malformed commit object: no separating \\n\\n?"));
+		eol = strchr(line, '\n');
 
 		if (line == eol)
 			return NULL;
-- 
1.7.9.2.467.g7fee4
