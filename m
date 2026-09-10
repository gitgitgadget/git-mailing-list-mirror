Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930AF29A309
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015746; cv=none; b=fkzvvai0gdsJow6fXHTkyHCyBLPgBCC9CWE+7FvlVodERlpXbLPUF2kcL3CoRqBsuo7MBCGLhU9W+8wQ1w6joAE6v4628gph3ZuB2pixWFYTam9OB8YdlRJk9kNF6WPNkum46V1mkJ+GWuiPrWBvxqBnMwoKu0bvqdWOTP3Cfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015746; c=relaxed/simple;
	bh=JFOv2Jd4oflNliMNUrm2csSEBDBHW5xrKghoXPJ78Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKevmLmw7U+21Lj80qpdRCuqXVxJfXSUEeCBzHmcCxNTpaRhGrdWod27FVGPeLQaSNeGH7b5VPh26aW2gL6EPyz0autp/PONgkRNJh48FkR7bfUBcwnhxnmipdQgr3XOLhuFOXlBD17kuGIYBQwmA3XkdjuM9XrhILUTQI9eMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fx3PAVhP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fx3PAVhP"
Received: from MacBookPro (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB68020B7166;
	Wed,  9 Sep 2026 21:48:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB68020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789015704;
	bh=8QiKDVWz2F0K3PFCZV9cSdxYhbQ72JZcfjU1AqvdbCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fx3PAVhPA9bbGUk5wgu66Jh6zEutI5DIUJ2X4aw3T+S+IAiAMbiX+ZeYKjjKTc5Yt
	 psB42mlCYAdatKVRLj+I1Kunm09okQcXGjhGwm4r2QISDo5UBGDJ8LAjp9gr1fxW5o
	 IeRPZGZs0CmoSEybBa5m0Qov7/fPKBfWQA8R2drc=
Date: Thu, 10 Sep 2026 14:48:54 +1000
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Nils Fahldieck <nils@fahldieck.de>, 
	Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Delilah Ashley Wu <delilahwu@microsoft.com>, Derrick Stolee <stolee@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] path: use forward slashes in XDG config on Windows
Message-ID: <aqIvJhLLcCSnyaL4-delilahwu@linux.microsoft.com>
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
 <20260823-fix-config-list-global-home-and-xdg-v2-1-b29cc63f017b@microsoft.com>
 <xmqqecfkhify.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecfkhify.fsf@gitster.g>

Thanks for the reviews! I'm still working through the feedback for v3.


On Wed, Aug 26, 2026 at 10:58:57AM +1000, Junio C Hamano wrote:
> Is this "force forwared slashes to Windows users" a required part of
> XDG/HOME global fix?  If not, please leave it out of the topic. [...]
> Again, I do not see it explained why this change has to be part of
> this series in the proposed log message, so...?

Sorry, I forgot to explain in the log message that this change is
supposed to supplement the `--show-origin` tests added in patch 3
(config: read global scope via config_sequence). Without it, the
`--show-origin` would output a path with mixed slashes on Windows:

    file:"C:\\Users\\delilah/.config/git/config"    xdg.foo=bar

The tests expect paths containing only forward slashes. So patch 3
modifies `t1300-config.sh` assertions to look like this:

    echo "file:$HOME/.config/git/config    xdg.config=xdg" >expect
    git config list --global --show-origin >actual
    test_cmp expect actual

where `$HOME` has been normalised to contain forward slashes only, as
seen at `t1300-config.sh:2179`, which was introduced in 45bf329 (t1300:
fix the new --show-origin tests on Windows):

    HOME="$(pwd)" # convert to Windows path


> Even if it is a good idea to always force forward slashes to Windows
> users (I have no strong opinions on the topic), and if it is very
> unlikely to break existing Windows users (I do not have any clue if
> that would be the case or not, as I do not do Windows), we would
> want to make sure if we can get the same effect without sprinkling
> "#ifdef" in the platform agnostic part of the codebase like "path.c"
> file.

I followed an existing usage of `#ifdef GIT_WINDOWS_NATIVE` and
`convert_slashes()` in `path.c`, but if it's no longer allowed in the
platform agnostic part, we could do the slash conversion elsewhere. This
assumes we want to keep converting the slashes, but we should reconsider
from your points raised below.


> Where would the slash in "ret" that is passed to convert_slashes()
> function come from?  If they come from environment variables like
> XDG_CONFIG_HOME and HOME, that is end-user's preference and we have
> no business forcing them which forms of slashes to use.

The slash in `ret` would come from the environment variables, so perhaps
we should not modify the slashes in them at all. Instead, I could drop
this patch and change the tests in patch 3 to export a `XDG_CONFIG_HOME`
value containing only forward slashes. This would satisfy the assumption
that paths in the tests will contain only forward slashes. What do you
think?


Thanks!
Delilah =)
