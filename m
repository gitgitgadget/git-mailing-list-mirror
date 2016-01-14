From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 15/21] clone/sha1_file: read info/alternates with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:30 -0800
Message-ID: <1452815916-6447-16-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnP-0003To-KV
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbcANX7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932108AbcANX7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 246223CD92;
	Thu, 14 Jan 2016 18:59:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=P031
	EvC3A7tWk8Xmql0pZZ6z2Rg=; b=tiv7yLW7WKj/vuituqn4Ijp9UNMY7jhC+WoH
	rJJFhd+qKaeRxV2yuZtBD5TrEA7RYm/8FatnDlLPnXU3GtKxkiCGfjZzxqPu5Ene
	C8MJhNcGvqqA3a9tlB4r8bCHfI83xq93RpNhAmylnEoCkrOXg3toferNuZT45xrM
	2tLY0I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	SoDZ8dkxwhfgouPTw53YoAhN3Cq6jpGaxRK2plQz9KKMm3WlfyrZjr28QhKxlTyd
	QC7guD7ETmk1luyrJ2JGMcELnY3LovKBYH7Y4mdgWEwmbOB/e1pfqd4tiQaETGOI
	reGIZEz0xcF9bZWd0DknqeZDEg10Gk4aBwcZX7vrbAY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1999B3CD91;
	Thu, 14 Jan 2016 18:59:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94E473CD8E;
	Thu, 14 Jan 2016 18:59:02 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C9585576-BB1A-11E5-9877-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284115>

$GIT_OBJECT_DIRECTORY/info/alternates is a text file that can be
edited with a DOS editor.  We do not want to use the real path with
CR appeneded at the end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c | 2 +-
 sha1_file.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 29741f4..43b4c99 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -339,7 +339,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	FILE *in = fopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline_lf(&line, in) != EOF) {
+	while (strbuf_getline(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
diff --git a/sha1_file.c b/sha1_file.c
index 86b5e8c..aab1872 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -396,7 +396,7 @@ void add_to_alternates_file(const char *reference)
 		struct strbuf line = STRBUF_INIT;
 		int found = 0;
 
-		while (strbuf_getline_lf(&line, in) != EOF) {
+		while (strbuf_getline(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
 				found = 1;
 				break;
-- 
2.7.0-250-ge1b5ba3
