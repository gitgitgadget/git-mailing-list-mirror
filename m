From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/21] revision: read --stdin with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:26 -0800
Message-ID: <1452815916-6447-12-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 01:00:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJro4-00040V-4B
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbcANX7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932086AbcANX65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 823D93CD80;
	Thu, 14 Jan 2016 18:58:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=G2kY
	FNjSah3wLTnZB8w3NJmI4Tc=; b=k1AViROVAmuTEt1GUCA+RaL8Pynruyt2pDXh
	D/HxsrLV2m1bHQgViueyH+P82dgUV1jq8ABtFi7K7XSfh32DVk8qNj64qLmvgGyl
	dxiJ2KHPWJtxKEcZ/00h4Wg5VSsIZMYVtPgaj49wzIqOUKV2ndCIWKDKOFqf1LcL
	1aDOOtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	aeIw5JatOtX7qmZnP5frooidLnsST9lqlpxmBFRq9PzEgSgU++oDT4poekcugkxN
	9U4qAxgGvNYPdHnPn56ZSgBXVcIHMAbOaR58k0vx5EEdPYyeHt3rcOMfFJ7hB+Wo
	xFV+UuGS91eDbElPxC9J4979fUPrEQz9e6TtsJoY47s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 786B73CD7F;
	Thu, 14 Jan 2016 18:58:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDEA93CD7E;
	Thu, 14 Jan 2016 18:58:55 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C563EA98-BB1A-11E5-9E1E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284124>

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
index 0a282f5..8df4e11 100644
--- a/revision.c
+++ b/revision.c
@@ -1635,10 +1635,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
 static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 				     struct cmdline_pathspec *prune)
 {
-	while (strbuf_getwholeline(sb, stdin, '\n') != EOF) {
-		int len = sb->len;
-		if (len && sb->buf[len - 1] == '\n')
-			sb->buf[--len] = '\0';
+	while (strbuf_getline(sb, stdin) != EOF) {
 		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
@@ -1655,10 +1652,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
-	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+	while (strbuf_getline(&sb, stdin) != EOF) {
 		int len = sb.len;
-		if (len && sb.buf[len - 1] == '\n')
-			sb.buf[--len] = '\0';
 		if (!len)
 			break;
 		if (sb.buf[0] == '-') {
-- 
2.7.0-250-ge1b5ba3
