From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http: clear POSTFIELDS when initializing a slot
Date: Tue, 26 Apr 2011 08:28:28 -0700
Message-ID: <7v39l5ghgj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 17:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEkBt-0002mm-83
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 17:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab1DZP2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 11:28:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab1DZP2f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 11:28:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F9A34314;
	Tue, 26 Apr 2011 11:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=i
	or5m6D4OfV2NFGzAOQgno/tQ/M=; b=HNrKRg3GMvAs1Fv/2tqPdLO4AdrrN8T54
	AtspM0c8sQepdwUvPrLnMaju8Wn2VLzpaZam6KpIu0pescocnn0l+76oWgICBMsK
	Amf3nX1dIw3cYhdxD0eFHwwS/uPoisLM/Y09xvN7+uiOd1g1Rvf+lFWp6uImXuN/
	fYpCusKjwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Qh2
	3wwvEk4vUPRks+1RXRDMy/r4WMgOUmzP9iC4nt1k8P6JZ9EB1uK0oeae0GE27qhM
	nFF0mpnIbqcmLd1pWuxHmuhwwkH61JwuOe2yMgLZ6osceMwXYBn6d57xDavSUM0Y
	W7xkR7+6cbIOgl/9ALB3o5/RkpTkA951ShTaSKfU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F099A4313;
	Tue, 26 Apr 2011 11:30:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 209B24312; Tue, 26 Apr 2011
 11:30:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2092A07C-701A-11E0-88F9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172101>

After posting a short request using CURLOPT_POSTFIELDS, if the slot
is reused for posting a large payload, the slot ends up having both
POSTFIELDS (which now points at a random garbage) and READFUNCTION,
in which case the curl library tries to use the stale POSTFIELDS.

Clear it as part of the general slot initialization in get_active_slot().

Heavylifting-by: Shawn Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This came up while Shawn was looking at the smart HTTP code again.  It
   makes me wonder why we do not use curl_easy_reset() in this function,
   though...

 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index ed6414a..b642eac 100644
--- a/http.c
+++ b/http.c
@@ -494,6 +494,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
-- 
1.7.5
