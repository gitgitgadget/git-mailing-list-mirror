From: Alex Zepeda <alex@inferiorhumanorgans.com>
Subject: [PATCH] verify-tag: Parse GPG configuration options.
Date: Thu, 8 Mar 2012 12:07:20 -0800
Message-ID: <20120308200720.GA93880@blarf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 08 21:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5jqj-0000Yy-EO
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758580Ab2CHUWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:22:04 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:34606 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756814Ab2CHUWC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 15:22:02 -0500
X-Greylist: delayed 880 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2012 15:22:02 EST
Received: from blarf.homeip.net (50-0-158-93.dsl.dynamic.sonic.net [50.0.158.93])
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id q28K7Km2031417;
	Thu, 8 Mar 2012 12:07:20 -0800
Received: by blarf.homeip.net (Postfix, from userid 1001)
	id 76DA68A039; Thu,  8 Mar 2012 12:07:20 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192642>

Modify verify-tag to load relevant GPG variables from the git
configuratio file.  This allows git tag -v to use an alternative
GPG binary in the same way that git tag -s does.

Signed-off-by: Alex Zepeda <alex@inferiorhumanorgans.com>
---
 builtin/verify-tag.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 28c2174..986789f 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -58,6 +58,14 @@ static int verify_tag(const char *name, int verbose)
 	return ret;
 }
 
+static int git_verify_tag_config(const char *var, const char *value, void *cb)
+{
+	int status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
+	return git_default_config(var, value, cb);
+}
+
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
@@ -66,7 +74,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_verify_tag_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
-- 
1.7.9.1
