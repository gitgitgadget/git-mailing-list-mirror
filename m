Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0D189BB6
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796574; cv=none; b=aZqXfTVy4gkYNSdPpEewnsdQ11uVxZqwee7495yLw6rwxGA4Xu1av4ycPjnVvsfEll9kzZID5Nuv/f3fRARLdMnl7APPa2Epwtj4gDtk66RRzRkqe3xYPQawO9flWri1t/Oni3GJKqozQhGHcze7JS79dz0PiOkKjdSpf0AQzeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796574; c=relaxed/simple;
	bh=0/W8K/dTbrxiYQlSha/lCQ74/eQeAecfwg6WbaqtDJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD0DUvVMj9mwBRUEtOSu/DlloQxt4nfjTT3+BomqzFonlHANwpfik/wOPGmNcmGzKSpomieqG8eVPcusNdbhmeaDrzPrpcSq1K6ni9Mss+Sq8ga247PatbNR4c7UkTDhC4DAmbKkPkD9Du247EZpC6VA5lJ0yqHRzA6iZtoE61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VDLg8y9D; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VDLg8y9D"
Received: (qmail 243969 invoked by uid 109); 3 Dec 2025 21:16:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0/W8K/dTbrxiYQlSha/lCQ74/eQeAecfwg6WbaqtDJ0=; b=VDLg8y9D+Y28dKd3kUJ5N3BIJlsxbFCXtkEoXyw+D9M6I7TQzFjFrmR5Eb5/qysnQS5mPtumRSdk5Ahowz4bmy1ifC+7IrNxsdfcUlGVWFA0wAgfZnvO1yVl0PbrGkjhp3cgG1sSYELORCxGqIxHIG/qhGOP81vcP1RwIiyXQh6XuPkFNVQBM85qLScOg8mbQiKmFz4gipmI0h8G6LwX2Trr/tkGc0MJRTpsXDY49ExP7PlTKDM5r3l98IQ8JVL3f+8g6fmgQYtJGEtsm64V/4E0pqIJ9v2lnXrs/JJtM6cABgBjFaGTKdy5a85BCw4YVJ9w1PY2nVFqDY3JbRCQCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Dec 2025 21:16:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 310851 invoked by uid 111); 3 Dec 2025 21:16:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Dec 2025 16:16:13 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Dec 2025 16:16:10 -0500
From: Jeff King <peff@peff.net>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <20251203211610.GA64204@coredump.intra.peff.net>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>

On Tue, Dec 02, 2025 at 03:07:27PM +0000, Paulo Casaretto via GitGitGadget wrote:

> The .lock.pid file is created when a lock is acquired (if enabled), and
> automatically cleaned up when the lock is released (via commit or
> rollback). The file is registered as a tempfile so it gets cleaned up
> by signal and atexit handlers if the process terminates abnormally.

I'm sympathetic to the goal of this series, and the implementation looks
cleanly done. But I wonder if there might be some system-level side
effects that make these .pid files awkward.

Temporarily having an extra .git/index.lock.pid file is probably not a
big deal. But for other namespaces, like refs, we're colliding with
names that have other meanings. So if we want to update refs/heads/foo,
for example, we'll create refs/heads/foo.lock now. And after your patch,
also refs/heads/foo.lock.pid.

The ".lock" suffix is special, in that we disallow it in a refname and
know to skip it when iterating over loose refs. But for the ".pid"
variant, we run the risk of colliding with a real branch named
"foo.lock.pid", both for reading and writing.

On the writing side, creating foo.lock.pid may accidentally overwrite an
existing branch. This can be mitigated by using O_EXCL when creating the
pid file.

But we can see the writes in the opposite order, which I think can also
lead to data loss. Something like:

  - process A wants to write branch "foo", so it holds
    refs/heads/foo.lock and now also the matching foo.lock.pid

  - process B wants to write branch "foo.lock.pid", so it holds
    refs/heads/foo.lock.pid.lock (and the matching pid)

  - process B finishes its write and atomically renames
    foo.lock.pid.lock into foo.lock.pid. It's expected to overwrite
    the existing file there, so now process A's pid file is gone.

  - process A finishes its write and tries to clean up its pid file.  So
    it deletes foo.lock.pid, which contains the actual data from process
    B's write.

And now process B's write has been lost (and maybe even the entire
existence of the foo.lock.pid branch, if it was not also present in the
packed-refs file).

On the reading side, anybody iterating refs/heads/ may racily see the
foo.lock.pid file and think it is supposed to be an actual ref. So they
open it, find it contains garbage, and then flag it as an error.

I think both could be mitigated if we disallowed ".lock.pid" as a suffix
in refnames, but that is a big user-facing change.

In the long run, alternate ref stores like reftable won't suffer from
this issue. It's possible there are other spots where we use lockfiles
alongside arbitrarily-named files, though I couldn't think of any.

So I dunno what that means for your patch. I notice that the user has to
enable the feature manually. But it feels more like it should be
selective based on which subsystem is using the lockfile (so refs would
never want it, but other lockfiles/tempfiles might).

-Peff
