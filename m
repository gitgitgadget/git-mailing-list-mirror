From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 5/9] check-attr: there are only two line terminators
Date: Wed, 13 Jan 2016 19:03:05 -0800
Message-ID: <1452740590-16827-6-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYCH-0007cE-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbcANDDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752816AbcANDDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C1113C436;
	Wed, 13 Jan 2016 22:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GW9O
	i4J+zypductjbXxvhbX+TUs=; b=UTJq+Y2jL1UrNYnHPhpdlYAY0FmPg3vjgX4E
	wAr0UKMisEjTxavU4S0ur+R66kiWm418gWAMN22V4+ioSwmZHjtW+XN7JfxaMw5C
	LJoMHHi3FApl9oeEDSJaD3O0ieYkCjRmP1yMmz01dqfNMNbadS2dXBDGDXR1HFPc
	J2D+zis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	hW0JVHpRagkq43NF550KZbBedmNdAP79UxsBODpFs1T1x9ckg4yEPE870dAD4P2Q
	l/hz/YPL72dflM5Tl0k3BKPtxr7C15h16+4iZxARYZHaY9EWqg0rZAUkdQK9ipAW
	1r/Ycrl5ydYmYx3eiAmswDZ43hIvxuyuL9fRyoR4Eis=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54BFE3C435;
	Wed, 13 Jan 2016 22:03:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB11C3C432;
	Wed, 13 Jan 2016 22:03:19 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5D8CD682-BA6B-11E5-B500-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284006>

The program by default works on LF terminated lines, with an option
to use NUL terminated records.  Instead of using line_termination
that happens to take LF or NUL, use the value of nul_term_line and
switch between strbuf_getline_{lf,nul} based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-attr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 265c9ba..087325e 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -73,12 +73,13 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 	struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
-	int line_termination = nul_term_line ? 0 : '\n';
+	strbuf_getline_fn getline_fn;
 
+	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-		if (line_termination && buf.buf[0] == '"') {
+	while (getline_fn(&buf, stdin) != EOF) {
+		if (!nul_term_line && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
 				die("line is badly quoted");
-- 
2.7.0-242-gdd583c7
