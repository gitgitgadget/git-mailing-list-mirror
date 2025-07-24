Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62002D4B57
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361715; cv=none; b=Pis014nw3bXek/GX3mYK4pcPDZy8zmD/dz7dT0cZKP9L2zucCLqVrEgCajIXuw7IUsmAgZkp/evPCjznEHGyICGc8tjWgmK7sGjN9gvpTcIaRV8LR4pRCd2Wf+1nN5Y01OWWFdjP74I1nXdqL5kRfWNZE0NHzKYnp3eoQESAyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361715; c=relaxed/simple;
	bh=QUxQ5u1Eb0o4fDZKoALC61hDaUn6PqDsVGpN83lV7QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCAX2xMpXGLwIY8SPmOEtaEGFHFE1g8TBizlXvpLWSgGCiWLjhmfiY65Y7X/0Z2Ql59B9R7l0iZkmyt/rVGyf7pdkP1cfD28UrOowHDy9ch+TslNYS8swKMJdGk8RFjlcuxbmZly+WKy/6qABKRQBa0dnOLo+6bjC5SekHyX4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=6OMnmNPx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="6OMnmNPx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753361707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KskpcIWigg2xYE3qRQl4+Tg+bjVFIg4gQ0ofFmUQ57w=;
	b=6OMnmNPx/fH9lyROa0feGKKVD8wXXPDtEllOFelpPhh1QU28mx118KKxLrKPfoCVzXY97n
	vuTa4TkKBEdWoSagVLRa75HDeH7LysojKiTvoo5diYLjWhowUcmM61fkEaBlA9cDjksDPv
	rQSyu1XJmn+TwgONKDK/q4gZ1BuaI7o=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
In-Reply-To: <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
Date: Thu, 24 Jul 2025 14:54:53 +0200
Message-ID: <87o6t9kaua.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> While we provide a couple of subcommands in git-reflog(1) to remove
> reflog entries, we don't provide any to write new entries. Obviously
> this is not an operation that really would be needed for many use cases
> out there, or otherwise people would have complained that such a command
> does not exist yet. But the introduction of the "reftable" backend
> changes the picture a bit, as it is now basically impossible to manually
> append a reflog entry if one wanted to do so due to the binary format.
>
> Plug this gap by introducing a simple "write" subcommand. For now, all
> this command does is to append a single new reflog entry with the given
> object IDs and message to the reflog. More specifically, it is not yet
> possible to:
>
>   - Write multiple reflog entries at once.
>
>   - Insert reflog entries at arbitrary indices.
>
>   - Specify the date of the reflog entry.
>
>   - Insert reflog entries that refer to nonexistent objects.
>
> If required, those features can be added at a future point in time. For
> now though, the new command aims to fulfill the most basic use cases
> while being as strict as possible when it comes to verifying parameters.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-reflog.adoc |  1 +
>  builtin/reflog.c              | 65 ++++++++++++++++++++++++++++++++++
>  t/meson.build                 |  1 +
>  t/t1421-reflog-write.sh       | 81 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 148 insertions(+)
>
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index 6ae13e772b8..798dbc0a00a 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -12,6 +12,7 @@ SYNOPSIS
>  git reflog [show] [<log-options>] [<ref>]
>  git reflog list
>  git reflog exists <ref>
> +git reflog write <ref> <old-oid> <new-oid> <message>
>  git reflog delete [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>  git reflog drop [--all [--single-worktree] | <refs>...]
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index b00b3f9edc9..d0374295620 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -3,6 +3,8 @@
>  #include "builtin.h"
>  #include "config.h"
>  #include "gettext.h"
> +#include "hex.h"
> +#include "odb.h"
>  #include "revision.h"
>  #include "reachable.h"
>  #include "wildmatch.h"
> @@ -20,6 +22,9 @@
>  #define BUILTIN_REFLOG_EXISTS_USAGE \
>  	N_("git reflog exists <ref>")
>  
> +#define BUILTIN_REFLOG_WRITE_USAGE \
> +	N_("git reflog write <ref> <old-oid> <new-oid> <message>")
> +
>  #define BUILTIN_REFLOG_DELETE_USAGE \
>  	N_("git reflog delete [--rewrite] [--updateref]\n" \
>  	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>}...")
> @@ -47,6 +52,11 @@ static const char *const reflog_exists_usage[] = {
>  	NULL,
>  };
>  
> +static const char *const reflog_write_usage[] = {
> +	BUILTIN_REFLOG_WRITE_USAGE,
> +	NULL,
> +};
> +
>  static const char *const reflog_delete_usage[] = {
>  	BUILTIN_REFLOG_DELETE_USAGE,
>  	NULL
> @@ -66,6 +76,7 @@ static const char *const reflog_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	BUILTIN_REFLOG_LIST_USAGE,
>  	BUILTIN_REFLOG_EXISTS_USAGE,
> +	BUILTIN_REFLOG_WRITE_USAGE,
>  	BUILTIN_REFLOG_DELETE_USAGE,
>  	BUILTIN_REFLOG_DROP_USAGE,
>  	BUILTIN_REFLOG_EXPIRE_USAGE,
> @@ -392,6 +403,59 @@ static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>  	return ret;
>  }
>  
> +static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
> +			    struct repository *repo)
> +{
> +	const struct option options[] = {
> +		OPT_END()
> +	};
> +	struct object_id old_oid, new_oid;
> +	struct strbuf err = STRBUF_INIT;
> +	struct ref_transaction *tx;
> +	const char *ref, *message;
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);

Wrong usage string here: s/reflog_drop_usage/reflog_write_usage/.

-- 
Cheers,
Toon
