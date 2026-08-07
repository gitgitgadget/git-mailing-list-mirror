Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A33A963C
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087002; cv=none; b=pUUHpwEEA1T0NoN1EgKcZX4ooGVByJ0EX9/8DqJHXW5gnIOPE/hZjBSIxmB5QOp6Ck2TJOqUnjGA6Kb9QpQwiRimRIGtsp3VCux6/Y0Bc31J6t3VdcKnV0tF3WK9+vSb0MAnlmnrRYdx0rN+HiG1P0pmTInSwuwbajePhFe4+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087002; c=relaxed/simple;
	bh=A/jxb4lrpqdQAb2iVTLQCDwLYXwD0CdLFyLDPWG2eTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDe7fNvC7gFV+/iviRBLeq1Qmo/F6KZ3EgkTVQdzV2DkNRUFR6+MMWwoT+l4qmidXldgcHHFNrdyh3ppl+vtXrNqe8qJbxmFxB3lt+O1e8xx6wTar2/XbdRY8lKc3E/dVRQCFsE5RBCs5Rl20STI8RWNwrji5MBJs9jtzcKZUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sMx52bhZ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sMx52bhZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786086996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNshLQzZ9oiuHcl50ZoJnTghRO52e5aCx1oJPDVgoJI=;
	b=sMx52bhZKGSh+EUdbfmmq/3Zta3mvuKIQfhEYllkUimDmW7i+I1PPSLh7GU8py2UHvQYnp
	eQl0cqaMfctU/U1QP/vJmZ/so15cG1e+bJ9yNvB0xDwX3Rv/nHL3RHNvgsMoM6bzJtM8k5
	9OnqiooZIRdKOsXhD36TTTF+Xs3MGiA=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 4/6] setup: defer object database creation
In-Reply-To: <xmqq1pcah7vg.fsf@gitster.g>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
 <20260807-pks-odb-create-on-disk-v5-4-399da0b0b140@pks.im>
 <xmqq1pcah7vg.fsf@gitster.g>
Date: Fri, 07 Aug 2026 09:16:22 +0200
Message-ID: <87mruy4czd.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> diff --git a/setup.c b/setup.c
>> index 5dfab3e79e..97338cbc51 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1888,6 +1882,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
>>  		read_and_verify_repository_format(&fmt, ".", NULL);
>>  		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>>  			die("%s", err.buf);
>> +		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
>>  		startup_info->have_repository = 1;
>>  
>>  		clear_repository_format(&fmt);
>
> The previous round corrected the overly long line while at it, but
> it is no longer done here.

Yeah, I've asked about this. In [PATCH v3 4/6] this change existed:

-	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+	if (apply_repository_format(repo, &repo_fmt,
+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
+				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)

But adding APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION was reverted in v4,
but that version still had the reformatting change (fixing the overly
long line).

There are multiple occurrences of this overly long line, but only this
one was changed in v4. So Patrick reverted changing the overly long line
in v5, which I think is better.

-- 
Cheers,
Toon
