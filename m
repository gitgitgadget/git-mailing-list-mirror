From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/8] grep: --count over binary
Date: Sat, 22 May 2010 23:29:35 +0200
Message-ID: <4BF84CBF.5000109@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:30:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwGd-00020g-Py
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758800Ab0EVV3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:29:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:51047 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758278Ab0EVV3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:29:54 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 63F0A2F8069;
	Sat, 22 May 2010 23:29:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147544>

The intent of showing the message "Binary file xyz matches" for
binary files is to avoid annoying users by potentially messing up
their terminals by printing control characters.  In --count mode,
this precaution isn't necessary.

Display counts of matches if -c/--count was specified, even if -a
was not given.  GNU grep does the same.

Moving the check for ->count before the code for handling binary
file also avoids printing context lines if --count and -[ABC] were
used together, so we can remove the part of the comment that
mentions this behaviour.  Again, GNU grep does the same.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |    9 ++++-----
 t/t7008-grep-binary.sh |    6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 2a8e879..35c18b7 100644
--- a/grep.c
+++ b/grep.c
@@ -873,6 +873,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			count++;
 			if (opt->status_only)
 				return 1;
+			if (opt->count)
+				goto next_line;
 			if (binary_match_only) {
 				opt->output(opt, "Binary file ", 12);
 				output_color(opt, name, strlen(name),
@@ -886,16 +888,12 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			}
 			/* Hit at this line.  If we haven't shown the
 			 * pre-context lines, we would need to show them.
-			 * When asked to do "count", this still show
-			 * the context which is nonsense, but the user
-			 * deserves to get that ;-).
 			 */
 			if (opt->pre_context)
 				show_pre_context(opt, name, buf, bol, lno);
 			else if (opt->funcname)
 				show_funcname_line(opt, name, buf, bol, lno);
-			if (!opt->count)
-				show_line(opt, bol, eol, name, lno, ':');
+			show_line(opt, bol, eol, name, lno, ':');
 			last_hit = lno;
 		}
 		else if (last_hit &&
@@ -939,6 +937,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		output_sep(opt, ':');
 		snprintf(buf, sizeof(buf), "%u\n", count);
 		opt->output(opt, buf, strlen(buf));
+		return 1;
 	}
 	return !!last_hit;
 }
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 2320e74..91970ea 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -27,6 +27,12 @@ test_expect_success 'git grep -I ina a' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git grep -c ina a' '
+	echo a:1 >expect &&
+	git grep -c ina a >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git grep -L bar a' '
 	echo a >expect &&
 	git grep -L bar a >actual &&
-- 
1.7.1
