From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 01:14:08 +0200
Message-ID: <20080330231408.GR11666@genesis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg6kT-00068i-F5
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626AbYC3XOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758596AbYC3XOP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:14:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60346 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758521AbYC3XON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:14:13 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 221561B256C;
	Mon, 31 Mar 2008 01:14:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 35B7D44696;
	Mon, 31 Mar 2008 01:11:02 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6B8E01190547; Mon, 31 Mar 2008 01:14:08 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78524>

This patch modifies git gc --auto so that it will not always repack when
a user is on battery.

It introduces the new gc.deferonbattery configuration variable, which
defaults to true. If it's true and the user is on battery, it will not
run git gc --auto.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Idea is from e2fsprogs, such a repack may take a lot of time and usually
you don't have infinite time when you are on battery.. :)

If the patch looks OK, just it's too late for 1.5.5, then please let me
know and I'll resend after 1.5.5.

Thanks.

 Documentation/git-gc.txt |    4 +++
 builtin-gc.c             |   49 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index d424a4e..7d54148 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -104,6 +104,10 @@ The optional configuration variable 'gc.pruneExpire' controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
+The optional configuration variable 'gc.deferonbattery' determines if
+`git gc --auto` should be disabled if the system is running on battery.
+This defaults to true.
+
 See Also
 --------
 linkgit:git-prune[1]
diff --git a/builtin-gc.c b/builtin-gc.c
index 8cef36f..7beb046 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -23,6 +23,7 @@ static const char * const builtin_gc_usage[] = {
 };
 
 static int pack_refs = 1;
+static int defer_on_battery = 1;
 static int aggressive_window = -1;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
@@ -67,6 +68,10 @@ static int gc_config(const char *var, const char *value)
 		prune_expire = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.deferonbattery")) {
+		defer_on_battery = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -157,6 +162,45 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit <= cnt;
 }
 
+static int is_on_battery(void)
+{
+	FILE *fp;
+	DIR *dir;
+	char buf[256], state[256], path[256];
+	unsigned int ac = 0;
+	struct dirent* entry;
+
+	if (!defer_on_battery)
+		return 0;
+
+	if ((fp = fopen("/proc/apm", "r"))) {
+		if (fscanf(fp, "%s %s %s %x", buf, buf, buf, &ac) != 4)
+			ac = 1;
+		fclose(fp);
+		return ac != 1;
+	}
+	if((dir = opendir("/proc/acpi/ac_adapter"))) {
+		while ((entry = readdir(dir))) {
+			if (!strcmp(".", entry->d_name) || !strcmp("..",
+						entry->d_name))
+				continue;
+			snprintf(path, 255, "/proc/acpi/ac_adapter/%s/state",
+					entry->d_name);
+			if ((fp = fopen(path, "r"))) {
+				if (fscanf(fp, "%s %s", buf, state) != 2)
+					state[0] = '\0';
+				fclose(fp);
+				if (!strncmp(state, "off-line", 8)) {
+					closedir(dir);
+					return 1;
+				}
+			}
+		}
+		closedir(dir);
+	}
+	return 0;
+}
+
 static int need_to_gc(void)
 {
 	/*
@@ -176,6 +220,11 @@ static int need_to_gc(void)
 		append_option(argv_repack, "-A", MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
+
+	if(is_on_battery()) {
+		fprintf(stderr, "Auto packing deferred; on battery");
+		return 0;
+	}
 	return 1;
 }
 
-- 
1.5.4.5
