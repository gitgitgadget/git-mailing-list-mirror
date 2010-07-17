From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 2/2] fast-export: Add a --full-tree option
Date: Sat, 17 Jul 2010 11:00:51 -0600
Message-ID: <1279386051-31112-3-git-send-email-newren@gmail.com>
References: <1279386051-31112-1-git-send-email-newren@gmail.com>
 <1279386051-31112-2-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, srabbelier@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 17 18:59:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaAje-0006Rh-7O
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760069Ab0GQQ73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 12:59:29 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60640 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab0GQQ7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 12:59:18 -0400
Received: by pzk26 with SMTP id 26so960223pzk.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=caxYD0RgFEnOGxQyhgv6hGFIRTuCYBAm4Cjf1moOnq8=;
        b=pzFQ3K59+nnDbZg79Kidkl/p60/oLMJXnhZJj/Zx3V1hTRqEN6SkR5WKXLCViEFJlt
         EJZxPFFIeqWrzjDmCuHeJ7xxCykaBn+3FTazkuBi66NiQCncz3P6hKBgE/fVPbV7eYSw
         AQdNr9xATiLl8wk5kwgDPPPLnBM2O8q7Mn3Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i23X+Cm5qTUqkIWwKR8fQ/+OwPNNBMgXjijoywb3pHh7tA4YP1HVnqyG6Wk6kb1hrA
         I5oxe2BGZoiOWk5JQO817a7uzdzPSsyZSu8IPu8JaX1ZEm7uscyzU21wl51FoWW46p6u
         S4LA857rkyNK4LtxnohCVY9hp57s6xC65tjGA=
Received: by 10.142.125.20 with SMTP id x20mr2647950wfc.298.1279385957694;
        Sat, 17 Jul 2010 09:59:17 -0700 (PDT)
Received: from localhost.localdomain (63-248-104-17.static.layl0101.digis.net [63.248.104.17])
        by mx.google.com with ESMTPS id r27sm14724374rvq.9.2010.07.17.09.59.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 09:59:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1279386051-31112-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151197>

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
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 Documentation/git-fast-export.txt |    6 ++++++
 builtin/fast-export.c             |    4 +++-
 t/t9350-fast-export.sh            |    5 +++++
 3 files changed, 14 insertions(+), 1 deletions(-)

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
index 6069e1f..d831404 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -364,6 +364,11 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
 	git fast-export --import-marks=marks simple -- file file0 | grep file0
 '
 
+test_expect_success 'full-tree re-shows unmodified files'        '
+	git checkout -f simple &&
+	test $(git fast-export --full-tree simple | grep -c file0) -eq 3
+'
+
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f master &&
 	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
-- 
1.6.6.1
