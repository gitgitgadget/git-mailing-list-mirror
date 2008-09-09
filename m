From: Dotan Barak <dotanba@gmail.com>
Subject: [PATCH] Rename dynamic memory allocation functions to their "x" version
Date: Tue, 9 Sep 2008 21:57:10 +0300
Message-ID: <200809092157.10185.dotanba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 20:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd7dS-0000gv-Gi
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 20:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbYIISG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755049AbYIISG4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 14:06:56 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:51884 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbYIISGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 14:06:55 -0400
Received: by py-out-1112.google.com with SMTP id p76so1313388pyb.10
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2oyzjHvgXSkkz0gebx5Fk/ETAU8MvWABjNga8UsEjng=;
        b=KQs3uxWsMnaCQEyBe/1VWWLIGABpkzHGQdBbPDAuX3SFznEUtUQpytgtlHUk9Y1l+D
         LI8ZkOwB1dJOJwM2bHH39djx6eXEgQ1nXsV9KtgSJ4JRaFaDX2wg3P/ZZm6ht92Or3za
         AHj4pkWMzgAgyct7e9c8v/Ae9eH8iLQuZBxBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=u6jGwefodL3LBJjC8/7nCNhA7meV+FpwfGKZQfexBfZRUmakpz1YLviw2irzuSVDPq
         xEsiaTGQLzyfbyELcEujWY8NPycTk4UcLUHuRm32djPdeD7rCMusQX7fPZSXIx9nzTG9
         NK82hXmmro/QbLBfNlCLKCz5bQ7AItv3YKGxg=
Received: by 10.114.181.6 with SMTP id d6mr69979waf.50.1220983614068;
        Tue, 09 Sep 2008 11:06:54 -0700 (PDT)
Received: from ?192.168.41.133? ( [85.65.202.84])
        by mx.google.com with ESMTPS id 4sm8206705yxq.9.2008.09.09.11.06.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 11:06:52 -0700 (PDT)
User-Agent: KMail/1.9.4
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95414>

In places that the standard malloc/strdup is used without checking
if the allocation was successful, I replaced it to xmalloc/xstrdup
which check the memory allocation result.

Signed-off-by: Dotan Barak <dotanba@gmail.com>

---

diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index 3a06248..ea2b689 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -53,7 +53,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 	}
 	url = argv[arg];
 	if (url && url[strlen(url)-1] != '/') {
-		rewritten_url = malloc(strlen(url)+2);
+		rewritten_url = xmalloc(strlen(url)+2);
 		strcpy(rewritten_url, url);
 		strcat(rewritten_url, "/");
 		url = rewritten_url;
diff --git a/git.c b/git.c
index adf7352..905acc2 100644
--- a/git.c
+++ b/git.c
@@ -364,7 +364,7 @@ static void handle_internal_command(int argc, const char **argv)
 	if (sizeof(ext) > 1) {
 		i = strlen(argv[0]) - strlen(ext);
 		if (i > 0 && !strcmp(argv[0] + i, ext)) {
-			char *argv0 = strdup(argv[0]);
+			char *argv0 = xstrdup(argv[0]);
 			argv[0] = cmd = argv0;
 			argv0[i] = '\0';
 		}
diff --git a/http-push.c b/http-push.c
index 6805288..c9dd9a1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2237,7 +2237,7 @@ int main(int argc, char **argv)
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
 	if (remote->url && remote->url[strlen(remote->url)-1] != '/') {
-		rewritten_url = malloc(strlen(remote->url)+2);
+		rewritten_url = xmalloc(strlen(remote->url)+2);
 		strcpy(rewritten_url, remote->url);
 		strcat(rewritten_url, "/");
 		remote->url = rewritten_url;
diff --git a/http.c b/http.c
index 1108ab4..0788936 100644
--- a/http.c
+++ b/http.c
@@ -402,7 +402,7 @@ static struct fill_chain *fill_cfg = NULL;
 
 void add_fill_function(void *data, int (*fill)(void *))
 {
-	struct fill_chain *new = malloc(sizeof(*new));
+	struct fill_chain *new = xmalloc(sizeof(*new));
 	struct fill_chain **linkp = &fill_cfg;
 	new->data = data;
 	new->fill = fill;
diff --git a/remote.c b/remote.c
index 3ef09a4..3f3c789 100644
--- a/remote.c
+++ b/remote.c
@@ -69,7 +69,7 @@ static const char *alias_url(const char *url)
 	if (!longest)
 		return url;
 
-	ret = malloc(rewrite[longest_i]->baselen +
+	ret = xmalloc(rewrite[longest_i]->baselen +
 		     (strlen(url) - longest->len) + 1);
 	strcpy(ret, rewrite[longest_i]->base);
 	strcpy(ret + rewrite[longest_i]->baselen, url + longest->len);
@@ -152,7 +152,7 @@ static struct branch *make_branch(const char *name, int len)
 		ret->name = xstrndup(name, len);
 	else
 		ret->name = xstrdup(name);
-	refname = malloc(strlen(name) + strlen("refs/heads/") + 1);
+	refname = xmalloc(strlen(name) + strlen("refs/heads/") + 1);
 	strcpy(refname, "refs/heads/");
 	strcpy(refname + strlen("refs/heads/"), ret->name);
 	ret->refname = refname;
