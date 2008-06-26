From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff --check: do not discard error status upon seeing a good
 line
Date: Thu, 26 Jun 2008 13:22:24 -0700
Message-ID: <7vwskcosjj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 22:23:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBy0I-00020u-Kt
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbYFZUWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 16:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYFZUWn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:22:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbYFZUWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 16:22:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 626781ED1A;
	Thu, 26 Jun 2008 16:22:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8218F1ED13; Thu, 26 Jun 2008 16:22:31 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F71F550-43BD-11DD-BBD6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86481>

"git diff --check" should return non-zero when there was any whitespace
errors but the code only paid attention to the error status of the last
new line in the patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * c1795bb (Unify whitespace checking, 2007-12-13) broke this part of the
   code.

 diff.c                 |    8 +++++---
 t/t4017-diff-retval.sh |    8 ++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5262490..f281c5b 100644
--- a/diff.c
+++ b/diff.c
@@ -1150,12 +1150,14 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	char *err;
 
 	if (line[0] == '+') {
+		unsigned bad;
 		data->lineno++;
-		data->status = check_and_emit_line(line + 1, len - 1,
+		bad = check_and_emit_line(line + 1, len - 1,
 		    data->ws_rule, NULL, NULL, NULL, NULL);
-		if (!data->status)
+		if (!bad)
 			return;
-		err = whitespace_error_string(data->status);
+		data->status |= bad;
+		err = whitespace_error_string(bad);
 		fprintf(data->file, "%s:%d: %s.\n", data->filename, data->lineno, err);
 		free(err);
 		emit_line(data->file, set, reset, line, 1);
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index dc0b712..0d0fb87 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -105,4 +105,12 @@ test_expect_success '--check with --no-pager returns 2 for dirty difference' '
 
 '
 
+
+test_expect_success 'check should test not just the last line' '
+	echo "" >>a &&
+	git --no-pager diff --check
+	test $? = 2
+
+'
+
 test_done
-- 
1.5.6.1.78.gde8d9
