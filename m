From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] diff --check: detect leftover conflict markers
Date: Thu, 26 Jun 2008 15:37:21 -0700
Message-ID: <7vwskbomam.fsf_-_@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
 <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
 <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
 <7vk5gbq10p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC07L-0003wS-Qa
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbYFZWhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYFZWhc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:37:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbYFZWh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:37:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD9E523DE9;
	Thu, 26 Jun 2008 18:37:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A3A3A23DE5; Thu, 26 Jun 2008 18:37:24 -0400 (EDT)
In-Reply-To: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 15:33:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75205D42-43D0-11DD-BAED-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86499>

This teaches "diff --check" to detect and complain if new lines
have lines that look like leftover conflict markers.

We should be able to remove the old Perl script used in the sample
pre-commit hook and modernize the script with this facility.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                 |   35 +++++++++++++++++++++++++++++++++++
 t/t4017-diff-retval.sh |   14 ++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index f31c721..d515b06 100644
--- a/diff.c
+++ b/diff.c
@@ -1143,6 +1143,35 @@ struct checkdiff_t {
 	int trailing_blanks_start;
 };
 
+static int is_conflict_marker(const char *line, unsigned long len)
+{
+	char firstchar;
+	int cnt;
+
+	if (len < 8)
+		return 0;
+	firstchar = line[0];
+	switch (firstchar) {
+	case '=': case '>': case '<':
+		break;
+	default:
+		return 0;
+	}
+	for (cnt = 1; cnt < 7; cnt++)
+		if (line[cnt] != firstchar)
+			return 0;
+	/* line[0] thru line[6] are same as firstchar */
+	if (firstchar == '=') {
+		/* divider between ours and theirs? */
+		if (len != 8 || line[7] != '\n')
+			return 0;
+	} else if (len < 8 || !isspace(line[7])) {
+		/* not divider before ours nor after theirs */
+		return 0;
+	}
+	return 1;
+}
+
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
@@ -1159,6 +1188,12 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 			data->trailing_blanks_start = 0;
 		else if (!data->trailing_blanks_start)
 			data->trailing_blanks_start = data->lineno;
+		if (is_conflict_marker(line + 1, len - 1)) {
+			data->status |= 1;
+			fprintf(data->o->file,
+				"%s:%d: leftover conflict marker\n",
+				data->filename, data->lineno);
+		}
 		bad = ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
 			return;
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 0d0fb87..d748d45 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -113,4 +113,18 @@ test_expect_success 'check should test not just the last line' '
 
 '
 
+test_expect_success 'check detects leftover conflict markers' '
+	git reset --hard &&
+	git checkout HEAD^ &&
+	echo binary >>b &&
+	git commit -m "side" b &&
+	test_must_fail git merge master &&
+	git add b && (
+		git --no-pager diff --cached --check >test.out
+		test $? = 2
+	) &&
+	test "$(grep "conflict marker" test.out | wc -l)" = 3 &&
+	git reset --hard
+'
+
 test_done
-- 
1.5.6.1.78.gde8d9
