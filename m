From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] get_importer: use run-command's internal argv_array
Date: Thu, 15 May 2014 04:35:06 -0400
Message-ID: <20140515083506.GF26866@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr8H-0005sl-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbaEOIfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:35:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:52066 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752167AbaEOIfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:35:08 -0400
Received: (qmail 20399 invoked by uid 102); 15 May 2014 08:35:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:35:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:35:06 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249073>

This saves a few lines and lets us avoid having to clean up
the memory manually when the command finishes.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 9f8f3b1..d9063d7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -394,18 +394,16 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 {
 	struct child_process *helper = get_helper(transport);
 	struct helper_data *data = transport->data;
-	struct argv_array argv = ARGV_ARRAY_INIT;
 	int cat_blob_fd, code;
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
-	argv_array_push(&argv, "fast-import");
-	argv_array_push(&argv, debug ? "--stats" : "--quiet");
+	argv_array_push(&fastimport->args, "fast-import");
+	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-		argv_array_pushf(&argv, "--cat-blob-fd=%d", cat_blob_fd);
+		argv_array_pushf(&fastimport->args, "--cat-blob-fd=%d", cat_blob_fd);
 	}
-	fastimport->argv = argv.argv;
 	fastimport->git_cmd = 1;
 
 	code = start_command(fastimport);
@@ -476,7 +474,6 @@ static int fetch_with_import(struct transport *transport,
 
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
-	argv_array_free_detached(fastimport.argv);
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
-- 
2.0.0.rc1.436.g03cb729
