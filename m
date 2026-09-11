Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5C38B7D1
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125291; cv=none; b=Z4R2r77F0kuT8O6LgURdcGy4GmPNoOp6+5H0S+3h4Ef+PXSFLlglnLww8hgU8e+y53LDNCUEeBYd7j5VMLAcmsElS6b16H5li7oIsAABpTWN3hZ9rGRhOWTDm9WD8Chl+G53EPwQqv+S02yFO9N6WXaBCJ0u5Y8aubm+ngEkhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125291; c=relaxed/simple;
	bh=jMuUTDXZeVKRC3m8fz95L2lpwgbnScxSZQtAto+KdDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IR964a8ozupXPxkGUiezq1tv+EjqlANPO3zlbzHlb+tHpQOCbSAPSEB8SVzK88HFxI4RGU9l1EhIapn9VTEeFHvZckP9e0llsGFJuByiM4bVeADpCuefJ83nymch/JRkz1KFJaCyY717THSE4PqsdrNbQeY/RJfSv1BzJi5EViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WCIfKy7q; arc=none smtp.client-ip=91.218.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WCIfKy7q"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jMuUTDXZeVKRC3m8fz95L2lpwgbnScxSZQtAto+KdDw=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789125286; v=1; x=1789730086;
 b=WCIfKy7q309+DMn4PEQWOlw19sVpH7ql4mc/ER7irmTJs7hIWXbW7vQrzHoy5+M+ZTeus2kz
 9VBWXdw/4yiQBXaM8nhVfdU3gJgQ3PNfso63B5WDk4y65p8d84LDHlK+o1yaeqr2F4IR8JYsVQg
 2clK+zXmebKGDTjaID+VSn8E=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id de29fd0aaa1e8cde;
	Fri, 11 Sep 2026 11:14:46 +0000
X-Mizu-Trace-ID: de29fd0aaa1e8cde
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/10] builtin/fsck: move multi-pack index
 verification into the packed source
In-Reply-To: <20260831-pks-odb-source-fsck-v2-9-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-9-f9b16ef4957b@pks.im>
Date: Fri, 11 Sep 2026 13:14:44 +0200
Message-ID: <877bksnior.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The checks for multi-pack indexes are hosted in `cmd_fsck()` directly.
> These checks are obviously specific to the "packed" backend.
>
> Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
> this means that we now properly honor both "--connectivity-only" and
> "--no-full". Furthermore, we drop the dedicated `ERROR_MULTI_PACK_INDEX`
> bit and instead use the generic `ERROR_OBJECT` bit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c              | 18 ------------------
>  odb/source-packed.c         | 27 +++++++++++++++++++++++++++
>  t/t5319-multi-pack-index.sh | 13 +++++++++++++
>  3 files changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 2f7d29aa56..7eaea340b0 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -48,7 +48,6 @@ static timestamp_t now;
>  #define ERROR_REACHABLE 02
>  #define ERROR_REFS 010
>  #define ERROR_COMMIT_GRAPH 020
> -#define ERROR_MULTI_PACK_INDEX 040
>  
>  static const char *describe_object(const struct object_id *oid)
>  {
> @@ -1085,23 +1084,6 @@ int cmd_fsck(int argc,
>  		}
>  	}
>  
> -	if (repo->settings.core_multi_pack_index) {
> -		struct child_process midx_verify = CHILD_PROCESS_INIT;
> -
> -		for (source = repo->objects->sources; source; source = source->next) {
> -			child_process_init(&midx_verify);
> -			midx_verify.git_cmd = 1;
> -			strvec_pushl(&midx_verify.args, "multi-pack-index",
> -				     "verify", "--object-dir", source->path, NULL);
> -			if (show_progress)
> -				strvec_push(&midx_verify.args, "--progress");
> -			else
> -				strvec_push(&midx_verify.args, "--no-progress");
> -			if (run_command(&midx_verify))
> -				errors_found |= ERROR_MULTI_PACK_INDEX;
> -		}
> -	}
> -
>  	free_snapshot_refs(&snap);
>  	return errors_found;
>  }
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 2b5dc502f5..9f42552377 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -14,6 +14,7 @@
>  #include "packfile.h"
>  #include "pack-bitmap.h"
>  #include "progress.h"
> +#include "run-command.h"
>  
>  static int find_pack_entry(struct odb_source_packed *store,
>  			   const struct object_id *oid,
> @@ -897,6 +898,29 @@ static int verify_reverse_indices(struct odb_source_packed *source,
>  	return res;
>  }
>  
> +static int verify_midx(struct odb_source_packed *source,
> +		       struct odb_fsck_options *opts)
> +{
> +	struct child_process midx_verify = CHILD_PROCESS_INIT;
> +	int ret = 0;

I don't see much reason to use a `ret` value instead of using early
returns instead.

> +
> +	if (!source->base.odb->repo->settings.core_multi_pack_index)

Because we cannot ensure where this function was called from, shall we
BUG() if (!settings.initialized)?

> +		return 0;
> +
> +	child_process_init(&midx_verify);
> +	midx_verify.git_cmd = 1;
> +	strvec_pushl(&midx_verify.args, "multi-pack-index",
> +		     "verify", "--object-dir", source->base.path, NULL);
> +	if (opts->flags & ODB_FSCK_PROGRESS)
> +		strvec_push(&midx_verify.args, "--progress");
> +	else
> +		strvec_push(&midx_verify.args, "--no-progress");
> +	if (run_command(&midx_verify))
> +		ret = -1;
> +
> +	return ret;
> +}
> +
>  static int odb_source_packed_fsck(struct odb_source *source,
>  				  struct odb_fsck_options *opts)
>  {
> @@ -912,6 +936,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
>  	if (verify_bitmap_files(packed))
>  		ret = -1;
>  
> +	if (verify_midx(packed, opts) < 0)

Any reason why you're checking negative value here and not in the if
above?

> +		ret = -1;
> +
>  	return ret;
>  }
>  
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 68143cb5b7..20b010c33b 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -573,6 +573,19 @@ test_expect_success 'verify incorrect checksum' '
>  		$objdir "incorrect checksum"
>  '
>  
> +test_expect_success 'git fsck --no-full checks multi-pack-index, --connectivity-only does not' '
> +	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
> +	corrupt_midx_and_verify $pos \
> +		"\377\377\377\377\377\377\377\377\377\377" \
> +		$objdir "incorrect checksum" &&
> +
> +	test_must_fail git fsck --no-full 2>err &&
> +	test_grep "incorrect checksum" err &&
> +
> +	git fsck --connectivity-only 2>err &&
> +	test_grep ! "incorrect checksum" err
> +'
> +
>  test_expect_success 'setup for v1-specific fsck tests' '
>  	git -c midx.version=1 multi-pack-index write
>  '
>
> -- 
> 2.55.0.979.g7e5102b832.dirty
>
>

-- 
Laters,
Toon
