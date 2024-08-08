Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFD2A1D8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133134; cv=none; b=FjkUMpgDeYZehRV6PRNWhvGDZcYSxqcobnyLT1qWxMaHc8j9VA3+ypv7W2oE+jcZSiLfIiGqT9SBXy6rOFNaKwiYuEZttmjyKA6fpKBcMq5TWseoAtcIruMcM6sZm2BFOIZSSRuP8KhenOhguqeV+QzbNL89miNmRSW0WnTKtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133134; c=relaxed/simple;
	bh=fSw3tNSTNXAWUJDPoWDIBlqlDIdbXVt/+3OOqTECWMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GUKkz0cTEqDSUkI1nKEBKHN5D38KFZHXPNV5sAtLEhxPglusry2JURfx1K03YpIlA+O8MMqWa6jJkjnOUgXtqPArud2qcO3Jvul0tSqoEmGKz3iWO1p2ZoCOoLfyvhwCeD2Jc7HI3wA6K+9Cl4LwmaCAKth17/Wa29U2kG1tn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TCLFL7jY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TCLFL7jY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D1342FDEB;
	Thu,  8 Aug 2024 12:05:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fSw3tNSTNXAWUJDPoWDIBlqlDIdbXVt/+3OOqT
	ECWMY=; b=TCLFL7jYLO0DxhaclQxryPwfhYvspLhZ0XOD5uFBaPNE3FYxXWDZ/P
	k3HvIasz1qyVjfwUpTP8uDQ+uv8RqkVsmMIyOqD9rCiQzzzus1GVSS/mpHZNRYIo
	Pen4AcpZjZoQeYtZNCyAy8T11hspCGPgRc41ppzolGP10wfKorKic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35EE82FDEA;
	Thu,  8 Aug 2024 12:05:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F5CB2FDE9;
	Thu,  8 Aug 2024 12:05:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re: [PATCH 19/22] userdiff: fix leaking memory for configured diff
 drivers
In-Reply-To: <ZrRSDaCClfh9dMZK@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Aug 2024 07:05:17 +0200")
References: <cover.1722933642.git.ps@pks.im>
	<ef780aa36039560fd069ec97ce87665eb0775200.1722933643.git.ps@pks.im>
	<D39KL8N6S0HC.HFB9VRAVWYOX@jamesliu.io> <ZrRSDaCClfh9dMZK@tanuki>
Date: Thu, 08 Aug 2024 09:05:28 -0700
Message-ID: <xmqqwmkrj8zb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08738086-55A0-11EF-8C76-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > -	if (git_config_string((char **) &f->pattern, k, v) < 0)
>> > +	f->pattern = NULL;
>> > +	FREE_AND_NULL(f->pattern_owned);
>> > +	if (git_config_string(&f->pattern_owned, k, v) < 0)
>> >  		return -1;
>> > +	f->pattern = f->pattern_owned;
>> >  	f->cflags = cflags;
>> >  	return 0;
>> >  }
>
> Yup. We have a bunch of statically defined userdiff drivers, all of
> which use string constants as patterns. We thus cannot reliably free
> those and instead have to track the allocated strings in a separate
> variable.

In other words, this is the usual "foo is the variable to be used,
and it may point at foo_to_free, when the value is an allocated
string" pattern.  I doubt .pattern_to_free is a better name even in
the name of consistency---foo_to_free is certainly much better than
foo_owned as a name for a temporary variable in a small scope, but a
structure member is a much longer validity and I am OK if we decide
to adopt the convention to call a structure member .foo_owned when
it is used in this manner.

Thanks.

