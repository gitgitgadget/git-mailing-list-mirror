From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] wrap-for-bin: do not export an empty GIT_TEMPLATE_DIR
Date: Tue, 02 Mar 2010 17:11:10 -0800
Message-ID: <7vaauqmcpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Mar 03 02:11:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmd7h-00070P-4d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 02:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab0CCBLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 20:11:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0CCBLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 20:11:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C19F09ECD2;
	Tue,  2 Mar 2010 20:11:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=IEEC
	LDeujNiZ8gGlly6tBBMqifk=; b=pSfynQEJy81BZdGvVe54ajNX6WEWX1BXTcuW
	9ONABvCIyaCgGHuskoKoyJfT/34Fx69SZH/HMEQbK9eMDtgq3mt4Rav5PBBlK7JM
	8/bQ3mciQQvb8bAQcvKfMLvcH0da90fO7w3AmnECniaRCSxSPauLE2MP5R/JaFKE
	KfN4drU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	Yo/p5AFijzEvc/QnePQ3aYVwKUtnMWYZsZTE+h5GF4KD8bl8YjZHElvvj94tPOmn
	tDXuV8GmYyYbSkatvSTqPak6QwSEiugO/TjZIZfSl3ZKVlaeaOGJpQT30mzEzQi+
	G4f3q7ENOzJ7kqkGaEyFhgqBO7XZJsgK1PiFgFhQCFA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5749A9ECCE;
	Tue,  2 Mar 2010 20:11:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 759899ECCC; Tue,  2 Mar
 2010 20:11:11 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA2E76DE-2661-11DF-BF1D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141427>

With bash on some platforms (e.g. FreeBSD 8.0), exporting an unset
variable does not "unexport" it.  The called process gets an empty
string from getenv(3) instead of NULL.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrap-for-bin.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index aece782..09feb1f 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -7,10 +7,15 @@
 # @@BUILD_DIR@@ and @@PROG@@.
 
 GIT_EXEC_PATH='@@BUILD_DIR@@'
-test -z "$NO_SET_GIT_TEMPLATE_DIR" &&
+if test -n "$NO_SET_GIT_TEMPLATE_DIR"
+then
+	unset GIT_TEMPLATE_DIR
+else
 	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
+	export GIT_TEMPLATE_DIR
+fi
 GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
-export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB PATH
+export GIT_EXEC_PATH GITPERLLIB PATH
 
 exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-- 
1.7.0.1.288.gffe3c
