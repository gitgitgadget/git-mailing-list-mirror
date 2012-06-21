From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] sha1_name.c: teach get_short_sha1() a commit-only
 option
Date: Wed, 20 Jun 2012 23:35:31 -0700
Message-ID: <1340260532-11378-9-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:35:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shazm-0006l5-GZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252Ab2FUGfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741Ab2FUGft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB9F98B31
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=D1PI
	PJd6uNye8lHk199y3Cu0v3E=; b=vhAmE28iOXkwrZ0VcjW8JrImLC40SfQC51Cd
	RGyl1kfzJlIOhMyHGadiziQi5Ght5RaFcm8q4F6hv2Lm3gxrohW2KJED5iChP9zr
	Jrg/DST2aBzdcpG+wJfXLovr+R3wzOPiaAQHdrf1///d61SLXxRy3H2STE2JWv1e
	tczaE+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OMq5zp
	hx0afGFpP4xa8mLFJ27d+W1i91NkMfsB2c1BpOokLpebZMveEOftTdZzqfoZcUUS
	ZfT74eFTpnWFP2kJJE9jPpLpjSmpB5gFuRUTwFhADdz3Kmc+kHZHTJ1uEUXgA1wr
	rYL3ZgoU4qJySGnwkxiuWnQbCf33gWseSfVSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D358E8B30
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60D0C8B2F for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5672894E-BB6B-11E1-9A90-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200388>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 7cca7d9..58dbbe2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -219,6 +219,13 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 }
 
 #define GET_SHORT_QUIETLY 01
+#define GET_SHORT_COMMIT_ONLY 02
+
+static int disambiguate_commit_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return kind == OBJ_COMMIT;
+}
 
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
@@ -255,6 +262,9 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	prepare_alt_odb();
 
 	memset(&ds, 0, sizeof(ds));
+	if (flags & GET_SHORT_COMMIT_ONLY)
+		ds.fn = disambiguate_commit_only;
+
 	find_short_object_filename(len, hex_pfx, &ds);
 	find_short_packed_object(len, bin_pfx, &ds);
 	status = finish_object_disambiguation(&ds, sha1);
-- 
1.7.11.2.gd284367
