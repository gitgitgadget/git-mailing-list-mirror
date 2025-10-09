Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0402836A3
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049839; cv=none; b=aD7Qb2hf0r3OJZ0MwX6Rc9tkcJPIcaSBbF1sweWArgJ55A3TqeiDfFmdRg2X/KuNAh6NI7O2AlWmm4SvJWje4245jg2uToufwRqQcqT0AdWJMyBoAAEkwd82yKMm3vo5DDkUrifze1fIGXmX3VTuQ2lmDWqQhcjlcfmNnZk2eME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049839; c=relaxed/simple;
	bh=NsKbKRbfdcQpNPCd2hWteeo2SQyXw0B9pzGxxTGoCNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFEXdpXKohADzm3GYwO5IsycgA9XWxYlXSKcBCkj434qdoRAlgE7Bq05IwvmowrzXRCvqSp35p5N/4CG0mdVZGxJUZ2W83RfQwhztrEsLipqY+9fYoKij6P3nf0i9TFr2aPPU/CUdYKFPKPGgkqn3K5y5gPVQRjUxrRXIp32dSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=N9wK0xV/; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="N9wK0xV/"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760049823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6u02fQeG6CdtVx10QeEHiditAt7QCmV5a+B4q9OYmco=;
	b=N9wK0xV/KRFadJoHjcJgi2561/rfOrfSkbTTjcRirZZ9InGKZ8si1xLyK+3xrcfaqPi9yY
	Wzx48UESHEpztlfx4VOAt0dAJ2o3AJdZRx6STqfrPH1caRcKl0ZXyx2QN3cu7Qe455FMMf
	gEqRw3mfAD1YQeek3TfQ70PywlLxUlUhKMPz0s0kVvRuwPFfDIWeuMGdVabjCG/fyvfUzI
	7Q9Ww/jIw+del+9Fziq+8DvxgVmU4V34UwPUMFrhJ0aTcfFW96GFSlYPbuPKIqTQ7fNG0D
	gDDEFA4WmoTwu/3Kc9yZW6kHIWmZZoWIdPJFKgMFT8vNw6K5sRxQTEAz7U/vaw==
To: peff@peff.net
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: Re: [RCF] Secure git against involuntary arb. code execution without feature loss
Date: Fri, 10 Oct 2025 00:43:17 +0200
Message-ID: <20251009224317.77565-1-git@lohmann.sh>
In-Reply-To: <20251009052422.GA1614343@coredump.intra.peff.net>
References: <20251009052422.GA1614343@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: Thanks to all peoples input I just mentally untangeled/refactored
a few things about the discusion for myself:

* Current situation:
    git assumes an unsafe repo, if neither
        a) the user owns it, nor
        b) it is included in "safe.directory" config
    and then refuses any operation.

* Suggestions from the discussion:
1) The suggested "token" approach is just an additional way to set the
   current state of allow "safe.directory" for repos _created_ by this
   user
2) The suggested --assume-(un)safe / GIT_ASSUME_(UN)SAFE are additional
   ways of setting the same state temporarily
3) There are suggested improvements on not blankly refusing operation at
   all if assumed to be unsafe
4) The _enforcement_ part of the RFC is about dropping the check for the
   owner of the repo to assume if safe or not

I think 1)-3) are relatively independent of one another to discuss,
whereas 4) probably requires all others to be viable.



And now for the long answer:

> We've discussed this a few times over the years. The most recent one I
> can remember is:
>
>   https://lore.kernel.org/git/ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net/
>
>   1. How does Git behave differently in an "unsafe" context?
>      In the thread above, I propose that it should skip loading config
>      from the repo-level $GIT_DIR/config file, and turn off hooks
>      inside the repo.

Indeed it would be a lot nicer, if git still worked and only showed a
(maybe hideable) warning. As mentioned in the above conversation, the
config parser could only extract the minimum required fields in the
assumed unsafe state and the hooks would be disabled, too.

>   2. How does the user tell Git which repos are safe or unsafe? You've
>      got a scheme here for marking user-created repositories with a
>      secret token. I think that could work, but there are other simpler
>      methods. E.g., we could pass down information through the
>      environment

I am not sure I can follow you. Just as an overwrite like you mentioned
below / as in suggestion 2)?

>      or mark a list of safe directories in user- or system-level
>      config (like we have already with safe.directories).
>      It's perhaps even reasonable to have multiple such mechanisms, as
>      they have different tradeoffs in convenience and security.

Indeed! E.g. for "automated trusting" on init/clone the path based
approach is probably not the best, since
a) if the user runs `git init /trusted && mv /trusted /elsewhere`, all
   of the sudden git would no longer work in that repo and
b) now the path "/trusted" is vulnerable, unknown to the user.

> So in some sense I think talking about this token scheme and Git 3.0
> compatibility is putting the cart before the horse. We need (1) first.

IMHO, an option on how to _detect_ if this repo is a "safe.directory"
would not depend on improvements on how to _act_ upon it (or the other
way around). Yes - to _enforce_ not whitelisting all user owned repos by
default any more, both are probably needed. So indeed this part is more
speculative.

-Michael
