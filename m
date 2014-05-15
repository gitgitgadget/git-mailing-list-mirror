From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] get_helper: use run-command's internal argv_array
Date: Thu, 15 May 2014 04:34:18 -0400
Message-ID: <20140515083418.GD26866@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:34:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr7S-0003qm-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbaEOIeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:34:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:52061 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751739AbaEOIeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:34:20 -0400
Received: (qmail 20301 invoked by uid 102); 15 May 2014 08:34:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:34:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:34:18 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249071>

The get_helper functions dynamically allocates an
argv_array, feeds it to start_command, and then returns. We
then have to later clean up the memory manually after
calling finish_command. We can make this simpler by just
using run-command's internal argv_array, which handles
cleanup for us.

This also prevents a memory leak in the case that
transport_take_over is used, in which case we free the child
in finish_connect, which does not manually free the array.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b468e4f..fefd34f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -101,7 +101,6 @@ static void do_take_over(struct transport *transport)
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
-	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
 	const char **refspecs = NULL;
@@ -123,10 +122,9 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->in = -1;
 	helper->out = -1;
 	helper->err = 0;
-	argv_array_pushf(&argv, "git-remote-%s", data->name);
-	argv_array_push(&argv, transport->remote->name);
-	argv_array_push(&argv, remove_ext_force(transport->url));
-	helper->argv = argv_array_detach(&argv, NULL);
+	argv_array_pushf(&helper->args, "git-remote-%s", data->name);
+	argv_array_push(&helper->args, transport->remote->name);
+	argv_array_push(&helper->args, remove_ext_force(transport->url));
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
@@ -245,7 +243,6 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		argv_array_free_detached(data->helper->argv);
 		free(data->helper);
 		data->helper = NULL;
 	}
-- 
2.0.0.rc1.436.g03cb729
