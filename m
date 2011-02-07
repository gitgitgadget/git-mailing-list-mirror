From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 3/5] mingw: make failures to unlink or move raise a
	question
Date: Mon, 7 Feb 2011 21:51:21 +0100
Message-ID: <20110207205120.GD63976@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY3U-0003JY-2F
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab1BGUvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:51:23 -0500
Received: from darksea.de ([83.133.111.250]:37613 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754091Ab1BGUvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:51:22 -0500
Received: (qmail 11741 invoked from network); 7 Feb 2011 21:51:20 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 21:51:20 +0100
Content-Disposition: inline
In-Reply-To: <20110207204818.GA63976@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166285>

On Windows in case a program is accessing a file unlink or
move operations may fail. To give the user a chance to correct
this we simply wait until the user asks us to retry or fail.

This is useful because of the following use case which seem
to happen rarely but when it does it is a mess:

After making some changes the user realizes that he was on the
incorrect branch. When trying to change the branch some file
is still in use by some other process and git stops in the
middle of changing branches. Now the user has lots of files
with changes mixed with his own. This is especially confusing
on repositories that contain lots of files.

Although the recent implementation of automatic retry makes
this scenario much more unlikely lets provide a fallback as
a last resort.

Thanks to Albert Dvornik for disabling the question if users can't see it.

If the stdout of the command is connected to a terminal but the stderr
has been redirected, the odds are good that the user can't see any
question we print out to stderr.  This will result in a "mysterious
hang" while the app is waiting for user input.

It seems better to be conservative, and avoid asking for input
whenever the stderr is not a terminal, just like we do for stdin.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Albert Dvornik <dvornik+git@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4a1c218..1354b8e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2,6 +2,7 @@
 #include "win32.h"
 #include <conio.h>
 #include "../strbuf.h"
+#include "../run-command.h"
 
 static const int delay[] = { 0, 1, 10, 20, 40 };
 
@@ -129,6 +130,74 @@ static inline int is_file_in_use_error(DWORD errcode)
 	return 0;
 }
 
+static int read_yes_no_answer(void)
+{
+	char answer[1024];
+
+	if (fgets(answer, sizeof(answer), stdin)) {
+		size_t answer_len = strlen(answer);
+		int got_full_line = 0, c;
+
+		/* remove the newline */
+		if (answer_len >= 2 && answer[answer_len-2] == '\r') {
+			answer[answer_len-2] = '\0';
+			got_full_line = 1;
+		}
+		else if (answer_len >= 1 && answer[answer_len-1] == '\n') {
+			answer[answer_len-1] = '\0';
+			got_full_line = 1;
+		}
+		/* flush the buffer in case we did not get the full line */
+		if (!got_full_line)
+			while((c = getchar()) != EOF && c != '\n');
+	} else
+		/* we could not read, return the
+		 * default answer which is no */
+		return 0;
+
+	if (tolower(answer[0]) == 'y' && !answer[1])
+		return 1;
+	if (!strncasecmp(answer, "yes", sizeof(answer)))
+		return 1;
+	if (tolower(answer[0]) == 'n' && !answer[1])
+		return 0;
+	if (!strncasecmp(answer, "no", sizeof(answer)))
+		return 0;
+
+	/* did not find an answer we understand */
+	return -1;
+}
+
+static int ask_yes_no_if_possible(const char *format, ...)
+{
+	char question[4096];
+	const char *retry_hook[] = { NULL, NULL, NULL };
+	va_list args;
+
+	va_start(args, format);
+	vsnprintf(question, sizeof(question), format, args);
+	va_end(args);
+
+	if ((retry_hook[0] = getenv("GIT_ASK_YESNO"))) {
+		retry_hook[1] = question;
+		return !run_command_v_opt(retry_hook, 0);
+	}
+
+	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
+		return 0;
+
+	while (1) {
+		int answer;
+		fprintf(stderr, "%s (y/n) ", question);
+
+		if ((answer = read_yes_no_answer()) >= 0)
+			return answer;
+
+		fprintf(stderr, "Sorry, I did not understand your answer. "
+				"Please type 'y' or 'n'\n");
+	}
+}
+
 #undef unlink
 int mingw_unlink(const char *pathname)
 {
@@ -149,6 +218,10 @@ int mingw_unlink(const char *pathname)
 		Sleep(delay[tries]);
 		tries++;
 	}
+	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
+	       ask_yes_no_if_possible("Unlink of file '%s' failed. "
+			"Should I try again?", pathname))
+	       ret = unlink(pathname);
 	return ret;
 }
 
@@ -1326,6 +1399,11 @@ repeat:
 		tries++;
 		goto repeat;
 	}
+	if (gle == ERROR_ACCESS_DENIED &&
+	       ask_yes_no_if_possible("Rename from '%s' to '%s' failed. "
+		       "Should I try again?", pold, pnew))
+		goto repeat;
+
 	errno = EACCES;
 	return -1;
 }
-- 
1.7.4.34.gd2cb1
