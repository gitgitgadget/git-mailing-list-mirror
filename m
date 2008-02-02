From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] help: make 'git-help--browse' usable outside
 'git-help'.
Date: Sat, 2 Feb 2008 07:32:33 +0100
Message-ID: <20080202073233.7a656fa8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 07:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLBqN-0000my-5d
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 07:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYBBG0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 01:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbYBBG0b
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 01:26:31 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:53994 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbYBBG0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 01:26:30 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CEEC21AB2B4;
	Sat,  2 Feb 2008 07:26:28 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5FB801AB2C1;
	Sat,  2 Feb 2008 07:26:28 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72226>

By moving some help specific stuff from 'git-help--browse.sh'
into 'help.c', we make it possible to use 'git-help--browse'
outside 'git-help'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile            |    2 +-
 git-help--browse.sh |   24 +++++++++---------------
 help.c              |   18 +++++++++++++++++-
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 92341c4..a03fd2e 100644
--- a/Makefile
+++ b/Makefile
@@ -819,6 +819,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 
 help.o: help.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
+		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
 
@@ -839,7 +840,6 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    -e 's|@@HTMLDIR@@|$(htmldir_SQ)|g' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-help--browse.sh b/git-help--browse.sh
index 10b0a36..8189c08 100755
--- a/git-help--browse.sh
+++ b/git-help--browse.sh
@@ -16,18 +16,13 @@
 # git maintainer.
 #
 
-USAGE='[--browser=browser|--tool=browser] [cmd to display] ...'
+USAGE='[--browser=browser|--tool=browser] url/file ...'
 
 # This must be capable of running outside of git directory, so
 # the vanilla git-sh-setup should not be used.
 NONGIT_OK=Yes
 . git-sh-setup
 
-# Install data.
-html_dir="@@HTMLDIR@@"
-
-test -f "$html_dir/git.html" || die "No documentation directory found."
-
 valid_tool() {
 	case "$1" in
 		firefox | iceweasel | konqueror | w3m | links | lynx | dillo)
@@ -71,6 +66,8 @@ do
     shift
 done
 
+test $# = 0 && usage
+
 if test -z "$browser"
 then
     for opt in "help.browser" "web.browser"
@@ -113,16 +110,13 @@ else
     fi
 fi
 
-pages=$(for p in "$@"; do echo "$html_dir/$p.html" ; done)
-test -z "$pages" && pages="$html_dir/git.html"
-
 case "$browser" in
     firefox|iceweasel)
 	# Check version because firefox < 2.0 does not support "-new-tab".
 	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
-	nohup "$browser_path" $NEWTAB $pages &
+	nohup "$browser_path" $NEWTAB "$@" &
 	;;
     konqueror)
 	case "$(basename "$browser_path")" in
@@ -130,20 +124,20 @@ case "$browser" in
 		# It's simpler to use kfmclient to open a new tab in konqueror.
 		browser_path="$(echo "$browser_path" | sed -e 's/konqueror$/kfmclient/')"
 		type "$browser_path" > /dev/null 2>&1 || die "No '$browser_path' found."
-		eval "$browser_path" newTab $pages
+		eval "$browser_path" newTab "$@"
 		;;
 	    kfmclient)
-		eval "$browser_path" newTab $pages
+		eval "$browser_path" newTab "$@"
 		;;
 	    *)
-	        nohup "$browser_path" $pages &
+	        nohup "$browser_path" "$@" &
 		;;
 	esac
 	;;
     w3m|links|lynx)
-	eval "$browser_path" $pages
+	eval "$browser_path" "$@"
 	;;
     dillo)
-	nohup "$browser_path" $pages &
+	nohup "$browser_path" "$@" &
 	;;
 esac
diff --git a/help.c b/help.c
index 1302a61..b929899 100644
--- a/help.c
+++ b/help.c
@@ -328,10 +328,26 @@ static void show_info_page(const char *git_cmd)
 	execlp("info", "info", "gitman", page, NULL);
 }
 
+static void get_html_page_path(struct strbuf *page_path, const char *page)
+{
+	struct stat st;
+
+	/* Check that we have a git documentation directory. */
+	if (stat(GIT_HTML_PATH "/git.html", &st) || !S_ISREG(st.st_mode))
+		die("'%s': not a documentation directory.", GIT_HTML_PATH);
+
+	strbuf_init(page_path, 0);
+	strbuf_addf(page_path, GIT_HTML_PATH "/%s.html", page);
+}
+
 static void show_html_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	execl_git_cmd("help--browse", page, NULL);
+	struct strbuf page_path; /* it leaks but we exec bellow */
+
+	get_html_page_path(&page_path, page);
+
+	execl_git_cmd("help--browse", page_path.buf, NULL);
 }
 
 void help_unknown_cmd(const char *cmd)
-- 
1.5.4.rc5.25.g7a831-dirty
