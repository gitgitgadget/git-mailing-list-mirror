From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] parse_date_basic(): return early when given a bogus timestamp
Date: Wed, 15 Apr 2015 09:21:45 -0700
Message-ID: <xmqqa8y9mkfa.fsf_-_@gitster.dls.corp.google.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	<xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
	<20150415072223.GA1389@flurp.local>
	<xmqqk2xdmp0e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:22:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQ4c-0004Xj-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbbDOQVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:21:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756336AbbDOQVs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:21:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB46E47260;
	Wed, 15 Apr 2015 12:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DL2Y0Dt2G2iqb3WIyfzGG6L04tw=; b=Eo4zAl
	PBWDHyjHnBE00zWqj5Jj2PVlOcUwVwlUPK2BHEIjRo1Gr/U2RtjxvnrwYx26m8mC
	yl4+l5L+B3uDHL3ANfesFTbAiwc2uVFP+K/rJmSoKCCR4xKNPNCtuapEoc/96OBG
	c0TxmYL3iAiZbLNTcMoCQwq8ONMFCsR95Y9Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S4UKwGk+SjcJXST9b3/wbJuKchb3ALAJ
	S49fvzILmTGwP1BOSAKnVHDpdF0NGf9r2xQEu2CjjQLC1zXQQnm53fYzEAUebEAY
	Yyz+vit/X4vJklO/f0p6YGtJeHQLnQuMLrCHJG1Dy4vJaKPaBmuiXeTTMgUk0WYz
	Thf16l5PfLk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E492E4725F;
	Wed, 15 Apr 2015 12:21:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B9974725A;
	Wed, 15 Apr 2015 12:21:46 -0400 (EDT)
In-Reply-To: <xmqqk2xdmp0e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Apr 2015 07:42:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 834A5A32-E38B-11E4-848C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267210>

When the input does not have GMT timezone offset, the code computes
it by computing the local and GMT time for the given timestamp. But
there is no point doing so if the given timestamp is known to be a
bogus one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A simple preliminary clean-up while we are in the vicinity.  We
   may want to use time_t throughout the codepath and turn it into
   ulong at the very last, but that would be a separate topic.

 date.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 782de95..01fd73f 100644
--- a/date.c
+++ b/date.c
@@ -696,6 +696,9 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 
 	/* mktime uses local timezone */
 	*timestamp = tm_to_time_t(&tm);
+	if (*timestamp == -1)
+		return -1;
+
 	if (*offset == -1) {
 		time_t temp_time = mktime(&tm);
 		if ((time_t)*timestamp > temp_time) {
@@ -705,8 +708,6 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 		}
 	}
 
-	if (*timestamp == -1)
-		return -1;
 
 	if (!tm_gmt)
 		*timestamp -= *offset * 60;
-- 
2.4.0-rc2-165-g862640d
