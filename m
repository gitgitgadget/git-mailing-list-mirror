X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adjust t5510 to put remotes in config
Date: Tue, 19 Dec 2006 09:18:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612190908060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612171545390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7iwox59i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612182325550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvek8vnb8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612182346500.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612182349070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6uwvmk8.fsf@assigned-by-dhcp.cox.net> <7virg8vl74.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 08:18:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7virg8vl74.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34795>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwaB9-00021P-Qy for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932655AbWLSISN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWLSISN
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:18:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:36953 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932655AbWLSISM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 03:18:12 -0500
Received: (qmail invoked by alias); 19 Dec 2006 08:18:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 19 Dec 2006 09:18:10 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 18 Dec 2006, Junio C Hamano wrote:

> fix testsuite: make sure they use templates freshly built from the source

Okay.

But why not introduce the environment variable GIT_TEMPLATE_DIR, to 
imitate similar solutions. This would result in a smaller diff, and people 
would not have to remember typing "git_init_db" in tests (I admit, I did 
not spot the subtle difference right away, and thought they were 
white-space fixes...).

I.e. something like this instead:

--
[PATCH] Introduce GIT_TEMPLATE_DIR

Instead of passing --template explicitely to init-db and clone, you can
just set the environment variable GIT_TEMPLATE_DIR.

Also make use of it in the tests, to make sure that the templates are
copied.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-init-db.c |    7 +++++--
 t/test-lib.sh     |    3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index fa70baa..85cd4d9 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -124,8 +124,11 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	int template_len;
 	DIR *dir;
 
-	if (!template_dir)
-		template_dir = DEFAULT_GIT_TEMPLATE_DIR;
+	if (!template_dir) {
+		template_dir = getenv("GIT_TEMPLATE_DIR");
+		if (!template_dir)
+			template_dir = DEFAULT_GIT_TEMPLATE_DIR;
+	}
 	strcpy(template_path, template_dir);
 	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac7be76..f0f9cd6 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -208,8 +208,9 @@ test_done () {
 # t/ subdirectory and are run in trash subdirectory.
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
+GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 HOME=$(pwd)/trash
-export PATH GIT_EXEC_PATH HOME
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR HOME
 
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
