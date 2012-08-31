From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] split_ident_line(): make best effort when parsing
 author/committer line
Date: Fri, 31 Aug 2012 14:57:16 -0700
Message-ID: <7vwr0elo77.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 23:57:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7ZDS-00081P-2W
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab2HaV5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 17:57:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099Ab2HaV5S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 17:57:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED3C81B9;
	Fri, 31 Aug 2012 17:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	wyxRjo85BMBhnuuc/EowsChHno=; b=EmJc1+iYaW3svsrm8tEgkicCvQRlxcoY4
	MHOO02PNJ/8mvL2swyYiw+3OKQMzBIT1Lpsj4RtPvVb9UriSal+XkQbyth04ctl6
	XSRjwA3jXCsgBQmMF4CH9OJtkdPThzn/kgY3QaLDoXL8SHgbbwXcu4syrgawXHCv
	ye9p//fOP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=q9v
	nvT/7yqdyD0j8fUvFCm0ufUGcP3aag6xjTy9euURwPxDhzRVWgzK2H2SSykwijpa
	WP/BR8rfczYEdKZ38N/IAj1pPHimZjlUAQPeEqChwbEmv5v6l+mp/w2wjX3gIZfi
	3E0l6vwpZHrmQRiR4gpPkq2JSWfulNMUFw42DOG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B79281B7;
	Fri, 31 Aug 2012 17:57:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFA0B81B6; Fri, 31 Aug 2012
 17:57:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4C773F8-F3B6-11E1-8625-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204612>

Commits made by ancient version of Git allowed committer without
human readable name, like this (00213b17c in the kernel history):

    tree 6947dba41f8b0e7fe7bccd41a4840d6de6a27079
    parent 352dd1df32e672be4cff71132eb9c06a257872fe
    author Petr Baudis <pasky@ucw.cz> 1135223044 +0100
    committer  <sam@mars.ravnborg.org> 1136151043 +0100

    kconfig: Remove support for lxdialog --checklist

    ...

    Signed-off-by: Petr Baudis <pasky@suse.cz>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

When fed such a commit, --format='%ci' fails to parse it, and gives
back an empty string.  Update the split_ident_line() to be a bit
more lenient when parsing, but make sure the caller that wants to
pick up sane value from its return value does its own validation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 17 ++++++++++++++++-
 ident.c          |  6 ++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 20cef95..62028e7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -478,6 +478,20 @@ static void export_one(const char *var, const char *s, const char *e, int hack)
 	strbuf_release(&buf);
 }
 
+static int sane_ident_split(struct ident_split *person)
+{
+	if (!person->name_begin || !person->name_end ||
+	    person->name_begin == person->name_end)
+		return 0; /* no human readable name */
+	if (!person->mail_begin || !person->mail_end ||
+	    person->mail_begin == person->mail_end)
+		return 0; /* no usable mail */
+	if (!person->date_begin || !person->date_end ||
+	    !person->tz_begin || !person->tz_end)
+		return 0;
+	return 1;
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
@@ -530,7 +544,8 @@ static void determine_author_info(struct strbuf *author_ident)
 	if (force_date)
 		date = force_date;
 	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
-	if (!split_ident_line(&author, author_ident->buf, author_ident->len)) {
+	if (!split_ident_line(&author, author_ident->buf, author_ident->len) &&
+	    sane_ident_split(&author)) {
 		export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 		export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
 		export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
diff --git a/ident.c b/ident.c
index 443c075..484e0a9 100644
--- a/ident.c
+++ b/ident.c
@@ -210,8 +210,10 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 			split->name_end = cp + 1;
 			break;
 		}
-	if (!split->name_end)
-		return status;
+	if (!split->name_end) {
+		/* no human readable name */
+		split->name_end = split->name_begin;
+	}
 
 	for (cp = split->mail_begin; cp < line + len; cp++)
 		if (*cp == '>') {
-- 
1.7.12.298.gee11d52
