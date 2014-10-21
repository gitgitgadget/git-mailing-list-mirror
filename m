From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix match highlighting for combined patterns with context lines
Date: Tue, 21 Oct 2014 15:40:33 -0700
Message-ID: <xmqqoat5hwri.fsf@gitster.dls.corp.google.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<xmqqh9yxz0pc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:40:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgi6a-0006Ka-B6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 00:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671AbaJUWkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 18:40:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933529AbaJUWkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 18:40:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 194B818EFE;
	Tue, 21 Oct 2014 18:40:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BCBX2ZhUKf7o3SUZM5jS9O3IfYs=; b=mGGdto
	HIrC1M3ElEKKPiTmWx5rjayExQJpxE84peVLVBrfOwkHVok9Cmr3ns7iR/bRwpJU
	7gSA25MVYdoJxq2N8zSDpBmWrHob/Ra2EIAa6luKLe1PST8nM09zSC6IPY9AbxNX
	632IRNsJa1t6IdCT3evWH6CvYeeauOpYg5OKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3oKN86IJ5WOQb1io6jeOyuqK7l3w+oi
	WdMYKxfxuwudmPVu/HfTsKDjn4/IR8Ld0SaME+w8sKOVJo9FQO2RAxD1biMBH/Zk
	aSVScQWa96H38WFVibnhxEUkJoEKDgW34hYRQiztq7carejIak0SlffJwuxH4P0U
	SOIn6/GoDIY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB4718EFD;
	Tue, 21 Oct 2014 18:40:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 967E718EFA;
	Tue, 21 Oct 2014 18:40:34 -0400 (EDT)
In-Reply-To: <xmqqh9yxz0pc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Oct 2014 12:23:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45458894-5973-11E4-BD19-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If your goal is to stop colouring words on context and other kinds
> of lines, do you still need the "while (next_match(...))" loop for
> them?  Can't you make the resulting code clearer by restructuring
> the inside of the whole "if (opt->color)" block further, something
> along the lines of...
> Hmm?

It turns out that the result of such a change becomes more readable
than the original, in that it makes it clear that reinspection of
the lines are done only for matched ones and not context lines.

The diff looks unnecessarily noisy because it indents the while ()
loop that is only needed for sign == ':', though.

 grep.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/grep.c b/grep.c
index c668034..b363a94 100644
--- a/grep.c
+++ b/grep.c
@@ -1112,31 +1112,33 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_sep(opt, sign);
 	}
 	if (opt->color) {
-		regmatch_t match;
-		enum grep_context ctx = GREP_CONTEXT_BODY;
-		int ch = *eol;
-		int eflags = 0;
+		if (sign == ':') {
+			/* paint the hits on matched lines */
+			regmatch_t match;
+			enum grep_context ctx = GREP_CONTEXT_BODY;
+			int ch = *eol;
+			int eflags = 0;
 
-		if (sign == ':')
 			line_color = opt->color_selected;
-		else if (sign == '-')
+			*eol = '\0';
+			while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+				if (match.rm_so == match.rm_eo)
+					break;
+
+				output_color(opt, bol, match.rm_so, line_color);
+				output_color(opt, bol + match.rm_so,
+					     match.rm_eo - match.rm_so,
+					     opt->color_match);
+				bol += match.rm_eo;
+				rest -= match.rm_eo;
+				eflags = REG_NOTBOL;
+			}
+			*eol = ch;
+		} else if (sign == '-') {
 			line_color = opt->color_context;
-		else if (sign == '=')
+		} else if (sign == '=') {
 			line_color = opt->color_function;
-		*eol = '\0';
-		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
-			if (match.rm_so == match.rm_eo)
-				break;
-
-			output_color(opt, bol, match.rm_so, line_color);
-			output_color(opt, bol + match.rm_so,
-				     match.rm_eo - match.rm_so,
-				     opt->color_match);
-			bol += match.rm_eo;
-			rest -= match.rm_eo;
-			eflags = REG_NOTBOL;
 		}
-		*eol = ch;
 	}
 	output_color(opt, bol, rest, line_color);
 	opt->output(opt, "\n", 1);
