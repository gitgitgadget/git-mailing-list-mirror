From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 10:26:33 -0700
Message-ID: <xmqqegm3l06u.fsf@gitster.dls.corp.google.com>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
	<20150525222215.GI26436@vauxhall.crustytoothpaste.net>
	<xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
	<20150526162937.GA24439@256bit.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Brabandt <cblists@256bit.org>
X-From: git-owner@vger.kernel.org Tue May 26 19:26:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxIcj-0000eB-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbbEZR0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:26:37 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33717 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbbEZR0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:26:36 -0400
Received: by igbpi8 with SMTP id pi8so65513533igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=z/tgqOrxh031RZAHYzhT5hHZjiyvs2oNM6bXfC/RUWo=;
        b=lIqyKWAuPP+iG7AwsP9QfphM9m9yIEpgjCsXe8zo747SUq1YqAuk7PpUkzLax2jprY
         7RJHZ0gN8T8g3Uyaql6AuJLQVHlSaMhQF+H0GoyryBS8WTp+N4rwVl2K7bPWsg4/9r1H
         Oc1dKdbJnmodZ0mqSGSA6IbWHukWePb2qLtSfGrIxgniWqPJFwgB4DyrU2alWQY4Y/Qr
         lb1Z12XWAWzBShFxhiCUmpuck+dWAddZl3sZWoWcO4hwtHi/OlDGdGtfYjsBEeEkq8l6
         kN7ZBkrLwpcAs7YAxLB/uqmKclDGl3VzF4P30Ocy6CyDlUhFtKb9WJMQp/lc0At1CLhz
         obMA==
X-Received: by 10.107.27.7 with SMTP id b7mr681037iob.64.1432661195764;
        Tue, 26 May 2015 10:26:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id q10sm8752443ige.16.2015.05.26.10.26.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 10:26:35 -0700 (PDT)
In-Reply-To: <20150526162937.GA24439@256bit.org> (Christian Brabandt's message
	of "Tue, 26 May 2015 18:29:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269954>

Christian Brabandt <cblists@256bit.org> writes:

> It was the one I am interesting in and also the one that I usually try 
> to avoid ;)
>
> (In fact, I thought if the other options would be needed, one could add 
> additional suboptions for core.whitespace as well,...

That road leads to madness.  Why should we add 2*N options in the
first place?  What valid reason are there, other than "because we
could", to have "diff --ws-check-delelted" and "diff -R" paint
whitespace breakages differently?

I personally do not think I'd use such an option often, but I do
recall running "diff -R" and realized that we fixed whitespace
breakages in the past, which made me feel good (the reason why I
gave "-R" was not to see whitespace breakages in the preimage,
though; it merely was a side effect).

I'll send out two patch series to do the painting part (I didn't
want to touch "--check", as its utility is even more dubious
compared to painting, at least to me).

Here is the first one, a preliminary refactoring.

-- >8 --
Subject: [PATCH 1/2] diff.c: add emit_del_line() and restructure callers of emit_line_0()

Traditionally, we only had emit_add_line() helper, which knows how
to find and paint whitespace breakages on the given line, because we
only care about whitespace breakages introduced in new lines.  The
context lines and old (i.e. deleted) lines are emitted with a
simpler emit_line_0() that paints the entire line in plain or old
colors.

Some people may want to paint whitespace breakages on old lines;
when they see a whitespace breakage on a new line, they can spot
the same kind of whitespace breakage on the corresponding old line
and want to say "Ah, that breakage is there but was inherited from
the original, so let's not fix that for now."

To make such a future enhancement easier, introduce emit_del_line()
and replace direct calls to emit_line_0() with it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 7500c55..93c1eb4 100644
--- a/diff.c
+++ b/diff.c
@@ -498,6 +498,15 @@ static void emit_add_line(const char *reset,
 	}
 }
 
+static void emit_del_line(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
+{
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD);
+
+	emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+}
+
 static void emit_hunk_header(struct emit_callback *ecbdata,
 			     const char *line, int len)
 {
@@ -603,7 +612,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 {
 	const char *endp = NULL;
 	static const char *nneof = " No newline at end of file\n";
-	const char *old = diff_get_color(ecb->color_diff, DIFF_FILE_OLD);
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -613,8 +621,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_line_0(ecb->opt, old, reset, '-',
-				    data, len);
+			emit_del_line(reset, ecb, data, len);
 		} else {
 			ecb->lno_in_postimage++;
 			emit_add_line(reset, ecb, data, len);
@@ -1250,17 +1257,22 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		return;
 	}
 
-	if (line[0] != '+') {
-		const char *color =
-			diff_get_color(ecbdata->color_diff,
-				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
-		ecbdata->lno_in_preimage++;
-		if (line[0] == ' ')
-			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->opt, color, reset, line, len);
-	} else {
+	switch (line[0]) {
+	case '+':
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
+		break;
+	case '-':
+		ecbdata->lno_in_preimage++;
+		emit_del_line(reset, ecbdata, line + 1, len - 1);
+		break;
+	default: /* both ' ' and incomplete line */
+		ecbdata->lno_in_preimage++;
+		ecbdata->lno_in_postimage++;
+		emit_line(ecbdata->opt,
+			  diff_get_color(ecbdata->color_diff, DIFF_PLAIN),
+			  reset, line, len);
+		break;
 	}
 }
 
-- 
2.4.1-511-gc1146d5
