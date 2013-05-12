From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5551: do not use unportable sed '\+'
Date: Sun, 12 May 2013 15:50:59 -0700
Message-ID: <7vr4hbu818.fsf_-_@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
	<7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
	<7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de>
	<7v8v3lwa5p.fsf@alter.siamese.dyndns.org> <518EAB7C.3010508@web.de>
	<7vsj1svqi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 13 00:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubf6i-00017a-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 00:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab3ELWvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 18:51:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab3ELWvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 18:51:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 390CE1EAEA;
	Sun, 12 May 2013 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xy7Rs4n9gghXMcBPDmhOJy/Q6+c=; b=Jq3Ylv
	10C+9ALAo5bQtAue6WfZ0NxECRoVLNPZ1rF/6p2pui3E1Qk40C1vgoV4zRIKDAWs
	1tUv3eZ5uylZB9jYPB2yVyvWojH3rGsZms32XRJQQ3/m1EWjgX7PBmxeJdnzlZAk
	QD6yiBDfDmbqrYiieFV3AP1PIj2GPS1EQwZoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMUN0dxGsGWjuGzHQ9HAQ83iyCPKOehb
	3t68MC0QZktpbRdLJIa0Bh+DwBecZdhBN/yj3LCHlOKazRLcbhzZDmzN1Hs+H30h
	5Qky29wnJTpZ5VWAXg8bUz0a631mSgy8DSslOvPdvbH41OHNTPaaPOIQfYes9SG2
	dlR7/v/FX8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6F21EAE9;
	Sun, 12 May 2013 22:51:01 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DFB11EAE7;
	Sun, 12 May 2013 22:51:00 +0000 (UTC)
In-Reply-To: <7vsj1svqi7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 11 May 2013 20:14:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AAE6608-BB56-11E2-B2D0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224067>

The set-up step to prepare a repository with 50000 tags used a
non-porable '\+' to match one-or-more.

The error was not caught because the next test that uses that
repository did not even bother to check if these expected tags were
actually cloned to the resulting repository.

Fix the sed construct to use BRE and update the "clone" test that
wanted to test cloning from such a repository with many refs to
check the resulting repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 47eb769..fe6637b 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -184,13 +184,17 @@ test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 
 	# now assign tags to all the dangling commits we created above
 	tag=$("$PERL_PATH" -e "print \"bla\" x 30") &&
-	sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >>packed-refs
+	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
 	)
 '
 
 test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command line overflow' '
 	git clone $HTTPD_URL/smart/repo.git too-many-refs 2>err &&
-	test_line_count = 0 err
+	test_line_count = 0 err &&
+	(
+		cd too-many-refs &&
+		test $(git for-each-ref refs/tags | wc -l) = 50000
+	)
 '
 
 stop_httpd
-- 
1.8.3-rc1-278-g19c008b
