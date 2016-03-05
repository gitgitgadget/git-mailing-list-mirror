From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] setup: set startup_info->have_repository more reliably
Date: Sat, 5 Mar 2016 17:11:34 -0500
Message-ID: <20160305221134.GB31508@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:11:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKQH-00081k-JY
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbcCEWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:11:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:55312 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750889AbcCEWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:11:37 -0500
Received: (qmail 13027 invoked by uid 102); 5 Mar 2016 22:11:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:11:37 -0500
Received: (qmail 12103 invoked by uid 107); 5 Mar 2016 22:11:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:11:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:11:34 -0500
Content-Disposition: inline
In-Reply-To: <20160305220829.GA31316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288330>

When setup_git_directory() is called, we set a flag in
startup_info to indicate we have a repository. But there are
a few other mechanisms by which we might set up a repo:

  1. When creating a new repository via init_db(), we
     transition from no-repo to being in a repo. We should
     tweak this flag at that moment.

  2. In enter_repo(), a stricter form of
     setup_git_directory() used by server-side programs, we
     check the repository format config. After doing so, we
     know we're in a repository, and can set the flag.

With these changes, library code can now reliably tell
whether we are in a repository and act accordingly. We'll
leave the "prefix" field as NULL, which is what happens when
setup_git_directory() finds there is no prefix.

Signed-off-by: Jeff King <peff@peff.net>
---
I did these patches directly on master.  When applied on top of the
other check_repository_format series I posted a few days ago, this one
will have a minor textual conflict (that other series dropped the
pointless return from this function).

 builtin/init-db.c | 1 +
 setup.c           | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6223b7d..da531f6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -322,6 +322,7 @@ int set_git_dir_init(const char *git_dir, const char *real_git_dir,
 		set_git_dir(real_path(git_dir));
 		git_link = NULL;
 	}
+	startup_info->have_repository = 1;
 	return 0;
 }
 
diff --git a/setup.c b/setup.c
index fa7a306..3439ec6 100644
--- a/setup.c
+++ b/setup.c
@@ -986,7 +986,9 @@ int check_repository_format_version(const char *var, const char *value, void *cb
 
 int check_repository_format(void)
 {
-	return check_repository_format_gently(get_git_dir(), NULL);
+	check_repository_format_gently(get_git_dir(), NULL);
+	startup_info->have_repository = 1;
+	return 0;
 }
 
 /*
-- 
2.8.0.rc1.318.g2193183
