Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EF3C47B
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185168; cv=none; b=n59yNRJpoYa5xfx1z9wA8AbpQAnXgAJBrSaoQph2qYIHr3jEdEbwv0Gfux20LKX422XuaO1HTWEeFu55o64iA/1GOVRbsaiSdLEN7WS0BaipF4ZfiooL3GHS0IrVmOoW2ui0XjTeToodTUWn9GEVQM+B1bgx0o3oIK86Trdko6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185168; c=relaxed/simple;
	bh=6fpBOYTo6+TiOt2H29sRvjnzKYFc5agAKDZOFDiNQuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kiBysMquOx/3t+lUxVsVTq95WQ61vFQF+K8dT7C0BjvrkC/yhgclBwNWe6Z1SQvAhieYv6j7hhG8vg/lnYr/3cONoqlJspjQHkjEiPe7pTRx41jvtOa3bpd4Ja4EyNNTWqcIu/5xSRiDV7zt8scKE7nO5BnTYhrCjne4PrCHiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4gxspQHs; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4gxspQHs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732185162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kH5XrDjbp0ehWYUsTJSKVFsuk0nSbPx8lMr0OlkhUA=;
	b=4gxspQHsbXb3zNRZIh/oIhAAJSKjpCHm6J1FezNLswuk2EwhobAnwxZ0x+6Qkfiadl+EVL
	yKPI9NUsdXdBI+zNCcp+2cuDaAXxPYPJVrPYEbT2l7JQXYc7ZIxgvK/rgdy8I7XbOGL+Di
	i1LQy9rOdHQAzMbN61XJzWgOEh8eKSM=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>, Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 00/27] Memory leak fixes (pt.10, final)
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
References: <cover.1730901926.git.ps@pks.im>
 <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
Date: Thu, 21 Nov 2024 11:32:17 +0100
Message-ID: <87mshsswr2.fsf@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the last part of my series of memory leak fixes. This series
> goes a bit further than past series:
>
>   - Patches 1 to 16 plug remaining memory leaks exposed by our test
>     suite.
>
>   - Patches 17 to 22 remove the last remaining `UNLEAK()` annotations
>     and ultimately remove the macro itself.
>
>   - Patch 23 works around a bug in the leak sanitizer itself.
>
>   - Patches 24 and 25 drop annotations where leak-free tests pass with
>     the leak sanitizer.
>
>   - Patches 26 and 27 unconditionally enable leak checking in all newly
>     added tests and then drop the `TEST_PASSES_SANITIZE_LEAK`
>     annotation.
>
> So once this series lands, the expectation is that any newly added test
> needs to be leak free by default. We still have an escape hatch in the
> form of the SANITIZE_LEAK prerequisite, but patch authors are expected
> to provide good arguments why their test cannot be made leak free.
>
> Changes in v3:
>
>   - Fix bounds checking in `strvec_splice()`.
>
>   - Rename `pos` to `idx` in `strvec_splice()`.
>
>   - Drop no-op code when finding bisection points with
>     `FIND_BISECT_ALL`.
>
> Link to v1: https://lore.kernel.org/r/cover.1730901926.git.ps@pks.im
> Link to v2: https://lore.kernel.org/r/20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im
>
> Thanks!
>
> Patrick
>
> [...snip...]
>
> Range-diff versus v2:
>
>  1:  89f354b667 =  1:  08acbe8895 builtin/blame: fix leaking blame entries with `--incremental`
>  2:  e50952aba3 =  2:  49269d747b bisect: fix leaking good/bad terms when reading multipe times
>  3:  c38a4e15b8 =  3:  83cd85b609 bisect: fix leaking string in `handle_bad_merge_base()`
>  4:  d2b48a08c2 =  4:  88a218045c bisect: fix leaking `current_bad_oid`
>  5:  496421e0fe =  5:  1c1f77497f bisect: fix multiple leaks in `bisect_next_all()`
>  6:  aeb9cacf64 =  6:  f02bbfde18 bisect: fix leaking commit list items in `check_merge_base()`
>  7:  a8afd12467 !  7:  6e6d490b8a bisect: fix various cases where we leak commit list items
>     @@ Commit message
>      
>       ## bisect.c ##
>      @@ bisect.c: void find_bisection(struct commit_list **commit_list, int *reaches,
>     - 			free_commit_list(list->next);
>     - 			best = list;
>       			best->next = NULL;
>     -+		} else {
>     -+			for (p = list; p != best; p = next) {
>     -+				next = p->next;
>     -+				free(p);
>     -+			}
>       		}
>       		*reaches = weight(best);
>      +	} else {
>  8:  f503331f08 =  8:  13e2158c23 line-log: fix leak when rewriting commit parents
>  9:  3edb9e0fe9 !  9:  3a9b0fa44a strvec: introduce new `strvec_splice()` function
>     @@ strvec.c: void strvec_pushv(struct strvec *array, const char **items)
>       		strvec_push(array, *items);
>       }
>       
>     -+void strvec_splice(struct strvec *array, size_t pos, size_t len,
>     ++void strvec_splice(struct strvec *array, size_t idx, size_t len,
>      +		   const char **replacement, size_t replacement_len)
>      +{
>     -+	if (pos + len > array->alloc)
>     ++	if (idx + len > array->nr)
>      +		BUG("range outside of array boundary");
>      +	if (replacement_len > len)
>      +		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>      +			   array->alloc);
>      +	for (size_t i = 0; i < len; i++)
>     -+		free((char *)array->v[pos + i]);
>     ++		free((char *)array->v[idx + i]);
>      +	if (replacement_len != len) {
>     -+		memmove(array->v + pos + replacement_len, array->v + pos + len,
>     -+			(array->nr - pos - len + 1) * sizeof(char *));
>     ++		memmove(array->v + idx + replacement_len, array->v + idx + len,
>     ++			(array->nr - idx - len + 1) * sizeof(char *));
>      +		array->nr += (replacement_len - len);
>      +	}
>      +	for (size_t i = 0; i < replacement_len; i++)
>     -+		array->v[pos + i] = xstrdup(replacement[i]);
>     ++		array->v[idx + i] = xstrdup(replacement[i]);
>      +}
>      +
>       const char *strvec_replace(struct strvec *array, size_t idx, const char *replacement)
>     @@ strvec.h: void strvec_pushl(struct strvec *, ...);
>       void strvec_pushv(struct strvec *, const char **);
>       
>      +/*
>     -+ * Replace `len` values starting at `pos` with the provided replacement
>     -+ * strings. If `len` is zero this is effectively an insert at the given `pos`.
>     ++ * Replace `len` values starting at `idx` with the provided replacement
>     ++ * strings. If `len` is zero this is effectively an insert at the given `idx`.
>      + * If `replacement_len` is zero this is effectively a delete of `len` items
>     -+ * starting at `pos`.
>     ++ * starting at `idx`.
>      + */
>     -+void strvec_splice(struct strvec *array, size_t pos, size_t len,
>     ++void strvec_splice(struct strvec *array, size_t idx, size_t len,
>      +		   const char **replacement, size_t replacement_len);
>      +
>       /**
> 10:  f4c5b4b029 = 10:  0e30d61ee3 git: refactor alias handling to use a `struct strvec`
> 11:  a30376077d = 11:  9dc3f5da99 git: refactor builtin handling to use a `struct strvec`
> 12:  6fc481018e = 12:  6a7bb2d4ec split-index: fix memory leak in `move_cache_to_base_index()`
> 13:  011ee82856 = 13:  5147a45e70 builtin/sparse-checkout: fix leaking sanitized patterns
> 14:  41c6aa41ba = 14:  1e1f0025e2 help: refactor to not use globals for reading config
> 15:  d2b9042512 = 15:  92fb58121b help: fix leaking `struct cmdnames`
> 16:  75228ba160 = 16:  a8f1cb44f8 help: fix leaking return value from `help_unknown_cmd()`
> 17:  f2da0c4825 = 17:  9e76f20ad5 builtin/help: fix leaks in `check_git_cmd()`
> 18:  fb369114b7 = 18:  2d0fa8a922 builtin/init-db: fix leaking directory paths
> 19:  bf7e34819e = 19:  598e385ad3 builtin/branch: fix leaking sorting options
> 20:  ec0f1d5f44 = 20:  469adc7754 t/helper: fix leaking commit graph in "read-graph" subcommand
> 21:  fad027056e = 21:  fe36f95eee global: drop `UNLEAK()` annotation
> 22:  dc9b641e6a = 22:  3898a90c35 git-compat-util: drop now-unused `UNLEAK()` macro
> 23:  1a1d34e9d3 = 23:  52e17f51cb t5601: work around leak sanitizer issue
> 24:  3d89a0c792 = 24:  972a56f3d5 t: mark some tests as leak free
> 25:  d0925d3731 = 25:  2cad683eab t: remove unneeded !SANITIZE_LEAK prerequisites
> 26:  b9f4007910 = 26:  de43715991 test-lib: unconditionally enable leak checking
> 27:  96313e3e47 = 27:  59637d5fea t: remove TEST_PASSES_SANITIZE_LEAK annotations
>
> ---
> base-commit: b0c643d6a710e2b092902a3941655176b358bfd0
> change-id: 20241111-b4-pks-leak-fixes-pt10-a6fa657f4fac

Range-diff looks good to me, no further comments.

--
Toon
