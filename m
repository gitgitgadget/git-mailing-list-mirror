From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] grep: move logic to compile header pattern into a
 separate helper
Date: Mon, 13 Sep 2010 01:13:58 -0700
Message-ID: <7vsk1eawmx.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
 <7veidlkxdb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emil Sit <sit@emilsit.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4BG-0003pi-9H
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab0IMIOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:14:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab0IMIOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 04:14:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EEFB2D549A;
	Mon, 13 Sep 2010 04:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4zXKumVXGe4NbTtlJO0HYazBFo=; b=fFL5eR
	iI6AlzO4WZjkmwa1i0cTm47Wltma6TpEU8Tl0xl+bC3MoP+bJrAAn4sXwx/H6xh2
	VO0ELTHYchtTNOe03PVP7ebRoVlYFoihCq0D5M7ErDpKzfqzTOYOhf4REogKFWNh
	mw0X4kyVbu4nq43Ppqty+x9fFrw0O57eBBv5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HepU8qbeQecdiJPRgGw8nBCLRhSX9nb5
	qtpkgEOHrWiQKeyHl+iJ9BUWjxhDYMm81wamMnaLQZNsBaONINMsNrQyYC39VLyL
	CiuZRmmX7m6u8mfS+SgglVux6Nm70Zgf6yLgMhkf75Rm6euzRHNX5XTq+RpRlX1I
	5gA067hNauw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9C7DD5498;
	Mon, 13 Sep 2010 04:14:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F20E7D5497; Mon, 13 Sep
 2010 04:13:59 -0400 (EDT)
In-Reply-To: <7veidlkxdb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 26 Aug 2010 12\:05\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE831C14-BF0E-11DF-A651-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156073>

The callers should be queuing only GREP_PATTERN_HEAD elements to the
header_list queue; simplify the switch and guard it with an assert.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is just a clean-up before the real fun.

 grep.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/grep.c b/grep.c
index 82fb349..718a3c2 100644
--- a/grep.c
+++ b/grep.c
@@ -189,29 +189,31 @@ static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
 	return compile_pattern_or(list);
 }
 
-void compile_grep_patterns(struct grep_opt *opt)
+static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
-	struct grep_expr *header_expr = NULL;
-
-	if (opt->header_list) {
-		p = opt->header_list;
-		header_expr = compile_pattern_expr(&p);
-		if (p)
-			die("incomplete pattern expression: %s", p->pattern);
-		for (p = opt->header_list; p; p = p->next) {
-			switch (p->token) {
-			case GREP_PATTERN: /* atom */
-			case GREP_PATTERN_HEAD:
-			case GREP_PATTERN_BODY:
-				compile_regexp(p, opt);
-				break;
-			default:
-				opt->extended = 1;
-				break;
-			}
-		}
+	struct grep_expr *header_expr;
+
+	if (!opt->header_list)
+		return NULL;
+	p = opt->header_list;
+	header_expr = compile_pattern_expr(&p);
+	if (p)
+		die("incomplete pattern expression: %s", p->pattern);
+	for (p = opt->header_list; p; p = p->next) {
+		if (p->token != GREP_PATTERN_HEAD)
+			die("bug: a non-header pattern in grep header list.");
+		if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
+			die("bug: unknown header field %d", p->field);
+		compile_regexp(p, opt);
 	}
+	return header_expr;
+}
+
+void compile_grep_patterns(struct grep_opt *opt)
+{
+	struct grep_pat *p;
+	struct grep_expr *header_expr = prep_header_patterns(opt);
 
 	for (p = opt->pattern_list; p; p = p->next) {
 		switch (p->token) {
@@ -231,9 +233,6 @@ void compile_grep_patterns(struct grep_opt *opt)
 	else if (!opt->extended)
 		return;
 
-	/* Then bundle them up in an expression.
-	 * A classic recursive descent parser would do.
-	 */
 	p = opt->pattern_list;
 	if (p)
 		opt->pattern_expression = compile_pattern_expr(&p);
-- 
1.7.3.rc1.227.gee5c7b
