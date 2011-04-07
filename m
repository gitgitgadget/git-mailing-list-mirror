From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative
 ":/path/from/top/level" pathspec support
Date: Wed, 06 Apr 2011 18:40:26 -0700
Message-ID: <7v62qqhm9h.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 03:40:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7eDE-0003gJ-Fn
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273Ab1DGBkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:40:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab1DGBkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:40:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E8004F82;
	Wed,  6 Apr 2011 21:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SdFX3+7XdO6MAFiJ8d9UAU1KCCo=; b=HeuirL
	SkBdmSfsLxlzUCUP0NTi61NS6BKxe5LsUJNyZSeiiwkSltwNpWtJujeCwfAJyKvo
	WqKOu1A6uf1nDgi50klUlD+cKlVsGf03mycSpME0WWhjuyDAJqhYsf3bQvxF4P/n
	TOks73MZKpYRSNgaCqseYLyCj4/fZlz7n68kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aDCSr8ZMHsbkwuF8QKzJw8wQOWMnjEwQ
	qQfklgm23mg517j/lkR4ecY4WhbPgVSSWY1v6iW5Nt4puNpz+lw2I21/Zce0taFR
	SzPfGt4Rdh6bdeiwceYO3czucn6WAkmH6Z+IowEKWUHK9UrivgbcTyhPurmHKwBo
	qS7eSg2uJzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6110A4F81;
	Wed,  6 Apr 2011 21:42:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3D8D74F7E; Wed,  6 Apr 2011
 21:42:21 -0400 (EDT)
In-Reply-To: <1302138996-10006-2-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 6 Apr 2011 18:16:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A041E3E-60B8-11E0-9D43-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171039>

Junio C Hamano <gitster@pobox.com> writes:

> This patch implements only "top" magic because it is the only kind of
> magic that can be hacked into the system without such a refactoring.
> Other types of magic that are envisioned (e.g. "icase") needs to be able
> to express more than what a simple string can encode and needs to wait.

Actually "icase" could be implemented inside get_pathspec() by doing
something like the attached patch.

But "noglob" needs support from the "struct pathspec_item" infrastructure.
It is insufficient to parse the magic signature at get_pathspec() level,
as I do not see a way to encode these magic in the match string.

I suspect that Duy's favourite "negate" cannot be done if we discard the
magic information at the get_pathspec() level, either.

---
 Documentation/glossary-content.txt |    7 +++++--
 setup.c                            |   31 +++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index e51d7e6..0ca029b 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -319,10 +319,13 @@ top `/`;;
 	The magic word `top` (mnemonic: `/`) makes the pattern match
 	from the root of the working tree, even when you are running
 	the command from inside a subdirectory.
+icase;;
+	The magic word `icase` (there is no mnemonic for it) makes the
+	pattern match case insensitively.  E.g. `:(icase)makefile` matches
+	both `Makefile` and `makefile`.
 --
 +
-Currently only the slash `/` is recognized as the "magic signature",
-but it is envisioned that we will support more types of magic in later
+It is envisioned that we will support more types of magic in later
 versions of git.
 
 [[def_parent]]parent::
diff --git a/setup.c b/setup.c
index 820ed05..e66ffbe 100644
--- a/setup.c
+++ b/setup.c
@@ -136,12 +136,12 @@ void verify_non_filename(const char *prefix, const char *arg)
  * Possible future magic semantics include stuff like:
  *
  *	{ PATHSPEC_NOGLOB, '!', "noglob" },
- *	{ PATHSPEC_ICASE, '\0', "icase" },
  *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
  *
  */
 #define PATHSPEC_FROMTOP    (1<<0)
+#define PATHSPEC_ICASE      (1<<1)
 
 struct pathspec_magic {
 	unsigned bit;
@@ -149,6 +149,7 @@ struct pathspec_magic {
 	const char *name;
 } pathspec_magic[] = {
 	{ PATHSPEC_FROMTOP, '/', "top" },
+	{ PATHSPEC_ICASE, '\0', "icase" },
 };
 
 /*
@@ -168,7 +169,8 @@ const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 {
 	unsigned magic = 0;
 	const char *copyfrom = elt;
-	int i;
+	const char *retval;
+	int i, free_source = 0;
 
 	if (elt[0] != ':') {
 		; /* nothing to do */
@@ -215,10 +217,31 @@ const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 			copyfrom++;
 	}
 
+	if (magic & PATHSPEC_ICASE) {
+		struct strbuf sb = STRBUF_INIT;
+		for (i = 0; copyfrom[i]; i++) {
+			int ch = copyfrom[i];
+			if (('a' <= ch && ch <= 'z') ||
+			    ('A' <= ch && ch <= 'Z')) {
+				strbuf_addf(&sb, "[%c%c]",
+					    tolower(ch), toupper(ch));
+			} else {
+				strbuf_addch(&sb, ch);
+			}
+		}
+		if (sb.len) {
+			free_source = 1;
+			copyfrom = strbuf_detach(&sb, NULL);
+		}
+	}
+
 	if (magic & PATHSPEC_FROMTOP)
-		return xstrdup(copyfrom);
+		retval = xstrdup(copyfrom);
 	else
-		return prefix_path(prefix, prefixlen, copyfrom);
+		retval = prefix_path(prefix, prefixlen, copyfrom);
+	if (free_source)
+		free((char *)copyfrom);
+	return retval;
 }
 
 const char **get_pathspec(const char *prefix, const char **pathspec)
