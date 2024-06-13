Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32029AB
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270371; cv=none; b=cuMY/Zk6RspvJdt5r07RHvLn2EdAt6DeOH/7oAoxJvTmJsmhSVCm3GnHKoeyVRlD64t3Qb08f+qZAcRwkHSixQ1QrgXtow9X1kPsz8L8Sje2hf1VS0NS0BN6YKnudkUHcqGsc1AKqVxkixa2dMUhiG895phAc9IohOJy5WRg49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270371; c=relaxed/simple;
	bh=7gf08+aZCcPfrgmKACjQ+aYfK+Veg/e3tWLQIPpILHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbKKHahaboAb26I0PHZeJ9dQwTcNY1ZktCjUs+ohQ/q8Wkzn93QF8X/o8T9SXEKw/UV9VJQXsJrXv0IgnPN5EW3BeRePAIzTSM9mvk2hWEJOvIuDhodFkwNN0A5MIUzoxSWJ1v9BDyZKu7DgbrzDlh1/g8ElTw+yB3d2PBrLsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24415 invoked by uid 109); 13 Jun 2024 09:19:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 09:19:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15352 invoked by uid 111); 13 Jun 2024 09:19:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 05:19:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 05:19:27 -0400
From: Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] t/lib-http.sh: add functions related to serve-git.py
Message-ID: <20240613091927.GB796372@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
 <20240612115028.1169183-3-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115028.1169183-3-cmn@dwim.me>

On Wed, Jun 12, 2024 at 01:50:26PM +0200, Carlos Martín Nieto wrote:

> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index d83bafeab32..6454300a041 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> [...]
> +start_serve_git() {

I can see why you'd stick this in lib-httpd.sh. But note that we'll bail
from that script's setup phase if we don't find Apache. That's not the
end of the world, but it does mean we'd fail to run this test on
platforms that otherwise could.

> +	test_atexit stop_serve_git

OK, you do the auto-kill on exit, which is good.

> +	"$TEST_DIRECTORY"/lib-httpd/serve-git.py \
> +		--document-root "$HTTPD_ROOT_PATH"/www \
> +		--port "$LIB_GIT_SERVE_PORT" &
> +
> +	mkdir -p "$HTTPD_ROOT_PATH"
> +	echo $! >"$HTTPD_ROOT_PATH"/git-serve.pid
> +
> +	GIT_SERVE_DEST=127.0.0.1:$LIB_GIT_SERVE_PORT
> +	GIT_SERVE_URL=http://$GIT_SERVE_DEST
> +}

But I suspect this part is racy. We started serve-git.py in the
background, but we have no guarantee that it finished starting up, or
even started listening on the port.

We've run into those kinds of races with git-daemon; you can find the
gross fifo-based solution in lib-git-daemon.sh. We don't do anything
special for apache, but I think that's because we depend on "apache -k
start" to handle this (we don't background it ourselves).

> +stop_serve_git() {
> +	kill -9 $(cat "$HTTPD_ROOT_PATH"/git-serve.pid)
> +}

This looks reasonable. You probably want to redirect stderr to
/dev/null, since any script which calls stop_serve_git() itself will
double-kill and see an error on the second one.

-Peff
