From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit: do not trigger bogus "has templated message
 edited" check
Date: Fri, 30 Mar 2012 12:45:18 -0700
Message-ID: <1333136719-12657-3-git-send-email-gitster@pobox.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
 <1333136719-12657-1-git-send-email-gitster@pobox.com>
Cc: Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhlR-0002lI-AM
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761265Ab2C3Tpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:45:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758382Ab2C3Tp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:45:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 699C03435;
	Fri, 30 Mar 2012 15:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8NV7
	m9rZ8SNxRmI9RpAZGTUZiO4=; b=uPQaUo/dleqBw1BIfT4aGjFxOyMChGVJMLHv
	uXPL1xtCYnHkRLbNfKkORSI1N3igzpaB0Pxj0f0AB2YX68E9V0iVy33s3pZkV3DL
	zAGi4PSQTwec28pDx+2BJaRTLids9T8TSFMmOZC83zAZZJ4Gs2DwDgMTnN1pOVNJ
	CfcHYwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZGxnklxEbu2/5sMwi78UzMQNcSoCcCM45v8ksqRiVn9rDkNe6IJfv53uSY96eRVK
	6dIRHyiPSeu67gQwyGuKs5EGLaFBaMl8/5DsdsRQDSaQ+PNbYkfmgap+H6B2aCyP
	6qqEA3+dHoh+pk/l9IRmhKFV1SqQkem63/Vy6mcCyis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6513434;
	Fri, 30 Mar 2012 15:45:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5C043431; Fri, 30 Mar 2012
 15:45:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc3.55.g06e99
In-Reply-To: <1333136719-12657-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E556CBB8-7AA0-11E1-BEA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194391>

When "-t template" and "-F msg" options are both given (or worse yet,
there is "commit.template" configuration but a message is given in some
other way), the documentation says that template is ignored.  However,
the "has the user edited the message?" check still used the contents of
the template file as the basis of the emptyness check.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c  |    2 ++
 t/t7501-commit.sh |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index eba1377..7141766 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1049,6 +1049,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of -c/-C/-F/--fixup can be used."));
 	if (message.len && f > 0)
 		die((_("Option -m cannot be combined with -c/-C/-F/--fixup.")));
+	if (f || message.len)
+		template_file = NULL;
 	if (edit_message)
 		use_message = edit_message;
 	if (amend && !use_message && !fixup_message)
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 45446b1..e59cc4e 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -81,7 +81,13 @@ test_expect_success 'empty commit message' '
 	test_must_fail git commit -F msg -a
 '
 
+test_expect_success 'template "emptyness" check does not kick in with -F' '
+	git checkout HEAD file && echo >>file && git add file &&
+	git commit -t file -F file
+'
+
 test_expect_success 'setup: commit message from file' '
+	git checkout HEAD file && echo >>file && git add file &&
 	echo this is the commit message, coming from a file >msg &&
 	git commit -F msg -a
 '
-- 
1.7.10.rc3.55.g06e99
