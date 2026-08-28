Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025F33C1AD
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928789; cv=none; b=rHxYHy/+t6qvmD2/d/40tv+K0CftTUzdk1C0c2+1IvfhAfCA47Dt+UzcPIGXmnsyIuCw/4AR/MskZhmj4R0WnEZfDvY59kwMJvEqwjodn4+pSRbWSVG5pAghaiT4BkNMdvhZxUHpioQ1U5XKUhLDBPwgqm8gVkifB32yIVG/oEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928789; c=relaxed/simple;
	bh=x38z/Zxgv/rCbRWCefKEHnW6JxnPvYDiwPw8gMYIsVQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BCT0jIlDrwvSJI76OP7T8NMSd65rITcStYA6PoiHuoebfnbGXbBds07haAXQPzkaiAJGA31SBXk8qwTwSkaCaQ3+Z4UnwcIXwEF36+BynYe0u4hN7opexYR9W2C0GbtXBE+muT1nN8M47D3VKBikE7rHOuiKKKn5HqF5U+c5Sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jsJ1Rtd6; arc=none smtp.client-ip=95.215.58.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jsJ1Rtd6"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x38z/Zxgv/rCbRWCefKEHnW6JxnPvYDiwPw8gMYIsVQ=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787928785; v=1; x=1788533585;
 b=jsJ1Rtd6rYKODyfEWUNfjGowWCqTA00RKB5xiC+VTH8XAVEJmOLy6qrlI/n0Kt6em2Ntg1sg
 zWwlPnMQg19xGCDZTUc04mYjDj8bCVyUYwOHBG1SkyvEEgjwqcqOjqqaL0mRz6ZhO1raD/jmAA0
 tJGqM/cZyJIqAw3lyCkiPFMc=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a1f957fbf7ae1796;
	Fri, 28 Aug 2026 14:53:05 +0000
X-Mizu-Trace-ID: a1f957fbf7ae1796
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/8] builtin/clone: move setup of alternates for
 non-shared local clones
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-5-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-5-911513ba95c3@pks.im>
Date: Fri, 28 Aug 2026 16:52:57 +0200
Message-ID: <874igeuwja.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Similar as in the preceding commit, move the setup of alternates for
> local clones with "--no-shared" into `collect_alternates()`. With this
> step, the complete setup of alternates is now handled by that function.
>
> Note that besides moving stuff around, it also fixes a bug: previously,
> we did not know to resolve the referenced repository's common directory.
> Consequently, when referencing a worktree we failed to resolve
> alternates. But as `collect_alternates()` already knows to resolve the
> commondir for "--local" we can simply reuse this resolved path for our
> purpose.
>
> Add two tests, the first one of which exercises this bug to avoid future
> regressions. The second patch ensures that we properly handle relative
> alternates for a referenced worktree.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c            | 34 +++++++++++++++++++++++-----------
>  t/t5604-clone-reference.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 08c8f5a94f..2e3473fddf 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -181,7 +181,7 @@ static int add_one_alternate(struct string_list_item *item, void *cb_data)
>  	return 0;
>  }
>  
> -static void copy_alternates(struct strbuf *src, const char *src_repo)
> +static void read_alternates(struct strvec *alternates, const char *src_repo)
>  {
>  	/*
>  	 * Read from the source objects/info/alternates file
> @@ -195,29 +195,41 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>  	 * to turn entries with paths relative to the original
>  	 * absolute, so that they can be used in the new repository.
>  	 */
> -	FILE *in = xfopen(src->buf, "r");
> +	FILE *in;
> +	struct strbuf path = STRBUF_INIT;
>  	struct strbuf line = STRBUF_INIT;
>  
> +	strbuf_addf(&path, "%s/objects/info/alternates", src_repo);
> +
> +	in = fopen(path.buf, "r");
> +	if (!in) {
> +		if (errno == ENOENT)
> +			goto out;
> +		die_errno("could not read alternates file '%s'", path.buf);
> +	}
> +
>  	while (strbuf_getline(&line, in) != EOF) {
>  		char *abs_path;
>  		if (!line.len || line.buf[0] == '#')
>  			continue;
>  		if (is_absolute_path(line.buf)) {
> -			odb_add_to_alternates_file(the_repository->objects,
> -						   line.buf);
> +			strvec_push(alternates, line.buf);
>  			continue;
>  		}
>  		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
>  		if (!normalize_path_copy(abs_path, abs_path))
> -			odb_add_to_alternates_file(the_repository->objects,
> -						   abs_path);
> +			strvec_push(alternates, abs_path);
>  		else
>  			warning("skipping invalid relative alternate: %s/%s",
>  				src_repo, line.buf);
>  		free(abs_path);
>  	}
> +
> +out:
> +	strbuf_release(&path);
>  	strbuf_release(&line);
> -	fclose(in);
> +	if (in)
> +		fclose(in);

Why not put this before the `out` label and remove the if?

>  }

-- 
Laters,
Toon
