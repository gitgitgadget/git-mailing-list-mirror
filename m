From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-list --author/--committer b0rked with -F/--fixed-strings
Date: Thu, 04 Sep 2008 00:12:28 -0700
Message-ID: <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
References: <g9o0ac$qig$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 09:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb932-0002Hf-LT
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 09:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbYIDHN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 03:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYIDHN0
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 03:13:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYIDHNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 03:13:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6827773B02;
	Thu,  4 Sep 2008 03:13:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1DEE373B00; Thu,  4 Sep 2008 03:13:16 -0400 (EDT)
In-Reply-To: <g9o0ac$qig$1@ger.gmane.org> (Giuseppe Bilotta's message of
 "Thu, 04 Sep 2008 08:47:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F55D8C26-7A50-11DD-96F1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94900>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> So, is this a known bug (I would call it a bug, yes) in rev-list?
> Are there any ideas around on how to fix it?

It depends on what you are trying to do.  An obvious thing to do is to
accept the fact that it has always been a regexp match, and quotemeta your
input string.

Because we allow you to give "-F" and "--author=foo" in any order, looking
at the options we have seen already and adjusting the pattern depending on
the fixed-string option in the code would not be workable.  You would have
to instead queue up all the --grep/--author/--committer options until the
very end and _then_ compile them at the end, after you saw all the other
grep related options such as -i/-F/-E

I am not interested in helping people with attitude very much ;-), but one
somewhat related thing I have been wanting to add was the change in the
attached patch.  It allows you to anchor not just at the beginning but at
the end.

 revision.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git c/revision.c w/revision.c
index 36291b6..83478ef 100644
--- c/revision.c
+++ w/revision.c
@@ -956,18 +956,24 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
 static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
 {
 	char *pat;
-	const char *prefix;
+	const char *prefix, *suffix;
 	int patlen, fldlen;
 
 	fldlen = strlen(field);
 	patlen = strlen(pattern);
-	pat = xmalloc(patlen + fldlen + 10);
-	prefix = ".*";
+	pat = xmalloc(patlen + fldlen + 64);
+	suffix = prefix = ".*";
 	if (*pattern == '^') {
 		prefix = "";
 		pattern++;
+		patlen--;
 	}
-	sprintf(pat, "^%s %s%s", field, prefix, pattern);
+	if (pattern[patlen-1] == '$') {
+		suffix = "";
+		patlen--;
+	}
+	sprintf(pat, "^%s %s%.*s%s [1-9][0-9]* [-+][0-1][0-9][0-9][0-9]$",
+		field, prefix, patlen, pattern, suffix);
 	add_grep(revs, pat, GREP_PATTERN_HEAD);
 }
 
