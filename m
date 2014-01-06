From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/17] cmd_init_db(): when creating directories, handle errors conservatively
Date: Mon,  6 Jan 2014 14:45:26 +0100
Message-ID: <1389015935-21936-9-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVk-0005xc-8r
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbaAFNqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:25 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50604 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557AbaAFNqY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:24 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-f6-52cab3af5726
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.A9.18966.FA3BAC25; Mon,  6 Jan 2014 08:46:23 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP9021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:22 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqLt+86kggxn/5C26rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgz9tyYxVrwnbPi2KXvLA2Mj9m7GDk5JARMJM51/GGDsMUkLtxbD2RzcQgJXGaU+HLr
	PCOEc4xJYvuiSUwgVWwCuhKLeprBbBEBNYmJbYdYQIqYBRYzSnRN+8YIkhAWSJA43/YGzGYR
	UJXYdvMiUBE7B6+Ai0RnYBcjB9AyBYnV14VACjgFXCWmTTsMdoMQUMGaQ49YJjDyLmBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mil5pSuokRElC8Oxj/r5M5xCjAwajEw+vx7GSQ
	EGtiWXFl7iFGSQ4mJVFeztWngoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8HItAMrxpiRWVqUW
	5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4TTYBNQoWpaanVqRl5pQgpJk4OEEE
	F8gGHqANCiCFvMUFibnFmekQRacYFaXEeQWB0SskAJLIKM2DGwCL/VeM4kD/CPPagLTzANMG
	XPcroMFMQIND48AGlyQipKQaGP2K5gR+6D4t4jl5m8i52m/mKj7q+vM2Jba11d07feCzyTfH
	7dbsKd5pK3Zt1NmUOr/Aqd/NfzXrpiMvuOzOvn1jvL12aaE8w87lf5Y9fcz9Ml/q486jjLoh
	VTtiN/NPPtrgny5TtMYoK71zi4xv7f+pxjUfJNaKXtgWtyJ2X074RZeaxdbuLEos 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239997>

safe_create_leading_directories_const() returns a non-zero value on
error.  The old code at this calling site recognized a couple of
particular error values, and treated all other return values as
success.  Instead, be more conservative: recognize the errors we are
interested in, but treat any other nonzero values as failures.  This
is more robust in case somebody adds another possible return value
without telling us.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6f69593..c7c76bb 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -515,13 +515,14 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				saved = shared_repository;
 				shared_repository = 0;
 				switch (safe_create_leading_directories_const(argv[0])) {
+				case SCLD_OK:
+				case SCLD_PERMS:
+					break;
 				case SCLD_EXISTS:
 					errno = EEXIST;
 					/* fallthru */
-				case SCLD_FAILED:
-					die_errno(_("cannot mkdir %s"), argv[0]);
-					break;
 				default:
+					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
 				shared_repository = saved;
-- 
1.8.5.2
