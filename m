Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CD221FDA
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961356; cv=none; b=H48PDJ4PYRwQjQR61FOCQwB6K1WnYcQJcK5JmZf9YVZNRGRct10HUSbERHqb+w5I0j0KiEg+nKVz34K/DvSr/a2BzD2rkHGPjr3qTzYpNT4/e/Kk7AgDjK/+BycxG6ZXnCviU9xnbQQ5l+VYARm/DV6b0/BIQvEKKnIL8AXnlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961356; c=relaxed/simple;
	bh=NyA6lI65Q+ux1yWI/Q1JBnEBYFjpktPtMx7DfZpN3o4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c1l6JU+eRwCSip6VuwDMfzXDYIrIHmIet2SLGqM65hJt5oplD7ZRwmecmL7MuK2JbryqXKpM3NBRggkhaJbGtEVjBy0PUIjDpBV0GZoVOfuanj9UOejqgbIVXXKMDRkCqoavC1BiuEMWcknjHlCmNVdrbJxYWynSgQz+3P0M4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=hmwxEKu6; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="hmwxEKu6"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1759961343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6a7Olxnj97VcoqIzusCh385aksAsiOtm7h8rL4MJasc=;
	b=hmwxEKu6R+9B380yEOS0iR3XeeyrW9/IgCWVfzEh+fxH+6pZlv266EK0+7IzX7R6kQjXP8
	QBBfe24RAFYYvF/8VWIvkKG96vLGyMk2ZJP1T3CqhuxPBIn5CWjpxG6pYceGZ9+fUgCLzT
	trwTYlOMNqm2FA38EYnB2w5beGVsNKOx8mXg3t0s+jeVLFmkc01lvHV7X8LtTjVQn4qH7I
	mSWu+p6s6D+wLCA05mWz/v9g6vi6UF7R7rb5CD7PQZTjMRH7Ics5GHHCghC3iBtzYUt32N
	JzepjOKJvcXrnfR5dlElcQMoTxvgIBWJ+jHvEk11FoXprLrLqaEl9FiTkUhYtg==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.33\))
Subject: Re: [RCF] Secure git against involuntary arb. code execution without
 feature loss
From: Michael Lohmann <git@lohmann.sh>
In-Reply-To: <aObceC/Ec/TGTEnv@nand.local>
Date: Thu, 9 Oct 2025 00:09:03 +0200
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <25FB37DC-09F3-41F4-ACFE-6F8A854E50B8@lohmann.sh>
References: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
 <aObX4C7lMHRnjbYq@nand.local> <aObceC/Ec/TGTEnv@nand.local>
To: Taylor Blau <me@ttaylorr.com>



> On 8. Oct 2025, at 23:49, Taylor Blau <me@ttaylorr.com> wrote:
> 
> On Wed, Oct 08, 2025 at 05:30:08PM -0400, Taylor Blau wrote:
>> On Wed, Oct 08, 2025 at 11:02:03PM +0200, Michael Lohmann wrote:
>>> * Proposed solution (keeping all existing features):
>>> - On first use, git generates a secret "token" (e.g. a random string in
>>>  ~/.gitsecret)
>>> - On calling `git init` or `git clone`, the secret is copied into the
>>>  new .git directory and serves as proof that this clone was created by
>>>  this user
>> 
>> Sure, but the problem is not with direct clones (at least, not using the
>> --local optimization), but with clones that recursively clone other
>> submodules.
> 
> This is a think-o. I meant to ask whether or not we would respect the
> token from the top-most $GIT_DIR in nested bare repositories. I imagine
> we would not (otherwise this proposal would not provide any additional
> security guarantees), and so...


My understanding was that submodules would add their own git folder in
the top-level .git/modules/my-submodule, so obviously in order to trust
a submodule, you need to "sign" these too and you could automatically
also with --recursive.

(Sorry @Taylor - I missed adding the whole list as recipient, so you get
this twice...)
