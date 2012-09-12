From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting
 options
Date: Wed, 12 Sep 2012 10:26:57 -0700
Message-ID: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net> <7vbohbdufz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBqiU-0002cq-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760760Ab2ILR1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:27:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab2ILR1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:27:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CE1684E9;
	Wed, 12 Sep 2012 13:27:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I8B3MsQIdjjdHtnML3TRvhJKB2Q=; b=lv2VYd
	07CMpIXfjwM7kPBD9NCWEoS96SbmkMzwpnlSWujqo4r9fILnHJKVPUF+AJoCodrz
	RnDI2NR5Sg7gt5tB/33BcX/mFDwbk6Twh6FjK9CkcWwkeSRPJOBaqVqI2PX7k4Ps
	PNLuWjToFYxmf35wmzah+k3xvtkDEQY9aK5rY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UyyVLKdrdElZny41UR10u7iECcRDYN7+
	9RP3L7+XrAJJAI96ssPkavO6aZKxw5OCUxmkBtXlfmmEfxVTnvCMYjGvb7oOnJcs
	3jpMAXOeFiABXaW+0TtRU9BBHIq8PKWxCL2GE+NyRc+lJUfeTbHNO9CLRTROBf/n
	3DCQ6u1lvFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A22084E8;
	Wed, 12 Sep 2012 13:27:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E10984E6; Wed, 12 Sep 2012
 13:26:59 -0400 (EDT)
In-Reply-To: <7vbohbdufz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Sep 2012 10:25:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EBD2C1E-FCFF-11E1-B82C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205311>

Junio C Hamano <gitster@pobox.com> writes:

> This is what I used to use when adding these generalized grep
> boolean expressions.
>
> With this applied,...

And this is the "this" X-<.

 grep.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 04e3ec6..566c4cc 100644
--- a/grep.c
+++ b/grep.c
@@ -332,6 +332,87 @@ static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
 	return compile_pattern_or(list);
 }
 
+static void indent(int in)
+{
+	while (in-- > 0)
+		fputc(' ', stderr);
+}
+
+static void dump_grep_pat(struct grep_pat *p)
+{
+	switch (p->token) {
+	case GREP_AND: fprintf(stderr, "*and*"); break;
+	case GREP_OPEN_PAREN: fprintf(stderr, "*(*"); break;
+	case GREP_CLOSE_PAREN: fprintf(stderr, "*)*"); break;
+	case GREP_NOT: fprintf(stderr, "*not*"); break;
+	case GREP_OR: fprintf(stderr, "*or*"); break;
+
+	case GREP_PATTERN: fprintf(stderr, "pattern"); break;
+	case GREP_PATTERN_HEAD: fprintf(stderr, "pattern_head"); break;
+	case GREP_PATTERN_BODY: fprintf(stderr, "pattern_body"); break;
+	}
+
+	switch (p->token) {
+	default: break;
+	case GREP_PATTERN_HEAD:
+		fprintf(stderr, "<head %d>", p->field); break;
+	case GREP_PATTERN_BODY:
+		fprintf(stderr, "<body>"); break;
+	}
+	switch (p->token) {
+	default: break;
+	case GREP_PATTERN_HEAD:
+	case GREP_PATTERN_BODY:
+	case GREP_PATTERN:
+		fprintf(stderr, "%.*s", (int)p->patternlen, p->pattern);
+		break;
+	}
+	fputc('\n', stderr);
+}
+
+static void dump_grep_expression_1(struct grep_expr *x, int in)
+{
+	indent(in);
+	switch (x->node) {
+	case GREP_NODE_TRUE:
+		fprintf(stderr, "true\n");
+		break;
+	case GREP_NODE_ATOM:
+		dump_grep_pat(x->u.atom);
+		break;
+	case GREP_NODE_NOT:
+		fprintf(stderr, "(not\n");
+		dump_grep_expression_1(x->u.unary, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	case GREP_NODE_AND:
+		fprintf(stderr, "(and\n");
+		dump_grep_expression_1(x->u.binary.left, in+1);
+		dump_grep_expression_1(x->u.binary.right, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	case GREP_NODE_OR:
+		fprintf(stderr, "(or\n");
+		dump_grep_expression_1(x->u.binary.left, in+1);
+		dump_grep_expression_1(x->u.binary.right, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	}
+}
+
+void dump_grep_expression(struct grep_opt *opt)
+{
+	struct grep_expr *x = opt->pattern_expression;
+
+	if (opt->all_match)
+		fprintf(stderr, "[all-match]\n");
+	dump_grep_expression_1(x, 0);
+	fflush(NULL);
+}
+
 static struct grep_expr *grep_true_expr(void)
 {
 	struct grep_expr *z = xcalloc(1, sizeof(*z));
@@ -395,7 +476,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	return header_expr;
 }
 
-void compile_grep_patterns(struct grep_opt *opt)
+static void compile_grep_patterns_real(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 	struct grep_expr *header_expr = prep_header_patterns(opt);
@@ -432,9 +513,16 @@ void compile_grep_patterns(struct grep_opt *opt)
 	else
 		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
 						       header_expr);
+
 	opt->all_match = 1;
 }
 
+void compile_grep_patterns(struct grep_opt *opt)
+{
+	compile_grep_patterns_real(opt);
+	dump_grep_expression(opt);
+}
+
 static void free_pattern_expr(struct grep_expr *x)
 {
 	switch (x->node) {
-- 
1.7.12.414.g1a62b7a
