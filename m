Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE61E86E
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425996; cv=none; b=pJUBJjTCsVp5yjuzuVT4HG4Zwyui6fT/TFQHublGasZTKj8V8YrbfxIcyc0g7YpQQt6DGE6stCXGCaANextLuUEAPz61WAf4DubkUZjWKJKOiWnaoy3p2hgq61NV9rUkr2AGD9AHXD0TE0zjZAbR1Q3Yx3CnKdLloxbSWTIUC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425996; c=relaxed/simple;
	bh=4u0VqvLbiKBtAsKgbiXN24TD5jP6MfAt5UwuEu7Z9Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mT0zO+ZFxUn8zd6EjbBpbezrllm4tXIJm+OWa+RAOpfRlImK1lSvxrlaNxizG3PIW0N3QAiRgk7NYcNKdie2jAxDegCASzA5z19pwO2d7t2LtXHF1WehjBZiGKA/c5xhEVxzk4xJuv7hDtGkUbcqq+sbBp8h+AvsUHP7VYnwDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AMSR01pq; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AMSR01pq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F16329D4A;
	Sat,  6 Apr 2024 13:53:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4u0VqvLbiKBt
	AsKgbiXN24TD5jP6MfAt5UwuEu7Z9Gg=; b=AMSR01pq78MfG1RxZqNWYO7f91Cp
	J6H+NRvjfEe4Qw6go0PO279lMxq8G9LFwx+/g/SxN2EzxyRdC45kYqeNidWlXkns
	tGIOX3rQADCEHSjce5/pm0CWdGJPIkrEtJ4Lrosqn1IiIUhux2SFHH92+twxckGR
	4zVo1uMXgUlXD/A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 77DBD29D49;
	Sat,  6 Apr 2024 13:53:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03DBD29D46;
	Sat,  6 Apr 2024 13:53:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] fix a leak with excludes_file
In-Reply-To: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sat, 6 Apr 2024 16:29:04 +0200")
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Date: Sat, 06 Apr 2024 10:53:09 -0700
Message-ID: <xmqq7chajs3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 888068C0-F43E-11EE-AA38-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> We call twice to git_config(): first to get the main git-branch(1) opti=
ons,
> and second to get the ones related to the sequencer.

The diagnosis of the control flow that leads to overwriting the
value assigned earlier to "excludes_file" is quite correct, but
I find that your fix is somehow not addressing the real issue.

We used to assume that excludes_file *always* points at a piece of
memory that somebody else owns.  But seeing the two places that
assign to the variable, both actually give the variable a piece of
memory allocated for the caller.

 - The one in config.c that reads core.excludesfile via
   git_config_pathname(), which calls interpolate_path(), whose
   return value is always allocated.

 - The one in dir.c that sets up standard excludes uses
   xdg_config_home() that returns a value obtained from mkpathdup().

The core of the fix ought to be just like this, but to lose the cast
that discards the constness away, the fallouts will be large (if you
remove "const" from the first parameter to git_config_pathname(),
the compiler will tell you where the fallouts are).

We may want to eventually fix the type of the first parameter of the
git_config_pathmame() function, but I somehow doubt that your
approach gets us any closer to that future.  Adding a parallel API
next to the existing git_config_pathname() and interpolate_path()
and convert only these callers that touch excludes_file would not
help other callers that hold the pointer git_config_pathname()
returned.

 config.c         | 4 +++-
 t/t7300-clean.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git c/config.c w/config.c
index eebce8c7e0..ae3652b08f 100644
--- c/config.c
+++ w/config.c
@@ -1584,8 +1584,10 @@ static int git_default_core_config(const char *var=
, const char *value,
 	if (!strcmp(var, "core.askpass"))
 		return git_config_string(&askpass_program, var, value);
=20
-	if (!strcmp(var, "core.excludesfile"))
+	if (!strcmp(var, "core.excludesfile")) {
+		free((char *)excludes_file);
 		return git_config_pathname(&excludes_file, var, value);
+	}
=20
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git c/t/t7300-clean.sh w/t/t7300-clean.sh
index 1f7201eb60..0aae0dee67 100755
--- c/t/t7300-clean.sh
+++ w/t/t7300-clean.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'git clean basic tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 git config clean.requireForce no
