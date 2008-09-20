From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to
 non-GNU extended regex syntax
Date: Sat, 20 Sep 2008 00:51:39 -0700
Message-ID: <7vej3f45mc.fsf@gitster.siamese.dyndns.org>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
 <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org> <7vtzcb47vh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Sep 20 09:53:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgxHM-0002bg-Rh
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 09:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYITHwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 03:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbYITHwM
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 03:52:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbYITHwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 03:52:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F2FC635DA;
	Sat, 20 Sep 2008 03:52:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AEF20635C9; Sat, 20 Sep 2008 03:51:41 -0400 (EDT)
In-Reply-To: <7vtzcb47vh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 20 Sep 2008 00:02:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07AA33A8-86E9-11DD-BB18-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96336>

Junio C Hamano <gitster@pobox.com> writes:

> static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
> 	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
> 	  REG_EXTENDED },
> 	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
> 	{ "java",
> 	  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
> 	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
> 	  REG_EXTENDED },
> 	{ "pascal",
> 	  "^((procedure|function|constructor|destructor|interface|"
> 		"implementation|initialization|finalization)[ \t]*.*)$"
> 	  "|"
> 	  "^(.*=[ \t]*(class|record).*)$",
> 	  REG_EXTENDED },
> 	{ "php", "^[\t ]*((function|class).*)", REG_EXTENDED },
> 	{ "python", "^[ \t]*((class|def)[ \t].*)$", REG_EXTENDED },
> 	{ "ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> 	  REG_EXTENDED },
> 	{ "tex",
> 	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\{.*)$",
> 	  REG_EXTENDED },
> };

On the "Objective-C hunk header" topic, I mentioned that I wondered how a
construct like:

	"( A | B ) | ( C | D )"

could possibly work, given that xdiff-interface.c::ff_regexp() uses a
regmatch_t array with only two elements to capture (which means it can
only capture $0 and $1).

It turns out that the function is not really prepared to do this
properly.  In order to cope with a pattern without _any_ capturing
parentheses in the regexp, it has a trick to use $0 if $1 is undefined.

In other words, if you write:

	"junk ( A | B ) | garbage ( C | D )"

then lines "junk A", "junk B", "garbage C" and "garbage D" would all match
and be on the hunk header line.  However, "garbage" is not stripped out
(while "junk" does get left out of the capture).

This happens not to be a problem with any of the above built-in patterns.
The risky one is "pascal", but it's $2 captures the entire line anyway, so
it does not make any difference if the code used $0 instead.  E.g.  a line
that matches the second alternative, "foo = class bar", will be captured
as $0 and this is the same as (un)captured $2.

But it would be a good idea to fix this while our attention to the issue
is still fresh.  As we discussed earlier, we can replace the top-level "|"
with "\n" and fix the semantics of multiple positive regexp to grab $1 (or
$0 if $1 is unavaialble) of the first positive one.  If we did so, when
the pattern

	"junk ( A | B ) | garbage ( C | D )"

matches a line "garbage C", the initial garbage part will not be included
inside the capture.

Here is such a proposed fix.

-- >8 --
diff: fix "multiple regexp" semantics to find hunk header comment

When multiple regular expressions are concatenated with "\n", they were
traditionally AND'ed together, and only a line that matches _all_ of them
were taken as a match.  This however is unwieldy when multiple regexp
feature is used to specify alternatives.

This fixes the semantics to take the first match.  A nagative pattern, if
matches, makes the line to fail.  A positive pattern, if matches, will be
the final match and what it captures in $1 is used as the hunk header
comment.

We could write alternatives using "|" in ERE, but the machinery can only
use captured $1 as the hunk header comment (or $0 if there is no match in
$1), so you cannot write:

    "junk ( A | B ) | garbage ( C | D )"

and expect both "junk" and "garbage" to get stripped with the existing
code.  With this fix, you can write it as:

    "junk ( A | B ) \n garbage ( C | D )"

and the way capture works would match the user expectation more
naturally.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c            |    2 +-
 xdiff-interface.c |   17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git c/diff.c w/diff.c
index a733010..1bcbbd5 100644
--- c/diff.c
+++ w/diff.c
@@ -1414,7 +1414,7 @@ static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	{ "pascal",
 	  "^((procedure|function|constructor|destructor|interface|"
 		"implementation|initialization|finalization)[ \t]*.*)$"
-	  "|"
+	  "\n"
 	  "^(.*=[ \t]*(class|record).*)$",
 	  REG_EXTENDED },
 	{ "php", "^[\t ]*((function|class).*)", REG_EXTENDED },
diff --git c/xdiff-interface.c w/xdiff-interface.c
index 7f1a7d3..6c6bb19 100644
--- c/xdiff-interface.c
+++ w/xdiff-interface.c
@@ -194,26 +194,29 @@ static long ff_regexp(const char *line, long len,
 	char *line_buffer = xstrndup(line, len); /* make NUL terminated */
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
-	int result = 0, i;
+	int i;
+	int result = -1;
 
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
-		if (reg->negate ^ !!regexec(&reg->re,
-					line_buffer, 2, pmatch, 0)) {
-			free(line_buffer);
-			return -1;
+		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
+			if (reg->negate)
+				goto fail;
+			break;
 		}
 	}
+	if (regs->nr <= i)
+		goto fail;
 	i = pmatch[1].rm_so >= 0 ? 1 : 0;
 	line += pmatch[i].rm_so;
 	result = pmatch[i].rm_eo - pmatch[i].rm_so;
 	if (result > buffer_size)
 		result = buffer_size;
 	else
-		while (result > 0 && (isspace(line[result - 1]) ||
-					line[result - 1] == '\n'))
+		while (result > 0 && (isspace(line[result - 1])))
 			result--;
 	memcpy(buffer, line, result);
+ fail:
 	free(line_buffer);
 	return result;
 }
