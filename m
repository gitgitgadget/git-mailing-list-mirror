From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 1/2] parse_date(): allow ancient git-timestamp
Date: Thu,  2 Feb 2012 13:41:42 -0800
Message-ID: <1328218903-5681-2-git-send-email-gitster@pobox.com>
References: <1328218903-5681-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 22:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt4Pi-0007Fx-B4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab2BBVlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 16:41:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536Ab2BBVls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 16:41:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 473886472;
	Thu,  2 Feb 2012 16:41:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NuCW
	+XPKDwwqAH3SUkJdBxPRLxA=; b=bnCFTUUHm8Vzx0GeUB2qkFkrNVh3M8x9DFOp
	exTFAfDzLzKteCOHtCEqywGuI+4meSDZt7+DyFG7S3sJtfedK67ociQWuj94HHgW
	e9MWTdZxZOxJ/3s0jCmOQo0g1fHrDKo6AemYIjOHI6fcUACH6UUd2oTxpJSPCQTM
	w/+YL54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Mv13w/
	XLssGN8Z1bHdCZDpuzlcN+1Q9mQWVqE+eQGQPT414dvsGdiw3RVqlGoqwk7NCoSl
	y9v2wO4X/uVqx00OxWIA0dxbc0K0pVbXk555994SxNitp5XBGu+oR5nUeYakXpk5
	YrejLIhpP6KT7XNNd6rP0fynmWtgsaSUvHIf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E1A96471;
	Thu,  2 Feb 2012 16:41:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DF30646F; Thu,  2 Feb 2012
 16:41:46 -0500 (EST)
X-Mailer: git-send-email 1.7.9.172.ge26ae
In-Reply-To: <1328218903-5681-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B49433DA-4DE6-11E1-B5F7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189712>

The date-time parser parses out a human-readble datestring piece by
piece, so that it could even parse a string in a rather strange
notation like 'noon november 11, 2005', but restricts itself from
parsing strings in "<seconds since epoch> <timezone>" format only
for reasonably new timestamps (like 1974 or newer) with 10 or more
digits. This is to prevent a string like "20100917" from getting
interpreted as seconds since epoch (we want to treat it as September
17, 2010 instead) while doing so.

The same codepath is used to read back the timestamp that we have
already recorded in the headers of commit and tag objects; because
of this, such a commit with timestamp "0 +0000" cannot be rebased or
amended very easily.

Teach parse_date() codepath to special case a string of the form
"<digits> +<4-digits>" to work this issue around, but require that
there is no other cruft around the string when parsing a timestamp
of this format for safety.

Note that this has a slight backward incompatibility implications.

If somebody writes "git commit --date='20100917 +0900'" and wants it
to mean a timestamp in September 2010 in Japan, this change will
break such a use case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/date.c b/date.c
index 896fbb4..c212946 100644
--- a/date.c
+++ b/date.c
@@ -585,6 +585,33 @@ static int date_string(unsigned long date, int offset, char *buf, int len)
 	return snprintf(buf, len, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
 }
 
+/*
+ * Parse a string like "0 +0000" as ancient timestamp near epoch, but
+ * only when it appears not as part of any other string.
+ */
+static int match_object_header_date(const char *date, unsigned long *timestamp, int *offset)
+{
+	char *end;
+	unsigned long stamp;
+	int ofs;
+
+	if (*date < '0' || '9' <= *date)
+		return -1;
+	stamp = strtoul(date, &end, 10);
+	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
+		return -1;
+	date = end + 2;
+	ofs = strtol(date, &end, 10);
+	if ((*end != '\0' && (*end != '\n')) || end != date + 4)
+		return -1;
+	ofs = (ofs / 100) * 60 + (ofs % 100);
+	if (date[-1] == '-')
+		ofs = -ofs;
+	*timestamp = stamp;
+	*offset = ofs;
+	return 0;
+}
+
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
 int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
@@ -610,6 +637,8 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	*offset = -1;
 	tm_gmt = 0;
 
+	if (!match_object_header_date(date, timestamp, offset))
+		return 0; /* success */
 	for (;;) {
 		int match = 0;
 		unsigned char c = *date;
-- 
1.7.9.172.ge26ae
