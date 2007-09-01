From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] URL: allow port specification in ssh:// URLs
Date: Sat, 1 Sep 2007 02:36:31 -0700 (PDT)
Message-ID: <583261.77513.qm@web31802.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 11:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRPPj-0001kv-Af
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 11:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbXIAJgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 05:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXIAJgd
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 05:36:33 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:39140 "HELO
	web31802.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752824AbXIAJgc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2007 05:36:32 -0400
Received: (qmail 88475 invoked by uid 60001); 1 Sep 2007 09:36:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=sDm6HWvcc4/gia/aebyCYDb/gDB5n+ShQo4Iqof4tSAD2KkOYoEQOTxgoFpcMWAmY9z8sjBTF56rVvcF+kF2XgIOQdEf0zjHXnzB80moYTpsehJUGt2QsEr0nA7Y38OIiU0PZg3Be57kc0dy2XfsWx2Go8tVPz2fZM+AnzBhJMg=;
X-YMail-OSG: TMaX0KMVM1mqILdAuofHRej61QshDaXmJG3jZpKCn2ffBllsqcxniQ5bnFi7hdq55D0t_n5VMw--
Received: from [71.84.13.248] by web31802.mail.mud.yahoo.com via HTTP; Sat, 01 Sep 2007 02:36:31 PDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57264>

Allow port specification in ssh:// URLs in the
usual notation:
	ssh://[user@]host.domain[:<port>]/<path>

This allows git to be used over ssh-tunneling
networks.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 Documentation/urls.txt |    4 +++-
 connect.c              |   30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index b38145f..e67f914 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,6 +10,7 @@ to name the remote repository:
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
@@ -18,7 +19,8 @@ to name the remote repository:
 SSH is the default transport protocol over the network.  You can
 optionally specify which user to log-in as, and an alternate,
 scp-like syntax is also supported.  Both syntaxes support
-username expansion, as does the native git protocol. The following
+username expansion, as does the native git protocol, but
+only the former supports port specification. The following
 three are identical to the last three above, respectively:
 
 ===============================================================
diff --git a/connect.c b/connect.c
index ae49c5a..8b1e993 100644
--- a/connect.c
+++ b/connect.c
@@ -453,6 +453,22 @@ static void git_proxy_connect(int fd[2], char *host)
 
 #define MAX_CMD_LEN 1024
 
+char *get_port(char *host)
+{
+	char *end;
+	char *p = strchr(host, ':');
+
+	if (p) {
+		strtol(p+1, &end, 10);
+		if (*end == '\0') {
+			*p = '\0';
+			return p+1;
+		}
+	}
+
+	return NULL;
+}
+
 /*
  * This returns 0 if the transport protocol does not need fork(2),
  * or a process id if it does.  Once done, finish the connection
@@ -471,6 +487,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 	pid_t pid;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
+	char *port = NULL;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -527,6 +544,12 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 		*ptr = '\0';
 	}
 
+	/*
+	 * Add support for ssh port: ssh://host.xy:<port>/...
+	 */
+	if (protocol == PROTO_SSH && host != url)
+		port = get_port(host);
+
 	if (protocol == PROTO_GIT) {
 		/* These underlying connection commands die() if they
 		 * cannot connect.
@@ -583,7 +606,12 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 				ssh_basename = ssh;
 			else
 				ssh_basename++;
-			execlp(ssh, ssh_basename, host, command, NULL);
+
+			if (!port)
+				execlp(ssh, ssh_basename, host, command, NULL);
+			else
+				execlp(ssh, ssh_basename, "-p", port, host,
+				       command, NULL);
 		}
 		else {
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
-- 
1.5.3.rc7.1278.g0f6d
