Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF8485CE7
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369435; cv=none; b=WWugyeW843I/BHujN1kNoJ0hP7Uo17VZ2+lcNjtsyZlhf30Mg5YGpJ1wW95MH7j7MS8sVoaX/vZ1Xz0JJzY4ztts3YDCFqFlhs8H/MPjMbNl5eAuaX24NjiDfDOyVU69Hxuffudh6WOikKQYh9XGDciVUilYKsA60fOgSVZrMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369435; c=relaxed/simple;
	bh=UiC1gKlgXkoHm2RBeRDg4lxCNSZ6sqr7Ku8ISAIKDyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUzT+jX0LD+ei+l9OKzhm4mbXhi3uz/CNX5bQfK4NZo7Qu3rY77hPyFHHOK3khan9ukYTyXZwUnu2qc4PRSdyjkek0KnQ45eLNJQ7DtRpEyFsQuIpWJII87NNFc34D1tPk+1jyfLO+mPEcWln0HTcAGq3OA70htabgMfyIvXkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4j08gN3zkjzRq2G;
	Wed,  7 Oct 2026 12:36:32 +0200 (CEST)
Message-ID: <09ed5eac-b9fc-4927-8425-1d17b599b73b@kdbg.org>
Date: Wed, 7 Oct 2026 12:36:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through
 remotes
To: Hanan Arshad <hananarshad619@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, gitster@pobox.com
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
 <20261005055337.7579-1-hananarshad619@gmail.com>
 <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org>
 <CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com>
 <7012706b-516b-4cd9-abf3-0144093e0779@kdbg.org>
 <CAKPibBwjRSb5cXd2iWo8bbYby1odcXNazEg-D9hcqbehrR6g3w@mail.gmail.com>
 <xmqqzewsmaod.fsf@gitster.g> <20261007063155.4573-1-hananarshad619@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20261007063155.4573-1-hananarshad619@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.10.26 um 08:31 schrieb Hanan Arshad:
> A tester may need to apply the same configuration while testing
> different branches or revisions, for example:
> 
>     branch A       + configuration X
>     branch B       + configuration X
>     release branch + configuration X
> 
> Using a branch for configuration X makes it another line of history
> based on some revision. When the code being tested changes, that
> configuration then has to be merged, rebased, cherry-picked, or
> otherwise combined with the revision being tested.
You are overthinking the required workflow.

Nobody claims that you have to keep the configuration X change on an
additional branch for each of the working branches. You would use a
branch only to transfer the configuration X change to other clones. You
don't work on that branch.

In the repository that wants to publish configuration X, you commit the
modifications on ONE branch (doesn't matter which one, say "release"):

	git switch -c configuration-X
	git commit -m"configuration X" -a  # or the config file name
	git push origin +configuration-X
	git checkout release

At this point the state is as if you had run `git stash push` on branch
"release", except the change is on a branch, not in a stash.

Then while on the first branch in a new (or old) clone that needs
configuration X, you run

	git fetch origin
	git show origin/configuration-X | git apply -3

ONCE, which leaves the modifications uncommitted (if there are no
conflicts). From here on, you would use the local stash to transfer the
modifications to other branches, just as you would have done with a
transferred stash.

-- Hannes

