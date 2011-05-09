From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] convert: make it safer to add conversion attributes
Date: Mon,  9 May 2011 15:05:00 -0700
Message-ID: <1304978701-19310-4-git-send-email-gitster@pobox.com>
References: <20110508101925.GA19525@do>
 <1304978701-19310-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYaI-0005q9-T2
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab1EIWF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:05:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab1EIWFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7C9F4792;
	Mon,  9 May 2011 18:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=emzJ
	uUM644LQduMccpMLv38KcQ8=; b=v72OI1Uf8LHO+1Fna7jYwv1p9mySaA2Gr7oc
	c73wmatiNMKifWBWtmUOEGC3H0RnM0uVRg39YHS2alwH2HMh69OPGX33imrdCjsf
	GmHLSt/NCr43H5FQHgFMxtvU7FnH6Zi7S3R28Qxvvrv0rToXlm7CGcwpQ64quUDQ
	KQeIuYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Iey4zVCri/xjKn9V2WkIYwuEfkzCI9HUgBMi7JLnMDw2lwR+V0XU9y+TwUdQnlLG
	kDVqR/LHZgeidOruUEYUNNVW665qdZv0ebKIPClpgpC1iqvLNYzMY60x8kxVyjax
	j3Slaa7Zlpe7/iayChZ6gL1NlPeaUdvdT/MvgC3nVgU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C50AD4791;
	Mon,  9 May 2011 18:07:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F20C64790; Mon,  9 May 2011
 18:07:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.288.g93ebc
In-Reply-To: <1304978701-19310-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B682BD92-7A88-11E0-8264-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173267>

The places that need to pass an array of "struct git_attr_check" needed to
be careful to pass a large enough array and know what index each element
lied.  Make it safer and easier to code these.

Besides, the hard-coded sequence of initializing various attributes was
too ugly after we gained more than a few attributes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c |   48 ++++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/convert.c b/convert.c
index e0ee245..a05820b 100644
--- a/convert.c
+++ b/convert.c
@@ -475,30 +475,6 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void setup_convert_check(struct git_attr_check *check)
-{
-	static struct git_attr *attr_text;
-	static struct git_attr *attr_crlf;
-	static struct git_attr *attr_eol;
-	static struct git_attr *attr_ident;
-	static struct git_attr *attr_filter;
-
-	if (!attr_text) {
-		attr_text = git_attr("text");
-		attr_crlf = git_attr("crlf");
-		attr_eol = git_attr("eol");
-		attr_ident = git_attr("ident");
-		attr_filter = git_attr("filter");
-		user_convert_tail = &user_convert;
-		git_config(read_convert_config, NULL);
-	}
-	check[0].attr = attr_crlf;
-	check[1].attr = attr_ident;
-	check[2].attr = attr_filter;
-	check[3].attr = attr_eol;
-	check[4].attr = attr_text;
-}
-
 static int count_ident(const char *cp, unsigned long size)
 {
 	/*
@@ -727,10 +703,30 @@ static enum crlf_action input_crlf_action(enum crlf_action text_attr, enum eol e
 	return text_attr;
 }
 
+static const char *conv_attr_name[] = {
+	"crlf", "ident", "filter", "eol", "text",
+};
+#define NUM_CONV_ATTRS ARRAY_SIZE(conv_attr_name)
+
+static void setup_convert_check(struct git_attr_check *check)
+{
+	int i;
+	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
+
+	if (!ccheck[0].attr) {
+		for (i = 0; i < NUM_CONV_ATTRS; i++)
+			ccheck[i].attr = git_attr(conv_attr_name[i]);
+		user_convert_tail = &user_convert;
+		git_config(read_convert_config, NULL);
+	}
+	for (i = 0; i < NUM_CONV_ATTRS; i++)
+		check[i].attr = ccheck[i].attr;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
-	struct git_attr_check check[5];
+	struct git_attr_check check[NUM_CONV_ATTRS];
 	enum crlf_action crlf_action = CRLF_GUESS;
 	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
@@ -767,7 +763,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
 {
-	struct git_attr_check check[5];
+	struct git_attr_check check[NUM_CONV_ATTRS];
 	enum crlf_action crlf_action = CRLF_GUESS;
 	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
-- 
1.7.5.1.288.g93ebc
