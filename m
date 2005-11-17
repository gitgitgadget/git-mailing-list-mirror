From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 2/2] Make init-db record the version in $GIT_DIR/version when creating repo.
Date: Thu, 17 Nov 2005 16:25:37 +0300
Message-ID: <11322339372336-git-send-email-matlads@dsmagic.com>
References: <11322339373013-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 14:30:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecjmc-0003uO-H3
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 14:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVKQN0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 08:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKQN0V
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 08:26:21 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:58117 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP
	id S1750813AbVKQN0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 08:26:17 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id C22A2517D; Thu, 17 Nov 2005 16:27:45 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1Ecjlh-0000M3-Iv; Thu, 17 Nov 2005 16:25:37 +0300
In-Reply-To: <11322339373013-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12112>

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 Makefile  |    3 +++
 init-db.c |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

applies-to: ec55de586902d26b3f55c3d0aeabf94be1b82586
ec733719bfee2ade91416bd429eeefe6c4acb5a8
diff --git a/Makefile b/Makefile
index 74c6b9e..c167120 100644
--- a/Makefile
+++ b/Makefile
@@ -400,6 +400,9 @@ git-rev-list$X: LIBS += $(OPENSSL_LIBSSL
 
 init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
+		-DVERSION='"$(VERSION)"' \
+		-DPATCHLEVEL='"$(PATCHLEVEL)"' \
+		-DSUBLEVEL='"$(SUBLEVEL)"' \
 		-DDEFAULT_GIT_TEMPLATE_DIR=$(call shellquote,"$(template_dir)") $*.c
 
 $(LIB_OBJS): $(LIB_H)
diff --git a/init-db.c b/init-db.c
index bd88291..6230e8e 100644
--- a/init-db.c
+++ b/init-db.c
@@ -19,6 +19,17 @@ static void safe_create_dir(const char *
 	}
 }
 
+static void record_repo_version(const char *path)
+{
+	FILE *verfile = fopen(path, "w");
+	if (!verfile)
+		die ("Can not write to %s?", path);
+	
+	fprintf(verfile, "%d.%d.%d\n", VERSION, PATCHLEVEL, SUBLEVEL);
+	
+	fclose(verfile);
+}
+
 static int copy_file(const char *dst, const char *src, int mode)
 {
 	int fdi, fdo, status;
@@ -212,6 +223,10 @@ static void create_default_files(const c
 				fprintf(stderr, "Ignoring file modes\n");
 		}
 	}
+
+	/* record the version of the git repo */
+	strcpy(path + len, "version");
+	record_repo_version(path);
 }
 
 static const char init_db_usage[] =
---
0.99.9.GIT
