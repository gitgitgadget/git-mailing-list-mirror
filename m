From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 7/2] Support for NO_OPENSSL
Date: Fri, 29 Jul 2005 17:50:51 +0200
Message-ID: <20050729155051.GJ21909@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 17:53:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyXB1-0005oX-Uy
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 17:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVG2Pw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVG2Pwq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 11:52:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17426 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262630AbVG2Pux (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 11:50:53 -0400
Received: (qmail 11920 invoked by uid 2001); 29 Jul 2005 15:50:51 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Support for completely OpenSSL-less builds. FSF considers distributing GPL
binaries with OpenSSL linked in as a legal problem so this is trouble
e.g. for Debian, or some people might not want to install OpenSSL
anyway. If you

	make NO_OPENSSL=1

you get completely OpenSSL-less build, disabling --merge-order and using
Mozilla's SHA1 implementation.

Ported from Cogito.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit cd2182ac0e0635faeca6467b68decf8ab9625f4c
tree d0c704c203d2319a77cd8fd9ee8fda8adc2d27b4
parent 656a66fe63898954dbc40854dd049dc76eb9b841
author Petr Baudis <pasky@suse.cz> Fri, 29 Jul 2005 17:42:32 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 29 Jul 2005 17:42:32 +0200

 Makefile   |    8 +++++++-
 rev-list.c |    6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -83,7 +83,7 @@ LIB_H=cache.h object.h blob.h tree.h com
 	pack.h pkt-line.h refs.h
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
-	 epoch.o refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o
+	 refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o
 
 LIB_H += rev-cache.h
 LIB_OBJS += rev-cache.o
@@ -105,6 +105,12 @@ LIB_OBJS += server-info.o
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+ifndef NO_OPENSSL
+	LIB_OBJS += epoch.o
+else
+	CFLAGS += '-DNO_OPENSSL'
+	MOZILLA_SHA1=1
+endif
 ifdef MOZILLA_SHA1
   SHA1_HEADER="mozilla-sha1/sha1.h"
   LIB_OBJS += mozilla-sha1/sha1.o
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -537,9 +537,13 @@ int main(int argc, char **argv)
 			sort_in_topological_order(&list);
 		show_commit_list(list);
 	} else {
+#ifndef NO_OPENSSL
 		if (sort_list_in_merge_order(list, &process_commit)) {
-			  die("merge order sort failed\n");
+			die("merge order sort failed\n");
 		}
+#else
+		die("merge order sort unsupported, OpenSSL not linked");
+#endif
 	}
 
 	return 0;
