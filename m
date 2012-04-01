From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Cannot clone the git repository shared over http with
 authorization.
Date: Sun, 1 Apr 2012 22:53:26 +0200
Message-ID: <20120401205324.GA31046@ecki>
References: <20120401184804.GJ3236@szczaw.snafu.pl>
 <20120401194534.GA16512@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Artur R. Czechowski" <arturcz@hell.pl>
X-From: git-owner@vger.kernel.org Sun Apr 01 22:53:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SERmQ-0000dH-T0
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 22:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab2DAUxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 16:53:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:53933 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab2DAUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 16:53:37 -0400
Received: from localhost (p5B22DD1B.dip.t-dialin.net [91.34.221.27])
	by bsmtp.bon.at (Postfix) with ESMTP id 95D3010019;
	Sun,  1 Apr 2012 22:49:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120401194534.GA16512@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194485>

On Sun, Apr 01, 2012 at 09:45:36PM +0200, Clemens Buchacher wrote:
> On Sun, Apr 01, 2012 at 08:48:04PM +0200, Artur R. Czechowski wrote:
> > 
> > arturcz@szczaw:/tmp$ git clone http://blabluga.hell.pl/git/test.git
> > Cloning into 'test'...
> > error: The requested URL returned error: 401 (curl_result = 22, http_code = 401, sha1 = e884293079beab9f2583b59b4e05479fc84fc588)
> > error: Unable to find e884293079beab9f2583b59b4e05479fc84fc588 under http://blabluga.hell.pl/git/test.git
> > Cannot obtain needed commit e884293079beab9f2583b59b4e05479fc84fc588
> > while processing commit c64bcf957545f61436d405326d985521dc45058f.
> > error: Fetch failed.

This is the minimal test case I could find to reproduce this reliably on
in our test suite. It seems that a certain number of loose objects is
also required to trigger the issue.

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 3c12b05..d31c083 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -77,6 +77,13 @@ SSLMutex file:ssl_mutex
 SSLEngine On
 </IfDefine>
 
+<Location /dumb/auth/>
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</Location>
+
 <Location /auth/>
 	AuthType Basic
 	AuthName "git-auth"
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index e5e6b8f..3eb8753 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -13,17 +13,22 @@ LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
 start_httpd
 
 test_expect_success 'setup repository' '
-	echo content >file &&
+	echo content1 >file &&
 	git add file &&
 	git commit -m one
+	echo content2 >file &&
+	git add file &&
+	git commit -m two
 '
 
 test_expect_success 'create http-accessible bare repository' '
-	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	cp -r .git "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	 git --bare init &&
+	 git config core.bare true &&
+	 mv hooks-disabled hooks &&
 	 echo "exec git update-server-info" >hooks/post-update &&
-	 chmod +x hooks/post-update
+	 chmod +x hooks/post-update &&
+	 hooks/post-update
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git push public master:master
@@ -73,6 +78,13 @@ expect_askpass() {
 	test_cmp askpass-expect askpass-query
 }
 
+test_expect_success 'clone password-protected repository with dumb http' '
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	GIT_CURL_VERBOSE=1 git clone "$HTTPD_URL/dumb/auth/repo.git" repo-dumb-auth &&
+	expect_askpass both user@host
+'
+
 test_expect_success 'cloning password-protected repository can fail' '
 	>askpass-query &&
 	echo wrong >askpass-response &&
