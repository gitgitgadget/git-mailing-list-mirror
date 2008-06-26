From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] checkdiff: pass diff_options to the callback
Date: Thu, 26 Jun 2008 15:36:34 -0700
Message-ID: <7v63rvq0wd.fsf_-_@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 27 00:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC060-0003Yt-4q
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbYFZWgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbYFZWgo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:36:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbYFZWgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:36:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F3AE23DD7;
	Thu, 26 Jun 2008 18:36:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 228FA23DD0; Thu, 26 Jun 2008 18:36:37 -0400 (EDT)
In-Reply-To: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 15:33:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 593DE16C-43D0-11DD-BAED-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86497>

We could later use more information from the diff_options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 52a34ee..6bcbe20 100644
--- a/diff.c
+++ b/diff.c
@@ -1136,18 +1136,19 @@ static void free_diffstat_info(struct diffstat_t *diffstat)
 struct checkdiff_t {
 	struct xdiff_emit_state xm;
 	const char *filename;
-	int lineno, color_diff;
+	int lineno;
+	struct diff_options *o;
 	unsigned ws_rule;
 	unsigned status;
-	FILE *file;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
-	const char *ws = diff_get_color(data->color_diff, DIFF_WHITESPACE);
-	const char *reset = diff_get_color(data->color_diff, DIFF_RESET);
-	const char *set = diff_get_color(data->color_diff, DIFF_FILE_NEW);
+	int color_diff = DIFF_OPT_TST(data->o, COLOR_DIFF);
+	const char *ws = diff_get_color(color_diff, DIFF_WHITESPACE);
+	const char *reset = diff_get_color(color_diff, DIFF_RESET);
+	const char *set = diff_get_color(color_diff, DIFF_FILE_NEW);
 	char *err;
 
 	if (line[0] == '+') {
@@ -1158,11 +1159,12 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 			return;
 		data->status |= bad;
 		err = whitespace_error_string(bad);
-		fprintf(data->file, "%s:%d: %s.\n", data->filename, data->lineno, err);
+		fprintf(data->o->file, "%s:%d: %s.\n",
+			data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->file, set, reset, line, 1);
+		emit_line(data->o->file, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
-			      data->file, set, reset, ws);
+			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ')
 		data->lineno++;
 	else if (line[0] == '@') {
@@ -1557,9 +1559,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.xm.consume = checkdiff_consume;
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
-	data.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
+	data.o = o;
 	data.ws_rule = whitespace_rule(attr_path);
-	data.file = o->file;
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
-- 
1.5.6.1.78.gde8d9
