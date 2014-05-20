From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH] Add an explicit GIT_DIR to the list of excludes
Date: Tue, 20 May 2014 16:26:27 -0700
Message-ID: <1400628387-9557-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: jrnieder@gmail.com, git@vger.kernel.org,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 21 01:27:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmtR3-0004ma-11
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 01:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbaETX04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 19:26:56 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38555 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaETX0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 19:26:55 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so774802pbc.23
        for <git@vger.kernel.org>; Tue, 20 May 2014 16:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SMDzcBjmJ2b7/Sof70dyZEucK7dInWSAh0sZhO14b2A=;
        b=JcuSUAZqcbzRZ2SWMd6SBwKaylVN9f378YGqJipi85frVrydT+atRdYuC/hgBVjVQk
         32ntcfvZL4JdULjPVuHX/1vf1lt/IoDgZNiAf8qWxlISdmcF7B2lyLiEaBhbc78gEzTA
         v3RqwpyBhM+yEdUie45N1vdOZZTb3Nn7MzsWlxWBhAGiUoO9Y/8JvPp/xlo9NShLGwDB
         j17Mu0VA6qdnkt2Uo/n92GVaa7MTei+Oin8J/0C1EVTFqQ+mn2pB0c41dw+nlCJj5UM8
         b6mRlCbFICRjWjFGR9obBBdVnGEMHh5Irt3dh0eiR3a2YvbU6RMVthhy70R/2A2CaV/k
         2ezg==
X-Received: by 10.68.132.42 with SMTP id or10mr54086488pbb.80.1400628414819;
        Tue, 20 May 2014 16:26:54 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id pz10sm588233pbb.33.2014.05.20.16.26.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 May 2014 16:26:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249760>

When an explicit '--git-dir' option points to a directory inside
the work tree, git treats it as if it were any other directory.
In particular, 'git status' lists it as untracked, while 'git add -A'
stages the metadata directory entirely

Add GIT_DIR to the list of excludes in setup_standard_excludes(),
while checking that GIT_DIR is not just '.git', in which case it
would be ignored by default, and that GIT_DIR is inside GIT_WORK_TREE

Although an analogous comparison of any given path against '.git'
is done in treat_path(), this does not seem to be the right place
to compare against GIT_DIR. Instead, the excludes provide an
effective mechanism of ignoring a file/directory, and adding GIT_DIR
as an exclude is equivalent of putting it into '.gitignore'. Function
setup_standard_excludes() was chosen because that is the place where
the excludes are initialized by the commands that are concerned about
excludes

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
 dir.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/dir.c b/dir.c
index 98bb50f..07e36f3 100644
--- a/dir.c
+++ b/dir.c
@@ -1588,6 +1588,26 @@ void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
 	char *xdg_path;
+	const char *gitdir = get_git_dir();
+
+	/* Add git directory to the ignores first */
+	if (strcmp(gitdir, ".git") != 0) { /* "--git-dir" has been given */
+		char ngit[PATH_MAX + 1];
+
+		/*
+		 * See if GIT_DIR is inside the work tree; need to normalize
+		 * 'gitdir' but 'get_git_work_tree()' always appears absolute
+		 * and normalized
+		 */
+		normalize_path_copy(ngit, real_path(absolute_path(gitdir)));
+
+		if (dir_inside_of(ngit, get_git_work_tree()) >= 0) {
+			struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
+							"--git-dir option");
+
+			add_exclude(gitdir, "", 0, el, 0);
+		}
+	}
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
-- 
1.9.1
