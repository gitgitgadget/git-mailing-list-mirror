From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 19:53:17 +0200
Message-ID: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 18:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaC52-0000rU-9t
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab0A0RxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 12:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549Ab0A0RxX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:53:23 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:59770 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab0A0RxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 12:53:22 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 3C930EFA0B;
	Wed, 27 Jan 2010 19:53:21 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0350E38485; Wed, 27 Jan 2010 19:53:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 121EDE51BD;
	Wed, 27 Jan 2010 19:53:17 +0200 (EET)
X-Mailer: git-send-email 1.7.0.rc0.19.gb557e6
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138178>

remote.<remote>.vcs causes remote->foreign_vcs to be set on entry to
transport_get(). Unfortunately, the code assumed that any such entry
is stale from previous round.

Fix this by making VCS set by URL to be volatile w.r.t. transport_get()
instead.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

Differences from first round:

This makes VCS setting apply to all URLs that don't explicitly override,
instead of it applying to just the first one.

diff --git a/transport.c b/transport.c
index 7714fdb..87581b8 100644
--- a/transport.c
+++ b/transport.c
@@ -912,20 +912,19 @@ static int external_specification_len(const char *url)
 
 struct transport *transport_get(struct remote *remote, const char *url)
 {
+	const char *helper;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	if (!remote)
 		die("No remote provided to transport_get()");
 
 	ret->remote = remote;
+	helper = remote->foreign_vcs;
 
 	if (!url && remote && remote->url)
 		url = remote->url[0];
 	ret->url = url;
 
-	/* In case previous URL had helper forced, reset it. */
-	remote->foreign_vcs = NULL;
-
 	/* maybe it is a foreign URL? */
 	if (url) {
 		const char *p = url;
@@ -933,11 +932,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		while (isalnum(*p))
 			p++;
 		if (!prefixcmp(p, "::"))
-			remote->foreign_vcs = xstrndup(url, p - url);
+			helper = xstrndup(url, p - url);
 	}
 
-	if (remote && remote->foreign_vcs) {
-		transport_helper_init(ret, remote->foreign_vcs);
+	if (helper) {
+		transport_helper_init(ret, helper);
 	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
-- 
1.7.0.rc0.19.gb557e6
