Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328482880
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801521; cv=none; b=tlEgxsTkH3RiO95T1I88Y33osZ9cBBEFsW2AHFBn+9J+UE3aYqUhuuFLP+kI8wrfJDOYdEYpktK9KWAhMctnXtVUa9CmXYkLoLwi1HZ0bRaVng9OD7/ty/PH5PlteaHLNsRlZ7pZm9dwOJ0UlzNvvRvrvYvT/+JqkgE4Gm69tJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801521; c=relaxed/simple;
	bh=QiSheEnhbBt6mH6yYDd64yL0QPrHbSu/VL7yXycybHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpWmEffzVSpaK1zSnQny6HKfa+mo2FGgAqkshmZBQM9+kZQy2gNxi3yIOzpGfNGnByj2JWZCoKDE9xckRuG0qbeJPspxFRqJD+LIGk8ee/k1aGbZuK1QkNWfUCqPDY6tdB/6vJJ5NqxEP+DdCOlx2gH4uFJVCOAm405rOQZHEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6692 invoked by uid 109); 7 Mar 2024 08:51:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 08:51:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12363 invoked by uid 111); 7 Mar 2024 08:52:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 03:52:03 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 03:51:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] t5801: fix object-format handling in git-remote-testgit
Message-ID: <20240307085158.GA2072294@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307084735.GA2072130@coredump.intra.peff.net>

Our fake remote helper tries to handle the object-format capability,
courtesy of 3716d50dd5 (remote-testgit: adapt for object-format,
2020-06-19). But its parsing isn't quite right; it expects to receive
"option object-format true", but the transport-helper code just sends
"option object-format" with no value.

As a result, we never set the $object_format variable to "true". And
worse, because $val is used unquoted, this confuses the shell's "test"
command, which prints something like:

  .../git/t/t5801/git-remote-testgit: 150: test: =: unexpected operator

It all turns out to be harmless, though, because we never look at
$object_format after that!

The Git-side behavior comes from 8b85ee4f47 (transport-helper: implement
object-format extensions, 2020-05-25). It is a bit unlike other "option"
variables, which always say "true" or "false". But in this case, there's
not really any need to do so. As I understand it from that commit, the
sequence is something like:

  1. the remote helper in its capabilities list says "object-format" to
     tell Git that it understands the object-format option.

  2. Git then tells the helper "option object-format" to tell it that it
     too understands object-formats.

  3. when the remote helper lists refs, it sends a special
     ":object-format" line that tells Git which object format it is
     using. But it presumably should only do this if we found out that
     the other side supports object-formats in step (2).

So let's improve our remote-testgit helper a bit:

  - when we see an object-format line, just set object_format=true;
    that's the only useful thing to take away from it

  - make sure that object_format is set before sending the special
    ":object-format" line. Since we're always testing against a version
    of Git recent enough to have sent us the object-format option, this
    is mostly a noop. But it confirms that the transport-helper code is
    correctly sending us the option (if we fail to send the line, then
    the test will fail when run with GIT_TEST_DEFAULT_HASH=sha256).

Signed-off-by: Jeff King <peff@peff.net>
---
The only other helper we ship that knows about object-format is
remote-curl. And there it _does_ expect "true" or an algorithm.
Curiously the "true" thing works because the remote-curl code silently
rewrites "option foo" to be the same as "option foo true". And even
though it understands receiving a specific algorithm, I'm not sure it
would do anything useful (whatever the caller says is generally
overwritten by the info/refs response).

So I dunno.

 t/t5801/git-remote-testgit | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index 1544d6dc6b..b348608847 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -25,6 +25,7 @@ GIT_DIR="$url/.git"
 export GIT_DIR
 
 force=
+object_format=
 
 mkdir -p "$dir"
 
@@ -56,7 +57,8 @@ do
 		echo
 		;;
 	list)
-		echo ":object-format $(git rev-parse --show-object-format=storage)"
+		test -n "$object_format" &&
+			echo ":object-format $(git rev-parse --show-object-format=storage)"
 		git for-each-ref --format='? %(refname)' 'refs/heads/' 'refs/tags/'
 		head=$(git symbolic-ref HEAD)
 		echo "@$head HEAD"
@@ -142,7 +144,7 @@ do
 			echo "ok"
 			;;
 		object-format)
-			test $val = "true" && object_format="true" || object_format=
+			object_format=true
 			echo "ok"
 			;;
 		*)
-- 
2.44.0.463.g71abcb3a9f

