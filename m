From: Jens Lindstrom <jl@opera.com>
Subject: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Fri, 28 Jun 2013 16:42:18 +0200
Message-ID: <1372430538-19216-1-git-send-email-jl@opera.com>
Cc: gitster@pobox.com, johan@herland.net, Jens Lindstrom <jl@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 28 16:57:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usa7F-0006OY-RE
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab3F1O5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:57:34 -0400
Received: from smtp.opera.com ([213.236.208.81]:47081 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780Ab3F1O5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:57:33 -0400
X-Greylist: delayed 838 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2013 10:57:31 EDT
Received: from insane.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r5SEh4Mp020447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Jun 2013 14:43:04 GMT
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229207>

The pack-*.keep files are temporary, and serve no purpose in the
clone.  They would probably also never be deleted from the clone if
copied, since the process that created them only expects to have to
delete them from the original repository.

Worse, though, they are created with access bits 0600, so if the
user trying to clone the repository is different from the user that
caused the pack-*.keep file to be created, the clone will likely
fail due to not being allowed to read (and thus copy) the file in
the first place.

Signed-off-by: Jens Lindstrom <jl@opera.com>
---
 builtin/clone.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 035ab64..0ec0ec9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -342,6 +342,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 
+		/* Skip pack-*.keep files, they are temporary and not
+		   relevant to the clone, and might not be accessible. */
+		if (!strcmp(src->buf + strlen(src->buf) - 5, ".keep"))
+			continue;
+
 		/* Files that cannot be copied bit-for-bit... */
 		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
 			copy_alternates(src, dest, src_repo);
-- 
1.7.10.4
