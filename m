Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A593C0613
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975818; cv=none; b=ciDfV+bDbZVRqN2cUobS6dNts4Z3idU+RrDul/XjoEbsz0XSbwS4L1+vE4FMcaIy2JLEdfyq5OAQEACDAQCUTP/GS6nsp79xQatbE+JbGhMF9Qoe4l8ZvUmeMixivj9Wl6xmP2ceoXt80kOAoVljB7cCj5/uEotug/A59z+yMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975818; c=relaxed/simple;
	bh=EJQSATRvIo5B2rzYg9nUZgyQsJyZFmrv8nPoeUbZn1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYrcj5ggCVp7B64JEUvw40PT+SxWpcJoS1GS9NUszoPOVXlxcQ9qnzYa5z0q9xxd8345pKrPdPthIqV707RZhFBgtGNHKhN/KGgHk+4aMVgtM50nk4BbSwBZhyp5Hqw+hAR3oY+8IIawkbOnaZzI9LA74IaDpP0GrvTm/IWMTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WGpOojv2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WGpOojv2"
Received: (qmail 69393 invoked by uid 106); 14 Oct 2026 11:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EJQSATRvIo5B2rzYg9nUZgyQsJyZFmrv8nPoeUbZn1s=; b=WGpOojv2ne7sI2MiZEK7ooxWHCJHmjMuuEVf90/czrTmLY/6SAu2AWfeKGsqgoKLWdhLv/+WtL3dgVZihrYbLQ39ikj9RuC+GDsSuQUYDuwwIsgGqZPEzgfxHLP4qTYZt2ycBGk6WGrVAnbE6tB3mKB83ct1vn8mPjyD7TURC34Xe+LE8pfTkMo6nvwK0pWmc9BFPecMeYd/Q2AWuAtuPGsIZwFSBEF4ffmuE5fQLOmsuVDYAkLJ+15MYaepvjJ7plW7SP8ARu6Y6rLQQbrcIKxKVMBYXFfYhveqOOcqgg2tib1FBNHxFugXS0Ac/6N/l3oNXvJm+qDATi33FlCnrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 11:03:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36937 invoked by uid 111); 14 Oct 2026 11:03:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 07:03:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 07:03:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: test-grep-lint is uncomfortably slow
Message-ID: <20261014110330.GB1356555@coredump.intra.peff.net>
References: <xmqqjynueq81.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjynueq81.fsf@gitster.g>

On Tue, Oct 06, 2026 at 09:41:34AM -0700, Junio C Hamano wrote:

> Does anyone else feel that make test takes too long to start?  There
> is a noticeable pause after "rm -f -r 'test-results'" before the first
> line of real output is shown.  The time in between is likely spent on
> make test-lint.

Yeah, "make test-greplint" takes ~6.5s to run for me. The whole test
suite runs in ~111s, so that is over 5% of the time. ;) And of course it
is more noticeable because there it is all at once before any output
happens.

Chainlint actually takes similar amounts of CPU time (which is not
surprising, because they share the parser) but it runs in parallel.
We could probably do the same here.

It does feel like a lot of processing just to detect one specific type
of lint error. If we amortized the parsing effort across other lint
checks (or even chainlint itself!) that might be more palatable.

This patch does reduce the cost by ~50%:

diff --git a/t/greplint.pl b/t/greplint.pl
index 23efe27511..68b6eba78d 100644
--- a/t/greplint.pl
+++ b/t/greplint.pl
@@ -190,6 +190,15 @@ sub check_test {
 		}
 	}
 	return unless $body;
+	# We can never match a bare "grep" if there isn't one in the first
+	# place. So we can skip all of the parsing effort. Technically you
+	# can have:
+	#
+	#   gr\
+	#   ep
+	#
+	# but that is sufficiently insane that I think we can ignore it.
+	return unless $body =~ /grep/;
 
 	my $raw_lines = $self->{raw_lines};
 

but of course it is working against the "maybe we could amortize the
parsing cost" idea.

-Peff
