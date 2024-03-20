Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E53B78B
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927464; cv=none; b=iDLTkoiba2vRBDafrkuegEFBVQpF+r9vLVBjo0K9dWcCbucZcxN4ErntqAK64QdYDWBJGHlYjN15nFGPCsrGRxUvfZQ6N2Zh67LcDtK2ru2I5NP/8+bHbr/Rs2IVsVnT6JeCfGpkNAOOoMWolCBPDYAagoVW5defSyu1Yoq67NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927464; c=relaxed/simple;
	bh=i7pRuGe87StRsm712YwBq02qI/7d1zAPVVMZIe3sL5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec/8F9v9CJLDM7UjeGlqNf+i+ukgbf8P3CLwq0jPgt8K6imp/NOadyeh6jFBiLGy+mQBN329WgmlyuBLZzKlyomE8YBjUjzxzwfAaimK1kh7XewKRQJQ4pV9Tnbl86WJwdnmv//RFYFT75wyHTxpc17+eDNov+UIpYhjgxQr75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11200 invoked by uid 109); 20 Mar 2024 09:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 09:37:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16800 invoked by uid 111); 20 Mar 2024 09:37:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 05:37:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 05:37:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@gmail.com>
Subject: [PATCH 2/3] transport-helper: drop "object-format <algo>" option
Message-ID: <20240320093740.GB2445682@coredump.intra.peff.net>
References: <20240320093226.GA2445531@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320093226.GA2445531@coredump.intra.peff.net>

The documentation in gitremote-helpers.txt claims that helpers should
accept an object-format option from Git whose value is either:

  1. "true", in which case the helper is merely told that Git
     understands the special ":object-format" response, and will send it

  2. an algorithm name that the helper should use

However, Git has never sent the second form, and it's not clear if it
would ever be useful.

When interacting with a remote Git repository, we generally discover
what _their_ object format is, and then decide what to do with a
mismatch (where that is currently just "bail out", but could eventually
be on-the-fly conversion and interop). And that is true for native
protocols, but also for transport helpers like remote-curl that talk to
remote Git repositories.  There we send back an ":object-format" line
telling Git what remote-curl detected on the other side.

And this is true even for pushes (since we get it via receive-pack's
advertisement). And it is even true for dumb-http, as we guess at the
algorithm based on the hash size, due to ac093d0790 (remote-curl: detect
algorithm for dumb HTTP by size, 2020-06-19).

The one case where it _isn't_ true is dumb-http talking to an empty
repository. There we have no clue what the remote hash is, so
remote-curl just sends back its default. If we kept the "object-format
<algo>" form then in theory Git could say "object-format sha256" to
change that default. But it doesn't really accomplish anything. We still
may or may not be mis-matched with the other side. For a fetch that's
OK, since it's by definition a noop. For a push into an empty
repository, it might matter (though the dumb http-push DAV code seems
happy to clobber a remote sha256 info/refs and corrupt the repository).
If we want to pursue making this work, I think we'd be better off
improving detection of the object format of empty repositories over
dumb-http (e.g., an "info/object-format" file).

But what about helpers that _aren't_ talking to another Git repo?
Consider something like git-cinnabar, which is converting on the fly
to/from hg. Most of the heavy lifting is done by fast-import/export, but
some oids may still pass between Git and the helper. Could
"object-format <algo>" be useful to tell the helper what oids we expect
to see?

Possibly, but in practice this isn't necessary. Git-cinnabar for example
already peeks at the local-repo .git/config to check its object-format
(and currently just bails if it is sha256).

So I think the "object-format" extension really is only useful for the
helper telling Git what object-format it found, and not the other way
around.

Note that this patch can't break any remote helpers; we're not changing
the code on the Git side at all, but just bringing the documentation in
line with what Git has always done. It does remove the receiving support
in remote-curl.c, but that code was never actually triggered.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitremote-helpers.txt | 7 ++-----
 remote-curl.c                       | 9 ++-------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 07c8439a6f..0d3f4f37c2 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -542,13 +542,10 @@ set by Git if the remote helper has the 'option' capability.
 	transaction.  If successful, all refs will be updated, or none will.  If the
 	remote side does not support this capability, the push will fail.
 
-'option object-format' {'true'|algorithm}::
-	If 'true', indicate that the caller wants hash algorithm information
+'option object-format true'::
+	Indicate that the caller wants hash algorithm information
 	to be passed back from the remote.  This mode is used when fetching
 	refs.
-+
-If set to an algorithm, indicate that the caller wants to interact with
-the remote side using that algorithm.
 
 SEE ALSO
 --------
diff --git a/remote-curl.c b/remote-curl.c
index 1161dc7fed..31b02b8840 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -211,14 +211,9 @@ static int set_option(const char *name, const char *value)
 		options.filter = xstrdup(value);
 		return 0;
 	} else if (!strcmp(name, "object-format")) {
-		int algo;
 		options.object_format = 1;
-		if (strcmp(value, "true")) {
-			algo = hash_algo_by_name(value);
-			if (algo == GIT_HASH_UNKNOWN)
-				die("unknown object format '%s'", value);
-			options.hash_algo = &hash_algos[algo];
-		}
+		if (strcmp(value, "true"))
+			die(_("unknown value for object-format: %s"), value);
 		return 0;
 	} else {
 		return 1 /* unsupported */;
-- 
2.44.0.650.g4615f65fe0

