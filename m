From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: core.worktree bug
Date: Tue, 15 Dec 2009 23:30:42 +0700
Message-ID: <20091215163042.GA14810@do>
References: <200912071115.48085.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 17:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKaJB-00074n-M2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 17:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbZLOQb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 11:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760555AbZLOQb1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 11:31:27 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51745 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543AbZLOQb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 11:31:26 -0500
Received: by yxe17 with SMTP id 17so36639yxe.33
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=uU7C+d1/gUixta3ZkbWNDfMQOzU4fVv026pZpxMrVvw=;
        b=KUWYuN8esbHaPrcMgYGMa7UAT+Ggw1TqruFeo/q2ZG4BxGNtgsFLnkW9ws3OxNe/Tm
         2kFwNvXRYL4DLGflBCnJew0NZtJAlGh83xzoJ40XFq+31keIdM086A0+3IsLzVA+RWTH
         GgGSGxBQd2oJyQNqsH7MygpY2ICmlbLrSJ8y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hE6ITH3dK+BcrWWxs7CD2u5ExhK51ilUVghKA4uTOwogUlnNgFK69ruAldv4fGc5Dz
         qp3A52550OuGTT6lqvCxMU08TN8fOFk0AYYq31z5L1Ji1BoBYpdT8heXXNEsI+j98pMl
         DpWPcepMYkIzBklf3UKXyKkIS6Sj3SNB5xNP8=
Received: by 10.151.92.8 with SMTP id u8mr9914334ybl.101.1260894685996;
        Tue, 15 Dec 2009 08:31:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.221.150])
        by mx.google.com with ESMTPS id 36sm2384775yxh.13.2009.12.15.08.31.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 08:31:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 15 Dec 2009 23:30:42 +0700
Content-Disposition: inline
In-Reply-To: <200912071115.48085.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135288>

On Mon, Dec 07, 2009 at 11:15:47AM +0100, Robin Rosenberg wrote:
> $ git config core.worktree $(cd ../r1;pwd)
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       deleted:    f
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> => Seems the config is actually honored even though GIT_DIR is not set.
> 
> Bisect tells me 4f38f6b5bafb1f7f85c7b54d0bb0a0e977cd947c broke it. My main point is that I am

You should have CCed me.

> implementing this in JGit so I want the same behaviour. Question: Should we try to fix this
> in git so it matches the documentation or fix the documentation to match behaviour.
> 
> The breakage appeared over a year ago and no one has complained.

This is, I think, due to the shared use of git_work_tree_cfg. When
setup_git_directory_gently() comes close to the end, work_tree has
been detected and set. Then check_repository_format_gently() is
called to make sure the repository is valid. Among the checks are
core.worktree check, which overrides the previously-set git_work_tree_cfg.

This might be the fix, or a start of new breakages. I'll need to look
at this again and make a proper patch message with tests if it's
really correct.

diff --git a/setup.c b/setup.c
index f67250b..1385edb 100644
--- a/setup.c
+++ b/setup.c
@@ -280,6 +280,18 @@ const char *read_gitfile_gently(const char *path)
 	return path;
 }
 
+static int check_repository_work_tree(const char *var, const char *value, void *cb)
+{
+	if (strcmp(var, "core.worktree") == 0) {
+		if (!value)
+			return config_error_nonbool(var);
+		free(git_work_tree_cfg);
+		git_work_tree_cfg = xstrdup(value);
+		inside_work_tree = -1;
+	}
+	return 0;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -317,6 +329,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			if (!work_tree_env) {
 				retval = set_work_tree(gitdirenv);
 				/* config may override worktree */
+				git_config(check_repository_work_tree, NULL);
 				if (check_repository_format_gently(nongit_ok))
 					return NULL;
 				return retval;
@@ -394,6 +407,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			die_errno("Cannot change to '%s/..'", cwd);
 	}
 
+	git_config(check_repository_work_tree, NULL);
 	inside_git_dir = 0;
 	if (!work_tree_env)
 		inside_work_tree = 1;
@@ -471,12 +485,6 @@ int check_repository_format_version(const char *var, const char *value, void *cb
 		is_bare_repository_cfg = git_config_bool(var, value);
 		if (is_bare_repository_cfg == 1)
 			inside_work_tree = -1;
-	} else if (strcmp(var, "core.worktree") == 0) {
-		if (!value)
-			return config_error_nonbool(var);
-		free(git_work_tree_cfg);
-		git_work_tree_cfg = xstrdup(value);
-		inside_work_tree = -1;
 	}
 	return 0;
 }



-- 
Duy
