Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF041547D1
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183467; cv=none; b=f2gVVBd2a2wl0zJg2XgOzCVYOgrduD2pXwyo12eY4DoKbLSJBtZWdxLHtoY2LtXRkDnAZv9xYnvhbXcwl9AoqRijsu+qOvIxaQwGyBt4YKlFvC39seRWxckAsGgNrixgSZ3Zbi6rlpUy4rElVGshCjbSZCyv0A7q2wWRbGuGDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183467; c=relaxed/simple;
	bh=EE0m61vtZ7chULDmWE2438z9UsblMuof0MruLan5huM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uCWH8Fnz9LfktgfJ0fhfvBUaY7RoZueVTNMuyM7rKv8FPfACF5+awZ0TMIFe1M6yzyL6M2Au88hQarzT3wIlKQn3GOA+AOnV+paVBzAog1HQ6AgbAG6NGaKVx+ixRPqI1O07ALGgGPwBjcuz/RPvVtlBxjROmbuR80kRiBmFJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GZg1XTg1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZg1XTg1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 658542DEC6;
	Tue, 20 Aug 2024 15:51:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EE0m61vtZ7chULDmWE2438z9UsblMuof0MruLa
	n5huM=; b=GZg1XTg1cow6rx9xjqVp3j+SK4mPA1QsEQawfF3xKQkFTg2/MXT2i6
	CyDIq+4gw560NtdCdhtk6r8fLuG26G84dfgZ4xyBRotwBn1ak77sPYumkr23aVNj
	OsjLL+QBBPeCFkxSqIe6bDEfbQCiafvrtK+Kr4JtHH1yKZFwh3Uqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 536AD2DEC5;
	Tue, 20 Aug 2024 15:51:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC37E2DEC1;
	Tue, 20 Aug 2024 15:51:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/20] convert: fix leaks when resetting attributes
In-Reply-To: <ed0f01bf92c83fb7371326bd1a59933619de2c47.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:05 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<ed0f01bf92c83fb7371326bd1a59933619de2c47.1724159575.git.ps@pks.im>
Date: Tue, 20 Aug 2024 12:51:01 -0700
Message-ID: <xmqqikvv6kii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87DA7AF0-5F2D-11EF-A10B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When resetting parsed gitattributes, we free the list of convert drivers
> parsed from the config. We only free some of the drivers' fields though
> and thus have memory leaks.
>
> Fix this by freeing all allocated convert driver fields to plug these
> memory leaks.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

The helper has only one caller, which makes me wonder why we do not
have to call it more often.  If "git checkout" or "log -p" notice an
attribute file is updated, I wonder they should call it, for
example.  But of course this is completely out of scope of this
topic.

This has been leaking even before 9642479a (convert: fix leaking
config strings, 2024-08-01) straightened out the ownership rules of
the value obtained from git_config_string().

The fix makes sense.  Will queue.  Thanks.
