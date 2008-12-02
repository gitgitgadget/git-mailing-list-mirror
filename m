From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Modifies the default git help message to be grouped by
	topic
Date: Tue, 2 Dec 2008 12:20:25 -0500
Message-ID: <20081202172025.GB15826@coredump.intra.peff.net>
References: <20081202060509.GA48796@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YwU-0007NX-SV
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 18:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbYLBRUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 12:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYLBRUa
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 12:20:30 -0500
Received: from peff.net ([208.65.91.99]:2115 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbYLBRU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 12:20:29 -0500
Received: (qmail 13125 invoked by uid 111); 2 Dec 2008 17:20:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 12:20:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 12:20:25 -0500
Content-Disposition: inline
In-Reply-To: <20081202060509.GA48796@agadorsparticus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102161>

On Mon, Dec 01, 2008 at 10:05:09PM -0800, Scott Chacon wrote:

> -     sed -n '
> -     /NAME/,/git-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -	    p
> -     }' "Documentation/git-$cmd.txt"

Sorry to reverse direction after you resubmitted, but my earlier comment
on "this list shouldn't change frequently" didn't take into account that
the _synopsis_ might change, which is much more likely. So maybe rather
than ditching the auto-generation, it makes sense to just hardcode the
order and categorization, but pull the rest from autogeneration.

Something like the patch below (though it makes the 'common' tag in
command-list.txt somewhat redundant, so we should probably just remove
that):

diff --git a/builtin-help.c b/builtin-help.c
index f076efa..b5eafb7 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -275,6 +275,15 @@ static int git_help_config(const char *var, const char *value, void *cb)
 
 static struct cmdnames main_cmds, other_cmds;
 
+static const char *find_cmdname_help(const char *name)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++)
+		if (!strcmp(common_cmds[i].name, name))
+			return common_cmds[i].help;
+	return "";
+}
+
 void list_common_cmds_help(void)
 {
 	int i, longest = 0;
@@ -285,11 +294,43 @@ void list_common_cmds_help(void)
 	}
 
 	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
-	}
+
+#define COMMON(x) \
+do { \
+	printf("   %s   ", x); \
+	mput_char(' ', longest - strlen(x)); \
+	puts(find_cmdname_help(x)); \
+} while(0)
+
+	puts("Basic Commands");
+	COMMON("init");
+	COMMON("add");
+	COMMON("status");
+	COMMON("commit");
+	puts("");
+
+	puts("History Commands");
+	COMMON("log");
+	COMMON("diff");
+	COMMON("reset");
+	COMMON("show");
+	puts("");
+
+	puts("Branch Commands");
+	COMMON("checkout");
+	COMMON("branch");
+	COMMON("merge");
+	COMMON("rebase");
+	COMMON("tag");
+	puts("");
+
+	puts("Remote Commands");
+	COMMON("clone");
+	COMMON("fetch");
+	COMMON("pull");
+	COMMON("push");
+
+#undef COMMON
 }
 
 static int is_git_command(const char *s)
