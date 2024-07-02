Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B21CCCBE
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950279; cv=none; b=kPe6j9ct8QPFgEjwZaZNWaR4ZL4q97Scxoytk9jvf0a9e+LgzSCJ86wvJmYi4p8ddp0zK1Ym3Z1oeZOkIkiJskd+h3lBs2nqjyiqFrLrj/3hRwxSgUc4p9yeOYKDGCrFzOGIQ5+pvO6u43aGmk+eDEfCF3NQzBntKjdsQC5Cebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950279; c=relaxed/simple;
	bh=LUED0HoyCkFl7BU8MTjT/lEKCeBFLcpFJbY65tlj6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gp2iPA6rzka5EX+ex1zzERNfBwfDvBCx657DBK+XN2lqcqJafsFpDwnQTXuRv4mA6vMV01CYfhv7meZt12RmLCTGyOcqqkSZYQAZc0J1OCiPASuJQAAxCuyFSBYppljpJNNZBDAkoay++46O/Xr08YpHE4IWjboB5wEMS6agj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BEtG2Ea0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BEtG2Ea0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CC67133041;
	Tue,  2 Jul 2024 15:57:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	UED0HoyCkFl7BU8MTjT/lEKCeBFLcpFJbY65tlj6NI=; b=BEtG2Ea01fUgVitIK
	oIs0LkKXYFeI3W9x67HbN8xMomDchPkF7qlNcbUhw/Z0xC0WcOuQ9x0JxiEifGOG
	OKqXhCY37vGavkpzBvUBTOsClp+Hor3FCZd+XRauydYlnibtn/S/EOod/Sq533LC
	eLPXxnq9+xfbZj5w8YKH6XYKPY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C62FB33040;
	Tue,  2 Jul 2024 15:57:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58ED23303D;
	Tue,  2 Jul 2024 15:57:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] push: avoid showing false negotiation errors
Date: Tue, 02 Jul 2024 12:57:47 -0700
Message-ID: <xmqqo77fr2h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BE1D840-38AD-11EF-A848-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

When "git push" is configured to use the push negotiation, a push of
deletion of a branch (without pushing anything else) may end up not
having anything to negotiate for the common ancestor discovery.

In such a case, we end up making an internal invocation of "git
fetch --negotiate-only" without any "--negotiate-tip" parameters
that stops the negotiate-only fetch from being run, which by itself
is not a bad thing (one fewer round-trip), but the end-user sees a
"fatal: --negotiate-only needs one or more --negotiation-tip=*"
message that the user cannot act upon.

Teach "git push" to notice the situation and omit performing the
negotiate-only fetch to begin with.  One fewer process spawned, one
fewer "alarming" message given the user.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c           | 13 +++++++++++--
 t/t5516-fetch-push.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git c/send-pack.c w/send-pack.c
index 713da582d7..fa2f5eec17 100644
--- c/send-pack.c
+++ w/send-pack.c
@@ -427,17 +427,26 @@ static void get_commons_through_negotiation(const char *url,
 	struct child_process child = CHILD_PROCESS_INIT;
 	const struct ref *ref;
 	int len = the_hash_algo->hexsz + 1; /* hash + NL */
+	int nr_negotiation_tip = 0;
 
 	child.git_cmd = 1;
 	child.no_stdin = 1;
 	child.out = -1;
 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!is_null_oid(&ref->new_oid))
-			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
+		if (!is_null_oid(&ref->new_oid)) {
+			strvec_pushf(&child.args, "--negotiation-tip=%s",
+				     oid_to_hex(&ref->new_oid));
+			nr_negotiation_tip++;
+		}
 	}
 	strvec_push(&child.args, url);
 
+	if (!nr_negotiation_tip) {
+		child_process_clear(&child);
+		return;
+	}
+
 	if (start_command(&child))
 		die(_("send-pack: unable to fork off fetch subprocess"));
 
diff --git c/t/t5516-fetch-push.sh w/t/t5516-fetch-push.sh
index 2e7c0e1648..a3f18404d9 100755
--- c/t/t5516-fetch-push.sh
+++ w/t/t5516-fetch-push.sh
@@ -230,6 +230,17 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
 	test_grep "push negotiation failed" err
 '
 
+test_expect_success 'push deletion with negotiation' '
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/heads/master &&
+	git ls-remote testrepo >ls-remote &&
+	git -c push.negotiate=1 push testrepo \
+		:master $the_first_commit:refs/heads/next 2>errors-2 &&
+	test_grep ! "negotiate-only needs one or " errors-2 &&
+	git -c push.negotiate=1 push testrepo :next 2>errors-1 &&
+	test_grep ! "negotiate-only needs one or " errors-1
+'
+
 test_expect_success 'push with negotiation does not attempt to fetch submodules' '
 	mk_empty submodule_upstream &&
 	test_commit -C submodule_upstream submodule_commit &&
