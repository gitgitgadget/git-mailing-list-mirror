From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] get_git_work_tree: core.worktree relative to git_dir
Date: Wed, 27 Oct 2010 21:58:15 +0700
Message-ID: <1288191496-31176-6-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7TI-0003OT-50
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761132Ab0J0O7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:59:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42300 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758421Ab0J0O7C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:59:02 -0400
Received: by gxk23 with SMTP id 23so434438gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=OsM0w2L8qGkDIMtTDbPPLSQ1vyM7B1B/KrUp0LxaKhs=;
        b=dN3a/rFakpyVC1J2lpqac0WLwXTySszmViLryHYlsBQy6kY2o4TQwLLKDKke8Y9OVr
         Glq5YTZ3Y4n6UcXfM/IPbSyHBJaG4PNsT0EsbXx1paSDa6Q6o7Pxeilptl7lBjLKm98L
         sj6sZ4nVWJupZvZ9PQJnaM+27M8wiG/eQuFas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CmsTUbwcblrTh/qtOJKF+m6yVl6Rgt/CZ9mZEvL4jSJfOT5tUwf5Sa+l3jGGpAd9Oh
         rNR18vG7Co/coGgRm79wNI6DzATGyTDJuc32LA8RYcGucfd//W6vDdn0WDHcYSYdaq+Z
         8WETXT8ra+jeKnPwmxma4pGIJiELbV2s18IzU=
Received: by 10.100.201.8 with SMTP id y8mr2991719anf.169.1288191541776;
        Wed, 27 Oct 2010 07:59:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x32sm11928495anx.24.2010.10.27.07.58.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:59:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:58:59 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160081>

---
 environment.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index de5581f..d41dcfb 100644
--- a/environment.c
+++ b/environment.c
@@ -153,8 +153,16 @@ const char *get_git_work_tree(void)
 		if (!work_tree && is_bare_repository_cfg < 1) {
 			work_tree = git_work_tree_cfg;
 			/* make_absolute_path also normalizes the path */
-			if (work_tree && !is_absolute_path(work_tree))
-				work_tree = xstrdup(make_absolute_path(git_path("%s", work_tree)));
+			if (work_tree && !is_absolute_path(work_tree)) {
+				char cwd[PATH_MAX];
+				if (!getcwd(cwd, PATH_MAX))
+					die("Could not get current working directory");
+				if (chdir(get_git_dir()))
+					die("Could not chdir to $GIT_DIR");
+				work_tree = xstrdup(make_absolute_path(work_tree));
+				if (chdir(cwd))
+					die("Could not chdir to previous working directory");
+			}
 		} else if (work_tree)
 			work_tree = xstrdup(make_absolute_path(work_tree));
 		git_work_tree_initialized = 1;
-- 
1.7.0.2.445.gcbdb3
