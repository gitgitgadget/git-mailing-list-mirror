From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/22] resolve_ref(): explicitly fail if a symlink is not readable
Date: Thu, 15 Sep 2011 23:10:31 +0200
Message-ID: <1316121043-29367-11-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:18:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKk-00010Q-TV
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935008Ab1IOVSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:18:53 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:40176 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934922Ab1IOVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:52 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8q-00019o-Rh; Thu, 15 Sep 2011 23:06:40 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181510>

Previously the failure came later, after a few steps in which the
length was treated like the actual length of a string.  Even though
the old code gave the same answers, it was somewhat misleading.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index d2aac24..c51fd45 100644
--- a/refs.c
+++ b/refs.c
@@ -518,6 +518,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
+			if (len < 0)
+				return NULL;
 			if (len >= 5 && !memcmp("refs/", buffer, 5)) {
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
-- 
1.7.6.8.gd2879
