From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 18:16:17 +0200
Message-ID: <1264608977-20665-1-git-send-email-ilari.liusvaara@elisanet.fi>
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 17:16:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAZ8-0000Sr-67
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab0A0QQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 11:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260Ab0A0QQV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:16:21 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:51446 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab0A0QQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 11:16:20 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 7B35118D05A;
	Wed, 27 Jan 2010 18:16:19 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01EA677F6A; Wed, 27 Jan 2010 18:16:19 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 67B40407E;
	Wed, 27 Jan 2010 18:16:17 +0200 (EET)
X-Mailer: git-send-email 1.7.0.rc0.19.gd681a
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138164>

remote.<remote>.vcs causes remote->foreign_vcs to be set on entry to
transport_get(). Unfortunately, the code assumed that any such entry
is stale from previous round. Resetting after starting the remote helper
avoids that case (it isn't likely anyone is using VCS setting and multiple
push URLs, as VCS setting is meant for non-URL-based helpers).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

Tor, does this also fix the segfault for you? This might work without
breaking some multiple-URL cases (just commenting out the reset will break
them).

diff --git a/transport.c b/transport.c
index 7714fdb..76b22e5 100644
--- a/transport.c
+++ b/transport.c
@@ -923,9 +923,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		url = remote->url[0];
 	ret->url = url;
 
-	/* In case previous URL had helper forced, reset it. */
-	remote->foreign_vcs = NULL;
-
 	/* maybe it is a foreign URL? */
 	if (url) {
 		const char *p = url;
@@ -938,6 +935,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	if (remote && remote->foreign_vcs) {
 		transport_helper_init(ret, remote->foreign_vcs);
+		remote->foreign_vcs = NULL;
 	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
-- 
1.7.0.rc0.19.gd681a
