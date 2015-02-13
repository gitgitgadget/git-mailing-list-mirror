From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/2] transport-helper: ask the helper to set progress and verbosity options after asking for its capabilities
Date: Fri, 13 Feb 2015 14:24:45 +0900
Message-ID: <1423805086-807-1-git-send-email-mh@glandium.org>
References: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 13 06:25:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM8kN-0003no-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 06:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbbBMFYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 00:24:55 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:60651 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbbBMFYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 00:24:54 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YM8kA-0000Dq-Gm; Fri, 13 Feb 2015 14:24:46 +0900
X-Mailer: git-send-email 2.3.0.3.g5a196f5
In-Reply-To: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263797>

Currently, a remote helper is only told about the progress and verbosity
options for the 'fetch' and 'push' commands. This means a remote helper
that implements 'import' and 'export' can never know the user requested
progress or verbosity (or lack thereof) through the command line.

Telling the remote helper about those options after asking for its
capabilities ensures it can act accordingly for all commands.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport-helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0224687..23a741c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -98,6 +98,8 @@ static void do_take_over(struct transport *transport)
 	free(data);
 }
 
+static void standard_options(struct transport *t);
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -212,6 +214,7 @@ static struct child_process *get_helper(struct transport *transport)
 	strbuf_release(&buf);
 	if (debug)
 		fprintf(stderr, "Debug: Capabilities complete.\n");
+	standard_options(transport);
 	return data->helper;
 }
 
@@ -339,7 +342,6 @@ static int fetch_with_fetch(struct transport *transport,
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	standard_options(transport);
 	if (data->check_connectivity &&
 	    data->transport_options.check_self_contained_and_connected)
 		set_helper_option(transport, "check-connectivity", "true");
@@ -824,7 +826,6 @@ static int push_refs_with_push(struct transport *transport,
 		return 0;
 	}
 
-	standard_options(transport);
 	for_each_string_list_item(cas_option, &cas_options)
 		set_helper_option(transport, "cas", cas_option->string);
 
-- 
2.3.0.3.g5a196f5
