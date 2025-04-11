Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC118C011
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398176; cv=none; b=vFuhXA4uP1uPg+xekkxN4WWi2c/FuDmaSxAbZQ7mFbDFstw95usEtKo1OP/4Jx7xtSib9YIqOoYDDIsKdN1+iiid7GZQg2cixYdZXge5/d8pbQNVZqYxObGc5LGEED8cxNbSuMsdGxM8vfTK0CtGODcyrTXoXEHUefwm1DSrsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398176; c=relaxed/simple;
	bh=xL657b5hnhpSEEbQyGaZYxcVqQ5eREZkNUN78ukvbX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SavNo/yC39rRBXC7WnVq/3YXRmBHdKbzSYem0Mq9visGdjyr918Pg+LeIsNUlAubbQPsvRzd5vpwGTBwVByKeRh32KbJKZFrgEpfwOUub+KhC31W5oVH7bLTJ0pahdss7Q9nGq0IEbAddWARXC/FhM5oeU6+eaPJ9WQ/5Oqt9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=CYJGDM0U; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="CYJGDM0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1744398167; bh=xL657b5hnhpSEEbQyGaZYxcVqQ5eREZkNUN78ukvbX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYJGDM0UCT84meBSvAzMwxJz15XL0UCDutZnlfGTm/7hIK1oDTY6fv2ZiEpS3CmE9
	 5R9YTWPKhSUJk4f+b7Ep2YtBkL2Lg3mBxINolRjb92SWNeg/IThlhsB/YrIhgcz2Y6
	 5tVMYI73WvZ/tuyt5aZHNv1axv7L9qK41N0VW64vN72KRp+mXh7+rANPrDvD2gkNdz
	 yiKZJm4k91lXK/7TdHbMfXIr3PyCaCth3d7/qg+Y0DUX5l7fn54nKzBbGMVpRaYfG2
	 RF1WnEF0xk77MngxzUrINYi0HpXYzvXS8PbITyJ87cp0x0QIxw5QHjp56FEdtucUYT
	 H3RY3FLoTLRnw==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id 4E10D1120FB9; Fri, 11 Apr 2025 21:02:47 +0200 (CEST)
Date: Fri, 11 Apr 2025 19:02:47 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org
Subject: Re: Way to "impersonate" remote or sync remotes without fetching
 everything?
Message-ID: <669a6a0f-bcfb-4596-a0c8-73c722a6ec10@frank.fyi>
User-Agent: Mozilla Thunderbird
References: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
 <CALnO6CCUHE6-RcZkTBYT-CeXHnYPBPe1eGSogWd7=5tK5NyuxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: de-DE, en-US-large, en-US
Content-Disposition: inline
In-Reply-To: <CALnO6CCUHE6-RcZkTBYT-CeXHnYPBPe1eGSogWd7=5tK5NyuxA@mail.gmail.com>

On 2025-04-11 20:43:24, D. Ben Knoble wrote:
> Maybe I haven't totally understood your use-case, but what if the
> authoritative source is your local repository, and then you push to

There is no local repository, that's kinda the source of all of this.
The sync script runs in a CI/CD. I'm kinda abusing CI/CD here to run
a kind of cron job, in a separate repository that does the sync, maybe it
is easier to just call it scheduled pipeline/action or just stateless 
cron job?

Lets make a more quick example:

gdm is being developed here: https://gitlab.gnome.org/GNOME/gdm
so in order to make a PR I'll have to create a fork in that GitLab
instance so now we're at 2 repositories. Then I want to have my own
independent archive mirror in my own gitlab instance. Then I also
want to mirror it onto gitlab.com and github.com just for the sake of
this example. Now we're at 5 remotes.

Now I'd like to have a script in CI/CD (that runs server side) to sync
all of them. In example the gnome.org one could probably mostly be the
autoritative source (except for the branches that contain my changes).

