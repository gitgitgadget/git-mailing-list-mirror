From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2] help: add "man.viewer" config var to use "woman" or
 "konqueror"
Date: Fri, 29 Feb 2008 03:00:02 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802290200.m1T2023x017992@localhost.localdomain>
References: <20080228051956.2f36edf0.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:36:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUv6M-0005wn-Q7
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbYB2Ceb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753913AbYB2Cea
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:34:30 -0500
Received: from master.uucpssh.org ([193.218.105.66]:58825 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274AbYB2CeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:34:23 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id E3B2EC8F67; Fri, 29 Feb 2008 03:32:54 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1T2036G017995;
	Fri, 29 Feb 2008 03:00:03 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1T2023x017992;
	Fri, 29 Feb 2008 03:00:02 +0100
In-reply-to: <20080228051956.2f36edf0.chriscool@tuxfamily.org> (message from
	Christian Couder on Thu, 28 Feb 2008 05:19:56 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.4,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.00,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75501>

Hi,

   Note that "emacsclient" is used with option "-e" to launch "woman"
   on emacs and this works only on versions >= 22.

I tested and it did not want to work at first. I modified it a
little bit and now it works with GNU Emacs 23.0.60 (CVS TRUNK).
Dunno if emacsclient has changed between 22 and CVS but it seems
it is printing onto stdout now. I will have to check that.

I am just attaching the patch with my modifications. Please
comment it and feel free to adapt it with yours.

Notice the if(!&buffer) is there just for me. It could be removed
safely. Also note that I did not develop C for ages so apologize
for my approximations ;)


diff --git a/help.c b/help.c
index e57a50e..b939f8d 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,9 @@
 #include "exec_cmd.h"
 #include "common-cmds.h"
 #include "parse-options.h"
+#include "run-command.h"
+
+static const char *man_viewer;
 
 enum help_format {
 	HELP_FORMAT_MAN,
@@ -50,6 +53,8 @@ static int git_help_config(const char *var, const char *value)
 		help_format = parse_help_format(value);
 		return 0;
 	}
+	if (!strcmp(var, "man.viewer"))
+		return git_config_string(&man_viewer, var, value);
 	return git_default_config(var, value);
 }
 
@@ -345,11 +350,90 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
+static int check_emacsclient_version(void)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct child_process ec_process;
+
+	const char *argv_ec[] = { "emacsclient", "--version", NULL };
+	int version;
+	size_t len;
+
+	/* emacsclient prints its version number on stderr */
+	memset(&ec_process, 0, sizeof(ec_process));
+	ec_process.argv = argv_ec;
+	ec_process.err = -1;
+	ec_process.out = -1;
+	ec_process.stdout_to_stderr = 0;
+
+	if (start_command(&ec_process))
+		return error("Failed to start emacsclient.");
+
+	len = strbuf_read(&buffer, ec_process.out, 20);
+	close(ec_process.out);
+
+	/*
+	 * Don't bother checking return value, because "emacsclient --version"
+	 * seems to always exits with code 1.
+	 */
+	finish_command(&ec_process);
+
+	if (!&buffer)
+		return;
+
+	if (!len || len < 0 || prefixcmp(buffer.buf, "emacsclient")) {
+		strbuf_release(&buffer);
+		return error("Failed to parse emacsclient version.");
+	}
+
+	strbuf_remove(&buffer, 0, strlen("emacsclient"));
+	version = atoi(buffer.buf);
+
+	if (version < 22) {
+		fprintf(stderr,
+			"emacsclient version '%d' too old (< 22).\n",
+			version);
+		strbuf_release(&buffer);
+		return -1;
+	}
+
+	strbuf_release(&buffer);
+	return 0;
+}
+
+static void exec_woman_emacs(const char *page)
+{
+	if (!check_emacsclient_version()) {
+		/* This works only with emacsclient version >= 22. */
+		struct strbuf man_page = STRBUF_INIT;
+		strbuf_addf(&man_page, "(woman \"%s\")", page);
+		execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
+	} else
+		execlp("man", "man", page, NULL);
+}
+
+static void exec_man_konqueror(const char *page)
+{
+	const char *display = getenv("DISPLAY");
+	if (display && *display) {
+		struct strbuf man_page = STRBUF_INIT;
+		strbuf_addf(&man_page, "man:%s(1)", page);
+		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
+	} else
+		execlp("man", "man", page, NULL);
+}
+
 static void show_man_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
 	setup_man_path();
-	execlp("man", "man", page, NULL);
+	if (!man_viewer || !strcmp(man_viewer, "man"))
+		execlp("man", "man", page, NULL);
+	if (!strcmp(man_viewer, "woman"))
+		exec_woman_emacs(page);
+	if (!strcmp(man_viewer, "konqueror"))
+		exec_man_konqueror(page);
+	die("'%s': unsupported man viewer.", man_viewer);
 }
 
 static void show_info_page(const char *git_cmd)




	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
