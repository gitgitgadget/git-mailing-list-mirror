From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] config: if mtime (or size) of the config file changed since
 last read, reread it
Date: Sun, 7 May 2006 01:26:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605070125010.6597@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 01:26:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcWA2-00006i-52
	for gcvg-git@gmane.org; Sun, 07 May 2006 01:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWEFX0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 19:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEFX0C
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 19:26:02 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20436 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751082AbWEFX0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 19:26:01 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 239361DC1
	for <git@vger.kernel.org>; Sun,  7 May 2006 01:26:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 17CF51DA6
	for <git@vger.kernel.org>; Sun,  7 May 2006 01:26:00 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 0480B1D46
	for <git@vger.kernel.org>; Sun,  7 May 2006 01:26:00 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19683>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This is extremely paranoic, I know.

 config.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 05d4d8c..6765186 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@ #define MAXNAME (256)
 static const char *contents = NULL;
 static int config_length = 0, config_offset = 0;
 static const char *config_file_name;
+static time_t config_file_mtime = 0;
 static int config_linenr;
 static int get_next_char(void)
 {
@@ -255,23 +256,26 @@ int git_default_config(const char *var, 
 int git_config_from_file(config_fn_t fn, const char *filename)
 {
 	int ret, in_fd;
+	struct stat st;
 
 	config_offset = 0;
 
+	in_fd = open(filename, O_RDONLY);
+	fstat(in_fd, &st);
+
 	if (contents) {
-		if (!strcmp(config_file_name, filename))
+		if (!strcmp(config_file_name, filename)
+				&& config_file_mtime == st.st_mtime
+				&& config_length == st.st_size) {
+			close(in_fd);
 			return git_parse_file(fn);
+		}
 		munmap((char*)contents, config_length);
 		free((char*)config_file_name);
 	}
 
-	in_fd = open(filename, O_RDONLY);
-
 	ret = -1;
 	if (in_fd > 0) {
-		struct stat st;
-
-		fstat(in_fd, &st);
 		config_length = st.st_size;
 		contents = mmap(NULL, config_length, PROT_READ, MAP_PRIVATE,
 				in_fd, 0);
-- 
1.3.1.g5545a
