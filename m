From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 21:02:18 -0500
Message-ID: <20061231020218.GA5366@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:02:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0q1q-0000JA-1A
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWLaCCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWLaCCW
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:02:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38667 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652AbWLaCCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:02:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0q1Z-0007eJ-20; Sat, 30 Dec 2006 21:02:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 05BE620FB65; Sat, 30 Dec 2006 21:02:18 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35648>

Sometimes its necessary to supply a value as a power of two in a
configuration parameter.  In this case the user may want to use
the standard suffixes such as K, KB, KiB, etc. to indicate that
the numerical value should be multiplied by a constant base before
being used.

The new git_config_datasize function can be used in config file
handler functions to obtain a size_t in bytes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Applies on top of sp/mmap, but was broken out to make it easier
 to apply earlier in case someone else needed this function.

 cache.h  |    1 +
 config.c |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index a5fc232..abbcab3 100644
--- a/cache.h
+++ b/cache.h
@@ -418,6 +418,7 @@ extern int git_config_from_file(config_fn_t fn, const char *);
 extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
+extern size_t git_config_datasize(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 2e0d5a8..07ad2f1 100644
--- a/config.c
+++ b/config.c
@@ -255,6 +255,31 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }
 
+size_t git_config_datasize(const char *name, const char *value)
+{
+	if (value && *value) {
+		char *end;
+		unsigned long val = strtoul(value, &end, 0);
+		while (isspace(*end))
+			end++;
+		if (!*end)
+			return val;
+		if (!strcasecmp(end, "k")
+			|| !strcasecmp(end, "kb")
+			|| !strcasecmp(end, "kib"))
+			return val * 1024;
+		if (!strcasecmp(end, "m")
+			|| !strcasecmp(end, "mb")
+			|| !strcasecmp(end, "mib"))
+			return val * 1024 * 1024;
+		if (!strcasecmp(end, "g")
+			|| !strcasecmp(end, "gb")
+			|| !strcasecmp(end, "gib"))
+			return val * 1024 * 1024 * 1024;
+	}
+	die("bad config value for '%s' in %s", name, config_file_name);
+}
+
 int git_default_config(const char *var, const char *value)
 {
 	/* This needs a better name */
-- 
1.5.0.rc0.g6bb1
