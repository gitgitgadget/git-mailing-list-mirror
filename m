From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] Make --stdin option to "log" family read also pathspecs
Date: Fri, 20 Nov 2009 03:25:15 -0800
Message-ID: <1258716315-2213-4-git-send-email-gitster@pobox.com>
References: <1258716315-2213-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 12:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRcp-0004lQ-T7
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbZKTLZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZKTLZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:25:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZKTLZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:25:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D21F9FE46
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HtGk
	eG0fpL/5es+O2M7vuwmvkNc=; b=s9M+A4ZJhhWbhrd2/1Fs1Mxj+JO2Aer6pC9b
	cUS0hWxzzHmj+V+vPAkQSN+25Pl518/iNdG0p9iFEMvZEBLOmDa7OVxKeEcIczEz
	BWgvpP/jBiII6mjKX64yDVvCqfmIEDY18LqSKwODG6wIkQoOXSdCBglrift6acDy
	N3S1jR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KaFQ4N
	iitlVVW3QqriZZNseIxIAmc3niTXTin4GNVCTulAAoXyl5UugXPQRzCu3Poz3xr2
	hlM+/OwnEDLroeIW9KuWaypx6huAWcZHd6ucPbK/N81V9jq4nQ50bKfVGcdYRdQE
	RKamj0+6V5ud2p2lXrz9KSM4QDCtctVqQvDEQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8994E9FE45
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C5C039FE44 for
 <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:22 -0500 (EST)
X-Mailer: git-send-email 1.6.5.3.342.g14bb9
In-Reply-To: <1258716315-2213-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 64DE8474-D5C7-11DE-BA9A-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133336>

Similar to the command line arguments, after giving zero or more revs, you can
feed a line "--" and then feed pathspecs one at a time.

With this

	(
		echo ^maint
		echo --
		echo Documentation
	) | git log --stat --oneline --stdin master -- t

lists commits that touch Documentation/ or t/ between maint and master.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 4410a45..8750c20 100644
--- a/revision.c
+++ b/revision.c
@@ -953,9 +953,38 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs)
+static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb, const char ***prune_data)
+{
+	const char **prune = *prune_data;
+	int prune_nr;
+	int prune_alloc;
+
+	/* count existing ones */
+	if (!prune)
+		prune_nr = 0;
+	else
+		for (prune_nr = 0; prune[prune_nr]; prune_nr++)
+			;
+	prune_alloc = prune_nr; /* not really, but we do not know */
+
+	while (strbuf_getwholeline(sb, stdin, '\n') != EOF) {
+		int len = sb->len;
+		if (len && sb->buf[len - 1] == '\n')
+			sb->buf[--len] = '\0';
+		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
+		prune[prune_nr++] = xstrdup(sb->buf);
+	}
+	if (prune) {
+		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
+		prune[prune_nr] = NULL;
+	}
+	*prune_data = prune;
+}
+
+static void read_revisions_from_stdin(struct rev_info *revs, const char ***prune)
 {
 	struct strbuf sb;
+	int seen_dashdash = 0;
 
 	strbuf_init(&sb, 1000);
 	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
@@ -964,11 +993,18 @@ static void read_revisions_from_stdin(struct rev_info *revs)
 			sb.buf[--len] = '\0';
 		if (!len)
 			break;
-		if (sb.buf[0] == '-')
+		if (sb.buf[0] == '-') {
+			if (len == 2 && sb.buf[1] == '-') {
+				seen_dashdash = 1;
+				break;
+			}
 			die("options not supported in --stdin mode");
+		}
 		if (handle_revision_arg(sb.buf, revs, 0, 1))
 			die("bad revision '%s'", sb.buf);
 	}
+	if (seen_dashdash)
+		read_pathspec_from_stdin(revs, &sb, prune);
 	strbuf_release(&sb);
 }
 
@@ -1220,6 +1256,34 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+static void append_prune_data(const char ***prune_data, const char **av)
+{
+	const char **prune = *prune_data;
+	int prune_nr;
+	int prune_alloc;
+
+	if (!prune) {
+		*prune_data = av;
+		return;
+	}
+
+	/* count existing ones */
+	for (prune_nr = 0; prune[prune_nr]; prune_nr++)
+		;
+	prune_alloc = prune_nr; /* not really, but we do not know */
+
+	while (*av) {
+		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
+		prune[prune_nr++] = *av;
+		av++;
+	}
+	if (prune) {
+		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
+		prune[prune_nr] = NULL;
+	}
+	*prune_data = prune;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -1294,7 +1358,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				}
 				if (read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs);
+				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
 
@@ -1322,7 +1386,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j]);
 
-			prune_data = argv + i;
+			append_prune_data(&prune_data, argv + i);
 			break;
 		}
 	}
-- 
1.6.5.3.342.g14bb9
