From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [BUGFIX] Reset possible helper before reusing remote structure
Date: Sat,  9 Jan 2010 19:28:12 +0200
Message-ID: <1263058092-20501-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 18:28:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTf6p-00030A-Ie
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 18:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab0AIR2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755Ab0AIR2P
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 12:28:15 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:51156 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab0AIR2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 12:28:14 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id A2D4418D2A0
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 19:28:13 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01C73A0137; Sat, 09 Jan 2010 19:28:13 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 9278D158A69
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 19:28:12 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136536>

If one had multiple URLs configured for remote with previous one
having forced helper but the subsequent one not, like:

url = foo::bar://baz
url = ssh://example/example.git

Then the subsequent URL is passed to foo helper, which isn't
correct. Fix it to be parsed normally by resetting foreign VCS
name before parsing the URL protocol.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 97bb5e6..669bc85 100644
--- a/transport.c
+++ b/transport.c
@@ -875,6 +875,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		url = remote->url[0];
 	ret->url = url;
 
+	/* In case previous URL had helper forced, reset it. */
+	remote->foreign_vcs = NULL;
+
 	/* maybe it is a foreign URL? */
 	if (url) {
 		const char *p = url;
-- 
1.6.6.3.gaa2e1
