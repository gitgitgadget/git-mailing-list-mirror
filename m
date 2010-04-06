From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 4/8] diff: Filter files that have changed only due to conversion changes.
Date: Tue,  6 Apr 2010 14:46:40 +0200
Message-ID: <3daab2593b3f83971c6da6cfcd3d56046c84477a.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 14:47:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz8Bl-0004uy-S0
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 14:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab0DFMrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 08:47:11 -0400
Received: from mail.roxen.com ([212.247.29.220]:48994 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026Ab0DFMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 08:46:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id F22CE628185
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 14:46:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3GDZA2LmOOS6; Tue,  6 Apr 2010 14:46:50 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id C9B51628173;
	Tue,  6 Apr 2010 14:46:50 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o36Ckol9028654;
	Tue, 6 Apr 2010 14:46:50 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o36Ckoik028653;
	Tue, 6 Apr 2010 14:46:50 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144135>

When the conversion filter for a file is changed, files may get listed
as modified even though the user has not made any changes to them.
This patch adds a configuration option 'core.refilterOnDiff', which
performs an extra renormalization pass to filter out such files.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
The typical reason to enable this option is when you have lots of files
that have been affected by a configuration change (eg crlf convention
or ident expansion), but don't want to recommit the otherwise unchanged
files just to get them on canonic form in the repository.

 Documentation/config.txt |    6 ++++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 diff.c                   |   42 ++++++++++++++++++++++++++++++++++++++=
++++
 environment.c            |    1 +
 t/t0021-conversion.sh    |   25 +++++++++++++++++++++++++
 6 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06b2f82..4eb3ab3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -535,6 +535,12 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
=20
+core.refilterOnDiff::
+	Enable "refilter on diff" feature. This causes source files that
+	have only changed from the committed version as a side effect of
+	a conversion filter change to be filtered from the output of eg
+	linkgit:git-status[1] and linkgit:git-diff[1].
+
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/cache.h b/cache.h
index 6dcb100..cd2bca4 100644
--- a/cache.h
+++ b/cache.h
@@ -552,6 +552,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_refilter_on_diff;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index 6963fbe..4954797 100644
--- a/config.c
+++ b/config.c
@@ -523,6 +523,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if(!strcmp(var, "core.refilterondiff")) {
+		core_refilter_on_diff =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/diff.c b/diff.c
index 2daa732..b2d8e6d 100644
--- a/diff.c
+++ b/diff.c
@@ -8,6 +8,8 @@
 #include "delta.h"
 #include "xdiff-interface.h"
 #include "color.h"
+#include "cache.h"
+#include "object.h"
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
@@ -3097,6 +3099,46 @@ int diff_unmodified_pair(struct diff_filepair *p=
)
 		return 1; /* no change */
 	if (!one->sha1_valid && !two->sha1_valid)
 		return 1; /* both look at the same file on the filesystem. */
+	if (one->dirty_submodule || two->dirty_submodule)
+		return 0; /* Known to differ. */
+	/* The hashes differ, but this might be due to either of them
+	 * not having been normalized (eg due to later .gitattributes
+	 * changes.
+	 */
+	if (core_refilter_on_diff) {
+		unsigned char one_sha1_norm[20];
+		unsigned char two_sha1_norm[20];
+		struct strbuf nbuf =3D STRBUF_INIT;
+		unsigned long buflen =3D 0;
+		void *buf;
+
+		diff_fill_sha1_info(one);
+		diff_fill_sha1_info(two);
+		memcpy(one_sha1_norm, one->sha1, 20);
+		memcpy(two_sha1_norm, two->sha1, 20);
+
+		buf =3D read_object_with_reference(one->sha1, typename(OBJ_BLOB),
+						 &buflen, one_sha1_norm);
+		if (buf && convert_to_git(one->path, buf, buflen,
+					  &nbuf, safe_crlf))
+			hash_sha1_file(nbuf.buf, nbuf.len,
+				       typename(OBJ_BLOB), one_sha1_norm);
+		if (buf)
+			free(buf);
+
+		buf =3D read_object_with_reference(two->sha1, typename(OBJ_BLOB),
+						 &buflen, two_sha1_norm);
+		if (buf && convert_to_git(two->path, buf, buflen,
+					  &nbuf, safe_crlf))
+			hash_sha1_file(nbuf.buf, nbuf.len,
+				       typename(OBJ_BLOB), two_sha1_norm);
+		if (buf)
+			free(buf);
+
+		strbuf_release(&nbuf);
+		if (!hashcmp(one_sha1_norm, two_sha1_norm))
+			return 1; /* Same hash after normalization. */
+	}
 	return 0;
 }
=20
diff --git a/environment.c b/environment.c
index 876c5e5..1b52bed 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+int core_refilter_on_diff;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 828e35b..48ae8bb 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -93,4 +93,29 @@ test_expect_success expanded_in_repo '
 	cmp expanded-keywords expected-output
 '
=20
+# Check that files containing keywords with proper markup aren't marke=
d
+# as modified on checkout when core.refilterOnDiff is set.
+test_expect_success keywords_not_modified '
+	{
+		echo "File with foreign keywords"
+		echo "\$Id\$"
+		echo "\$Id: NoTerminatingSymbol"
+		echo "\$Id: Foreign Commit With Spaces \$"
+		echo "\$Id: GitCommitId \$"
+		echo "\$Id: NoTerminatingSymbolAtEOF"
+	} > expanded-keywords2 &&
+
+	git add expanded-keywords2 &&
+	git commit -m "File with keywords expanded" &&
+
+	echo "expanded-keywords2 ident" >> .gitattributes &&
+
+	rm -f expanded-keywords2 &&
+	git checkout -- expanded-keywords2 &&
+	test "x`git status --porcelain -- expanded-keywords2`" =3D \
+             "x M expanded-keywords2" &&
+	git config --add core.refilterondiff true &&
+	test "x`git status --porcelain -- expanded-keywords2`" =3D x
+'
+
 test_done
--=20
1.7.0.3.316.g33b5e
