From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] cmd_config(): Make a copy of path obtained from git_path()
Date: Sun, 16 Nov 2014 08:37:44 +0100
Message-ID: <1416123464-22874-1-git-send-email-mhagger@alum.mit.edu>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 08:38:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpuPZ-0001fN-UU
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 08:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbaKPHiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 02:38:07 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60494 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656AbaKPHiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 02:38:06 -0500
X-AuditID: 1207440f-f79f06d000000bbf-54-546854503216
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.B4.03007.05458645; Sun, 16 Nov 2014 02:37:52 -0500 (EST)
Received: from michael.fritz.box (p4FC97A4A.dip0.t-ipconnect.de [79.201.122.74])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAG7bn7l003203
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 16 Nov 2014 02:37:51 -0500
X-Mailer: git-send-email 2.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqBsQkhFicOGvpUXXlW4mi4beK8wW
	/3csYLG4vWI+swOLx9/3H5g8jh1rZfa4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujPZ76xgL
	nvJWvHi7kamBsY+7i5GTQ0LARGLdwr3MELaYxIV769m6GLk4hAQuM0rs3feaFcI5wSTR+6SR
	HaSKTUBXYlFPMxOILSKgJjGx7RALiM0skCfxa3IbYxcjB4ewgLfEuQ3CIGEWAVWJxx3L2UBs
	XgEXiSXHT7BCLJOT2Dt5NcsERu4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RS
	U0o3MULCgX8HY9d6mUOMAhyMSjy8GywyQoRYE8uKK3MPMUpyMCmJ8oY6AYX4kvJTKjMSizPi
	i0pzUosPMUpwMCuJ8K4xBcrxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4
	lCR4dwcBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDAj2+GBjqICkeoL3JIO28
	xQWJuUBRiNZTjIpS4rxrQBICIImM0jy4sbAof8UoDvSlMC9bMFAVDzBBwHW/AhrMBDSY8Vgq
	yOCSRISUVAMjQ4Rd6PZGj8MTPwW1/bLxDjWwe/NsYrDq+x85xatz2ysdOJ9KWl4SXOwUJMD+
	69Prdf+WSwgL/XdYdWaSmnMm76ride1a4o0FoluO9Pm6abxR4Xyx2qmVTz/0jdZJb+V48SrT
	r4ZhPlmXQ+/kTXnPcT0z+sP2UtsXN5fVTYoKucLtf8REyVuJpTgj0VCLuag4EQCs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strings returned by git_path() are recycled after a while. So make
a copy of the config filename rather than holding onto the return
value from git_path().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch is an improvement by itself, and it also eases the merging
to master of my fix for the incorrectly set config file executable
bit [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/259644

 builtin/config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cc2604..606a3c0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -568,8 +568,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 	}
 	else if (actions == ACTION_EDIT) {
-		const char *config_file = given_config_source.file ?
-			given_config_source.file : git_path("config");
+		char *config_file;
+
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
 			die("not in a git directory");
@@ -578,6 +578,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
+		config_file = xstrdup(given_config_source.file ?
+				      given_config_source.file : git_path("config"));
 		if (use_global_config) {
 			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
 			if (fd) {
@@ -590,6 +592,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				die_errno(_("cannot create configuration file %s"), config_file);
 		}
 		launch_editor(config_file, NULL, NULL);
+		free(config_file);
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
-- 
2.1.1
