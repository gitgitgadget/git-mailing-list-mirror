From: Linus Torvalds <torvalds@osdl.org>
Subject: Teach "git diff" to handle filenames startign with '-'
Date: Mon, 17 Oct 2005 22:49:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510172243560.3369@g5.osdl.org>
References: <200510162114.27429.blaisorblade@yahoo.it>
 <Pine.LNX.4.64.0510171546580.3369@g5.osdl.org> <7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510171814430.3369@g5.osdl.org> <7vmzl7tv89.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510171933200.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:51:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERkMk-0003Pg-EP
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 07:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVJRFte (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 01:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVJRFte
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 01:49:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932373AbVJRFte (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 01:49:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9I5nSFC004957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Oct 2005 22:49:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9I5nR8R030221;
	Mon, 17 Oct 2005 22:49:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510171933200.3369@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10207>


It adds "--" to the git-diff.sh scripts, to keep any filenames that start 
with a "-" from being confused with an option.

But in order to do that, it needs to teach git-diff-files to honor "--".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

On Mon, 17 Oct 2005, Linus Torvalds wrote:
> 
> Yes, I know it's ambigious at times, but it really is very convenient. 
> Usually we allow a "--" to say where a filename starts when it _is_ 
> ambiguous.

This is on top of the rev-parse.c diff (it's strictly independent, but it 
needs the rev-parse.c one to make any sense, since without the rev-parse.c 
fix for -- handling, "git diff" won't work regardless).

diff --git a/diff-files.c b/diff-files.c
index 8a8f9b6..1789939 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -41,6 +41,11 @@ int main(int argc, const char **argv)
 	git_config(git_default_config);
 	diff_setup(&diff_options);
 	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "--")) {
+			argv++;
+			argc--;
+			break;
+		}
 		if (!strcmp(argv[1], "-q"))
 			silent = 1;
 		else if (!strcmp(argv[1], "-r"))
diff --git a/git-diff.sh b/git-diff.sh
index 84a152a..b3ec84b 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -28,16 +28,16 @@ case "$rev" in
 ?*' '^?*)
 	begin=$(expr "$rev" : '.*^.\([0-9a-f]*\).*') &&
 	end=$(expr "$rev" : '.\([0-9a-f]*\). .*') || exit
-	cmd="git-diff-tree $flags $begin $end $files"
+	cmd="git-diff-tree $flags $begin $end -- $files"
 	;;
 ?*' '?*)
-	cmd="git-diff-tree $flags $rev $files"
+	cmd="git-diff-tree $flags $rev -- $files"
 	;;
 ?*' ')
-	cmd="git-diff-index $flags $rev $files"
+	cmd="git-diff-index $flags $rev -- $files"
 	;;
 '')
-	cmd="git-diff-files $flags $files"
+	cmd="git-diff-files $flags -- $files"
 	;;
 *)
 	die "I don't understand $*"
