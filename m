From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH 3/3] t5551-http-fetch: Work around broken Accept header in libcurl
Date: Mon,  9 Nov 2009 10:10:37 -0800
Message-ID: <1257790237-30850-3-git-send-email-spearce@spearce.org>
References: <1257790237-30850-1-git-send-email-spearce@spearce.org>
Cc: Tarmigan <tarmigan+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 19:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7YhT-0007ma-K5
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZKISKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZKISKf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:10:35 -0500
Received: from george.spearce.org ([209.20.77.23]:39667 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbZKISKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 13:10:34 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id B1184381FD; Mon,  9 Nov 2009 18:10:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 787F9380E7
	for <git@vger.kernel.org>; Mon,  9 Nov 2009 18:10:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.351.g09432
In-Reply-To: <1257790237-30850-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132501>

Unfortunately at least one version of libcurl has a bug causing
it to include "Accept: */*" in the same POST request where we have
already asked for "Accept: application/x-git-upload-pack-response".

This is a bug in libcurl, not Git, or our test vector.  The
application has explicitly asked the server for a single content
type, but libcurl has mistakenly also told the server the client
application will accept */*, which is any content type.

Based on the libcurl change log, this "Accept: */*" header bug
may have been fixed in version 7.18.1 released March 30, 2008:

  http://curl.haxx.se/changes.html#7_18_1

Rather than require users to upgrade libcurl we change the test
vector to trim this line out of the 2nd request.

Reported-by: Tarmigan <tarmigan+git@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Actually, I don't want to apply this.

 Tarmigan, your libcurl is broken, it looks like a newer version
 fixes the problem, so I would suggest upgrading it.

 t/t5551-http-fetch.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 6b0165c..9d59065 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -61,6 +61,9 @@ test_expect_success 'clone http repository' '
 
 		/^> User-Agent: /d
 		/^> Host: /d
+		/^> POST /,$ {
+			/^> Accept: [*]\\/[*]/d
+		}
 		s/^> Content-Length: .*/> Content-Length: xxx/
 		/^00..want /d
 		/^00.*done/d
-- 
1.6.5.2.351.g09432
