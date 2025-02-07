Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD02E64A
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936174; cv=none; b=DxKmTcl30fcZRde+ikU1enwha5BfZMhQ/zflx1nIRjPHZkjRxL+Y5uN0wKsC8/wqMe7sH582o3JXP3SPWyksYzwoi+u0uDQQDZt07VFbeOcTnx4HlEKeuZXSMZoJTz2SkILPh4+9oUjI/fxvZKrdlOm47e4Nk5ByiJiLXvsZa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936174; c=relaxed/simple;
	bh=s+yP3pFibFEI5Ljyc42IB1bvuBbY+CSJ/VdwV2DKdmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cWmukowCskXXpmj9ciJdr/FKQIU64yFO5F165ORJae2x94CtidPXtxxy2CfJbqJQfpN/6MJHR3D7bs8Ua1mAxyPHz11dnKPUcceOaW/Tj1hIys141hp6B2f5CWJegQLPKMV0cjPJq7WPPCB80tVThnb01BfxiHll8DRAAPjSkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=M3Grz0MJ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="M3Grz0MJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738936164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r29RVql17i/8haA614ur0mJe4KfyzxYvqKDwt+kqRvs=;
	b=M3Grz0MJXilE09yM/5O6TqNWqHmU7Cb6Hc7olWrlhVzJdVoUIMhGtd7VILufchebHDgJFg
	YZh0KzG2Nn2/2yxsHLpEyJmG+UI6EuZx9dguB9B1J49fBeFgCH0Rb7wLkspE6y60UWzper
	ZCfjiu8YVY05HtfwiuUKsICYIFArRgA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 09/13] meson: improve handling of `sane_tool_path`
 option
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-9-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
 <20250130-b4-pks-meson-improvements-v2-9-2f05581ffb44@pks.im>
Date: Fri, 07 Feb 2025 14:49:12 +0100
Message-ID: <87zfix3lwn.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `sane_tool_path` option can be used to override the PATH variable
> from which the build process, tests and ultimately Git will end up
> picking programs from. It is currently lacking though because we only
> use it to populate the PATH environment variable for executed scripts
> and for the `BROKEN_PATH_FIX` mechanism, but we don't use it to find
> programs used in the build process itself.
>
> Fix this issue by treating it similar to the Windows-specific paths,
> which will make us use it both to find programs and to populate the PATH
> environment variable.
>
> To help with this fix, change the type of the option to be an array of
> paths, which makes the handling a bit easier for us. It's also the
> correct thing to do as the input indeed is a list of paths.

Should we consider this a breaking change, or aren't we because using
Meson is still not the "official" installation method? I've noticed it
breaks my "build" directory which was set up before this change and now
am trying to use these changes on:

   $ cd build
   $ meson configure

   ERROR: The value of option "sane_tool_path" is "[]", which is not a string.

   $ meson compile
   INFO: autodetecting backend as ninja
   INFO: calculating backend command to run: /home/toon/.local/bin/ninja
   [0/1] Regenerating build files.
   The Meson build system
   Version: 1.6.1
   Source dir: /home/toon/devel/git
   Build dir: /home/toon/devel/git/build
   Build type: native build
   Program sh found: YES (/usr/bin/sh)

   ../meson.build:171:0: ERROR: The value of option "sane_tool_path" is "[]", which is not a string.

   A full log can be found at /home/toon/devel/git/build/meson-logs/meson-log.txt
   FAILED: build.ninja
   /home/toon/.local/bin/meson --internal regenerate /home/toon/devel/git .
   ninja: error: rebuilding 'build.ninja': subcommand failed

-- 
Toon
