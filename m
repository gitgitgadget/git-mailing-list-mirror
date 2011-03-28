From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 9/9] add long forms for author and committer identity
Date: Tue, 29 Mar 2011 00:17:31 +0100
Message-ID: <1301354251-23380-10-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Lhf-00010L-Em
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151Ab1C1XSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:18:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1C1XSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:18:07 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so4410093wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ddnQ7MpsPLO7wzL9fFwjEUNFXx/IxPqM4whzU8zcqhU=;
        b=S5lE1griiyzUmJmElNJJzFD71E91x3F0vIqv6y8d6N52YktoAPObdMKD2Y7khDi7Ew
         TvFjRHFgtQ7vX4xbWKjEh1j1EYKL8taRq4AItCsQrzeSNkh903hTyikTTKEDjgp2Qcn+
         uXHfPieRQrtQv4KgRgug8QYEtQNL6W6BTzflM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qtkIt5rN0D5E9H/n5geR31PJwIMj8X+gCo4QpfKfwL019emFDuJUr7b7RqNVKq1gvg
         L94timJRyicyuWQoU3z4t/TjCATWw9qwLBlrPAkRYWA9HJqfv3EllI1F4P2ehBamkwmJ
         b0diotxI802sGNyyge8qjHf/qdjopLY1Bp0eE=
Received: by 10.216.120.193 with SMTP id p43mr4095018weh.92.1301354286545;
        Mon, 28 Mar 2011 16:18:06 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.18.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:18:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170206>

this adds the long forms %(authorname), %(committername),
%(authoremail), and %(committeremail) to complement the existing
placeholders %an, %ae, %cn, and %ce; and, :mailmap forms of each, eg:
    %(authoremail:mailmap)

The main purpose of this change is to match the format of the
placeholders supported in git for-each-ref, though the optional :mailmap
parameter seemed like a sensible extension.

At this point we have enough "long form" placeholders to justify giving
them their own section in the documentation, so we do.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/pretty-formats.txt |   57 ++++++++++++++++++++++++++++----
 commit.h                         |    6 +--
 pretty.c                         |   68 ++++++++++++++++++++++++++++----------
 test-pretty.c                    |   14 +++++--
 4 files changed, 112 insertions(+), 33 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index dfb81a7..e9d6634 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -97,7 +97,13 @@ The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 
 --------
 +
-The placeholders are:
+The placeholders are divided into two categories, "short forms",
+for quickly typing the more-common placeholders, and "long forms",
+which may be more readable, and may support various additional
+options.
++
+--
+Short forms:
 
 - '%H': commit hash
 - '%h': abbreviated commit hash
@@ -114,8 +120,6 @@ The placeholders are:
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
-- '%(authordate[:<format>])': author date. Without a <format>, the --date= option is respected.
-  Otherwise, a format of the type which can be specified via the --date= option is taken.
 - '%cn': committer name
 - '%cN': committer name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ce': committer email
@@ -125,8 +129,6 @@ The placeholders are:
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
-- '%(committerdate[:<format>])': committer date. Without a <format>, the --date= option is respected.
-  Otherwise, a format of the type which can be specified via the --date= option is taken.
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
@@ -142,20 +144,61 @@ The placeholders are:
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described in color.branch.* config option
-- '%(color:...)': alternative form of %C(...)
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
   linkgit:git-shortlog[1].
-- '%(wrap:[<w>[,<i1>[,<i2>]]])': alternative form of %w(...)
+
+Long forms:
+
+- '%(authorname[:mailmap])':
++
+author name, optionally respecting .mailmap (see linkgit:git-shortlog[1]
+or linkgit:git-blame[1]).
+
+- '%(authoremail[:mailmap])':
++
+author email, optionally respecting .mailmap (see linkgit:git-shortlog[1]
+or linkgit:git-blame[1]).
+
+- '%(authordate[:<format>])':
++
+author date. Without a <format>, the --date= option is respected.
+Otherwise, a format of the type which can be specified via the --date=
+option is taken.
+
+- '%(committername[:mailmap])':
++
+committer name, optionally respecting .mailmap (see
+linkgit:git-shortlog[1] or linkgit:git-blame[1]).
+
+- '%(committeremail[:mailmap])':
++
+committer email, optionally respecting .mailmap (see
+linkgit:git-shortlog[1] or linkgit:git-blame[1]).
+
+- '%(committerdate[:<format>])':
++
+committer date. Without a <format>, the --date= option is respected.
+Otherwise, a format of the type which can be specified via the --date=
+option is taken.
+
+- '%(color:[<spec>])':
++
+color specification, as described in color.branch.* config option.
+
+- '%(wrap:[<w>[,<i1>[,<i2>]]])':
++
+switch line wrapping, like the -w option of linkgit:git-shortlog[1].
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
 insert an empty string unless we are traversing reflog entries (e.g., by
 `git log -g`). The `%d` placeholder will use the "short" decoration
 format if `--decorate` was not already provided on the command line.
+--
 
 If you add a `{plus}` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
diff --git a/commit.h b/commit.h
index fff1225..a175444 100644
--- a/commit.h
+++ b/commit.h
@@ -95,14 +95,10 @@ enum format_part_type {
 	FORMAT_PART_TREE_HASH_ABBREV,
 
 	FORMAT_PART_AUTHOR_NAME,
-	FORMAT_PART_AUTHOR_NAME_MAILMAP,
 	FORMAT_PART_AUTHOR_EMAIL,
-	FORMAT_PART_AUTHOR_EMAIL_MAILMAP,
 	FORMAT_PART_AUTHOR_DATE,
 	FORMAT_PART_COMMITTER_NAME,
-	FORMAT_PART_COMMITTER_NAME_MAILMAP,
 	FORMAT_PART_COMMITTER_EMAIL,
-	FORMAT_PART_COMMITTER_EMAIL_MAILMAP,
 	FORMAT_PART_COMMITTER_DATE,
 
 	FORMAT_PART_DECORATE,
@@ -130,6 +126,7 @@ enum format_part_magic {
 
 enum format_arg_type {
 	FORMAT_ARG_UINT,
+	FORMAT_ARG_BOOLEAN,
 	FORMAT_ARG_DATE_MODE
 };
 
@@ -137,6 +134,7 @@ struct format_arg {
 	enum format_arg_type type;
 	union {
 		unsigned long uint;
+		int boolean : 1;
 		enum date_mode dmode;
 	};
 };
diff --git a/pretty.c b/pretty.c
index 006bbe3..ef6c3c1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -90,6 +90,16 @@ static void part_add_arg_date_mode(struct format_part *part,
 	return;
 }
 
+static void part_add_arg_boolean(struct format_part *part, int value)
+{
+	part->args = xrealloc(part->args,
+			      sizeof(struct format_arg) * (part->argc+1));
+	part->args[part->argc].type = FORMAT_ARG_BOOLEAN;
+	part->args[part->argc].boolean = value ? 1 : 0;
+	part->argc++;
+	return;
+}
+
 /*
 * Parse a single argument of an extended format, up to the next delimiter
 * ie: up to ',' or ')'
@@ -165,6 +175,31 @@ static struct format_part *parse_extended(const char *unparsed)
 				goto fail;
 			goto success;
 		}
+		if (!prefixcmp(c, "name") || !prefixcmp(c, "email")) {
+			if (*c == 'n') { /* name */
+				part->type = (*e == 'a') ? FORMAT_PART_AUTHOR_NAME :
+							   FORMAT_PART_COMMITTER_NAME;
+				c += 4;
+			} else { /* email */
+				part->type = (*e == 'a') ? FORMAT_PART_AUTHOR_EMAIL :
+							   FORMAT_PART_COMMITTER_EMAIL;
+				c += 5;
+			}
+
+			strspn(c, WHITESPACE);
+			if (*c == ')')
+				goto success;
+			if (*c != ':')
+				goto fail;
+			c += 1 + strspn(c + 1, WHITESPACE);
+			if (!prefixcmp(c, "mailmap")) {
+				part_add_arg_boolean(part, 1);
+				c += 7 + strspn(c + 7, WHITESPACE);
+				if (*c == ')')
+					goto success;
+			}
+			goto fail;
+		}
 
 		c = e;
 	}
@@ -285,13 +320,15 @@ static struct format_part *parse_special(const char *unparsed)
 			part->type = FORMAT_PART_AUTHOR_NAME;
 			return part;
 		case 'N':
-			part->type = FORMAT_PART_AUTHOR_NAME_MAILMAP;
+			part->type = FORMAT_PART_AUTHOR_NAME;
+			part_add_arg_boolean(part, 1);
 			return part;
 		case 'e':
 			part->type = FORMAT_PART_AUTHOR_EMAIL;
 			return part;
 		case 'E':
-			part->type = FORMAT_PART_AUTHOR_EMAIL_MAILMAP;
+			part->type = FORMAT_PART_AUTHOR_EMAIL;
+			part_add_arg_boolean(part, 1);
 			return part;
 		case 'd':
 			part->type = FORMAT_PART_AUTHOR_DATE;
@@ -321,13 +358,15 @@ static struct format_part *parse_special(const char *unparsed)
 			part->type = FORMAT_PART_COMMITTER_NAME;
 			return part;
 		case 'N':
-			part->type = FORMAT_PART_COMMITTER_NAME_MAILMAP;
+			part->type = FORMAT_PART_COMMITTER_NAME;
+			part_add_arg_boolean(part, 1);
 			return part;
 		case 'e':
 			part->type = FORMAT_PART_COMMITTER_EMAIL;
 			return part;
 		case 'E':
-			part->type = FORMAT_PART_COMMITTER_EMAIL_MAILMAP;
+			part->type = FORMAT_PART_COMMITTER_EMAIL;
+			part_add_arg_boolean(part, 1);
 			return part;
 		case 'd':
 			part->type = FORMAT_PART_COMMITTER_DATE;
@@ -976,10 +1015,11 @@ static void format_person_part(struct strbuf *sb, struct format_part *part,
 		return;
 	end = mail_end-msg;
 
-	if (part->type == FORMAT_PART_AUTHOR_NAME_MAILMAP ||
-	    part->type == FORMAT_PART_AUTHOR_EMAIL_MAILMAP ||
-	    part->type == FORMAT_PART_COMMITTER_NAME_MAILMAP ||
-	    part->type == FORMAT_PART_COMMITTER_EMAIL_MAILMAP) {
+	if ((part->type == FORMAT_PART_AUTHOR_NAME ||
+	     part->type == FORMAT_PART_AUTHOR_EMAIL ||
+	     part->type == FORMAT_PART_COMMITTER_NAME ||
+	     part->type == FORMAT_PART_COMMITTER_EMAIL) &&
+	    part->argc && part->args[0].boolean) { /* mailmap */
 		/* copy up to, and including, the end delimiter */
 		strlcpy(person_name, name_start, name_len+1);
 		strlcpy(person_mail, mail_start, mail_len+1);
@@ -990,16 +1030,12 @@ static void format_person_part(struct strbuf *sb, struct format_part *part,
 		mail_len = strlen(person_mail);
 	}
 	if (part->type == FORMAT_PART_AUTHOR_NAME ||
-	    part->type == FORMAT_PART_AUTHOR_NAME_MAILMAP ||
-	    part->type == FORMAT_PART_COMMITTER_NAME ||
-	    part->type == FORMAT_PART_COMMITTER_NAME_MAILMAP) {
+	    part->type == FORMAT_PART_COMMITTER_NAME) {
 		strbuf_add(sb, name_start, name_len);
 		return;
 	}
 	if (part->type == FORMAT_PART_AUTHOR_EMAIL ||
-	    part->type == FORMAT_PART_AUTHOR_EMAIL_MAILMAP ||
-	    part->type == FORMAT_PART_COMMITTER_EMAIL ||
-	    part->type == FORMAT_PART_COMMITTER_EMAIL_MAILMAP) {
+	    part->type == FORMAT_PART_COMMITTER_EMAIL) {
 		strbuf_add(sb, mail_start, mail_len);
 		return;
 	}
@@ -1338,17 +1374,13 @@ void format_commit_message_part(struct format_part *part,
 
 	switch (part->type) {
 	case FORMAT_PART_AUTHOR_NAME:
-	case FORMAT_PART_AUTHOR_NAME_MAILMAP:
 	case FORMAT_PART_AUTHOR_EMAIL:
-	case FORMAT_PART_AUTHOR_EMAIL_MAILMAP:
 	case FORMAT_PART_AUTHOR_DATE:
 		format_person_part(sb, part, commit->buffer + c->author.off,
 				   c->author.len, c->pretty_ctx->date_mode);
 		return;
 	case FORMAT_PART_COMMITTER_NAME:
-	case FORMAT_PART_COMMITTER_NAME_MAILMAP:
 	case FORMAT_PART_COMMITTER_EMAIL:
-	case FORMAT_PART_COMMITTER_EMAIL_MAILMAP:
 	case FORMAT_PART_COMMITTER_DATE:
 		format_person_part(sb, part, commit->buffer + c->committer.off,
 				   c->committer.len, c->pretty_ctx->date_mode);
diff --git a/test-pretty.c b/test-pretty.c
index 6a92c65..f9d44fa 100644
--- a/test-pretty.c
+++ b/test-pretty.c
@@ -19,11 +19,15 @@ static const char *all = "a"
 "%m%w()%w(1)%w(1,2)%w(1,2,3)"
 "%(wrap)%(wrap:1)%(wrap:1,2)%(wrap:1,2,3)"
 "%(color)%(color:red)%(color:red bold)%(color:red green bold)"
+"%(authorname)%(authorname:mailmap)"
+"%(authoremail)%(authoremail:mailmap)"
 "%(authordate)%(authordate:default)%(authordate:relative)"
 "%(authordate:short)%(authordate:local)"
 "%(authordate:iso8601)%(authordate:iso)"
 "%(authordate:rfc2822)%(authordate:rfc)"
 "%(authordate:unix)%(authordate:raw)"
+"%(committername)%(committername:mailmap)"
+"%(committeremail)%(committeremail:mailmap)"
 "%(committerdate)%(committerdate:default)%(committerdate:relative)"
 "%(committerdate:short)%(committerdate:local)"
 "%(committerdate:iso8601)%(committerdate:iso)"
@@ -46,14 +50,10 @@ static struct strbuf *parts_debug(struct format_parts *parts,
 		{FORMAT_PART_TREE_HASH, "TREE_HASH"},
 		{FORMAT_PART_TREE_HASH_ABBREV, "TREE_HASH_ABBREV"},
 		{FORMAT_PART_AUTHOR_NAME, "AUTHOR_NAME"},
-		{FORMAT_PART_AUTHOR_NAME_MAILMAP, "AUTHOR_NAME_MAILMAP"},
 		{FORMAT_PART_AUTHOR_EMAIL, "AUTHOR_EMAIL"},
-		{FORMAT_PART_AUTHOR_EMAIL_MAILMAP, "AUTHOR_EMAIL_MAILMAP"},
 		{FORMAT_PART_AUTHOR_DATE, "AUTHOR_DATE"},
 		{FORMAT_PART_COMMITTER_NAME, "COMMITTER_NAME"},
-		{FORMAT_PART_COMMITTER_NAME_MAILMAP, "COMMITTER_NAME_MAILMAP"},
 		{FORMAT_PART_COMMITTER_EMAIL, "COMMITTER_EMAIL"},
-		{FORMAT_PART_COMMITTER_EMAIL_MAILMAP, "COMMITTER_EMAIL_MAILMAP"},
 		{FORMAT_PART_COMMITTER_DATE, "COMMITTER_DATE"},
 
 		{FORMAT_PART_DECORATE, "DECORATE"},
@@ -155,6 +155,12 @@ static struct strbuf *parts_debug(struct format_parts *parts,
 					strbuf_addstr(buf, "UINT:");
 					strbuf_addf(buf, "%lu", part->args[j].uint);
 					break;
+				case FORMAT_ARG_BOOLEAN:
+					strbuf_addstr(buf, "BOOLEAN:");
+					strbuf_addstr(buf,
+						      part->args[j].boolean ?
+						       "TRUE" : "FALSE");
+					break;
 				case FORMAT_ARG_DATE_MODE:
 					strbuf_addstr(buf, "DATE_MODE:");
 					switch(part->args[j].dmode){
-- 
1.7.4.2
