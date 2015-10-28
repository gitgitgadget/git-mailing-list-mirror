From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/17] check-attr, check-ignore, checkout-index: read paths with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:46 -0700
Message-ID: <1446071161-15610-3-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIb-0001AA-RL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbbJ1WeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:34:04 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754680AbbJ1Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6026526A13;
	Wed, 28 Oct 2015 18:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7cJu
	St6bqD/xzr8CndSdH/nyRT0=; b=mlLN2gAS2ZupvSexD1PW65yXe9e9jRmzpKpp
	MzasFHRsjs/NOWDPlzykeBLwlFccn9mz0Zae37CUQIFozZl0iiDL4CgMGXDDzi2h
	Pkr6bal5N817oDZts2bQJPPNTjzVb7uW9REj6s5wcFme1SonZrmgyePp4ZCQNedM
	hws8s8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LsOPVs
	OqM+Q6aeguuVuNT61ssWx/ORhf7WtCn2o5yusKv9wqtr69xt+Gr9y6l6U4CYudxF
	NwKzHmpv9Ludm2Ki026Rd9VWwFSKu/BJcyW7Y/SYKZ7jyd0Hd/TdWFuBP+0/gk3d
	IGsC/YadD+Ik6y0NH6+zSvHtOSLGal0eC2m30=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 596C326A12;
	Wed, 28 Oct 2015 18:26:06 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4BB426A11;
	Wed, 28 Oct 2015 18:26:05 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E120BF1C-7DC2-11E5-8A1D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280417>

These commands read list of paths from their standard input under
the --stdin option (in order to avoid busting limit on the length of
the command line).

When they are using text input mode (i.e. line_termination is set to
'\n'), we should try to be more friendly to our DOSsy friends and
accept lines with CRLF endings.

It is tempting to lift this logic to strbuf_getline() and not
introduce a separate strbuf_gets(), but that can lead to silent
misconversion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-attr.c     | 4 +++-
 builtin/check-ignore.c   | 5 ++++-
 builtin/checkout-index.c | 4 +++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 265c9ba..72d4bb6 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -77,7 +77,9 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+	while ((line_termination
+		? strbuf_gets(&buf, stdin)
+		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 43f3617..d36e9bf 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -122,7 +122,10 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+
+	while ((line_termination
+		? strbuf_gets(&buf, stdin)
+		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..8b6be57 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -258,7 +258,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		if (all)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		while ((line_termination
+			? strbuf_gets(&buf, stdin)
+			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
-- 
2.6.2-423-g5314b62
