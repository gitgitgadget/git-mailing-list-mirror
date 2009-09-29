From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] fast-import.c::validate_raw_date(): really validate the
 value
Date: Mon, 28 Sep 2009 23:40:09 -0700
Message-ID: <1254206409-13256-2-git-send-email-gitster@pobox.com>
References: <1254206409-13256-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 08:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsWNu-0004DM-CZ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 08:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbZI2GkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 02:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbZI2GkL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 02:40:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbZI2GkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 02:40:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EF6C63987
	for <git@vger.kernel.org>; Tue, 29 Sep 2009 02:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/9j2
	T0FEKF/N9U6jHoYXFRnlMbQ=; b=sAKhM5dibLWay+ztiyjOiHhWH2KM0/oDE2gC
	kglEnRJ0PurudGxfPtQXZ3W9xmE4oSXN1/0qd7JNFHRSiheiywAi8VUjg3y5kssQ
	k0DBVc9yUWurd6GYpYtoeIpc33eTHys19atSbzVFuNWsF6fFJvI46h4Z+zmkztLd
	PUKcQ4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=glVodn
	D5KCzcY5mNQXhI7slKryJBVsUUal+mS41NzonbOB0RfSBS5AOq7SedEIwvHsYqu3
	2vACC6eN9r4W6Gcx60zlEEuzGVRCG8EMTY4mP9DbdpjgdoYG78xdwN4iT+dsgn0T
	CvmYGF94oR4z1KFzadspLqj+ouFyTVDK5l0E8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 453C163986
	for <git@vger.kernel.org>; Tue, 29 Sep 2009 02:40:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA41063985 for
 <git@vger.kernel.org>; Tue, 29 Sep 2009 02:40:12 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc2.53.g740c
In-Reply-To: <1254206409-13256-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F0DA7D30-ACC2-11DE-8FFF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129285>

When reading the "raw format" timestamp from the input stream, make sure
that the timezone offset is a reasonable value by imitating 7122f82
(date.c: improve guess between timezone offset and year., 2006-06-08).

We _might_ want to also check if the timestamp itself is reasonable, but
that is left for a separate commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fast-import.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..6faaaac 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1744,10 +1744,12 @@ static int validate_raw_date(const char *src, char *result, int maxlen)
 {
 	const char *orig_src = src;
 	char *endp;
+	unsigned long num;
 
 	errno = 0;
 
-	strtoul(src, &endp, 10);
+	num = strtoul(src, &endp, 10);
+	/* NEEDSWORK: perhaps check for reasonable values? */
 	if (errno || endp == src || *endp != ' ')
 		return -1;
 
@@ -1755,8 +1757,9 @@ static int validate_raw_date(const char *src, char *result, int maxlen)
 	if (*src != '-' && *src != '+')
 		return -1;
 
-	strtoul(src + 1, &endp, 10);
-	if (errno || endp == src || *endp || (endp - orig_src) >= maxlen)
+	num = strtoul(src + 1, &endp, 10);
+	if (errno || endp == src + 1 || *endp || (endp - orig_src) >= maxlen ||
+	    1400 < num)
 		return -1;
 
 	strcpy(result, orig_src);
-- 
1.6.3
