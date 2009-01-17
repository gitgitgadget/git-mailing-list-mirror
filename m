From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] http-push: when making directories, have a trailing slash
 in the path name
Date: Sat, 17 Jan 2009 16:11:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171606190.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>  <alpine.DEB.1.00.0901170654540.3586@pacific.mpi-cbg.de> <be6fef0d0901170028t3b418220wa024880235776037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOCqi-0007XI-O9
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127AbZAQPLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758120AbZAQPLL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:11:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:56070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757935AbZAQPLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:11:09 -0500
Received: (qmail invoked by alias); 17 Jan 2009 15:11:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 17 Jan 2009 16:11:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p4g97pnzpanK5W5z+Fw3OyI4GxSu8y8HrTZd/QM
	NAK0yvFFFN0ENo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901170028t3b418220wa024880235776037@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106055>


The function lock_remote() sends MKCOL requests to make leading
directories; However, if it does not put a forward slash '/' at the end of
the path, the server sends a 301 redirect.

By leaving the '/' in place, we can avoid this additional step.

Incidentally, at least one version of Curl (7.16.3) does not resend
credentials when it follows a 301 redirect, so this commit also fixes
a bug.

Original patch by Tay Ray Chuan <rctay89@gmail.com>.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 17 Jan 2009, Ray Chuan wrote:

	>  http-push.c |   20 +++++++++++++++-----
	>  1 files changed, 15 insertions(+), 5 deletions(-)

	Actually, I had more something like this in mind.  Please note 
	that I am not the best patch writer of the world, and I know it.  
	However, a few things I do try to follow:

	- our commit messages are not really uniform, but they do share a 
	  certain likeliness, e.g. all sentences start with a capital, we 
	  try to use a less personal form than "I", and we avoid 
	  abbreviations like "don't" and write "do not" instead.

	- if you can come up with a patch that is shorter, but still clear 
	  in what it does (the commit message might need to help there), 
	  it is preferred: the less lines changed, the less lines for bugs 
	  to hide in.

	- this patch includes a test case.

	The latter part cannot be stressed enough: my first idea was to 
	test for 301, but I realized then and there that _my_ Apache does not 
	care, but always returns a 201.

	However, I remember that I had an Apache something like 2 years 
	ago which cared, and therefore I think this patch should go in.

 http-push.c             |    5 +++--
 t/lib-httpd/apache.conf |    2 ++
 t/t5540-http-push.sh    |    6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index bbe7a8e..9fcccee 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1201,7 +1201,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	/* Make sure leading directories exist for the remote ref */
 	ep = strchr(url + strlen(remote->url) + 1, '/');
 	while (ep) {
-		*ep = 0;
+		char saved_character = ep[1];
+		ep[1] = '\0';
 		slot = get_active_slot();
 		slot->results = &results;
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
@@ -1223,7 +1224,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 			free(url);
 			return NULL;
 		}
-		*ep = '/';
+		ep[1] = saved_character;
 		ep = strchr(ep + 1, '/');
 	}
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 4717c2d..fdb19a5 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,6 +1,8 @@
 ServerName dummy
 PidFile httpd.pid
 DocumentRoot www
+LogFormat "%h %l %u %t \"%r\" %>s %b" common
+CustomLog access.log common
 ErrorLog error.log
 
 <IfDefine SSL>
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index da95886..22cfbb6 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -76,6 +76,12 @@ test_expect_failure 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
+test_expect_success 'MKCOL sends directory names with trailing slashes' '
+
+	! grep "\"MKCOL.*[^/] HTTP/[^ ]*\"" < "$HTTPD_ROOT_PATH"/access.log
+
+'
+
 stop_httpd
 
 test_done
-- 
1.6.1.325.g062d4
