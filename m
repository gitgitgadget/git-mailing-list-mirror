From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: match explicit-ident semantics for summary and
 template
Date: Sun, 17 Jan 2010 14:03:48 -0800
Message-ID: <7viqb0xubf.fsf@alter.siamese.dyndns.org>
References: <20100117193401.GA28448@coredump.intra.peff.net>
 <201001172153.44413.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:04:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWdET-0002Dj-GY
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 23:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab0AQWEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463Ab0AQWEH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 17:04:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0AQWD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 17:03:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBB4591D8A;
	Sun, 17 Jan 2010 17:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n8Qbz7T8NiQZFFmrKTXwy6hP8Ko=; b=K71QlO
	QgkUv2InHIFKzTmkUQs2ndT19nG37Bnnm3Q++spN9owZ+KOcgvY3z5X4+P6Qrln7
	rzCbai8qWdgvEVoBV5dLnpCO0G7Ize119ncRNczNlfL4OknoE5d01fh4VZhXBXNt
	dC6NlGsNEj9qOnpj2nUJmX5TKDlXS1fFmZzTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rCQ8OJ1ZaqhBSDbWvD4LBZj4W7/2jr1h
	Htcakez0Oi7ZIHs6d3CuzrfiryFjB//+AtA4ZvbO6F708UZuiLTZOeroP/DPGiD7
	O/rPVqfxBsLycig6lquKHBHwIJcP8xG+U5/+6hz9W4FCZAJhptM/uSs7IiF3/Eof
	yWkzw8zeVEA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6BDE91D87;
	Sun, 17 Jan 2010 17:03:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F5B591D7E; Sun, 17 Jan
 2010 17:03:50 -0500 (EST)
In-Reply-To: <201001172153.44413.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 17 Jan 2010 21\:53\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 340B042E-03B4-11DF-AAE2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137345>

Johannes Sixt <j6t@kdbg.org> writes:

> On Sonntag, 17. Januar 2010, Jeff King wrote:
>> -	if (!user_ident_explicitly_given) {
>> +	if (user_ident_explicitly_given != IDENT_ALL_GIVEN) {
>>  		strbuf_addstr(&format, "\n Committer: ");
>
> Sorry for chiming in so late, but this new condition worries me a bit. On all 
> of my machines I have the GECOS field filled in with "Johannes Sixt", i.e., I 
> do not need user.name. But of course the automatically derived email address 
> is nonsense, so I've set up only user.email. Now I would always this hint, 
> wouldn't I? Do most others fill in GECOS in ways that are inappropriate for 
> git?

We could say something like

	if (!(user_ident_explicitly_given & IDENT_EMAIL_GIVEN))

and it probably is a safer change on platforms with GECOS available, but
then wouldn't msysgit folks have to fork this code?

Below are _two_ overlapping patches that apply on top of individual
topics; they will conflict when the topics are merged but hopefully in a
way that is trivially understandable, and I think can supersede Jeff's
patch.

-- >8 -- to jc/ident topic -- >8 --

 builtin-commit.c |    2 +-
 cache.h          |    1 +
 ident.c          |    9 +++++++++
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f4974b5..b76f327 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -624,7 +624,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				author_ident);
 		free(author_ident);
 
-		if (user_ident_explicitly_given != IDENT_ALL_GIVEN)
+		if (!user_ident_sufficiently_given())
 			fprintf(fp,
 				"%s"
 				"# Committer: %s\n",
diff --git a/cache.h b/cache.h
index 16c8e8d..f7a287c 100644
--- a/cache.h
+++ b/cache.h
@@ -929,6 +929,7 @@ extern char git_default_name[MAX_GITNAME];
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 extern int user_ident_explicitly_given;
+extern int user_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/ident.c b/ident.c
index d4f6145..96b56e6 100644
--- a/ident.c
+++ b/ident.c
@@ -259,3 +259,12 @@ const char *git_committer_info(int flag)
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
+
+int user_ident_sufficiently_given(void)
+{
+#ifndef WINDOWS
+	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
+#else
+	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
+#endif
+}

-- 8< -- to jc/ident topic -- 8< --

-- >8 -- to jk/warn-author-committer-after-commit topic -- >8 --
 builtin-commit.c |    4 ++--
 cache.h          |    1 +
 ident.c          |    5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 7f61e87..29dc3df 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -602,7 +602,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				author_ident);
 		free(author_ident);
 
-		if (!user_ident_explicitly_given)
+		if (!user_ident_sufficiently_given())
 			fprintf(fp,
 				"%s"
 				"# Committer: %s\n",
@@ -991,7 +991,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
 	}
-	if (!user_ident_explicitly_given) {
+	if (!user_ident_sufficiently_given()) {
 		strbuf_addstr(&format, "\n Committer: ");
 		strbuf_addbuf_percentquote(&format, &committer_ident);
 		if (advice_implicit_identity) {
diff --git a/cache.h b/cache.h
index bf468e5..63e0701 100644
--- a/cache.h
+++ b/cache.h
@@ -926,6 +926,7 @@ extern const char *config_exclusive_filename;
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 extern int user_ident_explicitly_given;
+extern int user_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/ident.c b/ident.c
index 26409b2..248f769 100644
--- a/ident.c
+++ b/ident.c
@@ -259,3 +259,8 @@ const char *git_committer_info(int flag)
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
+
+int user_ident_sufficiently_given(void)
+{
+	return user_ident_explicitly_given;
+}

-- 8< -- to jk/warn-author-committer-after-commit topic -- 8< --
