From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/3] fetch: Only call a new ref a "branch" if it's
 under refs/heads/.
Date: Tue, 17 Apr 2012 08:28:34 -0700
Message-ID: <7v7gxepecd.fsf@alter.siamese.dyndns.org>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
 <7vbomqpef1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Tue Apr 17 17:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKAKg-0008TD-77
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 17:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab2DQP2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 11:28:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab2DQP2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 11:28:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B4A5080;
	Tue, 17 Apr 2012 11:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUeDBCRbG5B0N17ZIHuDbHPBtdE=; b=yFR1LX
	k6LPanq9L2JM96mZ1bUzDfY384yGxbmLVk6zbierr6MRgrYDSk+N0AlHs/h+fdOs
	Uj6d3JO60AsmICUqIIdrDV+WXCWyoXqVT9Zw40kWKTmiZCEq7xASd8okxx3bR3MU
	VfIv9Uc4wJLkdXgJjyBrZiWY2sYUbcCN7lfc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1r2vB6Yt2Ie1TNKVnwsfsP467RP6G/b
	+X2D5ocGu3Cy4ZKAsZmjfouVGxUzcA6xPkxbOR+3LR5+H43wviQu99ZX4+G6DgVr
	5XpBIl5X8+Sa1H5gg757rbBFgbe2tHGSm4qjXYDIqihTbQbH/ysWqZz3/Gj5HG3q
	cm2cPRGKGvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77666507F;
	Tue, 17 Apr 2012 11:28:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E23545075; Tue, 17 Apr 2012
 11:28:35 -0400 (EDT)
In-Reply-To: <7vbomqpef1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 17 Apr 2012 08:26:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFBAD968-88A1-11E1-9A40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195764>

From: Marc Branchaud <marcnarc@xiplink.com>
Date: Mon, 16 Apr 2012 18:08:50 -0400
Subject: [PATCH 2/2] fetch: describe new refs based on where it came from

update_local_ref() used to say "[new branch]" when we stored a new ref
outside refs/tags/ hierarchy, but the message is more about what we
fetched, so use the refname at the origin to make that decision.

Also, only call a new ref a "branch" if it's under refs/heads/.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is a re-roll of yours on top of the updated 1/2; I also
   fixed the new test here and there.

 builtin/fetch.c  |   14 +++++++++++---
 t/t5510-fetch.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 06d71e4..0f80cf8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -294,16 +294,24 @@ static int update_local_ref(struct ref *ref,
 		const char *msg;
 		const char *what;
 		int r;
-		if (!strncmp(ref->name, "refs/tags/", 10)) {
+		/*
+		 * Nicely describe the new ref we're fetching.
+		 * Base this on the remote's ref name, as it's
+		 * more likely to follow a standard layout.
+		 */
+		const char *name = remote_ref ? remote_ref->name : "";
+		if (!prefixcmp(name, "refs/tags/")) {
 			msg = "storing tag";
 			what = _("[new tag]");
-		}
-		else {
+		} else if (!prefixcmp(name, "refs/heads/")) {
 			msg = "storing head";
 			what = _("[new branch]");
 			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 			    (recurse_submodules != RECURSE_SUBMODULES_ON))
 				check_for_new_submodule_commits(ref->new_sha1);
+		} else {
+			msg = "storing ref";
+			what = _("[new ref]");
 		}
 
 		r = s_update_ref(msg, ref, 0);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 308c02e..d7a19a1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -162,6 +162,36 @@ test_expect_success 'fetch following tags' '
 
 '
 
+test_expect_success 'fetch uses remote ref names to describe new refs' '
+	cd "$D" &&
+	git init descriptive &&
+	(
+		cd descriptive &&
+		git config remote.o.url .. &&
+		git config remote.o.fetch "refs/heads/*:refs/crazyheads/*" &&
+		git config --add remote.o.fetch "refs/others/*:refs/heads/*" &&
+		git fetch o
+	) &&
+	git tag -a -m "Descriptive tag" descriptive-tag &&
+	git branch descriptive-branch &&
+	git checkout descriptive-branch &&
+	echo "Nuts" >crazy &&
+	git add crazy &&
+	git commit -a -m "descriptive commit" &&
+	git update-ref refs/others/crazy HEAD &&
+	(
+		cd descriptive &&
+		git fetch o 2>actual &&
+		grep " -> refs/crazyheads/descriptive-branch$" actual |
+		test_i18ngrep "new branch" &&
+		grep " -> descriptive-tag$" actual |
+		test_i18ngrep "new tag" &&
+		grep " -> crazy$" actual |
+		test_i18ngrep "new ref"
+	) &&
+	git checkout master
+'
+
 test_expect_success 'fetch must not resolve short tag name' '
 
 	cd "$D" &&
-- 
1.7.10.332.g1863c
