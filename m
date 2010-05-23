From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] decode file:// and ssh:// URLs
Date: Sun, 23 May 2010 05:19:44 -0400
Message-ID: <20100523091944.GB16520@coredump.intra.peff.net>
References: <20100523091612.GB26123@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:19:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Le-0005EB-24
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab0EWJTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:19:49 -0400
Received: from peff.net ([208.65.91.99]:40957 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab0EWJTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:19:48 -0400
Received: (qmail 21187 invoked by uid 107); 23 May 2010 09:19:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 05:19:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 05:19:44 -0400
Content-Disposition: inline
In-Reply-To: <20100523091612.GB26123@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147563>

We generally treat these as equivalent to "/path/to/repo"
and "host:path_to_repo" respectively. However, they are URLs
and as such may be percent-encoded. The current code simply
uses them as-is without any decoding.

With this patch, we will now percent-decode any file:// or
ssh:// url (or ssh+git, git+ssh, etc) at the transport
layer. We continue to treat plain paths and "host:path"
syntax literally.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this also impacts git:// URLs. Which I is probably a good thing,
but I haven't looked extensively for unexpected fallouts.

 connect.c        |    8 +++++++-
 t/t5601-clone.sh |   12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 9ae991a..0119bd3 100644
--- a/connect.c
+++ b/connect.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "remote.h"
+#include "url.h"
 
 static char *server_capabilities;
 
@@ -450,7 +451,7 @@ static struct child_process no_fork;
 struct child_process *git_connect(int fd[2], const char *url_orig,
 				  const char *prog, int flags)
 {
-	char *url = xstrdup(url_orig);
+	char *url;
 	char *host, *path;
 	char *end;
 	int c;
@@ -466,6 +467,11 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
+	if (is_url(url_orig))
+		url = url_decode(url_orig);
+	else
+		url = xstrdup(url_orig);
+
 	host = strstr(url, "://");
 	if (host) {
 		*host = '\0';
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 678cee5..8abb71a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -176,4 +176,16 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 	)
 '
 
+test_expect_success 'respect url-encoding of file://' '
+	git init x+y &&
+	test_must_fail git clone "file://$PWD/x+y" xy-url &&
+	git clone "file://$PWD/x%2By" xy-url
+'
+
+test_expect_success 'do not respect url-encoding of non-url path' '
+	git init x+y &&
+	test_must_fail git clone x%2By xy-regular &&
+	git clone x+y xy-regular
+'
+
 test_done
-- 
1.7.1.356.gc7d3.dirty
