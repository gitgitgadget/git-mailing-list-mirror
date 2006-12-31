From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 22:13:05 -0500
Message-ID: <20061231031305.GA5620@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 04:13:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0r8Y-0005BF-0j
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 04:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWLaDNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 22:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWLaDNK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 22:13:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40734 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701AbWLaDNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 22:13:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0r82-0003W6-PT; Sat, 30 Dec 2006 22:12:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2564A20FB65; Sat, 30 Dec 2006 22:13:05 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35660>

Sometimes its necessary to supply a value as a power of two in a
configuration parameter.  In this case the user may want to use the
standard suffixes such as K, M, or G to indicate that the numerical
value should be multiplied by a constant base before being used.

Shell scripts/etc. can also benefit from this automatic option
parsing with `git repo-config --int`.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is a resend of the prior version of this patch.  Junio
 convinced me on #git that this version might be better.  :-)

 Meant for the top of sp/mmap, but may be useful elsewhere.

 Documentation/git-repo-config.txt |    5 ++++-
 config.c                          |    8 ++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index b379ec5..c55a8ba 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -87,7 +87,10 @@ OPTIONS
 	git-repo-config will ensure that the output is "true" or "false"
 
 --int::
-	git-repo-config will ensure that the output is a simple decimal number
+	git-repo-config will ensure that the output is a simple
+	decimal number.  An optional value suffix of 'k', 'm', or 'g'
+	in the config file will cause the value to be multiplied
+	by 1024, 1048576, or 1073741824 prior to output.
 
 
 ENVIRONMENT
diff --git a/config.c b/config.c
index 2e0d5a8..83ce9e1 100644
--- a/config.c
+++ b/config.c
@@ -236,8 +236,16 @@ int git_config_int(const char *name, const char *value)
 	if (value && *value) {
 		char *end;
 		int val = strtol(value, &end, 0);
+		while (isspace(*end))
+			end++;
 		if (!*end)
 			return val;
+		if (!strcasecmp(end, "k"))
+			return val * 1024;
+		if (!strcasecmp(end, "m"))
+			return val * 1024 * 1024;
+		if (!strcasecmp(end, "g"))
+			return val * 1024 * 1024 * 1024;
 	}
 	die("bad config value for '%s' in %s", name, config_file_name);
 }
-- 
1.5.0.rc0.g6bb1
