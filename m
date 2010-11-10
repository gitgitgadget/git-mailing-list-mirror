From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: URL-escape the '@' sign in username/password
Date: Wed, 10 Nov 2010 02:33:09 +0100
Message-ID: <4CD9F655.8030908@enst-bretagne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 02:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFzjS-0005NH-3g
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 02:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab0KJBoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 20:44:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:56217 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab0KJBoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 20:44:07 -0500
Received: from [192.168.0.60] (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 381CAA61E3
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 02:44:00 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100918 Icedove/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161118>

Hello,

I've been trying to use git with a http/webdav repository with an 
username containing a '@' character (foobar@host). The git FAQ [1] 
suggests escaping the '@' character with percent encoding. However, the 
username and password of the URI are not unescaped and the username 
foobar%400host is sent to the web server.

$ #Launch a dummy web server
$ webfsd -4 -r ~/bidouilles/temp/empty/ -L- -F -bfoobar@host:secret 
-p8000 -i 127.0.0.1 &

$ git clone http://foobar%40host:secret@127.0.0.1:8000/
Cloning into 8000...
fatal: Authentication failed

Compare with:

$ git clone http://127.0.0.1:8000/
Cloning into 8000...
Username: foobar@host
Password: secret
fatal: http://127.0.0.1:8000/info/refs not found: did you run git 
update-server-info on the server?

[1] 
https://git.wiki.kernel.org/index.php/GitFaq#My_username_contains_a_.27.40.27.2C_I_can.27t_clone_through_HTTP.2FHTTPS

diff --git a/http.c b/http.c
index 0a5011f..c4d18a9 100644
--- a/http.c
+++ b/http.c
@@ -297,7 +297,7 @@ static CURL *get_curl_handle(void)

  static void http_auth_init(const char *url)
  {
-       char *at, *colon, *cp, *slash;
+       char *at, *colon, *cp, *slash, *temp;
         int len;

         cp = strstr(url, "://");
@@ -322,16 +322,25 @@ static void http_auth_init(const char *url)
                 user_name = xmalloc(len + 1);
                 memcpy(user_name, cp, len);
                 user_name[len] = '\0';
+               temp = url_decode(user_name);
+               free(user_name);
+               user_name = temp;
                 user_pass = NULL;
         } else {
                 len = colon - cp;
                 user_name = xmalloc(len + 1);
                 memcpy(user_name, cp, len);
                 user_name[len] = '\0';
+               temp = url_decode(user_name);
+               free(user_name);
+               user_name = temp;
                 len = at - (colon + 1);
                 user_pass = xmalloc(len + 1);
                 memcpy(user_pass, colon + 1, len);
                 user_pass[len] = '\0';
+               temp = url_decode(user_pass);
+               free(user_pass);
+               user_pass = temp;
         }
  }

-- 
Gabriel
