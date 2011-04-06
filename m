From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to
 use_wildcard
Date: Wed, 06 Apr 2011 12:52:10 -0700
Message-ID: <7vsjtvi2dx.fsf@alter.siamese.dyndns.org>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org>
 <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
 <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 21:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7YmA-00008N-Iz
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 21:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab1DFTwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 15:52:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1DFTwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 15:52:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 855F8465E;
	Wed,  6 Apr 2011 15:54:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N2hAqcD+Th8kbKlpt9HA8YwDxXU=; b=XGapKm
	anx2fLzh/b9h3vsOcIUTIimIl+qrN+Vpxd93PX1Mx0K3AtLFyKJw2CAvQZdigdvK
	yNU/39nQlrepTSy/GkueIvXxYJWSiYZPuuJxcokGVlkobYm13TggU4Jj04SS9RAj
	FsvLLYq3ivP9tXfQLNAuFWulFbaRvHqc1jCcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V5OBVFLYjBMQ9NkPsWQ0EEAMQYBKFRcT
	y5cEs37BkuIQcDsC43koQtTqFdgymq18hscaBsh8yBRBu0rAZJBCjaFaiCYSl2B6
	sFVqOkxJ2uhDyl0CdXjSjn0/4ZRYX/ZkY6HmA77Vjja1JJqgMBnaCw3KzGVCl6Yh
	tgNnrW6KwS0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4ED0E465A;
	Wed,  6 Apr 2011 15:54:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4BC234654; Wed,  6 Apr 2011
 15:54:05 -0400 (EDT)
In-Reply-To: <7vfwpvjobl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Apr 2011 10:13:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A42D0992-6087-11E0-BE43-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171009>

Junio C Hamano <gitster@pobox.com> writes:

> I am actually tempted to add Michael's hack to get_pathspec() only to
> support the "from the top" (and error out with any other magic---as the
> approach without a proper restructuring will not work with anything but
> that particular magic), to get the "add -u" topic going, and let you (or
> other people who are interested in the pathspec rationalization) later fix
> it up just a small part of existing issues.

Just a heads-up; it would look like this (no docs, tests, nor "add -u"
message updates yet).  The entries other than "top" should not be in the
final version but I just wanted to make sure that the extensibility would
look sane.


 setup.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 03cd84f..704a930 100644
--- a/setup.c
+++ b/setup.c
@@ -126,6 +126,104 @@ void verify_non_filename(const char *prefix, const char *arg)
 	    "Use '--' to separate filenames from revisions", arg);
 }
 
+/*
+ * Magic pathspec
+ *
+ * NEEDSWORK: These need to be moved to dir.h or even to a new
+ * pathspec.h when we restructure get_pathspec() users to use the
+ * "struct pathspec" interface.
+ */
+#define PATHSPEC_FROMTOP    (1<<0)
+#define PATHSPEC_NOGLOB     (1<<1)
+#define PATHSPEC_ICASE      (1<<2)
+#define PATHSPEC_RECURSIVE  (1<<3)
+#define PATHSPEC_REGEXP     (1<<4)
+
+struct pathspec_magic {
+	unsigned bit;
+	char mnemonic; /* cannot be ':'! */
+	const char *name;
+} pathspec_magic[] = {
+	{ PATHSPEC_FROMTOP, '/', "top" },
+	{ PATHSPEC_NOGLOB, '!', "noglob" },
+	{ PATHSPEC_ICASE, '\0', "icase" },
+	{ PATHSPEC_RECURSIVE, '*', "recursive" },
+	{ PATHSPEC_REGEXP, '\0', "regexp" },
+};
+
+/*
+ * Take an element of a pathspec and check for magic signatures.
+ * Append the result to the prefix.
+ *
+ * For now, we only parse the syntax and throw out anything other than
+ * "top" magic.
+ *
+ * NEEDSWORK: This needs to be rewritten when we start migrating
+ * get_pathspec() users to use the "struct pathspec" interface.  For
+ * example, a pathspec element may be marked as case-insensitive, but
+ * the prefix part must always match literally, and a single stupid
+ * string cannot express such a case.
+ */
+const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
+{
+	unsigned magic = 0;
+	const char *copyfrom = elt;
+	int i;
+
+	if (elt[0] != ':') {
+		; /* nothing to do */
+	} else if (elt[1] == '(') {
+		/* longhand */
+		const char *nextat;
+		for (copyfrom = elt + 2;
+		     *copyfrom && *copyfrom != ')';
+		     copyfrom = nextat) {
+			size_t len = strcspn(copyfrom, ",)");
+			if (copyfrom[len] == ')')
+				nextat = copyfrom + len;
+			else
+				nextat = copyfrom + len + 1;
+			if (!len)
+				continue;
+			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
+				if (strlen(pathspec_magic[i].name) == len &&
+				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
+					magic |= pathspec_magic[i].bit;
+					break;
+				}
+			if (ARRAY_SIZE(pathspec_magic) <= i)
+				die("Invalid pathspec magic '%.*s' in '%s'",
+				    (int) len, copyfrom, elt);
+		}
+		if (*copyfrom == ')')
+			copyfrom++;
+	} else {
+		/* shorthand */
+		for (copyfrom = elt + 1;
+		     *copyfrom && *copyfrom != ':';
+		     copyfrom++) {
+			char ch = *copyfrom;
+			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
+				if (pathspec_magic[i].mnemonic == ch) {
+					magic |= pathspec_magic[i].bit;
+					break;
+				}
+			if (ARRAY_SIZE(pathspec_magic) <= i)
+				break;
+		}
+		if (*copyfrom == ':')
+			copyfrom++;
+	}
+
+	if (magic & ~(PATHSPEC_FROMTOP))
+		die("Unsupported pathspec magic in '%s'", elt);
+
+	if (magic & PATHSPEC_FROMTOP)
+		return xstrdup(copyfrom);
+	else
+		return prefix_path(prefix, prefixlen, copyfrom);
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
@@ -147,8 +245,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	dst = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
 	while (*src) {
-		const char *p = prefix_path(prefix, prefixlen, *src);
-		*(dst++) = p;
+		*(dst++) = prefix_pathspec(prefix, prefixlen, *src);
 		src++;
 	}
 	*dst = NULL;
