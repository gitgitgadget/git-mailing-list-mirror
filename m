From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH 5/5] wt-status: read rebase todolist with strbuf_getline()
Date: Sat, 30 Jan 2016 19:05:47 +0100
Message-ID: <56ACFB7B.6050800@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 19:06:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPZuk-0007JI-2J
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933229AbcA3SGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:06:07 -0500
Received: from moritzneeb.de ([78.47.1.106]:48381 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933083AbcA3SGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:06:06 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id C000E1C050
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 19:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454177164;
	bh=NYyTPlztOnmtTpRuD3/+gDVWYtVB9lEE9h4vZqlPXvg=;
	h=From:Subject:References:To:Date:In-Reply-To:From;
	b=goTfy3Lia2zRnd9Pt0SRJdETnuAMz6zuIktByRHuk83HOTqyq7WAvSTjAQ8bdkEZU
	 0rjCjxkuZTKHuBAVGgdXwRIzPeU+bdXaNUdorYjXUJHnXfkgCRjv7V5ihMQJdCxEJZ
	 My3k9V57534iKUhx8hLT8ts33c9J2IFDGm8u41d4=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACF82B.2030005@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285121>

    In read_rebase_todolist() every line is, after reading, checked
    for a comment_line_char. After that it is trimmed via strbuf_trim().
    Assuming we do never expect a CR as comment_line_char,
    strbuf_getline_lf() can be safely replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---

Notes:
    Looking at the code in read_rebase_todolist(), the
    lines are read, checked for a comment_line_char and then trimmed. I
    wonder why the input is not trimmed before checking for this character?
    Is it safe to replace strbuf_getline_lf() by strbuf_getline() anyway?
        The only case I can imagine that could lead to unexpected behaviour then
    would be when someone sets the comment_line_char to CR. How likely is that?
        Why is the trim _after_ checking for the comment char anyway? Should
    something like "   # foobar" not be considered as comment?
        I decided to roll out the patch because I considered it not as a risk to be
    taken seriously, that the comment line char will be '\r'.
        Meta-question: Should something of this discussion be put into the commit?

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index ab4f80d..f053b2f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1076,7 +1076,7 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 	if (!f)
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
-	while (!strbuf_getline_lf(&line, f)) {
+	while (!strbuf_getline(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
 		strbuf_trim(&line);
-- 
2.4.3
