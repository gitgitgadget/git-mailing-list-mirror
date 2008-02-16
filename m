From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/maint] diff: Fix miscounting of --check output
Date: Fri, 15 Feb 2008 20:30:05 -0800
Message-ID: <7vk5l5frqq.fsf@gitster.siamese.dyndns.org>
References: <76718490802151218s62c4f884u39353b66540b347a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 05:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQEiI-0008Bo-NO
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbYBPEa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYBPEa6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:30:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbYBPEa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:30:57 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CC2359D;
	Fri, 15 Feb 2008 23:30:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 27770359C; Fri, 15 Feb 2008 23:30:48 -0500 (EST)
In-Reply-To: <76718490802151218s62c4f884u39353b66540b347a@mail.gmail.com>
 (Jay Soffian's message of "Fri, 15 Feb 2008 15:18:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74006>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> Apparently somewhere in the bowels of the "Crazy xdl interfaces", empty
> lines are skipped over, thus the line number counting in
> checkdiff_consume() is off? I dunno, I briefly looked into fixing it but
> it didn't seem like a quick fix.

Good catch, thanks.

This is not xdl interface, but simply a miscounting by the user
of xdl interface.  Here is a fix.

-- >8 --
diff: Fix miscounting of --check output

c1795bb (Unify whitespace checking) incorrectly made the
checking function return without incrementing the line numbers
when there is no whitespace problem is found on a '+' line.

This resurrects the earlier behaviour.

Noticed and reported by Jay Soffian.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 047310f..90af600 100644
--- a/diff.c
+++ b/diff.c
@@ -1021,6 +1021,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	char *err;
 
 	if (line[0] == '+') {
+		data->lineno++;
 		data->status = check_and_emit_line(line + 1, len - 1,
 		    data->ws_rule, NULL, NULL, NULL, NULL);
 		if (!data->status)
@@ -1031,13 +1032,12 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		emit_line(set, reset, line, 1);
 		(void)check_and_emit_line(line + 1, len - 1, data->ws_rule,
 		    stdout, set, reset, ws);
-		data->lineno++;
 	} else if (line[0] == ' ')
 		data->lineno++;
 	else if (line[0] == '@') {
 		char *plus = strchr(line, '+');
 		if (plus)
-			data->lineno = strtol(plus, NULL, 10);
+			data->lineno = strtol(plus, NULL, 10) - 1;
 		else
 			die("invalid diff");
 	}
