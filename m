From: Alex Riesen <raa.lkml@gmail.com>
Subject: use result of open(2) to check for presence
Date: Thu, 5 Jan 2006 12:43:34 +0100
Message-ID: <81b0412b0601050343w4c00ac86y30569c3babbf6728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11225_499875.1136461414872"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:43:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuTWx-0007cC-HC
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbWAELni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbWAELni
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:43:38 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:25515 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752157AbWAELnh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:43:37 -0500
Received: by nproxy.gmail.com with SMTP id x37so102778nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:43:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ABmST8DH1PewjsrRHNNVjcc9i5njvPdgc/zROQVz53o/QlJExsRMphQtBgVm8FD3OHPNGma8yT/R5VHF3y24J0jlQMrHDtI9JyfcV3ZPQPKDqYeyGGFFnJuPcxQbEIaJmkugRX1tTwiKKihMEwOrrnJqZetfTinyMes0GrUGXWM=
Received: by 10.48.254.2 with SMTP id b2mr683653nfi;
        Thu, 05 Jan 2006 03:43:35 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:43:34 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14187>

------=_Part_11225_499875.1136461414872
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Not that the stat against open race would matter much in this context,
but that simplifies
the code a bit. Also some diagnostics added (why the open failed)

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11225_499875.1136461414872
Content-Type: text/plain; 
	name=0001-use-result-of-open-2-to-check-for-presence-of-the-old-config-file.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-use-result-of-open-2-to-check-for-presence-of-the-old-config-file.txt"

Subject: [PATCH] use result of open(2) to check for presence

of the old config file

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>


---

 config.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

b74ea5a71504808112bd4781a69b17f6009104db
diff --git a/config.c b/config.c
index 992e988..8355224 100644
--- a/config.c
+++ b/config.c
@@ -409,8 +409,7 @@ int git_config_set_multivar(const char* 
 	const char* value_regex, int multi_replace)
 {
 	int i;
-	struct stat st;
-	int fd;
+	int fd, in_fd;
 	char* config_filename = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
 	const char* last_dot = strrchr(key, '.');
@@ -457,9 +456,17 @@ int git_config_set_multivar(const char* 
 	/*
 	 * If .git/config does not exist yet, write a minimal version.
 	 */
-	if (stat(config_filename, &st)) {
+	in_fd = open(config_filename, O_RDONLY);
+	if ( in_fd < 0 ) {
 		free(store.key);
 
+		if ( ENOENT != errno ) {
+			error("opening %s: %s", config_filename,
+			      strerror(errno));
+			close(fd);
+			unlink(lock_file);
+			return 3; /* same as "invalid config file" */
+		}
 		/* if nothing to unset, error out */
 		if (value == NULL) {
 			close(fd);
@@ -471,7 +478,7 @@ int git_config_set_multivar(const char* 
 		store_write_section(fd, key);
 		store_write_pair(fd, key, value);
 	} else{
-		int in_fd;
+		struct stat st;
 		char* contents;
 		int i, copy_begin, copy_end, new_line = 0;
 
@@ -528,7 +535,7 @@ int git_config_set_multivar(const char* 
 			return 5;
 		}
 
-		in_fd = open(config_filename, O_RDONLY, 0666);
+		fstat(in_fd, &st);
 		contents = mmap(NULL, st.st_size, PROT_READ,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
-- 
1.0.GIT




------=_Part_11225_499875.1136461414872--
