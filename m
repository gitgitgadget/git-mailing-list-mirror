From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: when applying binary diffs, -p0 is ignored
Date: Fri, 24 Aug 2012 22:25:53 -0700
Message-ID: <7v393by23i.fsf@alter.siamese.dyndns.org>
References: <CA+qbEUOw9zR1_kdXU=mB8_KADq2NRT_qxSvGT+SfS55dUM8j6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Colin McCabe <cmccabe@alumni.cmu.edu>
X-From: git-owner@vger.kernel.org Sat Aug 25 07:26:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T58tQ-0001gH-3g
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 07:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab2HYF0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 01:26:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab2HYFZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 01:25:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 313455467;
	Sat, 25 Aug 2012 01:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SYum7+BynwlaqX66r1wBihXt4pg=; b=vmTs/K
	vENiX0S5OVpki4W8sDqaJahQcecRaamnfxFb0goVnl8aPSMMvr0b+LQ/yBRgkKzO
	k/R5Hs/kzn5CGNtCCtJL6P9i99kUKpv4JG/ztacZXaYeXyL1IWisYgCKrAoM+VMk
	muUuZFv5FtDsaY6FgoOTLV1dbkqrGXFYdlxxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBq1f9rPRXtETs6E3Tce0nZBiDEeAo2R
	WEPNhUsPMWFZutEDyWHO8yrRXxbdv18p39JcCD1aPokFKxNtC8DO4yGw8/pTus71
	oAmHGOt+esviuCeAJY3OG0gCtubmUNVHMD1dPKEA7sOyfmyZ3U2wb0s76+xL2sVb
	lHssboHBp0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D8525466;
	Sat, 25 Aug 2012 01:25:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2672F5465; Sat, 25 Aug 2012
 01:25:55 -0400 (EDT)
In-Reply-To: <CA+qbEUOw9zR1_kdXU=mB8_KADq2NRT_qxSvGT+SfS55dUM8j6A@mail.gmail.com> (Colin
 McCabe's message of "Fri, 24 Aug 2012 15:09:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57EE5392-EE75-11E1-8576-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204247>

Colin McCabe <cmccabe@alumni.cmu.edu> writes:

> I found a bug in git's handling of binary diff segments.
>
> When applying binary diffs using -p0, the prefix (or --strip) argument
> is ignored.

Thanks for a report.  An ancient bug well spotted.

Perhaps this will help.

-- >8 --
Subject: apply: compute patch->def_name correctly under -p0

Back when "git apply" was written, we made sure that the user can
skip more than the default number of path components (i.e. 1) by
giving "-p<n>", but the logic for doing so was built around the
notion of "we skip N slashes and stop".  This obviously does not
work well when running under -p0 where we do not want to skip any,
but still want to skip SP/HT that separates the pathnames of
preimage and postimage and want to reject absolute pathnames.

Stop using "stop_at_slash()", and instead introduce a new helper
"skip_tree_prefix()" with similar logic but works correctly even for
the -p0 case.

This is an ancient bug, but has been masked for a long time because
most of the patches are text and have other clues to tell us the
name of the preimage and the postimage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 55 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git i/builtin/apply.c w/builtin/apply.c
index 3bf71dc..4a511b3 100644
--- i/builtin/apply.c
+++ w/builtin/apply.c
@@ -1095,15 +1095,23 @@ static int gitdiff_unrecognized(const char *line, struct patch *patch)
 	return -1;
 }
 
-static const char *stop_at_slash(const char *line, int llen)
+/*
+ * Skip p_value leading components from "line"; as we do not accept
+ * absolute paths, return NULL in that case.
+ */
+static const char *skip_tree_prefix(const char *line, int llen)
 {
-	int nslash = p_value;
+	int nslash;
 	int i;
 
+	if (!p_value)
+		return (llen && line[0] == '/') ? NULL : line;
+
+	nslash = p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
-			return &line[i];
+			return (i == 0) ? NULL : &line[i + 1];
 	}
 	return NULL;
 }
@@ -1133,12 +1141,11 @@ static char *git_header_name(const char *line, int llen)
 		if (unquote_c_style(&first, line, &second))
 			goto free_and_fail1;
 
-		/* advance to the first slash */
-		cp = stop_at_slash(first.buf, first.len);
-		/* we do not accept absolute paths */
-		if (!cp || cp == first.buf)
+		/* strip the a/b prefix including trailing slash */
+		cp = skip_tree_prefix(first.buf, first.len);
+		if (!cp)
 			goto free_and_fail1;
-		strbuf_remove(&first, 0, cp + 1 - first.buf);
+		strbuf_remove(&first, 0, cp - first.buf);
 
 		/*
 		 * second points at one past closing dq of name.
@@ -1152,22 +1159,21 @@ static char *git_header_name(const char *line, int llen)
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = stop_at_slash(sp.buf, sp.len);
-			if (!cp || cp == sp.buf)
+			cp = skip_tree_prefix(sp.buf, sp.len);
+			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
-			if (strcmp(cp + 1, first.buf))
+			if (strcmp(cp, first.buf))
 				goto free_and_fail1;
 			strbuf_release(&sp);
 			return strbuf_detach(&first, NULL);
 		}
 
 		/* unquoted second */
-		cp = stop_at_slash(second, line + llen - second);
-		if (!cp || cp == second)
+		cp = skip_tree_prefix(second, line + llen - second);
+		if (!cp)
 			goto free_and_fail1;
-		cp++;
-		if (line + llen - cp != first.len + 1 ||
+		if (line + llen - cp != first.len ||
 		    memcmp(first.buf, cp, first.len))
 			goto free_and_fail1;
 		return strbuf_detach(&first, NULL);
@@ -1179,10 +1185,9 @@ static char *git_header_name(const char *line, int llen)
 	}
 
 	/* unquoted first name */
-	name = stop_at_slash(line, llen);
-	if (!name || name == line)
+	name = skip_tree_prefix(line, llen);
+	if (!name)
 		return NULL;
-	name++;
 
 	/*
 	 * since the first name is unquoted, a dq if exists must be
@@ -1196,10 +1201,9 @@ static char *git_header_name(const char *line, int llen)
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = stop_at_slash(sp.buf, sp.len);
-			if (!np || np == sp.buf)
+			np = skip_tree_prefix(sp.buf, sp.len);
+			if (!np)
 				goto free_and_fail2;
-			np++;
 
 			len = sp.buf + sp.len - np;
 			if (len < second - name &&
@@ -1231,13 +1235,14 @@ static char *git_header_name(const char *line, int llen)
 		case '\n':
 			return NULL;
 		case '\t': case ' ':
-			second = stop_at_slash(name + len, line_len - len);
+			if (!name[len + 1])
+				return NULL;
+			second = skip_tree_prefix(name + len + 1,
+						  line_len - (len + 1));
 			if (!second)
 				return NULL;
-			second++;
-			if (second[len] == '\n' && !strncmp(name, second, len)) {
+			if (second[len] == '\n' && !strncmp(name, second, len))
 				return xmemdupz(name, len);
-			}
 		}
 	}
 }
