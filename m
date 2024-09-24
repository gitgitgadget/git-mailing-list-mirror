Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2082488
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214573; cv=none; b=syjjdN8A/TlGi58Hd09zw5nu2quKht8XpE21kQl7cp8y7Dz3MERDbDb5Me5eXcABTLXbnaXZEGtwSmyrILQVEqTRXFOFYziBdZYIbocWQjnG6pGkgyzyy28Cy7EIQ+3by3rh1IOAPLW87Z6TdyBt1j+ZaU45OSFFyCee/FkLNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214573; c=relaxed/simple;
	bh=nfAu3DIDGZ8OC0q62N/0HowNAMC9ou96Qg66eOwD3PI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H6csXXfMfj7EjoIspDSIzSJJAYBqb6exj85nAojRCS6N1WndlwA/mfTHBNaUaIImC4KBP6cCdXlFavI0MJy4e3JfYZvZiTesdM4WT0xliA2PIIodHHEKeh7eRi+33d6CO3Qo4FvNscetMmrvF9MCYpSJ285ylxo/emLVLJ1yiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15393 invoked by uid 109); 24 Sep 2024 21:49:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:49:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18176 invoked by uid 111); 24 Sep 2024 21:49:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:49:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:49:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/28] leak fixes for http fetch/push
Message-ID: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Patrick asked me to take a look at the remaining leaks in the http
push/fetch code, especially the dumb variants. So here are enough
patches to all of these scripts running leak-free:

  t5500-fetch-pack.sh
  t5539-fetch-http-shallow.sh
  t5540-http-push-webdav.sh
  t5541-http-push-smart.sh
  t5542-push-http-shallow.sh
  t5550-http-fetch-dumb.sh
  t5551-http-fetch-smart.sh
  t5582-fetch-negative-refspec.sh
  t5619-clone-local-ambiguous-transport.sh

I did have to cheat a little and steal some of the patches from his
"leak fixes part 8" work-in-progress (which are at the front of this
series). But otherwise this should be independent of the other
leak-fixing work and can be applied directly on master.

I tried to put patches touching similar areas together, but there's
probably still a bit of a jumble, just because I got there by picking at
the pile of leak logs for each script. :)

Most of them are pretty obvious "add a free call" one-liners. If you
really want to put on your thinking cap, try patches 7, 14, and 21 (I'm
going to pretend I spaced them out evenly for your reading pleasure).

  [01/28]: http-fetch: clear leaking git-index-pack(1) arguments
  [02/28]: shallow: fix leak when unregistering last shallow root
  [03/28]: fetch-pack: fix leaking sought refs
  [04/28]: connect: clear child process before freeing in diagnostic mode
  [05/28]: fetch-pack: free object filter before exiting
  [06/28]: fetch-pack, send-pack: clean up shallow oid array
  [07/28]: commit: avoid leaking already-saved buffer
  [08/28]: send-pack: free cas options before exit
  [09/28]: transport-helper: fix strbuf leak in push_refs_with_push()
  [10/28]: fetch: free "raw" string when shrinking refspec
  [11/28]: fetch-pack: clear pack lockfiles list
  [12/28]: transport-helper: fix leak of dummy refs_list
  [13/28]: http: fix leak when redacting cookies from curl trace
  [14/28]: http: fix leak of http_object_request struct
  [15/28]: http: call git_inflate_end() when releasing http_object_request
  [16/28]: http: stop leaking buffer in http_get_info_packs()
  [17/28]: remote-curl: free HEAD ref with free_one_ref()
  [18/28]: http-walker: free fake packed_git list
  [19/28]: http-push: clear refspecs before exiting
  [20/28]: http-push: free repo->url string
  [21/28]: http-push: free curl header lists
  [22/28]: http-push: free transfer_request dest field
  [23/28]: http-push: free transfer_request strbuf
  [24/28]: http-push: free remote_ls_ctx.dentry_name
  [25/28]: http-push: free xml_ctx.cdata after use
  [26/28]: http-push: clean up objects list
  [27/28]: http-push: clean up loose request when falling back to packed
  [28/28]: http-push: clean up local_refs at exit

 builtin/fetch-pack.c                       | 14 +++++++-
 builtin/fetch.c                            |  1 +
 builtin/push.c                             |  1 +
 builtin/send-pack.c                        |  2 ++
 commit.c                                   |  3 +-
 connect.c                                  |  1 +
 http-fetch.c                               | 16 ++++++---
 http-push.c                                | 40 +++++++++++++++-------
 http-walker.c                              | 18 +++++++---
 http.c                                     | 16 ++++++---
 http.h                                     |  4 +--
 refspec.c                                  |  2 +-
 refspec.h                                  |  2 +-
 remote-curl.c                              |  2 +-
 remote.c                                   |  2 +-
 remote.h                                   |  1 +
 shallow.c                                  |  5 ++-
 t/t5500-fetch-pack.sh                      |  1 +
 t/t5539-fetch-http-shallow.sh              |  1 +
 t/t5540-http-push-webdav.sh                |  1 +
 t/t5541-http-push-smart.sh                 |  1 +
 t/t5542-push-http-shallow.sh               |  1 +
 t/t5550-http-fetch-dumb.sh                 |  1 +
 t/t5551-http-fetch-smart.sh                |  1 +
 t/t5582-fetch-negative-refspec.sh          |  1 +
 t/t5619-clone-local-ambiguous-transport.sh |  1 +
 t/t5700-protocol-v1.sh                     |  1 +
 transport-helper.c                         | 11 ++++--
 transport.c                                | 11 +++++-
 29 files changed, 123 insertions(+), 39 deletions(-)

-Peff
