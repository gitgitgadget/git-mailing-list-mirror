From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] add_excludes_from_file: clarify the bom skipping logic
Date: Thu, 16 Apr 2015 11:39:05 -0700
Message-ID: <1429209548-32297-2-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429209548-32297-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 20:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yioh7-0006wt-7K
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbbDPSjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:39:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754549AbbDPSjL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:39:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 281C84A382;
	Thu, 16 Apr 2015 14:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KOdb
	Yhqg6LNhFaDq3sZ2xggUvfM=; b=OnN7ZqFmMoevcxxCSHMymeiu7vJGydd8bo+E
	vIHV1VZX4bRhczEvKnQpf2PYoohtRSFmOkmms6fqp2RWsScnxpsXp0II1/8swj0E
	NmtMO2IWvq1gruLEVdvQhEOlGs8uF09AH64qUpXlT/RFhWq2XsqWtZhR8ZDAiZtg
	FEl1Q7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jQeKgz
	KGkHRjGIjGl3Sv39vK007UhTIwH/dUzCAO3qIVN+zqQTNIeAGb4DhCPYpJKOZaq5
	fimi81YxiPbY05tzITKbfZj1OpBIX+K6vqfGph8Xp7te+AUyj1XhVNUFJF0vz4jZ
	jzfcOjRjg/fQHtyCYEPmotp3mcst3BvJ2oomQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20DDE4A381;
	Thu, 16 Apr 2015 14:39:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 870764A380;
	Thu, 16 Apr 2015 14:39:10 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <1429209548-32297-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DF36EC34-E467-11E4-A603-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267324>

Even though the previous step shifts where the "entry" begins, we
still iterate over the original buf[], which may begin with the
UTF-8 BOM we are supposed to be skipping.  At the end of the first
line, the code grabs the contents of it starting at "entry", so
there is nothing wrong per-se, but the logic looks really confused.

Instead, move the buf pointer and shrink its size, to truly
pretend that UTF-8 BOM did not exist in the input.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 10c1f90..b5bb389 100644
--- a/dir.c
+++ b/dir.c
@@ -576,10 +576,11 @@ int add_excludes_from_file_to_list(const char *fname,
 
 	el->filebuf = buf;
 
-	if (size >= 3 && !memcmp(buf, utf8_bom, 3))
-		entry = buf + 3;
-	else
-		entry = buf;
+	if (size >= 3 && !memcmp(buf, utf8_bom, 3)) {
+		buf += 3;
+		size -= 3;
+	}
+	entry = buf;
 
 	for (i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
-- 
2.4.0-rc2-171-g98ddf7f
