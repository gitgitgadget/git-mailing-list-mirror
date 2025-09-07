Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDB17996
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757288108; cv=none; b=IVW8G/4kJB9rX9iiuUXDjE4kuZOG0oHbehmH0RN30wCFUpd+nYwvTUqny2jWYiOKEzh0HbTFjVz8mzH4ZXsmz09mXQjCjThHvKSFUFK1kU7ixt0rSsfPvRfJ2cc7bsf2+E2YaST3i3PM68BQpJ611GfUs4czTMyCWATIpeGJ/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757288108; c=relaxed/simple;
	bh=xRgzr/+T9aGun5z8rGoj+9cZFNFL80g9+p/Q23HpkRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP/CL2qqV6W3pTYgBoBHv1qvsExfOYt0bYgu1WM1z8DhFDFdZKkVi5jKMNbVmiy+hXxIduNuMSt7JeNSBPdz0SQfQ3BRwzKfwGt7FLjI9552DRUF+RdNmE0w2YZSbl8K7Zh8o8uoye7hscDGonN3fwGHnlCYBmCtVDfOh3PF/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M2FHCd/T; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M2FHCd/T"
Received: (qmail 13421 invoked by uid 109); 7 Sep 2025 23:34:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xRgzr/+T9aGun5z8rGoj+9cZFNFL80g9+p/Q23HpkRM=; b=M2FHCd/TaRiBTR45E527ihnmRXqmMsvwR66tSs/C0DhH4e5FA3b/IK3TXJnj7l012UVZowQidCxXaccsmj+/Vb7EY4cWV0WUXStnJLDgO0H9penUWRmag0cU6P62cfjoxT/cZzmNf53obBD94BKX5FLBBO0E1Aji66kaLByTm79aUtx5joH7i/A6+e9dlbWnMobZYOVBW5VA65vv4joILt9hJJWppQAUfSGZhUGoCkcNFVsh/TKxLNj3e0qEnBJ4tgqVQHTU0xTgocYMtOgkRGw+VyMW1EWtzblVASX0ig7reSuCGCIUdAPeIawh492cH527grjs6Xhi2G+aE0EMHg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Sep 2025 23:34:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23481 invoked by uid 111); 7 Sep 2025 23:34:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 07 Sep 2025 19:34:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 7 Sep 2025 19:34:56 -0400
From: Jeff King <peff@peff.net>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
Message-ID: <20250907233456.GA1281511@coredump.intra.peff.net>
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>

On Sat, Sep 06, 2025 at 07:02:53PM -0700, Jon Forrest wrote:

> Apparently the presence of even 1 invalid file invalidates
> the whole 'git add' command, no matter how many valid files
> are included.
> 
> Is this deliberate?

Yes. The C code here goes back to f25933987f (builtin-add: warn on
unmatched pathspecs, 2006-05-17), which is in turn adapting 45e48120bb
(Detect misspelled pathspec to git-add, 2006-02-15) from the shell
version. Which is pulling the same feature from git-commit's bba319b5ce
(commit: detect misspelled pathspec while making a partial commit.,
2006-02-14). Which in turn from this thread:

  https://lore.kernel.org/git/7vfymlr7n8.fsf@assigned-by-dhcp.cox.net/

sounds like it came from cogito. I didn't follow the trail to the #git
archives mentioned there. ;)

Interestingly Pasky does mention that cogito behaved as you expected
(quietly ignoring a single misspelling) and considered it a bug.

I guess one could argue either way (though probably not at this point in
time, as switching behaviors would cause confusion). But one challenge
with "partial success" like this is that the exit code is binary. If we
return "0" even though some items were ignored, callers may miss a
failure. If we return "1" even though some items were added, callers may
not realize they've mutated the state (and might need to rollback
depending on what they were trying to accomplish).

I think Git's philosophy is along the lines of: if we are not sure your
command was well-formed, do nothing. You can always re-issue the command
with a corrected set of arguments.

-Peff
