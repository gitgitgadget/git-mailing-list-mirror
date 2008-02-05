From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Introduce the config variable pack.packSizeLimit
Date: Tue, 5 Feb 2008 14:25:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051423530.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, torarvid@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 05 15:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOkd-0002zG-Fo
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbYBEOZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbYBEOZq
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:25:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:46780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750874AbYBEOZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:25:46 -0500
Received: (qmail invoked by alias); 05 Feb 2008 14:25:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 05 Feb 2008 15:25:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LI9Vt5xALo1YlQsXPxF8AKiVTGbwvIxrYEvKtjA
	oYyFdun/mS5Iha
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72660>


"git pack-objects" has the option --max-pack-size to limit the file
size of the packs to a certain amount of bytes.  On platforms where
the pack file size is limited by filesystem constraints, it is easy
to forget this option, and this option does not exist for "git gc"
to begin with.

So introduce a config variable to set the default maximum, but make
this overrideable by the command line.

Suggested by Tor Arvid Lund.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt           |    6 ++++++
 Documentation/git-pack-objects.txt |    3 ++-
 builtin-pack-objects.c             |   10 +++++++++-
 t/t5300-pack-object.sh             |    6 ++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e222f1..3e10feb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -766,6 +766,12 @@ pack.indexVersion::
 	whenever the corresponding pack is larger than 2 GB.  Otherwise
 	the default is 1.
 
+pack.packSizeLimit:
+	The default maximum size of a pack.  This setting only affects
+	packing to a file, i.e. the git:// protocol is unaffected.  It
+	can be overridden by the `\--max-pack-size` option of
+	linkgit:git-repack[1].
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 74cc7c1..8353be1 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -99,7 +99,8 @@ base-name::
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
-	The default is unlimited.
+	The default is unlimited, unless the config variable
+	`pack.packSizeLimit` is set.
 
 --incremental::
 	This flag causes an object already in a pack ignored
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d3efeff..692a761 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -68,7 +68,7 @@ static int allow_ofs_delta;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
-static uint32_t pack_size_limit;
+static uint32_t pack_size_limit, pack_size_limit_cfg;
 static int depth = 50;
 static int delta_search_threads = 1;
 static int pack_to_stdout;
@@ -1867,6 +1867,10 @@ static int git_pack_config(const char *k, const char *v)
 			die("bad pack.indexversion=%d", pack_idx_default_version);
 		return 0;
 	}
+	if (!strcmp(k, "pack.packsizelimit")) {
+		pack_size_limit_cfg = git_config_ulong(k, v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
@@ -2096,6 +2100,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 		if (!prefixcmp(arg, "--max-pack-size=")) {
 			char *end;
+			pack_size_limit_cfg = 0;
 			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
 			if (!arg[16] || *end)
 				usage(pack_usage);
@@ -2220,6 +2225,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name)
 		usage(pack_usage);
 
+	if (!pack_to_stdout && !pack_size_limit)
+		pack_size_limit = pack_size_limit_cfg;
+
 	if (pack_to_stdout && pack_size_limit)
 		die("--max-pack-size cannot be used to build a pack for transfer.");
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4f350dd..cd3c149 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -268,4 +268,10 @@ test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
     '! git-index-pack -o bad.idx test-3.pack'
 
+test_expect_success \
+    'honor pack.packSizeLimit' \
+    'git config pack.packSizeLimit 200 &&
+     packname_4=$(git pack-objects test-4 <obj-list) &&
+     test 3 = $(ls test-4-*.pack | wc -l)'
+
 test_done
-- 
1.5.4.1178.gd491a5
