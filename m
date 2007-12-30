From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 30 Dec 2007 14:46:58 +0100
Message-ID: <e5bfff550712300546o167c460bl4628d87f8a4e14db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 14:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8yVm-0001QB-Te
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 14:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXL3NrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 08:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbXL3NrE
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 08:47:04 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:19529 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbXL3NrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 08:47:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4191558rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=2KOo0KP83zbqjJvlHWPGPJ6dqwoCX22VPEK3I7xXcr4=;
        b=GsV6Nb0eWH0h9apqoXHmcGqYfwHgoiAYbtD0jgTtlMojpIVf/LsfmG1hBHZ+l28XlVlOndO8y8ZctAR5gtIg5LZ81XhcpR78w7/GebMWiIM0QXQpYvEb+AwRhhyaI34gq/B8nKKpYkd3KgMYF8qd4tYbd8yNOR+PjUmXHQrK5nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FSdRLYhkqNkbmxTTxl0pK2VV/PhL5pWgfi6YsXTAFVj1Yjgtnw2ldz/zzboLaCytW1ujdS4P0gE5mwCbIaZE+lpjOlFA7NK0l41UFrMrzLnOGAFjNQB0OMzNxIVcEWnIveqflZk+E1r2ft/S4is+872IOlEKMqR9SSTCpht+u7Q=
Received: by 10.140.180.42 with SMTP id c42mr4086836rvf.145.1199022418256;
        Sun, 30 Dec 2007 05:46:58 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 05:46:58 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69360>

Currently the --prett=format prefix is looked up in a
tight loop in strbuf_expand(), if found is passed as parameter
to format_commit_item() that does another search using a
switch statement to select the proper operation according to
the kind of prefix.

Because the switch statement is already able to discard unknown
matches we don't need the prefix lookup before to call format_commit_item()

This patch removes an useless loop in a very fasth path,
used by, as example, by 'git log' with --pretty=format option

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This patch is somewhat experimental and is not intended to be merged as is.

That's what is missing:

- Matching of multi char prefixes is not 100% reliable, as example to match
  prefix "Cgreen" only the first 'C' and the third char 'e' is
checked, this could
  lead to aliases in case of malformed prefixes, as example something like
  "Cxxexxxx" will match the same.


- With this patch placeholders array defined in format_commit_message() becames
  useless. That code should be refactored to remove the vector and
perhaps add some
  stricter checking rules directly inside format_commit_item()


Anyhow with this patch we pass from


marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents -z --log-size --boundary
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
2.89user 0.07system 0:02.96elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27154minor)pagefaults 0swaps


With the super optimized prefixcmp() patch (see the other thread)

to the current

[marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents -z --log-size --boundary
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
2.76user 0.08system 0:02.85elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27153minor)pagefaults 0swaps


 pretty.c |   43 ++++++++++++++++++++++---------------------
 strbuf.c |   16 +++++++---------
 strbuf.h |    2 +-
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5b1078b..6225042 100644
--- a/pretty.c
+++ b/pretty.c
@@ -432,7 +432,7 @@ static void parse_commit_header(struct
format_commit_context *context)
 	context->commit_header_parsed = 1;
 }

-static void format_commit_item(struct strbuf *sb, const char *placeholder,
+static int format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
 	struct format_commit_context *c = context;
@@ -446,20 +446,20 @@ static void format_commit_item(struct strbuf *sb,
 		switch (placeholder[3]) {
 		case 'd':	/* red */
 			strbuf_addstr(sb, "\033[31m");
-			return;
+			return 4;
 		case 'e':	/* green */
 			strbuf_addstr(sb, "\033[32m");
-			return;
+			return 6;
 		case 'u':	/* blue */
 			strbuf_addstr(sb, "\033[34m");
-			return;
+			return 5;
 		case 's':	/* reset color */
 			strbuf_addstr(sb, "\033[m");
-			return;
+			return 6;
 		}
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
-		return;
+		return 1;
 	}

 	/* these depend on the commit */
@@ -469,34 +469,34 @@ static void format_commit_item(struct strbuf *sb,
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
-		return;
+		return 1;
 	case 'h':		/* abbreviated commit hash */
 		if (add_again(sb, &c->abbrev_commit_hash))
-			return;
+			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 		                                     DEFAULT_ABBREV));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
-		return;
+		return 1;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
-		return;
+		return 1;
 	case 't':		/* abbreviated tree hash */
 		if (add_again(sb, &c->abbrev_tree_hash))
-			return;
+			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
 		                                     DEFAULT_ABBREV));
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
-		return;
+		return 1;
 	case 'P':		/* parent hashes */
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
 		}
-		return;
+		return 1;
 	case 'p':		/* abbreviated parent hashes */
 		if (add_again(sb, &c->abbrev_parent_hashes))
-			return;
+			return 1;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
@@ -505,14 +505,14 @@ static void format_commit_item(struct strbuf *sb,
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
-		return;
+		return 1;
 	case 'm':		/* left/right/bottom */
 		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
 		                 ? '-'
 		                 : (commit->object.flags & SYMMETRIC_LEFT)
 		                 ? '<'
 		                 : '>');
-		return;
+		return 1;
 	}

 	/* For the rest we have to parse the commit header. */
@@ -522,22 +522,23 @@ static void format_commit_item(struct strbuf *sb,
 	switch (placeholder[0]) {
 	case 's':
 		strbuf_add(sb, msg + c->subject.off, c->subject.len);
-		return;
+		return 1;
 	case 'a':
 		format_person_part(sb, placeholder[1],
 		                   msg + c->author.off, c->author.len);
-		return;
+		return 2;
 	case 'c':
 		format_person_part(sb, placeholder[1],
 		                   msg + c->committer.off, c->committer.len);
-		return;
+		return 2;
 	case 'e':
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
-		return;
+		return 1;
 	case 'b':
 		strbuf_addstr(sb, msg + c->body_off);
-		return;
+		return 1;
 	}
+	return 0; /* unknown prefix */
 }

 void format_commit_message(const struct commit *commit,
diff --git a/strbuf.c b/strbuf.c
index b9b194b..3c2a3a7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -141,7 +141,8 @@ void strbuf_expand(struct strbuf *sb, const char
                    const char **placeholders, expand_fn_t fn, void *context)
 {
 	for (;;) {
-		const char *percent, **p;
+		const char *percent;
+		int prefix_len;

 		percent = strchrnul(format, '%');
 		strbuf_add(sb, format, percent - format);
@@ -149,14 +150,11 @@ void strbuf_expand(struct strbuf *sb, const char
 			break;
 		format = percent + 1;

-		for (p = placeholders; *p; p++) {
-			if (!prefixcmp(format, *p))
-				break;
-		}
-		if (*p) {
-			fn(sb, *p, context);
-			format += strlen(*p);
-		} else
+		prefix_len = fn(sb, format, context);
+
+		if (prefix_len)
+			format += prefix_len;
+		else
 			strbuf_addch(sb, '%');
 	}
 }
diff --git a/strbuf.h b/strbuf.h
index 36d61db..e6d09fc 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -103,7 +103,7 @@ static inline void strbuf_addbuf(struct strbuf *sb,
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);

-typedef void (*expand_fn_t) (struct strbuf *sb, const char
*placeholder, void *context);
+typedef int (*expand_fn_t) (struct strbuf *sb, const char
*placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format,
const char **placeholders, expand_fn_t fn, void *context);

 __attribute__((format(printf,2,3)))
-- 
1.5.4.rc2.1.gec59-dirty
