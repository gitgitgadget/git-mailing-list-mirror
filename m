Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5A1ABEB6
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639657; cv=none; b=PsW4oiM8+90yLH2pCW+J7ysO38iBH7hRKP3Up3npPM4PltDwf7myTUsUxp3g0NrjJtwIoy8EtIqOGae8UohKMrd2yhVZpz9CLmIzcOWh+MSyh9NGbyvTpZ+cUK/xJCt3Ozjuv696TdDuAilOVTcKPy2eF4CJvnX7muVGsAm9xL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639657; c=relaxed/simple;
	bh=BM+T3HJnbMUDmCgHFW21f3R4vTOBJPj8Re89wbn2Dsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkRpYHc93vBfpJfI1I6M/xRC+8dd1Q5fDYaHkkxzB3/9C2ZYrjsseSGAeD53tNAdJ+pU+jXhVQuLvgtH3Mkqq5z5Gg9NT3NAkqymMkHMny+cEAuwbtJbTUVnfeDkJ7NL5PrVxJ40TSLX4sktbGuhKvzqv3ybEbTigVVjTbLofV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cSrF7C+L; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cSrF7C+L"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4350218A7C;
	Fri,  2 Aug 2024 19:00:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BM+T3HJnbMUDmCgHFW21f3R4vTOBJPj8Re89wb
	n2Dsg=; b=cSrF7C+LYr3nZOocMRT653jXcpeKkncKy1l7garEXkbTsHs6dO9/hE
	Ohh+jXC2zr+38nR5BitL2SbSGWc5gBqkMJL63ewALQRRCcpUQCpj5Rme6XD3pQGn
	yXCCHb5XQV62hsj2Ozcx8e90CAo/wVfIm18U1bWNkolGAwMD8d2jM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B75D18A7B;
	Fri,  2 Aug 2024 19:00:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 904C318A7A;
	Fri,  2 Aug 2024 19:00:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] reftable/stack: simplify tracking of table locks
In-Reply-To: <40d9f75cf20d4b76adb1683709e054e264d4e06f.1722435214.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 31 Jul 2024 16:15:06 +0200")
References: <cover.1722435214.git.ps@pks.im>
	<40d9f75cf20d4b76adb1683709e054e264d4e06f.1722435214.git.ps@pks.im>
Date: Fri, 02 Aug 2024 16:00:52 -0700
Message-ID: <xmqqy15e8r8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11CC0B48-5123-11EF-A1AD-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> -	size_t i;
> +	size_t i, nlocks = 0;
>  
>  	if (first > last || (!expiry && first == last)) {
>  		err = 0;
> @@ -1051,7 +1051,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  	for (i = first; i <= last; i++) {
>  		stack_filename(&table_name, st, reader_name(st->readers[i]));
>  
> -		err = hold_lock_file_for_update(&table_locks[i - first],
> +		err = hold_lock_file_for_update(&table_locks[nlocks],
>  						table_name.buf, LOCK_NO_DEREF);
>  		if (err < 0) {
>  			if (errno == EEXIST)
> @@ -1066,7 +1066,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  		 * run into file descriptor exhaustion when we compress a lot
>  		 * of tables.
>  		 */
> -		err = close_lock_file_gently(&table_locks[i - first]);
> +		err = close_lock_file_gently(&table_locks[nlocks++]);
>  		if (err < 0) {
>  			err = REFTABLE_IO_ERROR;
>  			goto done;

The only unusual control flow in this loop that runs i from first to
last is to leave it upon an error, so "i - first" and "nlocks" is
always the same, at this step in the patch series.

> @@ -1183,8 +1183,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  	 * Delete the old tables. They may still be in use by concurrent
>  	 * readers, so it is expected that unlinking tables may fail.
>  	 */
> -	for (i = first; i <= last; i++) {
> -		struct lock_file *table_lock = &table_locks[i - first];
> +	for (i = 0; i < nlocks; i++) {
> +		struct lock_file *table_lock = &table_locks[i];
>  		char *table_path = get_locked_file_path(table_lock);
>  		unlink(table_path);
>  		free(table_path);

And this one at this step in the patch series is skipped if the
earlier loop saw even a single error, so again, this is a benign
noop change.

> @@ -1192,8 +1192,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  
>  done:
>  	rollback_lock_file(&tables_list_lock);
> -	for (i = first; table_locks && i <= last; i++)
> -		rollback_lock_file(&table_locks[i - first]);
> +	for (i = 0; table_locks && i < nlocks; i++)
> +		rollback_lock_file(&table_locks[i]);

This is a true bugfix, isn't it?  If we failed to create lock file
somewhere in the middle, we used to still go ahead and attempted
rollback_lock_file() on all of them.  Now we rollback only what we
successfully called hold_lock_file_for_update().

I wonder why nobody segfaulted where after a failed lock.  The
answer probably is that lk->tempfile that is NULL will safely bypass
most of the things because is_tempfile_active() would say "false" on
such a lockfile.  But still it probably still were wrong to call
rollback_lock_file() on a "struct lockfile" full of NUL-bytes, and
it is good that we no longer do that.

>  	reftable_free(table_locks);
>  
>  	delete_tempfile(&new_table);
