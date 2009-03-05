From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: [PATCH] http authentication via prompts
Date: Wed, 04 Mar 2009 19:07:11 -0600
Message-ID: <49AF25BF.5060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 03:04:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf2ws-0007Ah-7e
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 03:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZCECDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 21:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZCECDE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 21:03:04 -0500
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:42065 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427AbZCECDD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 21:03:03 -0500
X-Greylist: delayed 3358 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2009 21:03:03 EST
Received: from [66.236.120.2] (helo=[192.168.132.157])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mr.gaffo@gmail.com>)
	id 1Lf239-0005uP-0Z
	for git@vger.kernel.org; Wed, 04 Mar 2009 19:06:59 -0600
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112255>

Currently git over http only works with a .netrc file which required that you store your password on the file system in plaintext. This commit adds to configuration options for http for a username and an optional password. If a http.username is set, then the .netrc file is ignored and the username is used instead. If a http.password is set, then that is used as well, otherwise the user is prompted for their password.

With the old .netrc working, this patch provides backwards compatibility while adding a more secure option for users whose http password may be sensitive (such as if its a domain controller password) and do not wish to have it on the filesystem.

Signed-off-by: Mike Gaffney <mike@uberu.com>
---
 Documentation/config.txt                           |    7 +++
 Documentation/howto/setup-git-server-over-http.txt |   38 ++++++++++++++++--
 http.c                                             |   41 ++++++++++++++++++-
 http.h                                             |    2 +
 4 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5152c5..821bf48 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -920,6 +920,13 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
 
+http.username, http.password:
+    The username and password for http authentication. http.username is
+    required, http.password is optional. If supplied, the .netrc file will
+    be ignored. If a password is not supplied, git will prompt for it.
+    Be careful when configuring a password as it will be stored in plain text
+    on the filesystem.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 622ee5c..462a9d4 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -189,8 +189,19 @@ Make sure that you have HTTP support, i.e. your git was built with
 libcurl (version more recent than 7.10). The command 'git http-push' with
 no argument should display a usage message.
 
-Then, add the following to your $HOME/.netrc (you can do without, but will be
-asked to input your password a _lot_ of times):
+There are 2 ways to authenticate with git http, netrc and via the git config.
+The netrc option requires that you put the username and password for the connection
+in $HOME/.netrc. The configuration method allows you to specify a username and
+optionally a password. If the password is not supplied then git will prompt you
+for the password. The downside to the netrc method is that you must have your
+username and password in plaintext on the filesystem, albeit in a protected file.
+If the username/password combo is a sensitive one, you may wish to use the
+git config method. The downside of the config method is that you will be prompted
+for your password every time you push or pull to the remote repository.
+
+Using netrc:
+
+Using your favourite ext editor, add the following to your $HOME/.netrc:
 
     machine <servername>
     login <username>
@@ -204,7 +215,7 @@ instead of the server name.
 
 To check whether all is OK, do:
 
-   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/HEAD
+   curl --netrc --location -v http://<servername>/my-new-repo.git/HEAD
 
 ...this should give something like 'ref: refs/heads/master', which is
 the content of the file HEAD on the server.
@@ -213,12 +224,31 @@ Now, add the remote in your existing repository which contains the project
 you want to export:
 
    $ git-config remote.upload.url \
-       http://<username>@<servername>/my-new-repo.git/
+       http://<servername>/my-new-repo.git/
 
 It is important to put the last '/'; Without it, the server will send
 a redirect which git-http-push does not (yet) understand, and git-http-push
 will repeat the request infinitely.
 
+Using git config:
+
+curl --user <username>:<password> --location -v http://<servername>/my-new-repo.git/HEAD
+
+...this should give something like 'ref: refs/heads/master', which is
+the content of the file HEAD on the server.
+
+Now, add the remote in your existing repository which contains the project
+you want to export:
+
+   $ git-config remote.upload.url \
+       http://<servername>/my-new-repo.git/
+
+Also, add in your username with:
+   $ git-config http.username <username>
+
+And optionally your password (you will be prompted for it if you do not):
+   $ git-config http.password <password>
+
 
 Step 4: make the initial push
 -----------------------------
diff --git a/http.c b/http.c
index ee58799..348b9fb 100644
--- a/http.c
+++ b/http.c
@@ -26,6 +26,9 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv = 0;
 static const char *curl_http_proxy = NULL;
 
+static const char *curl_http_username = NULL;
+static const char *curl_http_password = NULL;
+
 static struct curl_slist *pragma_header;
 
 static struct active_request_slot *active_queue_head = NULL;
@@ -153,11 +156,45 @@ static int http_options(const char *var, const char *value, void *cb)
 			return git_config_string(&curl_http_proxy, var, value);
 		return 0;
 	}
+	if (!strcmp("http.username", var)) {
+		if (curl_http_username == NULL)
+		{
+			return git_config_string(&curl_http_username, var, value);
+		}
+		return 0;
+	}
+	if (!strcmp("http.password", var)) {
+		if (curl_http_password == NULL)
+		{
+			return git_config_string(&curl_http_password, var, value);
+		}
+		return 0;
+	}
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
 
+static void init_curl_http_auth(CURL* result){
+#if LIBCURL_VERSION_NUM >= 0x070907
+        struct strbuf userpass;
+        strbuf_init(&userpass, 0);
+        if (curl_http_username != NULL) {
+                strbuf_addstr(&userpass, curl_http_username);
+		strbuf_addstr(&userpass, ":");
+		if (curl_http_password != NULL) {
+			strbuf_addstr(&userpass, curl_http_password);
+		} else {
+			strbuf_addstr(&userpass, getpass("Password: "));
+		}
+		curl_easy_setopt(result, CURLOPT_USERPWD, userpass.buf);
+		curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_IGNORED);
+        } else {
+		curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+        }
+#endif
+}
+
 static CURL* get_curl_handle(void)
 {
 	CURL* result = curl_easy_init();
@@ -172,9 +209,7 @@ static CURL* get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x070907
-	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-#endif
+        init_curl_http_auth(result);
 
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
diff --git a/http.h b/http.h
index 905b462..71320d1 100644
--- a/http.h
+++ b/http.h
@@ -5,6 +5,8 @@
 
 #include <curl/curl.h>
 #include <curl/easy.h>
+#include <termios.h>
+#include <stdio.h>
 
 #include "strbuf.h"
 #include "remote.h"
-- 
1.6.1.2
