From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] xsize_t: check whether we lose bits
Date: Wed, 28 Jul 2010 18:36:31 +0200
Message-ID: <a619b6d672b4d01ce4107566267ba9b67904652b.1280334553.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 18:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe9cV-00066K-II
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab0G1Qge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 12:36:34 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:53244 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab0G1Qgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 12:36:33 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 28 Jul
 2010 18:36:32 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 28 Jul
 2010 18:36:32 +0200
X-Mailer: git-send-email 1.7.2.349.gd5452
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152099>

Attempting to mmap (via git-add or similar) a file larger than 4GB on
32-bit Linux systems results in a repository that has only the file
modulo 4GB stored, because of truncation of the off_t file size to a
size_t for mmap.

When xsize_t was introduced to handle this truncation in dc49cd7 (Cast
64 bit off_t to 32 bit size_t, 2007-03-06), Shawn even pointed out
that it should detect when such a cutoff happens.

Make it so.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Of course this does not fix the underlying issue that we want to mmap
the file, so you still cannot add them.

Also, I must be missing something, this patch is way too simple.


 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 02a73ee..fe845ae 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -388,6 +388,8 @@ extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1);
 
 static inline size_t xsize_t(off_t len)
 {
+	if (len > (size_t) len)
+		die("Cannot handle files this big");
 	return (size_t)len;
 }
 
-- 
1.7.2.349.gd5452
