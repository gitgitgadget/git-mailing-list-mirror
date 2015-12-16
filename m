From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/17] check-attr, check-ignore, checkout-index: read paths with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:03 -0800
Message-ID: <1450303398-25900-3-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAS-0000Zx-61
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965855AbbLPWDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755465AbbLPWDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B387325B3;
	Wed, 16 Dec 2015 17:03:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yBGh
	t43riUvyN1BjtcH/nGn6smw=; b=wc31AoioTmDUZzbs52pJKWaAMB4YK8rMUDc1
	qM3Ljyy9KypQwAqjJxNP2J34hCxgF2akNsUzZSd+9ftmftsX45CiFGiJI21uyLKY
	MR1sywS9QAtw18P0VOIlQrByBAvDdVLVn3QqZFW5DTvp9wvpdgdfmiUqUeYuNfBq
	5x8dDi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sTyVvf
	djFE8uBtpDw83ezCX6+IzKNDmRDbUTaApqGm6HZpZWSIOvS6GclubklRptAN3FDq
	v3pNi25DF+1OtOeoLkOrhJFEWbrL0ngzUYQvgTiB7k30H+uOKadMJ51pp2b8S62/
	ZAddV3Z/lu7a2QnmZ2+++lqHmJVjrLk7WOQWk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22B88325B2;
	Wed, 16 Dec 2015 17:03:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 93A59325B1;
	Wed, 16 Dec 2015 17:03:22 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D2CCA54E-A440-11E5-A999-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282598>

These commands read list of paths from their standard input under
the --stdin option (in order to avoid busting limit on the length of
the command line).

When they are using text input mode (i.e. line_termination is set to
'\n'), we should try to be more friendly to our DOSsy friends and
accept lines with CRLF endings.

It is tempting to lift this logic to strbuf_getline() and not
introduce a separate strbuf_getline_crlf(), but that can lead to silent
misconversion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-attr.c     | 4 +++-
 builtin/check-ignore.c   | 5 ++++-
 builtin/checkout-index.c | 4 +++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 265c9ba..4c44d8f 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -77,7 +77,9 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+	while ((line_termination
+		? strbuf_getline_crlf(&buf, stdin)
+		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 43f3617..862ced1 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -122,7 +122,10 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+
+	while ((line_termination
+		? strbuf_getline_crlf(&buf, stdin)
+		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..27d65f2 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -258,7 +258,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		if (all)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		while ((line_termination
+			? strbuf_getline_crlf(&buf, stdin)
+			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
-- 
2.7.0-rc1-83-ga8b6b9e
