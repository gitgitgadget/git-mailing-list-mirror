From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] am: plug small memory leak when split_mail_stgit_series() fails
Date: Wed, 11 May 2016 16:35:45 -0700
Message-ID: <20160511233546.13090-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:35:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0dfW-00026C-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbcEKXfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:35:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932113AbcEKXft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:35:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 854E21BE9B;
	Wed, 11 May 2016 19:35:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=0yG/TY0Ju+qey6t2GFnRCBarQgY
	=; b=BKK+4O+0vHW+jgv2ctnNZO6TLasTWDrtwrLiwf5qOhrGii7irHD86hByY/L
	PRvjW7B6qWlVp41D9wb7jlPDgvERrAzOucLrZCiNjn+FvwdK60GaKNg9Cc7yjH8e
	UhWdRijdDFf7lpU3H1FYh9dtuwJvUxIdTDS80k7xR9NGpw58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=VeLY/L8aWx8u27aQPVrXCqoGj2HnL
	fOcI5hR0VXfpU5vkU22NbbMDluKfbRYcQ1Sy3i7cgjEmofpmWOhGygvjQMpW9wF6
	7cjf926a8rRowKaAi/VtPKp4GqUEh2VnxO+hhZUIq2Kulx6dwefEnNw4q3kUOANb
	xT6L6OYNTV0ino=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C0331BE9A;
	Wed, 11 May 2016 19:35:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA7A91BE99;
	Wed, 11 May 2016 19:35:47 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-679-g91c6421
X-Pobox-Relay-ID: 16D0AE58-17D1-11E6-88F7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294376>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index ec75906..f1a84c6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -842,9 +842,11 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 	series_dir = dirname(series_dir_buf);
 
 	fp = fopen(*paths, "r");
-	if (!fp)
+	if (!fp) {
+		free(series_dir_buf);
 		return error(_("could not open '%s' for reading: %s"), *paths,
 				strerror(errno));
+	}
 
 	while (!strbuf_getline(&sb, fp, '\n')) {
 		if (*sb.buf == '#')
-- 
2.8.2-679-g91c6421
