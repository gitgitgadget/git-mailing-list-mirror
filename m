From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/17] revision: read --stdin with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:51 -0700
Message-ID: <1446071161-15610-8-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZHm-0000NQ-59
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbbJ1Wde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:34 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754095AbbJ1Wd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A66DB26A2E;
	Wed, 28 Oct 2015 18:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8B3G
	4WyWzbzuuAb2r5jOyifNIv8=; b=tzqsF2H1mvPLgk6zSGffBy1yQu0uPOSAA8/v
	DmnDsd27S2wTVUOML1GLwsuTyV08W85ABDk0UtoaAK0dixzQkxwiSiABpEkUmfAN
	y2pNuK0BJd+6Pn5WVnaYxLQ9InhmAzJk7dvtFrecNH+bM4YxYkmcjWAN4RhfEGrE
	32ztyLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NhdEAu
	yeEJudt6ANCyzBm75hps7b2ry8CqAhm4iUbk4Bjyt/vNdtGJmdLTj33fLT8kA0x1
	z6WbSaVH3bZnNlLUQ1WHgzSj4dVhwVCDRvY5RhXRv3Qpg/167JSinV3GRVpd79p1
	4mBhI08DmJqajds6czzP188D/ChZOqP2qOg6o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E28126A2D;
	Wed, 28 Oct 2015 18:26:13 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29BDF26A2C;
	Wed, 28 Oct 2015 18:26:13 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E57A9A92-7DC2-11E5-8C9A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280402>

Reading with getwholeline() and manually stripping the terminating
'\n' would leave CR at the end of the line if the input comes from
a DOS editor.

Constrasting this with the previous few changes, one may realize
that the way "log" family of commands read the paths with --stdin
looks inconsistent and sloppy.  It does not allow us to C-quote a
textual input, and it does not accept NUL-terminated records.  These
are unfortunately way too late to fix X-<.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 2236463..7d100d8 100644
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
+	while (strbuf_gets(sb, stdin) != EOF) {
 		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
@@ -1661,10 +1658,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
-	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+	while (strbuf_gets(&sb, stdin) != EOF) {
 		int len = sb.len;
-		if (len && sb.buf[len - 1] == '\n')
-			sb.buf[--len] = '\0';
 		if (!len)
 			break;
 		if (sb.buf[0] == '-') {
-- 
2.6.2-423-g5314b62
