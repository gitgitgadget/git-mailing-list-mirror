From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Do not unquote + into ' ' in URLs
Date: Fri, 23 Jul 2010 23:23:31 +0200
Message-ID: <db9c97908966fa332be07b2a9f5215679e35b9e0.1279920066.git.trast@student.ethz.ch>
References: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <avarab@gmail.com>, <jstpierre@mecheye.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 23:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcPiU-0002Ph-Ph
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 23:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab0GWVXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 17:23:33 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:11556 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab0GWVXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 17:23:32 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 23 Jul
 2010 23:23:31 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 23 Jul
 2010 23:23:31 +0200
X-Mailer: git-send-email 1.7.2.rc3.335.g26d7d
In-Reply-To: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151575>

Since 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23) the URL
logic unquotes escaped URLs.  For the %2B type of escape, this is
conformant with RFC 2396.  However, it also unquotes + into a space
character, which is only appropriate for the query strings in HTTP.
This notably broke fetching from the gtk+ repository.

Remove the corresponding bit of code.

Reported-by: Jasper St. Pierre <jstpierre@mecheye.net>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Jasper St. Pierre wrote:
> Yep. http://www.ietf.org/rfc/rfc2396.txt defines '+' as a reserved character,
> but doesn't give a purpose for it. www-form-encoded replaces space with '+'
> but in a URL it can mean anything it wants.

So let's do this then, instead?

Based on the discussion, I would consider this a bugfix that should go
in 1.7.2.1.


 t/t5601-clone.sh |   10 ++++++++--
 url.c            |    5 +----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8abb71a..4431dfd 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -178,8 +178,14 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 
 test_expect_success 'respect url-encoding of file://' '
 	git init x+y &&
-	test_must_fail git clone "file://$PWD/x+y" xy-url &&
-	git clone "file://$PWD/x%2By" xy-url
+	git clone "file://$PWD/x+y" xy-url-1 &&
+	git clone "file://$PWD/x%2By" xy-url-2
+'
+
+test_expect_success 'do not query-string-decode + in URLs' '
+	rm -rf x+y &&
+	git init "x y" &&
+	test_must_fail git clone "file://$PWD/x+y" xy-no-plus
 '
 
 test_expect_success 'do not respect url-encoding of non-url path' '
diff --git a/url.c b/url.c
index 2306236..fa4b8d4 100644
--- a/url.c
+++ b/url.c
@@ -90,10 +90,7 @@ static char *url_decode_internal(const char **query, const char *stop_at, struct
 			}
 		}
 
-		if (c == '+')
-			strbuf_addch(out, ' ');
-		else
-			strbuf_addch(out, c);
+		strbuf_addch(out, c);
 		q++;
 	} while (1);
 	*query = q;
-- 
1.7.2.rc3.335.g26d7d
