From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Subject: [PATCH] git-receive-pack needs to set umask(2)
Date: Sun, 28 May 2006 17:31:41 -0400
Message-ID: <v0irnpn8ea.fsf@marajade.sandelman.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-From: git-owner@vger.kernel.org Sun May 28 23:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkSzf-0001gW-4M
	for gcvg-git@gmane.org; Sun, 28 May 2006 23:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWE1VkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 17:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWE1VkL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 17:40:11 -0400
Received: from main.gmane.org ([80.91.229.2]:12773 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750960AbWE1VkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 17:40:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FkSzS-0001dQ-2o
	for git@vger.kernel.org; Sun, 28 May 2006 23:40:02 +0200
Received: from desk.marajade.sandelman.ca ([205.150.200.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 23:40:02 +0200
Received: from mcr by desk.marajade.sandelman.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 23:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: desk.marajade.sandelman.ca
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
Cancel-Lock: sha1:2Z5cqTmDRMT5oin+E0vUBee9hFM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20897>

--=-=-=


If there is another way to solve this, please let me know.
Wrapping git-receive-pack with a shell script to call umask seemed like too
global a change.
(also http://git.openswan.org/git#umask_hack)

When working with a common git repository, not all users are always clueful
enough to set their umask properly --- nor should the default for the user
always be so permissive.

This change adds $GIT_DIR/umask to contain a single line, an integer
which will be fed to umask(). This should also work for the git daemon,
which I personally do not use, so this may be inappropriate.

Signed-off-by: Michael Richardson <mcr@xelerance.com>

---

8698daf8fedc8618593ec44574df1efb9f31db84
 Documentation/git-receive-pack.txt |    3 +++
 cache.h                            |    1 +
 path.c                             |    2 ++
 setup.c                            |   19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 0 deletions(-)

8698daf8fedc8618593ec44574df1efb9f31db84
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 60debca..d3a8c11 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -74,6 +74,9 @@ packed and is served via a dumb transpor
 There are other real-world examples of using update and
 post-update hooks found in the Documentation/howto directory.
 
+The file $GIT_DIR/umask, if it exists will be opened, and the integer found
+in it will be used to initialize the umask(2) for subsequent file creation
+operations. 
 
 OPTIONS
 -------
diff --git a/cache.h b/cache.h
index 3a46fb9..65d5124 100644
--- a/cache.h
+++ b/cache.h
@@ -355,6 +355,7 @@ extern int git_config_bool(const char *,
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int check_repository_format_version(const char *var, const char *value);
+extern void setup_umask();
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/path.c b/path.c
index 334b2bd..571ff01 100644
--- a/path.c
+++ b/path.c
@@ -244,6 +244,8 @@ char *enter_repo(char *path, int strict)
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_symref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
+
+		setup_umask();
 		check_repository_format();
 		return path;
 	}
diff --git a/setup.c b/setup.c
index fe7f884..2129125 100644
--- a/setup.c
+++ b/setup.c
@@ -228,6 +228,25 @@ int check_repository_format_version(cons
        return 0;
 }
 
+void setup_umask(void)
+{
+	FILE *f;
+
+	f = fopen(git_path("umask"), "r");
+	if(f != NULL) {
+		char maskstr[32];
+		if(fgets(maskstr, sizeof(maskstr), f) != NULL) {
+			char *foo;
+			unsigned int mask = strtoul(maskstr, &foo, 0);
+			
+			if(foo != maskstr) {
+				umask(mask);
+			}
+		}
+		fclose(f);
+	}
+}
+
 int check_repository_format(void)
 {
 	git_config(check_repository_format_version);
-- 
1.3.GIT





-- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

    "The Microsoft _Get the Facts CD_ does not work on Linux." - orospakr


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARHoWwICLcPvd0N1lAQI4KQgApYdMDi/eq5AszIMg1ZEMzPJgcOH/ZlzU
3tr/KZX9IQ3J8/crOvj2qQoqjvEmtWdnz2wAfJPp6UaLiAWyOQ5Ln3yIg9c1PQ+G
f+B81S68OElEtSagC460vOKJzJVobWJyJyMXDxNRPWFPWc/M8+SsJl8F4wWlUQuk
21yK2p/SXPAiO1wwynVodgX0Jq0xSqn8G1AxglwRO4W8vbfHWGjV841CCRMjicH7
cVSSPoi5nzR69ah1b3BHvZN7rKtYtG/wzi9b/vyj/7+S+YeRb42oPtjNz5OnVVHv
FU5dtu80xvWcJ5O4VyQrB6EIM61OAAZs5wBUH6w2GOehL/SBKacVtw==
=DFp7
-----END PGP SIGNATURE-----
--=-=-=--
