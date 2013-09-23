From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 00/16] Make Gnome Credential helper more Gnome-y and support ancient distros
Date: Mon, 23 Sep 2013 11:49:01 -0700
Message-ID: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCM-0007St-D8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab3IWStZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14672 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3IWStY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:24 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B52408d0c0000>; Mon, 23 Sep 2013 11:48:44 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:45:51 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 23 Sep 2013 11:45:51 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:24 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235215>

From: Brandon Casey <drafnel@gmail.com>

Mostly unchanged.

Inserts a patch to fix the style issues for block statements.
i.e. use "if ()" instead of "if()"

A couple early patches were reordered to improve logical flow.

Updated the comment in the last patch to hopefully improve clarity
wrt RHEL 4.X

The only functional change is in 14/16 "report failure to store".
We should accept GNOME_KEYRING_RESULT_CANCELLED as a successful
return and _not_ produce an error message.

Interdiff follows...

Brandon Casey (16):
  contrib/git-credential-gnome-keyring.c: remove unnecessary
    pre-declarations
  contrib/git-credential-gnome-keyring.c: remove unused die() function
  contrib/git-credential-gnome-keyring.c: *style* use "if ()" not "if()"
    etc.
  contrib/git-credential-gnome-keyring.c: add static where applicable
  contrib/git-credential-gnome-keyring.c: exit non-zero when called
    incorrectly
  contrib/git-credential-gnome-keyring.c: strlen() returns size_t, not
    ssize_t
  contrib/git-credential-gnome-keyring.c: ensure buffer is non-empty
    before accessing
  contrib/git-credential-gnome-keyring.c: set Gnome application name
  contrib/git-credential-gnome-keyring.c: use gnome helpers in
    keyring_object()
  contrib/git-credential-gnome-keyring.c: use secure memory functions
    for passwds
  contrib/git-credential-gnome-keyring.c: use secure memory for reading
    passwords
  contrib/git-credential-gnome-keyring.c: use glib memory allocation
    functions
  contrib/git-credential-gnome-keyring.c: use glib messaging functions
  contrib/git-credential-gnome-keyring.c: report failure to store
    password
  contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
  contrib/git-credential-gnome-keyring.c: support really ancient
    gnome-keyring

 contrib/credential/gnome-keyring/Makefile          |   4 +-
 .../gnome-keyring/git-credential-gnome-keyring.c   | 301 ++++++++++++---------
 2 files changed, 169 insertions(+), 136 deletions(-)

---

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index ce2ddee..635c96b 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -50,7 +50,7 @@
 
 /*
  * ancient gnome-keyring returns DENIED when an entry is not found.
- * Setting NO_MATCH to DENIED will prevent us from reporting denied
+ * Setting NO_MATCH to DENIED will prevent us from reporting DENIED
  * errors during get and erase operations, but we will still report
  * DENIED errors during a store.
  */
@@ -87,8 +87,8 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
 }
 
 /*
- * Just a guess to support RHEL 4.X.
- * Glib 2.8 was roughly Gnome 2.12 ?
+ * Support really ancient gnome-keyring, circ. RHEL 4.X.
+ * Just a guess for the Glib version.  Glib 2.8 was roughly Gnome 2.12 ?
  * Which was released with gnome-keyring 0.4.3 ??
  */
 #if GLIB_MAJOR_VERSION == 2 && GLIB_MINOR_VERSION < 8
@@ -162,7 +162,7 @@ static char* keyring_object(struct credential *c)
 	if (!c->path)
 		return NULL;
 
-	if(c->port)
+	if (c->port)
 		return g_strdup_printf("%s:%hd/%s", c->host, c->port, c->path);
 
 	return g_strdup_printf("%s/%s", c->host, c->path);
@@ -251,7 +251,8 @@ static int keyring_store(struct credential *c)
 
 	g_free(object);
 
-	if (result != GNOME_KEYRING_RESULT_OK) {
+	if (result != GNOME_KEYRING_RESULT_OK &&
+	    result != GNOME_KEYRING_RESULT_CANCELLED) {
 		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
@@ -363,14 +364,14 @@ static int credential_read(struct credential *c)
 	{
 		line_len = strlen(buf);
 
-		if(line_len && buf[line_len-1] == '\n')
+		if (line_len && buf[line_len-1] == '\n')
 			buf[--line_len]='\0';
 
-		if(!line_len)
+		if (!line_len)
 			break;
 
 		value = strchr(buf,'=');
-		if(!value) {
+		if (!value) {
 			g_warning("invalid credential line: %s", key);
 			gnome_keyring_memory_free(buf);
 			return -1;
@@ -432,9 +433,9 @@ static void usage(const char *name)
 
 	basename = (basename) ? basename + 1 : name;
 	fprintf(stderr, "usage: %s <", basename);
-	while(try_op->name) {
+	while (try_op->name) {
 		fprintf(stderr,"%s",(try_op++)->name);
-		if(try_op->name)
+		if (try_op->name)
 			fprintf(stderr,"%s","|");
 	}
 	fprintf(stderr,"%s",">\n");
@@ -455,15 +456,15 @@ int main(int argc, char *argv[])
 	g_set_application_name("Git Credential Helper");
 
 	/* lookup operation callback */
-	while(try_op->name && strcmp(argv[1], try_op->name))
+	while (try_op->name && strcmp(argv[1], try_op->name))
 		try_op++;
 
 	/* unsupported operation given -- ignore silently */
-	if(!try_op->name || !try_op->op)
+	if (!try_op->name || !try_op->op)
 		goto out;
 
 	ret = credential_read(&cred);
-	if(ret)
+	if (ret)
 		goto out;
 
 	/* perform credential operation */

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
