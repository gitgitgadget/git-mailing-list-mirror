From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Wed, 13 Jan 2016 15:54:05 -0800
Message-ID: <xmqqlh7tkpcy.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601120939270.2964@virtualbox>
	<xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
	<20160112214909.GD2841@sigill.intra.peff.net>
	<xmqqtwmhkrj2.fsf@gitster.mtv.corp.google.com>
	<20160113232255.GA17937@sigill.intra.peff.net>
	<xmqqpox5kpsy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:54:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJVF1-0004Lw-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 00:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbcAMXyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 18:54:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753470AbcAMXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 18:54:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA4C23C791;
	Wed, 13 Jan 2016 18:54:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/6X/1MUVfxBruP3i5J7HQRPSeNI=; b=W6UjPG
	+WbPjC6NKxbvHJD6GhsHGxP0ncKsRHGwwRd5R73dmykIqsbEwCQi8dcdwNjlZcXE
	VmwEcu+JJ7HkTBrInysfHcmF5SiAmRhR+269JiUGOqxJYMwezmq8PExk/XKuA0mE
	2jTiYOURAMM/mZP8dib4HQQxGZ9ZXbKbHM1OE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FrTLDxvt8TJF1t/H0mshsvX1+SGlWi6b
	MupZmFZWsm/IOE1QRctZbJAfNrIccXvMJVrFr65N+DZlJD7jfHYZ2Vzejc1i3GNV
	uOWU585b52xlbFctYxEUM1cT5H+dPL9sxkXpFCvM2kljiu1p8G4oLPviA0iPEu8Z
	bn8iTQPilBA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 996AF3C790;
	Wed, 13 Jan 2016 18:54:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1ADDE3C78F;
	Wed, 13 Jan 2016 18:54:07 -0500 (EST)
In-Reply-To: <xmqqpox5kpsy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 Jan 2016 15:44:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EECD1C58-BA50-11E5-99C3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283999>

Junio C Hamano <gitster@pobox.com> writes:

> My plan is to use a function pointer to switch between them.  A code
> like the above in practice look more like
>
> (1) there is a config/option parser that sets line_terminator that
>     is typically a file-scope global.
>
> 	if (z_option)
>         	line_terminator = '\0';
> 	else
>         	line_terminator = '\n';
>
> (2) the callsite calls getline with it
>
> 	strbuf_getline(..., line_terminator);
>
> So we can introduce a file-scope global, (*getline_fn)(), and then
> tweak (1) by removing line_terminator and replacing the assignment
> with an assignment to getline_fn.

And after doing the obvious wholesale replacement on callers that
hardcode either '\n' or '\0' with this:

#!/bin/sh
perl -i -p -e '
	s/strbuf_getline\((.*?), '\''\\n'\''\)/strbuf_getline_lf($1)/g;
	s/strbuf_getline\((.*?), '\''\\0'\''\)/strbuf_getline_nul($1)/g;
' "$@"

the only direct callers of strbuf_getline() that remain in the tree
are check-attr, check-ignore, checkout-index and mktree.

And the conversion of mktree would look like this.  I might further
tweak it to rename and flip the polarity of lf_lines to nul_lines,
but I do not think that matters very much.

 builtin/mktree.c | 15 +++++++++------
 strbuf.h         |  3 +++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index a964d6b..7633d35 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -65,7 +65,7 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, size_t len, int line_termination, int allow_missing)
+static void mktree_line(char *buf, size_t len, int lf_lines, int allow_missing)
 {
 	char *ptr, *ntr;
 	unsigned mode;
@@ -97,7 +97,7 @@ static void mktree_line(char *buf, size_t len, int line_termination, int allow_m
 	*ntr++ = 0; /* now at the beginning of SHA1 */
 
 	path = ntr + 41;  /* at the beginning of name */
-	if (line_termination && path[0] == '"') {
+	if (lf_lines && path[0] == '"') {
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
@@ -141,13 +141,14 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	unsigned char sha1[20];
-	int line_termination = '\n';
+	int lf_lines = 1;
 	int allow_missing = 0;
 	int is_batch_mode = 0;
 	int got_eof = 0;
+	strbuf_getline_fn getline_fn;
 
 	const struct option option[] = {
-		OPT_SET_INT('z', NULL, &line_termination, N_("input is NUL terminated"), '\0'),
+		OPT_SET_INT('z', NULL, &lf_lines, N_("input is NUL terminated"), '\0'),
 		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objects"), 1),
 		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more than one tree"), 1),
 		OPT_END()
@@ -155,9 +156,11 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
 
+	getline_fn = lf_lines ? strbuf_getline_lf : strbuf_getline_nul;
+
 	while (!got_eof) {
 		while (1) {
-			if (strbuf_getline(&sb, stdin, line_termination) == EOF) {
+			if (getline_fn(&sb, stdin) == EOF) {
 				got_eof = 1;
 				break;
 			}
@@ -167,7 +170,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 					break;
 				die("input format error: (blank line only valid in batch mode)");
 			}
-			mktree_line(sb.buf, sb.len, line_termination, allow_missing);
+			mktree_line(sb.buf, sb.len, lf_lines, allow_missing);
 		}
 		if (is_batch_mode && got_eof && used < 1) {
 			/*
diff --git a/strbuf.h b/strbuf.h
index db053be..9c8d715 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -405,6 +405,9 @@ static inline int strbuf_getline_nul(struct strbuf *sb, FILE *fp)
 	return strbuf_getline(sb, fp, '\0');
 }
 
+typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
+
+
 /**
  * Like `strbuf_getline`, but keeps the trailing terminator (if
  * any) in the buffer.
