From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/6] t7810-grep: test multiple --author with
 --all-match
Date: Thu, 13 Sep 2012 16:26:01 -0700
Message-ID: <7vwqzx4i9i.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
 <8fd93bb87098298677426735dd354fa4f64abc17.1347544259.git.git@drmicha.warpmail.net> <7vmx0t7iq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 01:26:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCInZ-0000a6-0O
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 01:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758446Ab2IMX0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 19:26:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032Ab2IMX0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 19:26:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7800386EF;
	Thu, 13 Sep 2012 19:26:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQloq7YyLoorAMzUw4NFqrmjaDc=; b=JO80i0
	Y4uwjffnbnU0vixCafforOlrjZ9D/5duawTKmtmSgmI2NEPWI4b9zuvxn+BiGrFx
	leOOcZ432QzBwXbtBm8G5MxaJKuLv26HWbXosL04vLD8Tl30WA0fXEM/Kwtg+OE9
	b1rUmgX84+E1tf38OJZww7wYgLyRq6UxcWJBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jef1VySiq5kaGcpnfW5MpvChuClTWwDA
	N0UGrpzwmag2OOQsZfOg3a144zpXV56N1sLc7Vnabw2oNykKhPrEd1wEJmx08gpN
	qUlz4yLuTh0/1KvU40Z6UHQVLTvMMBtajGNWoD8vfZ6Oir9cm/NOPg2S/KFZ2MmA
	BKLN5DeQFvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C3F986EE;
	Thu, 13 Sep 2012 19:26:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FC2486EC; Thu, 13 Sep 2012
 19:26:02 -0400 (EDT)
In-Reply-To: <7vmx0t7iq0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 13:47:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6204E7F8-FDFA-11E1-9373-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205440>

Junio C Hamano <gitster@pobox.com> writes:

> One possible improvement we can make is to parse the command line in
> the last example with "--all-match" to
>
>     [all-match]
>     (or
>      pattern_body<body>commit
>      (or
>       pattern_body<body>tag
>       (or
>        pattern_head<head 1>Linus
>        (or
>         pattern_head<head 0>Junio
>         true
>        )
>       )
>      )
>     )
>
> so that the backbone becomes
>
>  - Mentions commit,
>  - Mentions tag,
>  - Committed by Linus,
>  - Authored by Junio
>
> to require that both commit and tag are mentioned in the message.

And this is an attempt to do exactly that.  Earlier, when we have
both header expression (which by the way has to be an OR node by
construction) and pattern expression (which could be anything), we
created a top-level OR node (again, look at this as if you are
reading LISP),

           OR
        /        \
       /          \
   pattern            OR
     / \           /     \
    .....    committer    OR
                         /   \ 
                     author   TRUE

in other words, the three elements on the top-level backbone are
"pattern", "committer" and "author"; when there are more than one
elements in the "pattern", the top-level node of it is OR, so that
node is inspected by "all-match", hence the result ends up ignoring
the "--all-match" given from the command line.

This patch turns it into

	     OR
          /      \
         /         \
        /              OR
    committer        /    \
                 author    \
                           pattern

when "--all-match" was given from the command line, so that the
"committer", "author" and elements on the top-level backbone in
"pattern" form the top-level backbone of the resulting expression to
be inspected by the "all-match" logic.

Does this pass the expect-failure test in your [PATCH 5/6]?

 grep.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git c/grep.c w/grep.c
index be15c47..925aa92 100644
--- c/grep.c
+++ w/grep.c
@@ -476,6 +476,22 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	return header_expr;
 }
 
+static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y)
+{
+	struct grep_expr *z = x;
+
+	while (x) {
+		assert(x->node == GREP_NODE_OR);
+		if (x->u.binary.right &&
+		    x->u.binary.right->node == GREP_NODE_TRUE) {
+			x->u.binary.right = y;
+			break;
+		}
+		x = x->u.binary.right;
+	}
+	return z;
+}
+
 static void compile_grep_patterns_real(struct grep_opt *opt)
 {
 	struct grep_pat *p;
@@ -510,6 +526,9 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 
 	if (!opt->pattern_expression)
 		opt->pattern_expression = header_expr;
+	else if (opt->all_match)
+		opt->pattern_expression = grep_splice_or(header_expr,
+							 opt->pattern_expression);
 	else
 		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
 						       header_expr);
