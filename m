From: Bradford C Smith <bradford.carl.smith@gmail.com>
Subject: [PATCH 2/2] use make_absolute_path() in lock_file()
Date: Fri, 27 Jul 2007 15:10:56 -0400
Message-ID: <1185563460165-git-send-email-bradford.carl.smith@gmail.com>
References: <11855634561516-git-send-email-bradford.carl.smith@gmail.com>
 <11855634582686-git-send-email-bradford.carl.smith@gmail.com>
Cc: Junio C Hamano <gitster@pobox.como>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Bradford C. Smith" <bradford.carl.smith@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 21:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVDe-0003AW-64
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761930AbXG0TLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761731AbXG0TLI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:11:08 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:56010 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbXG0TLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:11:03 -0400
Received: by qb-out-0506.google.com with SMTP id e11so797977qbe
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 12:11:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cgN8Ry2xBeWN+2N2tBB8GuVDeW6pxJF5QZWOuQVO+O9iLEGV1fDQhH0zV0PbArkxqfzjJwdTXNuIEYkFZkrBuH2Goouv5v2ucGTgpQEidkqMhGa44vFJijA1PxXLqdlQfeZcvVE7gsrzOq6QMbjEZfndzXUr1Y2oEy20J3DFy9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OWzkk0826V74IZI4qHV+wIAs1tkER6zQEZuHmsX3kqWQ1opRjucvZyLoEFj+TIaOTdDHdBL7Sc9VGpP8dgnciIuII3bEcoOqUBAv8RJ5ez5DVZgy0alvVH4aGp4lgRRPu436cK2Ilb7ZUggBGc/g+uHOEmq+1+wPHGSTog+9p5U=
Received: by 10.100.143.11 with SMTP id q11mr3193362and.1185563462373;
        Fri, 27 Jul 2007 12:11:02 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id b29sm68387ana.2007.07.27.12.11.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 12:11:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc3.9.g9ef91
In-Reply-To: <11855634582686-git-send-email-bradford.carl.smith@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53951>

From: Bradford C. Smith <bradford.carl.smith@gmail.com>

Use make_absolute_path() to get fully resolved path name for creating
the lock file.

Signed-off-by: Bradford C. Smith <bradford.carl.smith@gmail.com>
---
 lockfile.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9202472..57f850f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -28,20 +28,10 @@ static void remove_lock_file_on_signal(int signo)
 static int lock_file(struct lock_file *lk, const char *path)
 {
 	int fd;
-	struct stat st;
 
-	if ((!lstat(path, &st)) && S_ISLNK(st.st_mode)) {
-		ssize_t sz;
-		static char target[PATH_MAX];
-		sz = readlink(path, target, sizeof(target));
-		if (sz < 0)
-			warning("Cannot readlink %s", path);
-		else if (target[0] != '/')
-			warning("Cannot lock target of relative symlink %s", path);
-		else
-			path = target;
-	}
-	sprintf(lk->filename, "%s.lock", path);
+	strcpy(lk->filename, path);
+	make_absolute_path(lk->filename);
+	strcat(lk->filename, ".lock");
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
 		if (!lock_file_list) {
-- 
1.5.3.rc3.9.g9ef91
