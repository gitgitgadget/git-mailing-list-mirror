From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Sun, 16 Nov 2014 08:21:47 +0100
Message-ID: <1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 08:22:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpuA1-0005pX-Bt
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 08:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbaKPHWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 02:22:00 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60428 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656AbaKPHV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 02:21:59 -0500
X-AuditID: 1207440f-f79f06d000000bbf-5c-54685096f9aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C0.94.03007.69058645; Sun, 16 Nov 2014 02:21:58 -0500 (EST)
Received: from michael.fritz.box (p4FC97A4A.dip0.t-ipconnect.de [79.201.122.74])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAG7Lrk7002608
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 16 Nov 2014 02:21:57 -0500
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqDstICPEYNNidYuuK91MFg29V5gt
	Fv47ym7xf8cCFovbK+YzW+xvSrJY072DyaKz4yujA4fH3/cfmDx2zrrL7nHsWCuzx8VLyh6f
	N8l53H62jcWjecp51gD2KG6bpMSSsuDM9Dx9uwTujOmX+1kLznBX9Nx6wNLAuIuzi5GTQ0LA
	ROLqt2YmCFtM4sK99WwgtpDAZUaJ30/Nuxi5gOwTTBJT5p8EK2IT0JVY1APRICKgJjGx7RAL
	SBGzwDYmiW/z/rGDJIQFQiROLbnGCGKzCKhKbLq6FMzmFXCRaFy9G2qbnMTeyatZQGxOAVeJ
	ky8XQ212kVjV8Zt1AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxgh
	Qci/g7FrvcwhRgEORiUe3g0WGSFCrIllxZW5hxglOZiURHlDnYBCfEn5KZUZicUZ8UWlOanF
	hxglOJiVRHjXmALleFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvK/8
	gBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9DeQH+QvcUFiblA
	UYjWU4yKUuK8+SAJAZBERmke3FhYannFKA70pTBvHUgVDzAtwXW/AhrMBDSY8VgqyOCSRISU
	VAOjQ4G631Sj/ZVPV029pVrw6aiPnop14fWHEv177XJiZv/ZWsHwVnHmy5bpylrt1vmWD9hs
	U+JyPL8pWOoWWcmd8lao9pnwx4fjSOGPgg13nNW3XenPnzfbVlDqi3t6F++6nifL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since time immemorial, the test of whether to set "core.filemode" has
been done by trying to toggle the u+x bit on $GIT_DIR/config and then
testing whether the change "took". It is somewhat odd to use the
config file for this test, but whatever.

The test code didn't set the u+x bit back to its original state
itself, instead relying on the subsequent call to git_config_set() to
re-write the config file with correct permissions.

But ever since

    daa22c6f8d config: preserve config file permissions on edits (2014-05-06)

git_config_set() copies the permissions from the old config file to
the new one. This is a good change in and of itself, but it interacts
badly with create_default_files()'s sloppiness, causing "git init" to
leave the executable bit set on $GIT_DIR/config.

So change create_default_files() to reset the permissions on
$GIT_DIR/config after its test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..4c8021d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -255,6 +255,7 @@ static int create_default_files(const char *template_path)
 		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
 				st1.st_mode != st2.st_mode);
+		filemode &= !chmod(path, st1.st_mode);
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-- 
2.1.1
