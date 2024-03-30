Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3025197
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756936; cv=none; b=eTh+jp4oZ3PSScpwNnsMkwmw3xAPFC5kmdXm6E8iO40swc1menNOlCSuMhv+oVAZv5NnrfQx0B7Ycx7+8IZ1ePPEGjDBt1v5Uw9Vg0nbNA0q2tDSEwwYAvwwplgJNOomVJAIDhhoO8wXTRixX+99dSdUWvPn2VWL664ra1lUz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756936; c=relaxed/simple;
	bh=uFcPIPcsvI18Fn6mS14f/8j+yT69QtsZImcSvvSXo5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ghm86ZumcaHBXVbU8NJNcUSsLrT6XwpeJjXGNVQcMsehNltJoA96liT9L4W2tAYR8DmBbMSOktNPoTr8EHv/SwWzFnsjOBqtwj1koxst+ZzU/wgdBwpRp/zoLf/irf0w7FaQ7GMWFEGc4WePyWaGpMrFkjj/VPbeYIZKC0XddK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32414 invoked by uid 109); 30 Mar 2024 00:02:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Mar 2024 00:02:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24700 invoked by uid 111); 30 Mar 2024 00:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Mar 2024 20:02:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 Mar 2024 20:02:12 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
Subject: tests broken with curl-8.7.0
Message-ID: <20240330000212.GA1261238@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I noticed some http-related failures in the test suite on my Debian
unstable system, which recently got an upgraded curl package. It looks
like it's related to cases where we use the remote-curl helper in
"connect" mode (i.e., protocol v2) and the http buffer is small
(requiring us to stream the data to curl). Besides just running t5551,
an easy reproduction is:

  [this works]
  $ git ls-remote https://git.kernel.org/pub/scm/git/git.git | wc -l
  1867

  [this doesn't]
  $ git -c http.postbuffer=65536 ls-remote https://git.kernel.org/pub/scm/git/git.git
  fatal: expected flush after ref listing

The error message comes from ls-remote itself, which was expecting a
FLUSH packet from the remote. Instead it gets the RESPONSE_END from
remote-curl (remember that in connect mode, remote-curl is just ferrying
bytes back and forth between ls-remote and the server).

It works with older versions of libcurl, but not 8.7.0 (or 8.7.1).
Bisecting in libcurl points to 9369c30cd (lib: Curl_read/Curl_write
clarifications, 2024-02-15).

Running with GIT_TRACE_CURL=1 shows weirdness on the POST we send to
issue the ls-refs command. With older curl, I see this:

  => Send header: POST /pub/scm/git/git.git/git-upload-pack HTTP/1.1
  => Send header: Host: git.kernel.org
  => Send header: User-Agent: git/2.44.0.789.g252ee96bc5.dirty
  => Send header: Accept-Encoding: deflate, gzip
  => Send header: Content-Type: application/x-git-upload-pack-request
  => Send header: Accept: application/x-git-upload-pack-result
  => Send header: Git-Protocol: version=2
  => Send header: Transfer-Encoding: chunked
  => Send header:
  => Send data: 14..0014command=ls-refs...
  => Send data: 2a..002aagent=git/2.44.0.789.g252ee96bc5.dirty..
  [and so on until...]
  == Info: Signaling end of chunked upload via terminating chunk.

But with the broken version, I get:

  => Send header: POST /pub/scm/git/git.git/git-upload-pack HTTP/1.1
  => Send header: Host: git.kernel.org
  => Send header: User-Agent: git/2.44.0.789.g252ee96bc5.dirty
  => Send header: Accept-Encoding: deflate, gzip, br, zstd
  => Send header: Content-Type: application/x-git-upload-pack-request
  => Send header: Accept: application/x-git-upload-pack-result
  => Send header: Git-Protocol: version=2
  => Send header: Transfer-Encoding: chunked
  => Send header:
  => Send data, 0000000014 bytes (0x0000000e)
  => Send data: 4..0014..0....
  == Info: upload completely sent off: 14 bytes

So we only get the first 4 bytes, and then we quit (the double mention
of 14 is confusing, but I think it is both the size of the pkt-line
("command=ls-refs\n") but also the length of the 4-byte string when
framed with chunked transfer-encoding). Those 4 bytes are the first
thing returned by rpc_out(), which we use as our CURLOPT_READFUNCTION.

It's possible that we're doing something wrong with our read/write
function callbacks. But I don't see how; we say "here's 4 bytes", but
then we never get called again. It's like curl is giving up on trying to
read the post input early for some reason.

I'm not sure how to dig further. That commit is pretty big and scary. I
did check that the tip of master in curl.git is still affected (I'd
hoped maybe the 0-length write fixes in b30d694a027 would be related,
but that's not it).

Ideas?

-Peff
