From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] dir: test_one_path: fix inconsistent behavior due to missing '/'
Date: Fri, 23 Aug 2013 00:29:15 -0400
Message-ID: <1377232155-7300-3-git-send-email-sunshine@sunshineco.com>
References: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 06:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCj0U-00072z-Rg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 06:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab3HWE3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 00:29:44 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54270 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3HWE3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 00:29:42 -0400
Received: by mail-ie0-f173.google.com with SMTP id qd12so144383ieb.18
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHkk81gin8PxzZAq9NR7P5bvaJnjv7YOQ8AvopZgPAg=;
        b=QRiuOVGywP5Og3MeXyQ4rSplURmTvwcUTkjoRPP9mBkUWMIymEZbb0Jw1RSesWM+3n
         jL5IV/TyWp0qy3W1Mqjrx5OcPLs+Fzaltlh4rz7VuHJ1NvLCXtb8p0Z8+tcekSZ1QEqz
         m+6igyuIBaEXZivpQVXm8ABsrkNOhkWyj1DHbALUO/VrjmeVLeFz6rmsrbDrM0WDAYAL
         erS24BQXuROq7mgkWubW5Da1379UoLJzIvPu4/veLexYvWLuF4ngVr8PS1hdTc8Cw+LI
         MS/MAwBvbL/oErTxYlh2OO4Zd8Etv8o9HEh1htbhZu/arDkHx/dsXgz3A3bQ4pg8jzma
         Ny/w==
X-Received: by 10.50.122.40 with SMTP id lp8mr256778igb.24.1377232182205;
        Thu, 22 Aug 2013 21:29:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id p5sm1090591igj.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 21:29:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.529.g78818d7
In-Reply-To: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232798>

Although undocumented, directory_exists_in_index_icase(dirname,len)
unconditionally assumes the presence of a '/' at dirname[len] (despite
being past the end-of-string). Callers are expected to respect this
assumption by ensuring that a '/' is present beyond the last character
of the passed path. directory_exists_in_index(), on the other hand,
does not assume nor care about a trailing '/' beyond end-of-string.

2eac2a4cc4bdc8d7 (ls-files -k: a directory only can be killed if the
index has a non-directory; 2013-08-15) adds a caller which forgets to
ensure the trailing '/', thus leading to inconsistent behavior between
directory_exists_in_index() and directory_exists_in_index_icase()
depending upon the setting of core.ignorecase. Fix this problem.

This also fixes an initially-unnoticed failure in a t3010 test added by
3c56875176390eee (t3010: update to demonstrate "ls-files -k"
optimization pitfalls; 2013-08-15) when core.ignorecase is true.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 dir.c                   | 12 +++++++++---
 t/t3103-ls-tree-misc.sh |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index edd666a..a52c6f9 100644
--- a/dir.c
+++ b/dir.c
@@ -1160,9 +1160,15 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	 */
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
-	    !has_path_in_index &&
-	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
-		return path_none;
+	    !has_path_in_index) {
+		strbuf_addch(path, '/');
+		if (directory_exists_in_index(path->buf, path->len - 1) ==
+		    index_nonexistent) {
+			strbuf_setlen(path, path->len - 1);
+			return path_none;
+		}
+		strbuf_setlen(path, path->len - 1);
+	}
 
 	exclude = is_excluded(dir, path->buf, &dtype);
 
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index fd95991..9fb1706 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -22,7 +22,7 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
-test_expect_failure 'ls-tree directory core.ignorecase' '
+test_expect_success 'ls-tree directory core.ignorecase' '
 	cat >expect <<-\EOF &&
 	d/e/f
 	EOF
-- 
1.8.4.rc4.529.g78818d7
