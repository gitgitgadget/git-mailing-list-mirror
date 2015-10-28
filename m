From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/17] clone/sha1_file: read info/alternates with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:55 -0700
Message-ID: <1446071161-15610-12-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZI5-0000ek-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbbJ1Wda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:30 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753696AbbJ1WdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 977FD26A3E;
	Wed, 28 Oct 2015 18:26:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=U9rC
	x3rMRwxFmpZhkXAHPjdM4XQ=; b=GSvGrFLzWiic12uZleP/i7RD0G50kAG3nm3u
	x6XWCKH/4GwpsF+H24gUv9hmT9SQBMM5iSlGeCeCY9Fun8ZbTVyw3KbxbAasx2Zl
	/W/qaNUP8Ght0IXgk20zE1EfRt1vnq3EFqeoumBz4hHm0z4vvzP4SOh1lpitIoiV
	kSNuHfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=S25BwB
	+vSzM84cBKR9hoNa9PRsM4/cOAR51aZnZyDnaZ0aqIAJh0NzRZuB89A1FYM05P5h
	gNUfWNDc8vKTQg4YWBK+Nc6FG54pkFuaS7FfXfJhodFng4XGu1aZkI1jLLWlM/cO
	mYPn2ItzyfHOJ2uHX0ebKYRfVI9naay7yR3vc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DFFD26A3D;
	Wed, 28 Oct 2015 18:26:19 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19FB326A3C;
	Wed, 28 Oct 2015 18:26:19 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E904AA0E-7DC2-11E5-9BFB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280405>

$GIT_OBJECT_DIRECTORY/info/alternates is a text file that can be
edited with a DOS editor.  We do not want to use the real path with
CR appeneded at the end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c | 2 +-
 sha1_file.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..3d2615c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -339,7 +339,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	FILE *in = fopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, in, '\n') != EOF) {
+	while (strbuf_gets(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
diff --git a/sha1_file.c b/sha1_file.c
index 50896ff..957178c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -395,7 +395,7 @@ void add_to_alternates_file(const char *reference)
 		struct strbuf line = STRBUF_INIT;
 		int found = 0;
 
-		while (strbuf_getline(&line, in, '\n') != EOF) {
+		while (strbuf_gets(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
 				found = 1;
 				break;
-- 
2.6.2-423-g5314b62
