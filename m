From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] rev-list: fix finish_object() call
Date: Wed, 17 Aug 2011 14:30:33 -0700
Message-ID: <1313616635-25331-2-git-send-email-gitster@pobox.com>
References: <1313616635-25331-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 23:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtnhP-00080u-5U
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab1HQVan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 17:30:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab1HQVak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 17:30:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EB63B12
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=S5iz
	Tyfb2MaVYhSLitBbK8lpjl8=; b=e/lGXqsm4CBlQwOgZDVMUset25uln4uMJcyS
	mDyxmZ1mmO7JDk5sDhFrbl47GoVOz+xCwaB9/I9+NTmHo3lKaS/2acB3oY8XyllV
	UtEyOH5V1CNtFhYbBg09BSwrY+6n1p/B+U2v+nCwsVy9ZAV+G/5j9uNz3lEz8KXg
	WI0gzLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cKzc6U
	q4udWSnMGDVRf4SuUTKBzaT+Tw1DlaFrcDc+d0WbGdPxck3iCDql7ZNTlNiYTCgY
	OVbXZvZDWK19L22A2uSB6phz9hsURFyFzvq1Tlr6pLwIqXYwMza+NTQyLuEA3BpT
	e8xIJW5R2dIBK3hlCgB5cxXseyaGpS4CFiDzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 786F03B11
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C5833B10 for
 <git@vger.kernel.org>; Wed, 17 Aug 2011 17:30:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.472.g4bfe7c
In-Reply-To: <1313616635-25331-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 26ED3D90-C918-11E0-BB66-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179539>

The callback to traverse_commit_list() are to take linked name_path and
a string for the last path component.

If the callee used its parameters, it would have seen duplicated leading
paths. In this particular case, the callee does not use this argument but
that is not a reason to leave the call broken.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 56727e8..d789279 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -182,7 +182,7 @@ static void show_object(struct object *obj, const struct name_path *path, const
 	 */
 	const char *ep = strchr(name, '\n');
 
-	finish_object(obj, path, name);
+	finish_object(obj, path, component);
 	if (ep) {
 		printf("%s %.*s\n", sha1_to_hex(obj->sha1),
 		       (int) (ep - name),
-- 
1.7.6.472.g4bfe7c
