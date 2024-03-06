Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98592137923
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744229; cv=none; b=OfUXFX7oyF0GU9CraR1lI5Ejc+IlAB/5LTLqyBaW2ilPovRxv9jTjPM+CfmCwCxTC/3AuRTTRt9MzGiXx9I5Wjbs5j1IUHSrZLmSksG5REXrst3tnYFNlA5swxXoFoZ74QyzKwcs4bSnXr5rp5nLpT7LrI+p2GcwEuxFs/XFhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744229; c=relaxed/simple;
	bh=ZVF1+q8Ekgx962dYTWxEB+c1Vt1p2/xsTJ7a2e8Jho4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+JES72Vu9OIWXpsNd9HDT3WZMTp7gOMwpAf/63CnaNvxQv4M4UgiEzEA4lemG7PKsWCB97Tcdd7QAPWGwWSs5cgYIgwDzaSa75gQ/b3PeWK7E/ln2RW74U8nP7eFyy+vc5t37Dmg9zU7qEZlvfB3H+d367F29mOW6qT6tXnBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vAo9fYCa; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vAo9fYCa"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E962A26C44;
	Wed,  6 Mar 2024 11:57:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZVF1+q8Ekgx9
	62dYTWxEB+c1Vt1p2/xsTJ7a2e8Jho4=; b=vAo9fYCavvLlQoO1Kp1b1jYScvd5
	B7ETvbI4SoVukPpkhlr+09FsWuC4URT0KVHZrX0xBuXgGXwp48gT+UW+DCIZXWa5
	4BhSX6gTwCaKCZNMdVWjDEGMg69V74Bic64Y24cnGxVMhGHgSCRyKHn2592UVNeZ
	umUHleMv9Ioq12c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CCF6B26C43;
	Wed,  6 Mar 2024 11:57:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6D1626C41;
	Wed,  6 Mar 2024 11:57:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: Atneya Nair <atneya@google.com>,  git@vger.kernel.org,
  jeffhost@microsoft.com,  me@ttaylorr.com,  nasamuffin@google.com
Subject: Re: [RFC PATCH 1/3] Make read_gitfile and resolve_gitfile thread safe
In-Reply-To: <10042df8-5d06-47cd-9202-ea6965f50784@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila"'s message of "Wed, 6 Mar 2024 09:13:15 +0100")
References: <20240305012112.1598053-2-atneya@google.com>
	<20240305012112.1598053-3-atneya@google.com>
	<10042df8-5d06-47cd-9202-ea6965f50784@gmail.com>
Date: Wed, 06 Mar 2024 08:57:01 -0800
Message-ID: <xmqqttljs3he.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8E030CDE-DBDA-11EE-ABED-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

>> -const char *read_gitfile_gently(const char *path, int *return_error_c=
ode)
>> +const char *read_gitfile_gently(const char *path, int *return_error_c=
ode, struct strbuf* result_buf)
>>  {
>>  	const int max_file_size =3D 1 << 20;  /* 1MB */
>>  	int error_code =3D 0;
>> @@ -848,7 +852,10 @@ const char *read_gitfile_gently(const char *path,=
 int *return_error_code)
>>  	struct stat st;
>>  	int fd;
>>  	ssize_t len;
>> -	static struct strbuf realpath =3D STRBUF_INIT;
>> +	static struct strbuf shared =3D STRBUF_INIT;
>> +	if (!result_buf) {
>> +		result_buf =3D &shared;
>> +	}
>> =20
>
> Question about general style: is it accepted practice to override a
> parameter of a function?

We do not forbid it.  We have a rule against enclosing a single
statement block inside {braces}, though ;-).

> I would have written:

If it matters to know what the caller-supplied value of the
parameter was, then we would probably write that way.  If it does
not, then the above is perfectly fine.  Even with the above, if a
later code really wanted to, it can compare the pointers to find out
if the caller was uninterested in the result (i.e., passed NULL),
but at that point, we may be better off to (re)write it your way.

>> -	strbuf_realpath(&realpath, dir, 1);
>> -	path =3D realpath.buf;
>> +	strbuf_realpath(result_buf, dir, 1);
>> +	path =3D result_buf->buf;
>> +	// TODO is this valid?
>> +	if (!path) die(_("Unexpected null from realpath '%s'"), dir);
>
> In fact, this is not a null path, but an empty path (null is not part o=
f
> the string).
> By the way, shouldn't this be an internal bug instead of a message to
> the user?

Unless the strbuf instance the result_buf pointer points at is
corrupt, its .buf member should *NEVER* be NULL.  Testing for NULL
is meaningless, unless you are manually futzing with the members of
strbuf (you shouldn't).

Thanks for carefully reading.

