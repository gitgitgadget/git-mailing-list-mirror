Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916143D79
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Af6jtfyK"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71AD4E
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 16:48:11 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA041C4CFF;
	Mon, 13 Nov 2023 19:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=doqZUcl0qHACDqIcreB/lTE4A8llW1oZOKrrtB
	coM7U=; b=Af6jtfyK/gAPRMhntpegmMxUxb2Ck5qD9B4l3ibYX2KQ07+L1Ku01q
	RtUOvE1dK00ZKTzjbOKdvHjvACadapzRDry+1y5tQ48Npk8tpirnQL6/bH/ZfiZk
	gkRwvXRVD4pv0BMLNv/+w2LFsJIIy2gTwtUSLQwDgUGc8dB9zO1kI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B45E61C4CFE;
	Mon, 13 Nov 2023 19:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 221171C4CFC;
	Mon, 13 Nov 2023 19:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH 02/13] Enable builds for z/OS.
In-Reply-To: <098b9ca8ece4fdce45a9b48e576b474ed81dced1.1699871056.git.gitgitgadget@gmail.com>
	(Haritha D. via GitGitGadget's message of "Mon, 13 Nov 2023 10:24:04
	+0000")
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
	<098b9ca8ece4fdce45a9b48e576b474ed81dced1.1699871056.git.gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 09:48:09 +0900
Message-ID: <xmqqcywd2m9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7BA37A58-8287-11EE-8E29-25B3960A682E-77302942!pb-smtp2.pobox.com

"Haritha D via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 02/13] Enable builds for z/OS.

Documentation/CodingGuidelines and Documentation/SubmittingPatches
would help here, I think.

>  # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
>  #
> +# Define SHELL_PATH_FOR_SCRIPTS to a POSIX shell if your /bin/sh is broken.

The reason to exist for the _FOR_SCRIPTS variants is not justified
anywhere in the proposed log message.

The former should be sufficient, and our policy is to let the
builder specify exactly what binaries the build products depend on,
(instead of random $PATH interfere with the choice by using
"#!/bin/env tool" that also has to assume that everybody's "env" is
installed in "/bin").

This patch has too many #ifdefs in the primary codepaths.  Your
porting strategy may need to be rethought.  Our usual convention is
to encapsulate these platform differences as much as possible in
git-compat-util.h and platform specific files in compat/ directory.

> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 5ffec99dcea..b33b32ff977 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -57,11 +57,39 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
>  	maybe_flush_or_die(stdout, "hash to stdout");
>  }
>  
> +#ifdef __MVS__
> +#  if (__CHARSET_LIB == 1)
> +#  include <stdio.h>
> +#  include <stdlib.h>
> +
> +   int setbinaryfd(int fd)
> +   {
> +     attrib_t attr;
> +     int rc;

Ahh, OK, I saw [03/13] first and was utterly confused by this thing.
Do not send in such a mess that introduces broken code in an early
step that you need to later say "oops that one was broken and I need
to fix it up with this patch".  "rebase -i" is your friend to clean
up your mess into a logical progression to help readers better
understand what you wrote.

I'll stop here.
