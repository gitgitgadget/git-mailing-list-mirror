Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659538E125
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134086; cv=none; b=juThUCx69n1rTKJJOE8YTVoZXFRCInsECDL7x76P563ahsyoAlNCgJufG2DFB8Yvvb/r+bPXr/wTrjbKiYcq9kKz0VORNla9zIe8jvAf3nL6gM0t2TKnKYx4GadlU0gduTadScJ9nSyEl0ySSWfD7z3Qv+z9XeDIBZ0SyM4iHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134086; c=relaxed/simple;
	bh=5SFHuKYfxHkVkJuEZE0eRsuaaMB3CHTfMQPD04X76EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbPjI8h84YTCQa0QQNHuYwdY5cOEAd6pvXTHk010V8XgFFfDxhf5QjEtEshtzibIzZCDsRw44cfGZGCOml2GSCJ2s7zGVzeK/xPsrmohw5gW768XeZdODJLKsAUUZBAcjxW1374/9ZiRumlWXmJV7u3ti18oHcee7lo+oDXO82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TLX/19GK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TLX/19GK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1770134080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrBabMFCA5rARLVm6a+UOft5uEC3DKqiAjnQdZslGps=;
	b=TLX/19GKvlW7wodgiI+ZP4TTlGvFTN5WNlGRqOry7UKYvjCMjs2+pSXqE5ikscroeLzAU2
	Gk7k/SFKJ6E1/O0sH8J9L1HGa5LkxJcRP03L2PL3yk3TFul/S2tilg0rhjHQ/EswuqKkug
	SOaDa0j4Jya6kEg9/igu7YpjqXxXEeI=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become
 generic
In-Reply-To: <20260203001002.2500198-4-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com>
Date: Tue, 03 Feb 2026 16:54:19 +0100
Message-ID: <87o6m5rff8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> An ODB transaction handles how objects are stored temporarily and
> eventually committed. Due to object storage being implemented
> differently for a given ODB source, the ODB transactions must be
> implemented in a manner specific to the source the objects are being
> written to. To provide generic transactions, `struct odb_transaction` is
> updated to store a commit callback that can be configured to support a
> specific ODB source. For now `struct odb_transaction_files` is the
> only transaction type and what is always returned when starting a
> transaction.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c | 80 ++++++++++++++++++++++++++++-----------------------
>  object-file.h |  6 ----
>  odb.c         |  5 +++-
>  odb.h         | 17 +++++++++++
>  4 files changed, 65 insertions(+), 43 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 7b34a2b274..d7e153c1b9 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -710,15 +710,17 @@ struct transaction_packfile {
>  	uint32_t nr_written;
>  };
>  
> -struct odb_transaction {
> -	struct odb_source *source;
> +struct odb_transaction_files {
> +	struct odb_transaction base;
>  
>  	struct tmp_objdir *objdir;
>  	struct transaction_packfile packfile;
>  };
>  
> -static void prepare_loose_object_transaction(struct odb_transaction *transaction)
> +static void prepare_loose_object_transaction(struct odb_transaction *base)
>  {
> +	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;

So you're assuming `struct odb_transaction` is the first field in
`struct odb_transaction_files`?

I think it would be safer to do this instead:

+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);

(this also can be applied in a few other places in this patch)

-- 
Cheers,
Toon
