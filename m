From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fmt-merge-msg: plug small leak of commit buffer
Date: Wed, 15 Apr 2015 14:25:35 -0700
Message-ID: <xmqqegnljd80.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 23:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiUoZ-0001lt-DD
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 23:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbbDOVZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 17:25:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751455AbbDOVZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 17:25:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DCF848C93;
	Wed, 15 Apr 2015 17:25:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	upW3YXqrAd5uDizHNdc7wQaKBg=; b=uMfyU1plMfOaN2iy0A9rcphWslRAFDR3d
	PDU2vxz3QsKWn7HDJawfw/0CFvCB5Ecequ1yDDzRNxx6iz2IqPcnXguSpCrdKzdQ
	56QFo7P5G95nCBgQqJifl5g8MYhXsc/OpGbJ0RAp6/vGd8vpQXMJzZ57w3PDPSCa
	piJEsGWdVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=GuNzEZQNnbFKgdnStEsk2QR8lFo17k1O3cy43FXzwHgKVEgAdpJ7Mz3J
	F/VBC+HWsQDEqNiSTMZsCUEcmFY6x9yKweHHVPcUW+N4f/UQ1zMN6z+EUoEbQ0jD
	TGM8M++kqK7JAVKKuZhewG1HnbmI07u3dohVs/UfKghT6dwokAE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2716A48C92;
	Wed, 15 Apr 2015 17:25:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FF0C48C91;
	Wed, 15 Apr 2015 17:25:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4FBDB68-E3B5-11E4-A18C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267240>

A broken or badly formatted commit might not record author or
committer lines; the function record_person() returned after
calling get_commit_buffer() without calling unuse_commit_buffer()
on the memory, potentially leaking it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * to be applied on bc6b8fc1 (use get_commit_buffer everywhere,
   2014-06-10)

 builtin/fmt-merge-msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 01f6d59..076264d 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -238,8 +238,10 @@ static void record_person(int which, struct string_list *people,
 	field = (which == 'a') ? "\nauthor " : "\ncommitter ";
 	buffer = get_commit_buffer(commit);
 	name = strstr(buffer, field);
-	if (!name)
+	if (!name) {
+		unuse_commit_buffer(commit, buffer);
 		return;
+	}
 	name += strlen(field);
 	name_end = strchrnul(name, '<');
 	if (*name_end)
-- 
2.4.0-rc2-173-gefc434b
