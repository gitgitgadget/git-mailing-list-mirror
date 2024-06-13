Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9586136
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273240; cv=none; b=u3qAy80E6+idzbO90lvrfa869fUs9fQeaGudA6i/FaAE57pSX3AJYFZYJJSuCACoQgYOkiogngQrZ+3a0AtP6XTQdDU3jXdbYuYz+B0T6mXp1eftGO/WKbvB26MnyZggVwbcU2hmfx4Sm7ZFRguosnxaLjr7182ZwsgQqFMx434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273240; c=relaxed/simple;
	bh=MREJXckfs8hWRhWkIJHn68dEOgl3nLT8lVpwGgyAfMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuUJrrBG8q1STfKV18m0CLH626bf+fbSvI/rKkVA8BqeAdHOHsBcB6ozK5slfZ3WWwf+BS4Z7bJ2zQgin22KPTLas1LpKhZ8QoJS6e3SkuI/8MVZah7yG11sOspl36FZMF9HjWgamHlzKH8RCFn/P54pjl7nGGG3JSeeQEQ56bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25964 invoked by uid 109); 13 Jun 2024 10:07:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 10:07:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15888 invoked by uid 111); 13 Jun 2024 10:07:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 06:07:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 06:07:16 -0400
From: Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] t5541: add test for rejecting a push due to packfile
 size
Message-ID: <20240613100716.GB817573@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
 <20240612115028.1169183-4-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115028.1169183-4-cmn@dwim.me>

On Wed, Jun 12, 2024 at 01:50:27PM +0200, Carlos Martín Nieto wrote:

> +test_expect_success 'reject too-large push over HTTP' '
> +	git init "$HTTPD_DOCUMENT_ROOT_PATH/error_too_large" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/error_too_large" config receive.maxInputSize 128 &&
> +	test-tool genrandom foo $((10*1024*1024)) >large-file &&
> +	git add large-file &&
> +	test_commit large-file &&
> +	test_must_fail git push --porcelain \
> +		$GIT_SERVE_URL/error_too_large \
> +		HEAD:refs/tags/will-fail >actual &&
> +	test_must_fail git -C "$HTTPD_DOCUMENT_ROOT_PATH/error_too_large" \
> +		rev-parse --verify refs/tags/will-fail &&
> +	cat >expect <<-EOF &&
> +	To $GIT_SERVE_URL/error_too_large
> +	!	HEAD:refs/tags/will-fail	[remote rejected] (unpacker error)
> +	Done
> +	EOF
> +	test_cmp expect actual
> +'

This test fails for me (even with the fix in the next patch) with:

  Exception occurred during processing of request from ('127.0.0.1', 47480)
  Traceback (most recent call last):
    File "/usr/lib/python3.11/socketserver.py", line 317, in _handle_request_noblock
      self.process_request(request, client_address)
    File "/usr/lib/python3.11/socketserver.py", line 348, in process_request
      self.finish_request(request, client_address)
    File "/usr/lib/python3.11/socketserver.py", line 361, in finish_request
      self.RequestHandlerClass(request, client_address, self)
    File "/home/peff/compile/git/t/lib-httpd/serve-git.py", line 35, in __init__
      super().__init__(*args, **kwargs)
    File "/usr/lib/python3.11/socketserver.py", line 755, in __init__
      self.handle()
    File "/usr/lib/python3.11/http/server.py", line 436, in handle
      self.handle_one_request()
    File "/usr/lib/python3.11/http/server.py", line 424, in handle_one_request
      method()
    File "/home/peff/compile/git/t/lib-httpd/serve-git.py", line 117, in do_GET
      self.do_receive_pack(responder, gitdir, True, protocol)
    File "/home/peff/compile/git/t/lib-httpd/serve-git.py", line 243, in do_receive_pack
      self._run_command(resp, 'receive-pack', gitdir, advertisement, protocol)
    File "/home/peff/compile/git/t/lib-httpd/serve-git.py", line 192, in _run_command
      with subprocess.Popen(argv, stdin=stdin, stdout=subprocess.PIPE, cwd=gitdir, env=env) as proc:
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/usr/lib/python3.11/subprocess.py", line 1026, in __init__
      self._execute_child(args, executable, preexec_fn, close_fds,
    File "/usr/lib/python3.11/subprocess.py", line 1955, in _execute_child
      raise child_exception_type(errno_num, err_msg, err_filename)
  FileNotFoundError: [Errno 2] No such file or directory: 'git'

which seems...odd. It should be finding "git" in bin-wrappers/, but I
think it is using a restricted/vanilla path. If I put "git" into
/usr/bin, it stops complaining (but obviously this is very wrong, as we
are not running the Git we're trying to test!).

Ah, I think I see it. You set up an environment for the Popen like:

  env = {k:v for k, v in os.environ.items() if k.startswith('GIT_')}
  if protocol is not None:
      env['GIT_PROTOCOL'] = protocol

so it does not contain $PATH (nor other possibly useful things!), so
presumably a fallback $PATH is used. I think you'd want to start with
"env = os.environ.copy()" and then modify it from there.

-Peff
