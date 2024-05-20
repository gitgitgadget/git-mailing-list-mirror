Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C79475
	for <git@vger.kernel.org>; Mon, 20 May 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245126; cv=none; b=GDKDXRKAvluiqNrBC+XYSp6IS+t5j2f77vSaueCIYi+SDy3L9rF650u2GGuQNYi3kGpa8OcTMn0o7y7l6L4XVJ/2Nw5KCtFupadyeaZf8mLt+lFv2P/P1UYosj7IAwWgXLztwVA3Nis/TqJIRP+FyITiMChGYBEUtgBNZZ1jGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245126; c=relaxed/simple;
	bh=bk/XtdHjJlNIhi+KhktaVj+efQcUQD9smsHj4qC8as0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6lAYn9PEfakgam0/z1QSEqVCCkN6Azx14GaZVdVimIkcGNJRwhF+DuUEhA0do23hnQ5RBw5TZiwA6YPomQL9tO3qUhrtLKa9exnXjc8aa7sv6+B8DEYXsgCY94L14TLZ9QKmMT33t7itJuReZaydIP3WrPKbpxrhZWtZwfKQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XbxvDoG/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XbxvDoG/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC5AD28729;
	Mon, 20 May 2024 18:45:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bk/XtdHjJlNIhi+KhktaVj+efQcUQD9smsHj4q
	C8as0=; b=XbxvDoG/VFtaxksDs86jcoILunan1M5R6srf7vVhZKhZin1Q5sjn4g
	09nWyj9zQYmzAU1FKrw5+y8cDpx5lTOvLewkYlQX2/Ivs3Os3NpqQuIkcglI454f
	yURKU2Us7bqRzS0sVRpmyo1/k0OwHmWHtv0ZpBZuCQNr3uFOszu7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E4A7728728;
	Mon, 20 May 2024 18:45:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EBDD828725;
	Mon, 20 May 2024 18:45:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/5] builtin/hash-object: fix uninitialized hash
 function
In-Reply-To: <xmqqed9wdvv5.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	20 May 2024 14:19:42 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-5-gitster@pobox.com>
	<xmqqmsoodmoe.fsf@gitster.g> <xmqqed9wdvv5.fsf@gitster.g>
Date: Mon, 20 May 2024 15:45:13 -0700
Message-ID: <xmqqa5kkdrwm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FC3DBE6-16FA-11EF-946B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I haven't looked at the breakage in 1007 yet, though.

This turned out to be almost trivial.  A fix relative to an earlier
version is that the call to test_oid helper needs to explicitly ask
for SHA-1 variant, as the command invocation outside a repository
uses SHA-1 (not due to falling back to a hardcoded default, but by
an explicit fallback in the "git hash-object" itself.

I'll send a v5 of the whole series sometime later (if I have time it
may happen today but otherwise tomorrow).

Thanks.

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64aea38486..d73a5cc237 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -260,4 +260,10 @@ test_expect_success '--literally with extra-long type' '
 	echo example | git hash-object -t $t --literally --stdin
 '
 
+test_expect_success '--stdin outside of repository (uses SHA-1)' '
+	nongit git hash-object --stdin <hello >actual &&
+	echo "$(test_oid --hash=sha1 hello)" >expect &&
+	test_cmp expect actual
+'
+
 test_done

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 82ca6d2bfd..c767414a0c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -123,6 +123,9 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	else
 		prefix = setup_git_directory_gently(&nongit);
 
+	if (nongit && !the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (vpath && prefix) {
 		vpath_free = prefix_filename(prefix, vpath);
 		vpath = vpath_free;
