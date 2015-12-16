From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/17] clone/sha1_file: read info/alternates with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:12 -0800
Message-ID: <1450303398-25900-12-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAl-00014Y-2N
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967085AbbLPWDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966801AbbLPWDi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3271325D8;
	Wed, 16 Dec 2015 17:03:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BGqM
	gxSdDYk18wJdTbpttulV4ZU=; b=ps9uZqDmuRl+Se9sgJy0+RQEdXcKaUugO1SQ
	ZLht2quIxrBSrEkwijdQOXtVwuUks0bVJc2AjetI9QUaXo2W46eEuMWvGSxZ4Cqt
	1871aDRw1C6In7f7wCCj9wccJOgRuM3a3KXuk1vKtjPIqw80h7F7Se0qARAa/VSe
	Ox5/ITg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Bzbz3H
	NAwDNy4M/BeE7MVcj2TtBy72iP+PG8Uigit+8eAfmgUjp2ibPsYAyPWl9ySDj6D6
	5aReCn1BSqP0k7nK85cKab02p2kqoxorlERNN0diH0DLcCoikqiyDfjp/DcTSrXb
	NsCje1JLTj34Z6XTHrYkXNKAQj5wcY0YXt9Bs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9D40325D7;
	Wed, 16 Dec 2015 17:03:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69157325D4;
	Wed, 16 Dec 2015 17:03:37 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DBA2FC72-A440-11E5-A92F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282607>

$GIT_OBJECT_DIRECTORY/info/alternates is a text file that can be
edited with a DOS editor.  We do not want to use the real path with
CR appended at the end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c | 2 +-
 sha1_file.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..0a85243 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -339,7 +339,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	FILE *in = fopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, in, '\n') != EOF) {
+	while (strbuf_getline_crlf(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
diff --git a/sha1_file.c b/sha1_file.c
index 50896ff..7a748f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -395,7 +395,7 @@ void add_to_alternates_file(const char *reference)
 		struct strbuf line = STRBUF_INIT;
 		int found = 0;
 
-		while (strbuf_getline(&line, in, '\n') != EOF) {
+		while (strbuf_getline_crlf(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
 				found = 1;
 				break;
-- 
2.7.0-rc1-83-ga8b6b9e
