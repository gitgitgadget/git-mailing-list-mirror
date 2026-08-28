Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521846A5F4
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928840; cv=none; b=a97Gh5paAXBRU3JO25RRLYUFMXdTi+5yq2CGKno1NUy7JYGh4D0RvyPuMF64QfMJJc3a6v3lfeD7H5B+m4cdBUWiRFyiXYYB0BLup/ZD+CxVTJ0QyHx9aFMMFM/X1GTjLzwVw+Fc0D1Xi9f6qjaQn0ASasd1YWJNiGHer9TMmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928840; c=relaxed/simple;
	bh=aCnG64bandoGa4HwScH6GXPTh8MiM/loS7RVIVPkH0o=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aUJR6xX5+SD2NjOHzj0+Cw9NJomHD+URzXi3InKxqjFzMoit+54CHc3g/AviUdFqszTIJuARh5p/VYNvAQnN7hXK4onuz/XfDMAJNAMrSPsyRZ98yv2A4OB7e3newq5LGviwJvd8CJJZYGn4p419qiN3d5OwPM1lpuXb09dWoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Oq/L0s44; arc=none smtp.client-ip=95.215.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Oq/L0s44"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aCnG64bandoGa4HwScH6GXPTh8MiM/loS7RVIVPkH0o=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787928835; v=1; x=1788533635;
 b=Oq/L0s44LozNggC030wYTW66ZGFb0gldqsnphRvgnn90+ZSwzcLYSp5Eszx12q+IfOkh+104
 vnY43khBNYMAnUwfo5UWPzyNjRJFn454avqQBuqVkXm/IMxJOrSHeU3uY0SK+W2fmcE7RTKnuj7
 TQZZh1fHZuP4m7fY7uk3hi1M=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 5479d9565b0f27e4;
	Fri, 28 Aug 2026 14:53:55 +0000
X-Mizu-Trace-ID: 5479d9565b0f27e4
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 8/8] odb/source: remove the ability to write alternates
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-8-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-8-911513ba95c3@pks.im>
Date: Fri, 28 Aug 2026 16:53:47 +0200
Message-ID: <871pbiuwhw.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There are no users of `odb_source_write_alternates()` in our tree
> anymore. Remove that function and its supporting infrastructure.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c                 |  9 ---------
>  odb.h                 |  7 -------
>  odb/source-files.c    | 55 ---------------------------------------------------
>  odb/source-inmemory.c |  7 -------
>  odb/source-loose.c    |  7 -------
>  odb/source-packed.c   |  7 -------
>  odb/source.h          | 26 ------------------------
>  7 files changed, 118 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 67d98d64fc..b531cf8fb3 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -239,15 +239,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
>  	return alternate;
>  }
>  
> -void odb_add_to_alternates_file(struct object_database *odb,
> -				const char *dir)
> -{
> -	int ret = odb_source_write_alternate(odb->sources, dir);
> -	if (ret < 0)
> -		die(NULL);
> -	odb_add_alternate_recursively(odb, dir, 0);
> -}
> -
>  struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
>  						const char *dir)
>  {
> diff --git a/odb.h b/odb.h
> index b9e0db56ec..2d002461f8 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -270,13 +270,6 @@ int odb_mkstemp(struct object_database *odb,
>   */
>  int odb_has_alternates(struct object_database *odb);
>  
> -/*
> - * Add the directory to the on-disk alternates file; the new entry will also
> - * take effect in the current process.
> - */
> -void odb_add_to_alternates_file(struct object_database *odb,
> -				const char *dir);
> -
>  /*
>   * Add the directory to the in-memory list of alternate sources (along with any
>   * recursive alternates it points to), but do not modify the on-disk alternates
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 5e77b21d9f..feef9e169a 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -4,7 +4,6 @@
>  #include "chdir-notify.h"
>  #include "config.h"
>  #include "gettext.h"
> -#include "lockfile.h"
>  #include "object-file.h"
>  #include "odb.h"
>  #include "odb/source.h"
> @@ -303,59 +302,6 @@ static int odb_source_files_read_alternates(struct odb_source *source,
>  	return 0;
>  }
>  
> -static int odb_source_files_write_alternate(struct odb_source *source,
> -					    const char *alternate)
> -{
> -	struct lock_file lock = LOCK_INIT;
> -	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
> -	FILE *in, *out;
> -	int found = 0;
> -	int ret;
> -
> -	repo_hold_lock_file_for_update(source->odb->repo, &lock, path,
> -				       LOCK_DIE_ON_ERROR);

Why is the new implementation not using a lockfile?

-- 
Laters,
Toon
