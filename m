From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ll-merge: use a longer conflict marker for internal merge
Date: Thu, 14 Apr 2016 16:02:30 -0700
Message-ID: <xmqqtwj3equx.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn5bg7r4.fsf@gitster.mtv.corp.google.com>
	<xmqqy48fer2s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:02:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqqHW-0007sT-JS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 01:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbcDNXCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 19:02:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752418AbcDNXCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 19:02:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CD6D13D96;
	Thu, 14 Apr 2016 19:02:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dmsmal1Bjj/ghMiZpWmHkpv6B68=; b=v5/a8w
	E/duZw73Biat5RE6BCmryq2A7n2yS1bXQYShsMzBfZ9aMGfUfvO0Kay+oreJaGk9
	ahtPOorGIjZHhMwb+nkz0p9B8x8OWa47mn8m9EYXxoVQQc1Xg/u6YMF1b3x0jA3K
	7Wb6J/XLKoIeYfdmv1TFSM3VSgfhVodb3tpoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ShplsiYLtZeadXs+fFKAcXFtykJr4NkM
	QTbNbLboFFVhh6RAN85UNBlbIdtvlEWyxWvWHt9w+okRTDdKPwCWWI97+6GEw/n/
	qQYH4KFWHPo+//eFSs6J3P+B2pdplfy6dnUk7343kLKbEK1umJd0+13knRJDmlo7
	ImYxmKl40Tg=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 053C013D95;
	Thu, 14 Apr 2016 19:02:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6872C13D94;
	Thu, 14 Apr 2016 19:02:31 -0400 (EDT)
In-Reply-To: <xmqqy48fer2s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 Apr 2016 15:57:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7A1FD80-0294-11E6-87ED-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291576>

Junio C Hamano <gitster@pobox.com> writes:

> The primary use of conflict markers is to help the user who resolves
> the final (outer) merge by hand to show which part came from which
> branch by separating the blocks of lines apart.  When the conflicted
> parts from a "virtual ancestor" merge created by merge-recursive
> remains in the common ancestor part in the final result, however,
> the conflict markers that are the same size as the final merge
> become harder to see.
>
> Increase the conflict marker size slightly for these inner merges so
> that the markers from the final merge and cruft from internal merge
> can be distinguished more easily.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This would help reduce the common issue that prevents "rerere"
>    from being used on a really complex conflict.  I have another
>    (arguably riskier) patch that teaches rerere's parser to ignore
>    "<<<" and ">>>" markers that says "Temporary merge branch " at
>    the end of the line that achives a similar effect, but I think
>    this may be a cleaner solution, partly because it also deals with
>    "===" and "|||" lines that do not have such a clue to help
>    rerere's parser.

Just for comparison, this is the other "riskier" approach.

-- >8 --
Subject: [PATCH] rerere: try ignoring extra cruft left by merge-recursive

Sometimes the conflict markers from the virtual ancestor synthesis
done by merge-recursive can seep out to the conflicted area of the
final (incomplete) merge result.  Detect and reject them by noticing
the "Temporary merge branch 1" (or "2") branch names.

This is an incomplete solution for "rerere sometimes cannot parse
the conflicted parts" problem, because there is no such helpful clue
on "|||||" (seen only when using "diff3" style) and "=====" lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 1693866..02cbc24 100644
--- a/rerere.c
+++ b/rerere.c
@@ -359,6 +359,18 @@ static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 	return strbuf_getwholeline(sb, io->input, '\n');
 }
 
+static int is_temporary_branch_mark(char *buf)
+{
+	const char *name;
+
+	if (!skip_prefix(buf, " Temporary merge branch ", &name))
+		return 0;
+	if (*name != '1' && *name != '2')
+		return 0;
+	name++;
+	return (!*name || (*name == '\n'));
+}
+
 /*
  * Require the exact number of conflict marker letters, no more, no
  * less, followed by SP or any whitespace
@@ -381,7 +393,7 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
 	while (marker_size--)
 		if (*buf++ != marker_char)
 			return 0;
-	if (want_sp && *buf != ' ')
+	if (want_sp && (*buf != ' ' || is_temporary_branch_mark(buf)))
 		return 0;
 	return isspace(*buf);
 }
-- 
2.8.1-367-g5b624f2
