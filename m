From: Jeff King <peff@peff.net>
Subject: [PATCH 07/16] transport-helper: avoid reading past end-of-string
Date: Wed, 18 Jun 2014 15:47:17 -0400
Message-ID: <20140618194717.GG22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:47:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLpL-0002rE-LY
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbaFRTrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:47:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:46949 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754703AbaFRTrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:47:19 -0400
Received: (qmail 30226 invoked by uid 102); 18 Jun 2014 19:47:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:47:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:47:17 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252039>

We detect the "import-marks" capability by looking for that
string, but _without_ a trailing space. Then we skip past it
using strlen("import-marks "), with a space. So if a remote
helper gives us exactly "import-marks", we will read past
the end-of-string by one character.

This is unlikely to be a problem in practice, because such
input is malformed in the first place, and because there is
a good chance that the string has an extra NUL terminator
one character after the original (because it formerly had a
newline in it that we parsed off).

We can fix it by using skip_prefix with "import-marks ",
with the space. The other form appears to be a typo from
a515ebe (transport-helper: implement marks location as
capability, 2011-07-16); "import-marks" has never existed
without an argument, and it should match the "export-marks"
definition above.

Speaking of which, we can also use skip_prefix in a few
other places while we are in the function.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 84c616f..3d8fe7d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -153,7 +153,7 @@ static struct child_process *get_helper(struct transport *transport)
 	write_constant(helper->in, "capabilities\n");
 
 	while (1) {
-		const char *capname;
+		const char *capname, *arg;
 		int mandatory = 0;
 		if (recvline(data, &buf))
 			exit(128);
@@ -183,19 +183,19 @@ static struct child_process *get_helper(struct transport *transport)
 			data->export = 1;
 		else if (!strcmp(capname, "check-connectivity"))
 			data->check_connectivity = 1;
-		else if (!data->refspecs && starts_with(capname, "refspec ")) {
+		else if (!data->refspecs && skip_prefix(capname, "refspec ", &arg)) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = xstrdup(capname + strlen("refspec "));
+			refspecs[refspec_nr++] = xstrdup(arg);
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
-		} else if (starts_with(capname, "export-marks ")) {
-			data->export_marks = xstrdup(capname + strlen("export-marks "));
-		} else if (starts_with(capname, "import-marks")) {
-			data->import_marks = xstrdup(capname + strlen("import-marks "));
+		} else if (skip_prefix(capname, "export-marks ", &arg)) {
+			data->export_marks = xstrdup(arg);
+		} else if (skip_prefix(capname, "import-marks ", &arg)) {
+			data->import_marks = xstrdup(arg);
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
-- 
2.0.0.566.gfe3e6b2
