Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00B77F13
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547046; cv=none; b=WCfXBprrhrAkzpl3WabHlSi/q5G6VrIclLiiaLu1X4SH6nAETL7AbteeemwL2wdTWbJ6s7g06xw8GHJuvkW4SlS8/CWYagWYu6XvaCrfTKcRNS5b/fjE9JMB1mg5OSP95n4zQWvh0vNDJRQteX5WFvI6j5ieGO97I3tph/A+XSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547046; c=relaxed/simple;
	bh=t/ZGQtK96LP3sXDSB3aIG8wU64Ou90wSqObr8BMV8KA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XauesEBPrnS65VrhOZ8s1yn/eJzD9hgx7gBqSqovu7XzUFIW6Y6hEmmkPbz7bgVZzSKhcb8omY7xzZCwkqyhrd4tuxg8a4vCr5OAXqphSZPWaH6JnkfPXVk8RdWJ+Zk37sfTw6TQnCxYeZOCk52Q0oujn+hGXpj68yAuUsDRpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wgWdGL9N; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wgWdGL9N"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A8BD32CD9;
	Fri, 19 Apr 2024 13:17:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	/ZGQtK96LP3sXDSB3aIG8wU64Ou90wSqObr8BMV8KA=; b=wgWdGL9NLMSl0Lwa+
	8qE6dhjcoZxP5elygwTd4xmJk+8WqqZN+8+2nMYGrXy509RhkK49ADjazxOToblB
	r/UMvTT6MGlHpBWNTFSuKZeeY/mb5AThKinEeOp1pdu6JdZMNbqT/PNmUoQXpiE8
	ygwPRTTYrDurvXMTA4nwgCrfPA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8488A32CD8;
	Fri, 19 Apr 2024 13:17:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B71F32CD7;
	Fri, 19 Apr 2024 13:17:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [BUG?] "format-patch --range-diff=$commit HEAD^ HEAD" fails
Date: Fri, 19 Apr 2024 10:17:18 -0700
Message-ID: <xmqqbk65jmqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ADCB2188-FE70-11EE-A43F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Immediately after "git commit --amend" of a single commit,
this fails:

    $ git format-patch --range-diff=@{1} -v2 HEAD^ HEAD
    fatal: --range-diff requires --cover-letter or single patch

The intent is very clear.  I know it is a single-patch topic, and I
want to show what I changed with "commit --amend" as a reference to
the previous version.  These, on the other hand, that specify the
range of commits to be emitted correctly recognises that we are
talking about a single patch and does not fail.

    $ git format-patch --range-diff=@{1} -v2 HEAD^
    $ git format-patch --range-diff=@{1} -v2 -1

It seems to me that the traditional "format-patch <since> <until>"
notation, which is understood by everywhere else in format-patch, is
not correctly understood by the code for "--range-diff" to make this
complaint, to recognise that the given range has only a single commit.

