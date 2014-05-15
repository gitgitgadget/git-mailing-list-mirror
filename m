From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] get_exporter: use argv_array
Date: Thu, 15 May 2014 04:34:44 -0400
Message-ID: <20140515083444.GE26866@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr7z-0005HK-8o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbaEOIes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:34:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:52063 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbaEOIeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:34:46 -0400
Received: (qmail 20330 invoked by uid 102); 15 May 2014 08:34:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:34:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:34:44 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249072>

This simplifies the code and avoids a fixed array size that
we might accidentally overflow. It also prevents a leak
after finish_command is run, by using the argv_array that
run-command manages for us.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index fefd34f..9f8f3b1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -418,30 +418,24 @@ static int get_exporter(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
-	int argc = 0, i;
-	struct strbuf tmp = STRBUF_INIT;
+	int i;
 
 	memset(fastexport, 0, sizeof(*fastexport));
 
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
-	fastexport->argv = xcalloc(6 + revlist_args->nr, sizeof(*fastexport->argv));
-	fastexport->argv[argc++] = "fast-export";
-	fastexport->argv[argc++] = "--use-done-feature";
-	fastexport->argv[argc++] = data->signed_tags ?
-		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
-	if (data->export_marks) {
-		strbuf_addf(&tmp, "--export-marks=%s.tmp", data->export_marks);
-		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
-	}
-	if (data->import_marks) {
-		strbuf_addf(&tmp, "--import-marks=%s", data->import_marks);
-		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
-	}
+	argv_array_push(&fastexport->args, "fast-export");
+	argv_array_push(&fastexport->args, "--use-done-feature");
+	argv_array_push(&fastexport->args, data->signed_tags ?
+		"--signed-tags=verbatim" : "--signed-tags=warn-strip");
+	if (data->export_marks)
+		argv_array_pushf(&fastexport->args, "--export-marks=%s.tmp", data->export_marks);
+	if (data->import_marks)
+		argv_array_pushf(&fastexport->args, "--import-marks=%s", data->import_marks);
 
 	for (i = 0; i < revlist_args->nr; i++)
-		fastexport->argv[argc++] = revlist_args->items[i].string;
+		argv_array_push(&fastexport->args, revlist_args->items[i].string);
 
 	fastexport->git_cmd = 1;
 	return start_command(fastexport);
-- 
2.0.0.rc1.436.g03cb729
