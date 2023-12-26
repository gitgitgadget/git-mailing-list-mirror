Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E94F885
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lD2K3lK7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 727A331964;
	Tue, 26 Dec 2023 12:14:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lCKBdySlZ3Ee7VWMdfk8IZEgh5zjt68p+YugF/
	g8qBQ=; b=lD2K3lK7xVoM/5icSFQ4iw2eJPclhQGGZhwPyutNr5u1OvTinZBUQX
	rf2fZIM7KyNVuxoVmKGSRWNa9J98IBTsRj+fEQnnuPsHLLhId3WW57bZ55efW07G
	YJsROl/XGLREztRWX1GnEaMrBjqVI523A5eugih+hYSXoPe3W7Kuw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AB3F31963;
	Tue, 26 Dec 2023 12:14:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18D9531961;
	Tue, 26 Dec 2023 12:14:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] sideband.c: replace int with size_t for clarity
In-Reply-To: <pull.1625.git.1703264469238.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Fri, 22 Dec 2023 17:01:09
	+0000")
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
Date: Tue, 26 Dec 2023 09:14:26 -0800
Message-ID: <xmqqo7ecj37x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39CD1F88-A412-11EE-8D46-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> +static void maybe_colorize_sideband(struct strbuf *dest, const char *src, size_t n)

Changing the type of the paramter alone might be a good start, but
does not really help anybody, as (1) the callers are not taught to
handle wider integral types for the values they pass and (2) the
function uses "int len" it computes internally to compare with "n".

There are three callers in demultiplex_sideband(), one of whose
paramters is "int len" and is passed to this function in one of
these calls.  Among the other two, one uses "int linelen" derived
from scanning the piece of memory read from sideband via strpbrk(),
and the other uses strlen(b) which is the length of the "remainder"
of the same buffer after the loop that processes one line at a time
using the said strpbrk() is done with the complete lines in the
early part.

The buffer involved in all of the above stores bytes taken from a
packet received via the pkt-line interface, which is capable of
transferring only 64kB at a time.

I _think_ the most productive use of our time is to replace the
NEEDSWORK with a comment saying why it is fine to use "int" here to
avoid tempting the next developer to come up with this patch
again---they will waste their time to do so without thinking it
through if we leave the (incomplete) NEEDSWORK comment, I am afraid.

