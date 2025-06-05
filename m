Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328A1FCFFB
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109985; cv=none; b=P7vSC3SF0u5+UwERO6IfkgozmPASwUHSOg9AzjKyNrQ5cpYRTLjI7O2/l/KKZULhpXdeH3f59OciXEsmIovG+GvFR5zehWDwyw2S962k3Par+1MVVMjQiCnjLtUvWtkPjcXE07/vJ9+ipdr6sAtuB6ZGPWBMJQ6f9ojNnffBX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109985; c=relaxed/simple;
	bh=We6kvhRjm/T2gTOCm3+dccn7I+EDemBitnoRcEyqgQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN92B9nlgn+6Ir+thbrLSMwb1wzddhVgVTa0yZwgyDYE77QAx4CtQRbDeyh2bEotVn20IP594Y8do7yOWCHem75oB2AVqEcaMJx6qYayCIXGk9/7x/tq8olzvlbCX09tW9xAvMLnwO6L8SPTgi+Dup1M9LTtZWw78lXHgV2VlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N0x7Fey6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N0x7Fey6"
Received: (qmail 17352 invoked by uid 109); 5 Jun 2025 07:53:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=We6kvhRjm/T2gTOCm3+dccn7I+EDemBitnoRcEyqgQc=; b=N0x7Fey6dDkmuphK/9Z394a8+6Fjr5jQJHmZtEmOGTnF3w2wW3zSFA4IqMdfZGI9hOeINd6YGTKMI5iPu4axh14mGRIqlrshf171nIlsaGn4FnqH9KKA7LMXE1tz5HAeV8LQU3r7w8FNYown3B7cgsGYoiYIeIxvHMQnuc00S8K8jMGKHUDWDyNI7/oLO0HCu8ONmQJChJf1966eXc8XV9QxV5Jm8E+fETvrFIEcwuOTJzs04eOHj7jf6+cE1T6jKcfMYjIslyiuiek6dkdKdsADLn01j6ajrIv6psW0Hhnuy5fC58juUIp3yXFoHiexYogkKB9AmqcmGO/KfAXdJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 07:53:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21459 invoked by uid 111); 5 Jun 2025 07:53:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 03:53:06 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 03:53:01 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] repo_logmsg_reencode: fix memory leak when use
 repo_logmsg_reencode()
Message-ID: <20250605075301.GD2066712@coredump.intra.peff.net>
References: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
 <pull.1988.v2.git.git.1749104846531.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1988.v2.git.git.1749104846531.gitgitgadget@gmail.com>

On Thu, Jun 05, 2025 at 06:27:26AM +0000, Lidong Yan via GitGitGadget wrote:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> pretty.c:repo_logmsg_reencode() allocated memory should be freed with
> repo_unuse_commit_buffer(). Callers sometimes forgot free it at exit
> point. Add `repo_unuse_commit_buffer()` in insert_records_from_trailers
> at builtin/shortlog.c and create_commit at builtin/replay.c

The patch here looks fine, and I can confirm with the hacky test-patch
I showed elsewhere in the thread that the case in replay.c is fixed.

I don't think the shortlog one is triggered by the test suite, and it's
probably not worth adding a specific test for a commit with no header
separator.

-Peff
