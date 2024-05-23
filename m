Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CBB662
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507633; cv=none; b=BRDgILn3A15HwI8lucsWfnHnUDOTdIKEN8A5QzVzpxpX22yNJeul2sOU9XS+gkJg8KpAeWA18LLsr54fax2xM/rKRIfmXGaetO0InvYEMz9phumZvSyoBdke1O+chBy9Bn1eqksd2gbuUbkAspO0FEy85vDAqeFMMm1hXJCTPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507633; c=relaxed/simple;
	bh=5YzExLaMgo7lWjuhTfV7ge+IyOUoOa3L5naQfmKmNqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpjD+4Xs5bs1sI4SHZUH4BwNTEyjijZLN+0nIRUjPced8eM1woXO+wVmQvr+S2tSsUKRvjOp96OB8BoIsqYY/59uyDk7qvISOeCiNj24s7NHQLYvdgU1VED6pICsei33lv1XUmueRDIqH1h6CBu8VNRrr1SPqcNxcF6lUmpSZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Brcqvnn2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Brcqvnn2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 182EE23C31;
	Thu, 23 May 2024 19:40:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5YzExLaMgo7lWjuhTfV7ge+IyOUoOa3L5naQfm
	KmNqY=; b=Brcqvnn2IdUENyvtlPcJnsQ2JVbjQtOsfhEH7dLdmA9tXziG5rQ1gb
	Sra1CDJc/C1ffTnleaba2dExJ2ixtqO7Ge5xlJRn1h7mLLCtHXBfpDPFXnvcnh17
	gvQOX9ynbZyMRaUry5yoqRhnudGQrd8Tp9gjixXmqfe/k5LMu9xOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1092023C30;
	Thu, 23 May 2024 19:40:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E24423C2D;
	Thu, 23 May 2024 19:40:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
In-Reply-To: <xmqqpltcwnqm.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 May 2024 08:29:21 -0700")
References: <20240523042143.1220862-1-iwienand@redhat.com>
	<20240523043806.1223032-1-iwienand@redhat.com>
	<20240523043806.1223032-3-iwienand@redhat.com>
	<xmqqpltcwnqm.fsf@gitster.g>
Date: Thu, 23 May 2024 16:40:25 -0700
Message-ID: <xmqqttiop05y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D5662262-195D-11EF-83A7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +	git config alias.echo "!echo \$*" &&
>> +	env GIT_TRACE=1 git echo argument 2>output &&
>> +	cp output /tmp/output &&
>> +	test_grep "^trace: prepare_cmd: /bin/sh -c '\''echo \$\* \"\$@\"" output
>> +'
>
> This is probably too specific search string, ...

And of course, 'seen' no longer passes the test with this topic
merged when run with SHELL_PATH=/bin/dash for obvious reasons.

I've added the following band-aid to help 'seen' pass CI, but this
has to be fixed in the main patch by squashing it in.

Thanks.

--- >8 ---
Subject: [PATCH] fixup! run-command: show prepared command

Do not assume everybody sets SHELL_PATH to /bin/sh
---
 t/t0014-alias.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 75c8763a6c..0d42d2b454 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -48,7 +48,8 @@ test_expect_success 'tracing a shell alias with arguments shows full prepared co
 	git config alias.echo "!echo \$*" &&
 	env GIT_TRACE=1 git echo argument 2>output &&
 	cp output /tmp/output &&
-	test_grep "^trace: prepare_cmd: /bin/sh -c '\''echo \$\* \"\$@\"" output
+	# ".*" can be "sh", or SHELL_PATH (not always "/bin/sh")
+	test_grep "^trace: prepare_cmd: .* -c '\''echo \$\* \"\$@\"" output
 '
 
 test_done
-- 
2.45.1-246-gb9cfe4845c

