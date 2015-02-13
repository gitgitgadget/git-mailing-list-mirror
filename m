From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] transport-helper: ask the helper to set the same options for import as for fetch
Date: Fri, 13 Feb 2015 14:24:46 +0900
Message-ID: <1423805086-807-2-git-send-email-mh@glandium.org>
References: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
 <1423805086-807-1-git-send-email-mh@glandium.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 13 06:25:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM8kO-0003no-J1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 06:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbbBMFYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 00:24:55 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:60649 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbbBMFYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 00:24:54 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YM8kA-0000Dt-IK; Fri, 13 Feb 2015 14:24:46 +0900
X-Mailer: git-send-email 2.3.0.3.g5a196f5
In-Reply-To: <1423805086-807-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263796>

A remote helper is currently only told about the 'check-connectivity',
'cloning', and 'update-shallow' options when it supports the 'fetch'
command, but not when it supports 'import' instead.

This is especially important for the 'cloning' option, because it
means a remote helper that only supports 'import' can't distinguish
between a clone and a pull besides doing some assumptions from the
git directory state.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport-helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 23a741c..c3868e4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -342,16 +342,6 @@ static int fetch_with_fetch(struct transport *transport,
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (data->check_connectivity &&
-	    data->transport_options.check_self_contained_and_connected)
-		set_helper_option(transport, "check-connectivity", "true");
-
-	if (transport->cloning)
-		set_helper_option(transport, "cloning", "true");
-
-	if (data->transport_options.update_shallow)
-		set_helper_option(transport, "update-shallow", "true");
-
 	for (i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
@@ -622,6 +612,16 @@ static int fetch(struct transport *transport,
 	if (!count)
 		return 0;
 
+	if (data->check_connectivity &&
+	    data->transport_options.check_self_contained_and_connected)
+		set_helper_option(transport, "check-connectivity", "true");
+
+	if (transport->cloning)
+		set_helper_option(transport, "cloning", "true");
+
+	if (data->transport_options.update_shallow)
+		set_helper_option(transport, "update-shallow", "true");
+
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
-- 
2.3.0.3.g5a196f5
