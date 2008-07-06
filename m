From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5]
Date: Sat, 05 Jul 2008 18:50:12 -0700
Message-ID: <7vskunpyqz.fsf@gitster.siamese.dyndns.org>
References: <20080705204849.GJ4729@genesis.frugalware.org>
 <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, mdl123@verizon.net,
	Johannes.Schindelin@gmx.de, jnareb@gmail.com,
	vmiklos@frugalware.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 03:51:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFJPZ-0005d4-6t
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 03:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbYGFBua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 21:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbYGFBua
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 21:50:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbYGFBu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 21:50:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 425511A03B;
	Sat,  5 Jul 2008 21:50:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4D3641A03A; Sat,  5 Jul 2008 21:50:18 -0400 (EDT)
In-Reply-To: <1215293200-28199-1-git-send-email-adambrewster@gmail.com> (Adam
 Brewster's message of "Sat, 5 Jul 2008 17:26:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8B8DAC0-4AFD-11DD-8957-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87485>

Adam Brewster <adambrewster@gmail.com> writes:

> The real reason read_revisions_from_stdin moved to revision.c is because I was 
> asked to do it that way.

Yeah, it is simply a bad taste to use helper in builtin-A from builtin-B.
More library-ish files such as revision.c are better home for utility
functions to be shared between builtins and commands.

Here is what I queued.

By the way did you compile test your fix before sending?

-- >8 --
Move read_revisions_from_stdin from builtin-rev-list.c to revision.c

Reading rev-list parameters from the command line can be reused by
commands other than rev-list.  Move this function to more "library-ish"
place to promote code reuse.

Signed-off-by: Adam Brewster <asb@bu.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 83a7b13..54b6672 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -565,23 +565,6 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs)
-{
-	char line[1000];
-
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = strlen(line);
-		if (len && line[len - 1] == '\n')
-			line[--len] = 0;
-		if (!len)
-			break;
-		if (line[0] == '-')
-			die("options not supported in --stdin mode");
-		if (handle_revision_arg(line, revs, 0, 1))
-			die("bad revision '%s'", line);
-	}
-}
-
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
diff --git a/revision.c b/revision.c
index fc66755..6ce6042 100644
--- a/revision.c
+++ b/revision.c
@@ -910,6 +910,23 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
+void read_revisions_from_stdin(struct rev_info *revs)
+{
+	char line[1000];
+
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		int len = strlen(line);
+		if (len && line[len - 1] == '\n')
+			line[--len] = '\0';
+		if (!len)
+			break;
+		if (line[0] == '-')
+			die("options not supported in --stdin mode");
+		if (handle_revision_arg(line, revs, 0, 1))
+			die("bad revision '%s'", line);
+	}
+}
+
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
 {
 	if (!revs->grep_filter) {
diff --git a/revision.h b/revision.h
index abce500..83f364a 100644
--- a/revision.h
+++ b/revision.h
@@ -111,6 +111,8 @@ struct rev_info {
 #define REV_TREE_DIFFERENT	2
 
 /* revision.c */
+void read_revisions_from_stdin(struct rev_info *revs);
+
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
 volatile show_early_output_fn_t show_early_output;
 
