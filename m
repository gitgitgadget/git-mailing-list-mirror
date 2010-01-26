From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 2/2] Allow use of []-wrapped addresses in git://
Date: Tue, 26 Jan 2010 20:24:42 +0200
Message-ID: <1264530282-4783-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6Z-0005Wt-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0AZSYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833Ab0AZSYt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:49 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:47192 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812Ab0AZSYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:48 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 923F28C918
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:46 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A020544685B; Tue, 26 Jan 2010 20:24:46 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 6D2722BD56
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:45 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
In-Reply-To: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138066>

Allow using "["<host>"]":<port> and "["<host>"]" notations in git://
host addresses. This is needed to be able to connect to addresses
that contain ':' (e.g. numeric IPv6 addresses). Also send the host
header []-wrapped so it can actually be parsed by remote end.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 connect.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 3a12562..20054e4 100644
--- a/connect.c
+++ b/connect.c
@@ -502,12 +502,18 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		c = ':';
 	}
 
+	/*
+	 * Don't do destructive transforms with git:// as that
+	 * protocol code does '[]' dewrapping of its own.
+	 */
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
 		if (end) {
-			*end = 0;
+			if (protocol != PROTO_GIT) {
+				*end = 0;
+				host++;
+			}
 			end++;
-			host++;
 		} else
 			end = host;
 	} else
-- 
1.6.6.1.439.gf06b6
