Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD926136D
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620368; cv=none; b=mI3JP+IfH2NEaypQw2z3zNeNnU3iBKBU/vavCBg7TuOfeSC7GuW1AjmQXxxZlTLT1KVTVsSqbFSdELkLoSN/bgguKKseqO/wO/JaoqS9WLt5O2cIJpkDxBZY2foFNjXclxLBUMfItUICGfsknTipmj+YTuPf6SyAk1q8CAdy7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620368; c=relaxed/simple;
	bh=WkDlSzCXoddaZxPZO+cPBq+frB0U4i/R/ZhPaYnUfIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Td5Axovq0lUh0L3gh9MPNlJN1yOkz0SO1YZrUTmlBRYck3UVi1tmMuir9mBHFYD5vzp9KlvdEGPHqoCUUoTqFzIy1U5FikDHaL/CeEBNInAPyxriLmL6wCQx2m5iAURWFL33y6q5g9AtvzjFcMaHWXOHvPangTI+X4C3sw6dDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=D/vnfIy5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="D/vnfIy5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744620360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAHJ6Y/yzY6mfBF0nA6wj3vpzSpBFil3TQUBBHTzKOU=;
	b=D/vnfIy5TGnD8FXMAMnRhb6JDlIYG8DiF8cVK9W/9cCOXoWWSEBSEad230GMkBQiRnqrNQ
	aRKrcYWx8lDWjyNcBu7IUQQAXyEmDrnH/2y3MyUqXLpxjleC+6Z7w/1EQVaA93VpkkzSwj
	hsWqZtx+OB0Rog1YZgtf/a+RO4PYSM4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
Date: Mon, 14 Apr 2025 10:45:49 +0200
Message-ID: <87mscj5dxe.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The Makefile supports a target called 'hdr-check', which checks if
> individual header files can be independently compiled. Let's port this
> functionality to meson, our new build system too. The implementation
> resembles that of the Makefile and provides the same check.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 790d178007..6fce1aa618 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -655,6 +655,12 @@ if git.found()
>    endforeach
>  endif
>  
> +headers_generated = [
> +  'command-list.h',
> +  'config-list.h',
> +  'hook-list.h'
> +]

Can we maybe compose this list by instead doing:

    generated_headers = []
    foreach f : builtin_sources + libgit_sources + third_party_sources
      if f.endswith(".h")
        generated_headers += f
      endif
    endforeach

(This would take `third_party_sources` into account as suggested by
Patrick[1]).

If we consider that too much magic, I would suggest:

    generated_headers = []
    builtin_sources += custom_target(
      output: 'config-list.h',
      command: [
        shell,
        meson.current_source_dir() + '/generate-configlist.sh',
        meson.current_source_dir(),
        '@OUTPUT@',
      ],
      env: script_environment,
    )
    generated_headers += 'config-list.h'

I hope this would reduce the chance to forget to add more headers to
this list (assuming people copy the code blurb from another location).

--
Toon
