From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] teach add_submodule_odb() to look for alternates
Date: Mon, 14 May 2012 18:24:45 +0200
Message-ID: <20120514162445.GA58058@book.hvoigt.net>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com> <7v1umuznuj.fsf@alter.siamese.dyndns.org> <20120509215815.GC74366@book.hvoigt.net> <7v1umtq9pm.fsf@alter.siamese.dyndns.org> <7vwr4lotjl.fsf@alter.siamese.dyndns.org> <20120513172301.GA58961@book.hvoigt.net> <20120513221333.GB59647@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 18:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STy4r-0003N6-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148Ab2ENQYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 12:24:48 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40221 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757144Ab2ENQYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 12:24:47 -0400
Received: (qmail 2643 invoked from network); 14 May 2012 16:24:45 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 14 May 2012 16:24:45 -0000
Content-Disposition: inline
In-Reply-To: <20120513221333.GB59647@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197779>

Since we allow to link other object databases when loading a submodules
database we should also load possible alternates.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
I had a look over the code path in read_info_alternates() and it seems
that it uses the relative_base parameter for relative paths in the
alternates file which is the correct behavior.

So for me this looks like the correct solution. The testsuite passes.

Cheers Heiko

 cache.h                          |  1 +
 sha1_file.c                      |  3 +--
 submodule.c                      |  3 +++
 t/t4041-diff-submodule-option.sh | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e14ffcd..cc5048c 100644
--- a/cache.h
+++ b/cache.h
@@ -947,6 +947,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern void read_info_alternates(const char * relative_base, int depth);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index 3c4f165..4ccaf7a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -229,7 +229,6 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-static void read_info_alternates(const char * alternates, int depth);
 static int git_open_noatime(const char *name);
 
 /*
@@ -354,7 +353,7 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 	}
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+void read_info_alternates(const char * relative_base, int depth)
 {
 	char *map;
 	size_t mapsz;
diff --git a/submodule.c b/submodule.c
index 784b580..959d349 100644
--- a/submodule.c
+++ b/submodule.c
@@ -63,6 +63,9 @@ static int add_submodule_odb(const char *path)
 	alt_odb->name[40] = '\0';
 	alt_odb->name[41] = '\0';
 	alt_odb_list = alt_odb;
+
+	/* add possible alternates from the submodule */
+	read_info_alternates(objects_directory.buf, 0);
 	prepare_alt_odb();
 done:
 	strbuf_release(&objects_directory);
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index bf9a752..6c01d0c 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -458,4 +458,38 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'diff --submodule with objects referenced by alternates' '
+	mkdir sub_alt &&
+	(cd sub_alt &&
+		git init &&
+		echo a >a &&
+		git add a &&
+		git commit -m a
+	) &&
+	mkdir super &&
+	(cd super &&
+		git clone -s ../sub_alt sub &&
+		git init &&
+		git add sub &&
+		git commit -m "sub a"
+	) &&
+	(cd sub_alt &&
+		sha1_before=$(git rev-parse --short HEAD)
+		echo b >b &&
+		git add b &&
+		git commit -m b
+		sha1_after=$(git rev-parse --short HEAD)
+		echo "Submodule sub $sha1_before..$sha1_after:
+  > b" >../expected
+	) &&
+	(cd super &&
+		(cd sub &&
+			git fetch &&
+			git checkout origin/master
+		) &&
+		git diff --submodule > ../actual
+	)
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.10.1.488.ga84c0c8
