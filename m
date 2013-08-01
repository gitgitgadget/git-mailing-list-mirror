From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/6] t5540/5541: smart-http does not support "--force-with-lease"
Date: Thu, 01 Aug 2013 11:05:02 -0700
Message-ID: <7vk3k5s2wh.fsf@alter.siamese.dyndns.org>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 20:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4xFU-0007D0-1T
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 20:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3HASFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 14:05:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab3HASFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 14:05:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F84357FC;
	Thu,  1 Aug 2013 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z2zxEomVlW/9f/AmZL6RURJVADg=; b=Sqfc68
	YvtHEtOzxvhf6SM3mULdPudmATUxYDoW/o/vXEm8eyRLAok7P+pNvgUkGx1s0L/0
	iSXYZRgCUXeIStGZx92r+VQ5V8CTKZuC1WoLZ8/sKrSWT+BYRohpdhnzJchIE7RP
	S3MQKNwD+KY65rIsJtcZ8BYPPLLXSql86Nlj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v4ADHRu6U9A/CYjCmf7Cakp3AYZTIECf
	+9KPTe9jDq6WYyi//H8wD9S6HCNt+/x02sI+t99Hs5tP0SJGYhQgnhV3EEq6HuyG
	+YJ+Mz1w84runctM4VEABTAEVEpz9CbwwiNLk62Ph9SH6sv5YrION5katbYYw+NP
	c3FqMg2wsDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8729A357FA;
	Thu,  1 Aug 2013 18:05:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1707357F5;
	Thu,  1 Aug 2013 18:05:04 +0000 (UTC)
In-Reply-To: <1374561800-938-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 22 Jul 2013 23:43:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E47E0980-FAD4-11E2-BB4D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231496>

The push() method in remote-curl.c is not told and does not pass the
necessary information to underlying send-pack, so this extension
does not yet work.  Leave a note in the test suite.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is primarily to give a target for other people to shoot at;
   patches to allow us to flip this expect_failure to expect_success
   are very much welcomed ;-)

 t/lib-httpd.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 895b925..e2eca1f 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -167,6 +167,22 @@ test_http_push_nonff() {
 	test_expect_success 'non-fast-forward push shows help message' '
 		test_i18ngrep "Updates were rejected because" output
 	'
+
+	test_expect_failure 'force with lease aka cas' '
+		HEAD=$(	cd "$REMOTE_REPO" && git rev-parse --verify HEAD ) &&
+		test_when_finished '\''
+			(cd "$REMOTE_REPO" && git update-ref HEAD "$HEAD")
+		'\'' &&
+		(
+			cd "$LOCAL_REPO" &&
+			git push -v --force-with-lease=$BRANCH:$HEAD origin
+		) &&
+		git rev-parse --verify "$BRANCH" >expect &&
+		(
+			cd "$REMOTE_REPO" && git rev-parse --verify HEAD
+		) >actual &&
+		test_cmp expect actual
+	'
 }
 
 setup_askpass_helper() {
-- 
1.8.4-rc0-154-gc668397
