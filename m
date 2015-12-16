From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/17] revision: read --stdin with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:08 -0800
Message-ID: <1450303398-25900-8-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAb-0000pX-5i
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967045AbbLPWDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965979AbbLPWDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D457325C6;
	Wed, 16 Dec 2015 17:03:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aBKp
	7A/pOckATjdWEJIr2cP0jqw=; b=hGjiemDOkhiazYA+v+rJf90UGvHt/PNP/adU
	LVxjJ1Fc4ow7spVzFoQ7Gi/LyAcgdTE4p5F7iZUtdlIpH8w0R8wNWYMahxXG04s+
	JGmmRBzu7iwBI6iNAFjcqaMtvpf+Mpr1B53c0I8/A4Z+rI+IADT+aCNHD2zIuuZV
	ljZ5yn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=h4sGl1
	v6GCsjW70kCaQM//W0NHruU6u4d5Jl2rb1s7rJ1XRt8fFCg4QEfAcPW8C6ts9+T6
	NTy5IQfyKk4aGlLrvBHXNB9zUWgCJFNUC28/DbrMuteEyUDMUAh408e8Qo9Fj4fO
	Lf51ISu/5QzLtsqT0o1GTRZA0AwoyGdTTAam8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44D9F325C5;
	Wed, 16 Dec 2015 17:03:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B80A6325C4;
	Wed, 16 Dec 2015 17:03:30 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D7A81AB2-A440-11E5-B095-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282600>

Reading with getwholeline() and manually stripping the terminating
'\n' would leave CR at the end of the line if the input comes from
a DOS editor.

Contrasting this with the previous few changes, one may realize that
the way "log" family of commands read the paths with --stdin looks
inconsistent and sloppy.  It does not allow us to C-quote a textual
input, and it does not accept NUL-terminated records.  These are
unfortunately way too late to fix X-<.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 2236463..651a34b 100644
--- a/revision.c
+++ b/revision.c
@@ -1641,10 +1641,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
 static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 				     struct cmdline_pathspec *prune)
 {
-	while (strbuf_getwholeline(sb, stdin, '\n') != EOF) {
-		int len = sb->len;
-		if (len && sb->buf[len - 1] == '\n')
-			sb->buf[--len] = '\0';
+	while (strbuf_getline_crlf(sb, stdin) != EOF) {
 		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
@@ -1661,10 +1658,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
-	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+	while (strbuf_getline_crlf(&sb, stdin) != EOF) {
 		int len = sb.len;
-		if (len && sb.buf[len - 1] == '\n')
-			sb.buf[--len] = '\0';
 		if (!len)
 			break;
 		if (sb.buf[0] == '-') {
-- 
2.7.0-rc1-83-ga8b6b9e
