From: newren@gmail.com
Subject: [PATCHv2 2/2] fast-export: Add a --full-tree option
Date: Wed,  7 Jul 2010 14:46:02 -0600
Message-ID: <1278535562-14875-3-git-send-email-newren@gmail.com>
References: <1278535562-14875-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 22:38:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWbOC-0007Ae-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab0GGUi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 16:38:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38268 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab0GGUi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:38:27 -0400
Received: by pwi5 with SMTP id 5so26557pwi.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F4G0Db0cPKIqL0Sd2JXqJf8qpfriNgGmsZq/J11zRKE=;
        b=jm5hgwTLdcpzFzNV5LcoY+yv9jWgtgo/8ec7ONwZ7pKyUxlGrUoAD5tdHdZ/qhjqq8
         MZqFI310JpzYLfdykbK7ivTjSPDQ005wF1ZqvHIZzV4DFoTE9lQK8kfls3tFEy21VuO9
         nj0CfgdlQt3upYVIUf7W/DBSST9Za9AznTubI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NrE6DluiMFLXuUKdEMKV3xTXUYp6QRBVFNI1pJUqde6bd4MksfGfsJRzt/BeiDb1k7
         6pjxBt9/yF28nlf1dvPfGpZIrBEXoyT836qesuGN1s5Pr0OADGXmC7G5S78LgA+33GS/
         m4tvW0FOhWBEOxpeNySAx9h8ZnUQI4pvOwYU8=
Received: by 10.142.233.12 with SMTP id f12mr8941036wfh.19.1278535106568;
        Wed, 07 Jul 2010 13:38:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id c26sm7589013rvf.15.2010.07.07.13.38.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:38:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.14.g19914
In-Reply-To: <1278535562-14875-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150503>

From: Elijah Newren <newren@gmail.com>

This option adds symmetry with fast-import, enabling it to also work with
complete trees instead of just incremental changes.  It works by issuing a
'deleteall' directive with each commit and then listing the full set of
files that make up that commit, rather than just showing the list of files
that have changed since the (first) parent commit.  Note that this
functionality is automatically turned on when using --import-marks together
with path limiting in order to avoid dropping important but unchanged
files.

This functionality is desired when using hand-written filters along with
'fast-export | some-filter | fast-import' as it can be easier to write
<some-filter> in terms of complete trees than incremental changes.

We could avoid the need to add this option by simply always turning it on.
While the end result would be identical, it would slow things down slightly
by printing many more filenames per commit which goes somewhat against the
'fast' in 'fast-export'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt |    6 +++
 builtin/fast-export.c             |    4 ++-
 t/t9350-fast-export.sh            |   70 +++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 98ec6b5..8a6a3cb 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -90,6 +90,12 @@ marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
+--full-tree::
+	This option will cause fast-export to issue a "deleteall"
+	directive for each commit followed by a full list of all files
+	in the commit (as opposed to just listing the files which are
+	different from the commit's first parent).
+
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and references
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 25d13a1..8c77602 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -27,7 +27,7 @@ static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 static int no_data;
-static int full_tree = 0;
+static int full_tree;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -588,6 +588,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
+		OPT_BOOLEAN(0, "full-tree", &full_tree,
+			     "Output full tree for each commit"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 6069e1f..b08954e 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -364,6 +364,76 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
 	git fast-export --import-marks=marks simple -- file file0 | grep file0
 '
 
+cat > expected << EOF
+blob
+mark :1
+data 8
+Wohlauf
+
+blob
+mark :2
+data 9
+break it
+
+reset refs/heads/simple
+commit refs/heads/simple
+mark :3
+author A U Thor <author@example.com> 1112912053 -0700
+committer C O Mitter <committer@example.com> 1112912053 -0700
+data 8
+initial
+deleteall
+M 100644 :1 file
+M 100644 :2 file0
+
+blob
+mark :4
+data 9
+die Luft
+
+blob
+mark :5
+data 12
+geht frisch
+
+commit refs/heads/simple
+mark :6
+author A U Thor <author@example.com> 1112912113 -0700
+committer C O Mitter <committer@example.com> 1112912113 -0700
+data 7
+second
+from :3
+deleteall
+M 100644 :4 file
+M 100644 :2 file0
+M 100644 :5 file2
+
+blob
+mark :7
+data 22
+die Luft
+more content
+
+commit refs/heads/simple
+mark :8
+author A U Thor <author@example.com> 1112912773 -0700
+committer C O Mitter <committer@example.com> 1112912773 -0700
+data 5
+next
+from :6
+deleteall
+M 100644 :7 file
+M 100644 :2 file0
+M 100644 :5 file2
+
+EOF
+
+test_expect_success 'full-tree shows all files in commits'        '
+	git checkout -f simple &&
+	git fast-export --full-tree simple > output &&
+	test_cmp output expected
+'
+
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f master &&
 	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
-- 
1.7.2.rc1.14.g19914
