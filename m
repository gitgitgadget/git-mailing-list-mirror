From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-add says 'pathspec did not match any files' for git
 repository in /
Date: Fri, 25 Mar 2011 19:56:35 +0700
Message-ID: <20110325125635.GA28118@do>
References: <20110325100254.GH30350@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Fri Mar 25 13:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q36ZR-00049T-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 13:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab1CYM4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 08:56:48 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61423 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab1CYM4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 08:56:47 -0400
Received: by pzk9 with SMTP id 9so142828pzk.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=G3S4QVoMJyg5YxSZLxJYzHt5wDeUCqYqhNTqhCAHiyU=;
        b=blv9WvfPppAUOuJZ4zqnpVW8u7YlyRwOPMP/ZR9nE+j0ROWW4VMXYKji7MRRglhLRX
         7fZjvqcfsN9ZV63L3+o5sl5pcWZLc47f2tbKPckTrvzzg+EcXnhjAvFWmesCEWBNmWzG
         T1+jIcnGh5RTuF06xAteBobin5r1Lm4lH6hJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wpj2WGzGVVW8RvdsamwXdpLbwVOMk5P6kqTUKG335ZbSWOxirTB11YdW33D+jbQ1Tq
         PtwEtzUOw71I2tp9sAvRV4gNjgyibEUOAhFnGaaQ0LDxZiOo0jcsi+6C8/VrDI7AnYa4
         4Riz+Z+9GuFO1xGo6Z74vGxOQylcxGGQkVnrI=
Received: by 10.142.248.41 with SMTP id v41mr659556wfh.323.1301057807132;
        Fri, 25 Mar 2011 05:56:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id 25sm1299812wfb.22.2011.03.25.05.56.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 05:56:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 25 Mar 2011 19:56:35 +0700
Content-Disposition: inline
In-Reply-To: <20110325100254.GH30350@login.drsnuggles.stderr.nl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169983>

On Fri, Mar 25, 2011 at 11:02:54AM +0100, Matthijs Kooijman wrote:
> Hey folks,
> 
> I've been using git for keeping config files using a repository in /.
> In 1.7.4.1, this seems to be broken again. Committing, diffing and
> status work this time, but git add gives a pathspec did not match any
> files error when adding a file while the current working directory is
> not /.

We have t1509 to guard these cases (and it does indeed show
breakages). The problem is that the test requires chroot and cannot be
run automatically. I need to think of writing better tests.

The following makes t1509 pass again for me. You may want to try and
see if it fixes it for you.

diff --git a/setup.c b/setup.c
index 03cd84f..c18ea9c 100644
--- a/setup.c
+++ b/setup.c
@@ -390,15 +390,25 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		return NULL;
 	}
 
-	if (!prefixcmp(cwd, worktree) &&
-	    cwd[strlen(worktree)] == '/') { /* cwd inside worktree */
-		set_git_dir(real_path(gitdirenv));
-		if (chdir(worktree))
-			die_errno("Could not chdir to '%s'", worktree);
-		cwd[len++] = '/';
-		cwd[len] = '\0';
-		free(gitfile);
-		return cwd + strlen(worktree) + 1;
+	if (!prefixcmp(cwd, worktree)) {
+		if (strlen(worktree) == offset_1st_component(worktree)) {
+			set_git_dir(real_path(gitdirenv));
+			if (chdir(worktree))
+				die_errno("Could not chdir to '%s'", worktree);
+			cwd[len++] = '/';
+			cwd[len] = '\0';
+			free(gitfile);
+			return cwd + offset_1st_component(worktree);
+		}
+		if (cwd[strlen(worktree)] == '/') { /* cwd inside worktree */
+			set_git_dir(real_path(gitdirenv));
+			if (chdir(worktree))
+				die_errno("Could not chdir to '%s'", worktree);
+			cwd[len++] = '/';
+			cwd[len] = '\0';
+			free(gitfile);
+			return cwd + strlen(worktree) + 1;
+		}
 	}
 
 	/* cwd outside worktree */

-- 
Duy
