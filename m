From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/3 v2] add: introduce new --exclude option
Date: Mon, 16 Mar 2015 01:06:23 +0600
Message-ID: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXDsG-0003FW-LO
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 20:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbbCOTGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 15:06:43 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35458 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbbCOTGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 15:06:39 -0400
Received: by labjg1 with SMTP id jg1so24000041lab.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WVIB1OmE1ziicDugFdPF3s+JgZ1m5WHvb9b/yFXN2vg=;
        b=JKZv79Ymv7+UsM87y9/vcPvGiij2p/81rcm4beXPWRb64ILzy94fLjeDPBFtVnC8xv
         OXXICf2eBwzhxO0nA8xUFEbGTW3P6XuKNxqrMLM6B+GEbb01sXnG3j9SjVl6fsJ69Cb1
         ECRWkekIz7R4RXRM6PhqACFKnlFvmebl0062QuRGx3Ne3K5ahvzZmMijj10cyxMJLuXw
         DYCwTCDVB4yPZUJTXlJo+02sXYX+EM4o2+kj0JoAMMVRoz/WiavTIjQNkhUUwU5J+oKn
         84srTvNZTMh+689XoOZOtWMkyy0szrvNDJnFagdBBtknxnHZCreWL0LSxPqUIa+Sw7W7
         WJpg==
X-Received: by 10.152.182.196 with SMTP id eg4mr51713152lac.70.1426446396949;
        Sun, 15 Mar 2015 12:06:36 -0700 (PDT)
Received: from localhost.localdomain ([95.56.108.218])
        by mx.google.com with ESMTPSA id en12sm1724456lbc.11.2015.03.15.12.06.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2015 12:06:36 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.472.g20ceeac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265512>

We already have core.excludesfile configuration variable which indicate=
s
a path to file which contains patterns to exclude. This patch provides
ability to pass --exclude option to the git add command to exclude path=
s
from command line in addition to which specified in the ignore files.

This option can be useful in a case when we have a directory with some =
*.ext
files which have changes and we want to commit all files besides one fo=
r now.
It can be too annoying to touch .gitignore for this.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/add.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 3390933..e165fbc 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -244,6 +244,8 @@ static int ignore_removal_cb(const struct option *o=
pt, const char *arg, int unse
 	return 0;
 }
=20
+static struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
+
 static struct option builtin_add_options[] =3D {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -255,6 +257,8 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked fi=
les")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fa=
ct that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tr=
acked and untracked files")),
+	OPT_STRING_LIST(0, "exclude", &exclude_list, N_("pattern"),
+			N_("do not add files matching pattern to index")),
 	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
 	  NULL /* takes no arguments */,
 	  N_("ignore paths removed in the working tree (same as --no-all)"),
@@ -305,6 +309,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen =3D NULL;
+	struct exclude_list *el;
=20
 	git_config(add_config, NULL);
=20
@@ -379,8 +384,14 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 		/* Set up the default git porcelain excludes */
 		memset(&dir, 0, sizeof(dir));
 		if (!ignored_too) {
+			int i;
 			dir.flags |=3D DIR_COLLECT_IGNORED;
 			setup_standard_excludes(&dir);
+
+			el =3D add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+			for (i =3D 0; i < exclude_list.nr; i++)
+				add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
+
 		}
=20
 		memset(&empty_pathspec, 0, sizeof(empty_pathspec));
@@ -446,5 +457,6 @@ finish:
 			die(_("Unable to write new index file"));
 	}
=20
+	string_list_clear(&exclude_list, 0);
 	return exit_status;
 }
--=20
2.3.3.472.g20ceeac.dirty
