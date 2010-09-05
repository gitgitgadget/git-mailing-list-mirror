From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 10/15] sparse-repo: Provide a function to record sparse limiting arguments
Date: Sat,  4 Sep 2010 18:14:02 -0600
Message-ID: <1283645647-1891-11-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rh-0008IQ-EB
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab0IEANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0IEANT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:19 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so647396pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hrIuDXWLkJ9w/AclVXZ3VKp9h+nzVPO+Ticm+0np34s=;
        b=FVBjI28vyKQdvC2OKH9qqI6cohhj8RfFmL9PSNWR+1wb8rp40RgrgfOi7xaRIGJlDv
         qv0DD3KY2bUIzGJv1rRCVy0BlUMQDiFMt3DX3CetREVZMzFAyRhlgwkc7yeqTRc9amPz
         ssGmrGzrUGY6/wQah0vbayg4Eki7bCguBViq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MXiZKHUJ76K1NSXrhFHY3dq7/IqGdrVwj3KP38dLYzJKFutxbPrPNH6Pq6vv+XVQUB
         229Rb4xYQFGie66jANPnGW+Zegg9J0UeGYZ+149x0T55KkvpFqbSQfk5SznmnFDHoqQN
         aB1utcVIBmAFX451OLxjeX55Ty3kGhKz36y1k=
Received: by 10.114.151.5 with SMTP id y5mr695280wad.172.1283645598916;
        Sat, 04 Sep 2010 17:13:18 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155396>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sparse-repo.c |   20 ++++++++++++++++++++
 sparse-repo.h |    1 +
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sparse-repo.c b/sparse-repo.c
index 18ea976..c983096 100644
--- a/sparse-repo.c
+++ b/sparse-repo.c
@@ -5,6 +5,26 @@
 
 #define SPARSE_FILE "sparse-limits"
 
+void record_sparse_limits(const char *quoted_argv)
+{
+	int fd, len;
+	char *sparse_file = git_path(SPARSE_FILE);
+
+	/* FIXME: sq_quote_argv puts a leading space in front of quoted
+	 * arguments, but sq_dequote_to_argv chokes on it.  Maybe sq_quote_argv
+	 * should be fixed?
+	 */
+	if (*quoted_argv == ' ')
+		quoted_argv++;
+	len = strlen(quoted_argv);
+
+	fd = open(sparse_file, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0 || write_in_full(fd, quoted_argv, len) != len)
+		die_errno("could not write %s", sparse_file);
+	xwrite(fd, "\n", 1);
+	close(fd);
+}
+
 void register_sparse_limits(const char **revlist_argv)
 {
 	if (revlist_argv != git_sparse_limits) {
diff --git a/sparse-repo.h b/sparse-repo.h
index ed9018a..2df175f 100644
--- a/sparse-repo.h
+++ b/sparse-repo.h
@@ -1,3 +1,4 @@
+void record_sparse_limits(const char *quoted_argv);
 void register_sparse_limits(const char **revlist_argv);
 void register_quoted_sparse_limits(char *quoted_argv);
 void check_sparse_repo(void);
-- 
1.7.2.2.140.gd06af
