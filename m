From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TEASER PATCH] write .gitmodules according to core.autocrlf
Date: Thu, 26 Jun 2008 12:58:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806261257460.9925@racer>
References: <g3vaaq$pm1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:01:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqAA-0004pD-S5
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYFZMAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYFZMAX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:00:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:36614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752162AbYFZMAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:00:22 -0400
Received: (qmail invoked by alias); 26 Jun 2008 12:00:20 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp049) with SMTP; 26 Jun 2008 14:00:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19w9gJNw8FwxguI/uYORqTXJ3PV8S0lywVvzVpIw6
	8nJWPVnqUQD7YI
X-X-Sender: gene099@racer
In-Reply-To: <g3vaaq$pm1$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86440>


This patch introduces the option "--crlf=<bool>" to git-config, which
tells git-config to write with or without CR/LF line endings.  (Empty
means 'false'.)

This option is then used by git-submodule to write .gitmodules with
the correct line-endings according to core.autocrlf.

NOTE: this patch is _not_ meant for inclusion, but as a starting point.
I have _no_ desire to continue working on this topic.  It is just a
proof of concept, and it is _your_ responsibility to get it into
submittable form.

This would involve:

	- giving the option a better name (--crlf does not imply that
	  it is only for writing),

	- move the declaration of the config_endl variable to somewhere
	  more public, such as cache.h,

	- possibly even move the definition of config_endl to
	  environment.c,

	- split the patch into the config-related and the
	  submodule-related part,

	- add documentation both for the config-related as well as for
	  the submodule-related part,

	- add tests,

	- submit it, and be quick to fix whatever is criticized on the
	  Git mailing list.

If you do that, would be nice to give me some credit, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-config.c |    5 +++++
 config.c         |   14 +++++++++-----
 git-submodule.sh |   15 ++++++++++-----
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 3a441ef..6ab191f 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -17,6 +17,7 @@ static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
+extern const char *config_endl;
 
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
@@ -334,6 +335,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			delim = '\n';
 			key_delim = '\n';
 		}
+		else if (!prefixcmp(argv[1], "--crlf="))
+			config_endl = argv[1][7] &&
+				git_config_bool("crlf", argv[1] + 7) ?
+				"\r\n" : "\n";
 		else if (!strcmp(argv[1], "--rename-section")) {
 			int ret;
 			if (argc != 4)
diff --git a/config.c b/config.c
index 58749bf..da9213e 100644
--- a/config.c
+++ b/config.c
@@ -15,6 +15,7 @@ static const char *config_file_name;
 static int config_linenr;
 static int config_file_eof;
 static int zlib_compression_seen;
+const char *config_endl = "\n";
 
 static int get_next_char(void)
 {
@@ -749,9 +750,10 @@ static int store_write_section(int fd, const char* key)
 				strbuf_addch(&sb, '\\');
 			strbuf_addch(&sb, key[i]);
 		}
-		strbuf_addstr(&sb, "\"]\n");
+		strbuf_addstr(&sb, "\"]");
+		strbuf_addstr(&sb, config_endl);
 	} else {
-		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
+		strbuf_addf(&sb, "[%.*s]%s", store.baselen, key, config_endl);
 	}
 
 	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
@@ -789,7 +791,7 @@ static int store_write_pair(int fd, const char* key, const char* value)
 	for (i = 0; value[i]; i++)
 		switch (value[i]) {
 		case '\n':
-			strbuf_addstr(&sb, "\\n");
+			strbuf_addstr(&sb, config_endl);
 			break;
 		case '\t':
 			strbuf_addstr(&sb, "\\t");
@@ -801,7 +803,7 @@ static int store_write_pair(int fd, const char* key, const char* value)
 			strbuf_addch(&sb, value[i]);
 			break;
 		}
-	strbuf_addf(&sb, "%s\n", quote);
+	strbuf_addf(&sb, "%s%s", quote, config_endl);
 
 	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
 	strbuf_release(&sb);
@@ -1047,7 +1049,9 @@ int git_config_set_multivar(const char* key, const char* value,
 				    copy_end - copy_begin)
 					goto write_err_out;
 				if (new_line &&
-				    write_in_full(fd, "\n", 1) != 1)
+				    write_in_full(fd, config_endl,
+					    strlen(config_endl)) !=
+				    strlen(config_endl))
 					goto write_err_out;
 			}
 			copy_begin = store.offset[i];
diff --git a/git-submodule.sh b/git-submodule.sh
index 3eb78cc..c551c74 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -27,6 +27,11 @@ say()
 	fi
 }
 
+gitmodules_config ()
+{
+	git config -f .gitmodules --crlf=$(git config --bool core.autocrlf) "$@"
+}
+
 # NEEDSWORK: identical function exists in get_repo_base in clone.sh
 get_repo_base() {
 	(
@@ -74,8 +79,8 @@ module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
 	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
-	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
-		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
+	name=$(gitmodules_config '^submodule\..*\.path$' |
+		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p')
        test -z "$name" &&
        die "No submodule mapping found in .gitmodules for path '$path'"
        echo "$name"
@@ -198,8 +203,8 @@ cmd_add()
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
-	git config -f .gitmodules submodule."$path".path "$path" &&
-	git config -f .gitmodules submodule."$path".url "$repo" &&
+	gitmodules_config submodule."$path".path "$path" &&
+	gitmodules_config submodule."$path".url "$repo" &&
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
@@ -240,7 +245,7 @@ cmd_init()
 		url=$(git config submodule."$name".url)
 		test -z "$url" || continue
 
-		url=$(git config -f .gitmodules submodule."$name".url)
+		url=$(gitmodules_config submodule."$name".url)
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"
 
-- 
1.5.6.173.gde14c
