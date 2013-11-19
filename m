From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 ] commit -v: strip diffs and submodule shortlogs from the
 commit message
Date: Tue, 19 Nov 2013 19:47:25 +0100
Message-ID: <528BB23D.4020001@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>	<5283C701.8090400@web.de>	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>	<5287F735.3030306@web.de>	<20131117090935.GC17016@sigill.intra.peff.net> <xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 19 19:47:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViqKp-0002Ss-Bd
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 19:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab3KSSrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 13:47:35 -0500
Received: from mout.web.de ([212.227.15.4]:53316 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab3KSSrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 13:47:33 -0500
Received: from [192.168.178.41] ([91.3.154.76]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LlWRb-1V9mpX0rVn-00bGRD for <git@vger.kernel.org>; Tue,
 19 Nov 2013 19:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:hNXCWObpIq/ud6rf3SQxsPMV5eS1DLgdwKQUldPvgpr/TvL3pGO
 hvb2x7trtV7zwLw7YbE3cD4EmVHQDU19lMSKaqiLgk+vnjVUM2XYcRlMzfyrTiLXwXexyI9
 NZ1K0pbrjC20KQo7slfq6lwUkD38HvQhPkDbCilRQ2jOBJmRh9cuCYz6ITYq0uIBQvd0Dyu
 JLtk/AV+XDUEU0GepTD+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238035>

When using the '-v' option of "git commit" the diff added to the commit
message temporarily for editing is stripped off after the user exited the
editor by searching for "\ndiff --git " and truncating the commmit message
there if it is found. But this approach has two problems: when the commit
message itself contains a line starting with "diff --git" it will be
truncated there prematurely. And when the "diff.submodule" setting is set
to "log", the diff may start with "Submodule <hash1>..<hash2>", which will
be left in the commit message while it shouldn't.

Fix that by introducing a special scissor separator line starting with the
comment character '#' followed by a line describing what it is for. The
scissor line - which will not be translated - is used to reliably detect
the start of the diff so it can be chopped off from the commit message, no
matter what the user enters there. Turn a known test failure fixed by this
change into a successful test and add another one for a diff starting with
a submodule log.

Reported-by: Ari Pollak <ari@debian.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 18.11.2013 17:01, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> I found this hard to parse, I think because of the "keeping" (why would
>> I not keep it?), and because you are talking about lines above and
>> below. It is not as accurate to say:
>>
>>   # ------------------ >8 --------------------
>>   # Everything below this line will be removed.
>>
>> because it is technically the line above that is the cutoff. But I think
>> the meaning is clear, and it is simpler to parse.

Ok, changed in this version.

> I agree with your rewording suggestion.  It might make it even more
> robust to do something like
> 
>     const char cut_here[] = "# --- cut here --- >8 --- cut here ---";
> 
>     fprintf(fh, "%s\n", cut_here);
>     fputs(_("# Everything below this line will be removed\n"), fh);
>     ...
>     p = strstr(cut_here);
> 
> i.e. a real marker line that will never be translated, with an
> explanation immediately below that can be translated.

Which is what my last version already did :-)  But it didn't mention
that in the commit message, which it does now).

Also the too strict check for the scissor line is fixed according to
Peff's proposal, it will now handle an empty commit message correctly
too.


 builtin/commit.c          |  6 +++---
 t/t7507-commit-verbose.sh | 15 ++++++++++++++-
 wt-status.c               |  4 ++++
 wt-status.h               |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..b6d6655 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1602,9 +1602,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)

 	/* Truncate the message just before the diff, if any. */
 	if (verbose) {
-		p = strstr(sb.buf, "\ndiff --git ");
-		if (p != NULL)
-			strbuf_setlen(&sb, p - sb.buf + 1);
+		p = strstr(sb.buf, wt_status_diff_divider);
+		if (p && (p == sb.buf || p[-1] == '\n'))
+			strbuf_setlen(&sb, p - sb.buf);
 	}

 	if (cleanup_mode != CLEANUP_NONE)
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index da5bd3b..09c1150 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -65,9 +65,22 @@ test_expect_success 'diff in message is retained without -v' '
 	check_message diff
 '

-test_expect_failure 'diff in message is retained with -v' '
+test_expect_success 'diff in message is retained with -v' '
 	git commit --amend -F diff -v &&
 	check_message diff
 '

+test_expect_success 'submodule log is stripped out too with -v' '
+	git config diff.submodule log &&
+	git submodule add ./. sub &&
+	git commit -m "sub added" &&
+	(
+		cd sub &&
+		echo "more" >>file &&
+		git commit -a -m "submodule commit"
+	) &&
+	GIT_EDITOR=cat test_must_fail git commit -a -v 2>err &&
+	test_i18ngrep "Aborting commit due to empty commit message." err
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index b4e44ba..a499bd2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,8 @@
 #include "column.h"
 #include "strbuf.h"

+const char wt_status_diff_divider[] = "# -----------------------------------8<-----------------------------------\n";
+
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
@@ -791,6 +793,8 @@ static void wt_status_print_verbose(struct wt_status *s)
 	 */
 	if (s->fp != stdout)
 		rev.diffopt.use_color = 0;
+	fprintf(s->fp, wt_status_diff_divider);
+	fprintf(s->fp, _("# Everything below this line will be removed.\n"));
 	run_diff_index(&rev, 1);
 }

diff --git a/wt-status.h b/wt-status.h
index 6c29e6f..cd2709f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -91,6 +91,8 @@ struct wt_status_state {
 	unsigned char cherry_pick_head_sha1[20];
 };

+const char wt_status_diff_divider[];
+
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-- 
1.8.5.rc2.7.gb1d0fd2
