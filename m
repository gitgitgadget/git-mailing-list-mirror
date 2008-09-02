From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] ignore trailing slashes when creating leading
	directories
Date: Tue, 2 Sep 2008 22:07:59 +0200
Message-ID: <20080902200759.GA13451@localhost>
References: <20080902081909.GA2059@localhost> <7vk5dul7f5.fsf@gitster.siamese.dyndns.org> <20080902191322.GA11172@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:08:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KacAz-0006Es-Do
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYIBUH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYIBUH1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:07:27 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:9487 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYIBUH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:07:26 -0400
Received: from darc.dyndns.org ([84.154.73.149]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Sep 2008 22:07:23 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KacAR-00074V-98; Tue, 02 Sep 2008 22:07:59 +0200
Content-Disposition: inline
In-Reply-To: <20080902191322.GA11172@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 02 Sep 2008 20:07:23.0604 (UTC) FILETIME=[836C3940:01C90D37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94700>

Currently, create_leading_directories() will interpret all parts of
paths like 'a/b/c/' as "leading directories". A subsequent call to mkdir
for the tail of the path will fail, because the "File already exists."

This makes sure trailing slashes are ignored.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Applies to next. Passes regression tests.

 sha1_file.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9ee1ed1..dcb3d22 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -93,12 +93,19 @@ static inline int offset_1st_component(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path + offset_1st_component(path);
+	char *next;
 	struct stat st;
 
 	while (pos) {
 		pos = strchr(pos, '/');
 		if (!pos)
 			break;
+		next = pos + 1;
+		while (*next == '/')
+			next++;
+		if (!*next)
+			break;
+
 		*pos = 0;
 		if (!stat(path, &st)) {
 			/* path exists */
-- 
1.6.0.1.275.gc88b6
