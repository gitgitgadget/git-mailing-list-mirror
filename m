Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83003BB23
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927666; cv=none; b=lyQMbkMfdMHr57M3HTxn1HrcQD2oFDFcZ185QYyfVOdY7egXDXmVjDsApl7TCfX3Cm+lQiorwZ6OGQHQKFptoZeCLXs0RiJfPqIJNl3YlQtI23e1SRAhso+IS/7iy7xF/b14xy6zekpTZ34aZnUFBkb6NhqFxcT55mr/mTi2UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927666; c=relaxed/simple;
	bh=aF58tSV6+9yZE/Rdug4TDNEWdOuIK2S176d+LcfrBUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsFsph/0k8Agv+NhB+RtxW32c7ewhA1m8L3f3uPSmqx4jJMzs/DiwCd73FDGfHkK+yUxoP9QXaL2fGgYMPltvnOvEqq1SkbdxxVceKQRCoHugnjFDgWAt7K1WH7sH8WWecKL05kIcp4pLH5YU7w6g8jQyV9dmp0lg/ck63KEd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11211 invoked by uid 109); 20 Mar 2024 09:41:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 09:41:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16830 invoked by uid 111); 20 Mar 2024 09:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 05:41:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 05:41:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@gmail.com>
Subject: [PATCH 3/3] transport-helper: send "true" value for object-format
 option
Message-ID: <20240320094103.GC2445682@coredump.intra.peff.net>
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

The documentation in gitremote-helpers.txt claims that after a helper
has advertised the "object-format" capability, Git may then send "option
object-format true" to indicate that it would like to hear which object
format the helper is using when it returns refs.

However, the code implementing this has always written just "option
object-format", without the extra "true" value. Nobody noticed in
practice or in the tests because the only two helpers we ship are:

  - remote-curl, which quietly converts missing values into "true". This
    goes all the way back to ef08ef9ea0 (remote-helpers: Support custom
    transport options, 2009-10-30), despite the fact that I don't think
    any other option has ever made use of it.

  - remote-testgit in t5801 does insist on having a "true" value. But
    since it sends the ":object-format" response regardless of whether
    it thinks the caller asked for it (technically breaking protocol),
    everything just works, albeit with an extra shell error:

      .../git/t/t5801/git-remote-testgit: 150: test: =: unexpected operator

    printed to stderr, which you can see running t5801 with --verbose.
    (The problem is that $val is the empty string, and since we don't
    double-quote it in "test $val = true", we invoke "test = true"
    instead).

When the documentation and code do not match, it is often good to fix
the documentation rather than break compatibility. And in this case, we
have had the mis-match since 8b85ee4f47 (transport-helper: implement
object-format extensions, 2020-05-25). However, the sha256 feature was
listed as experimental until 8e42eb0e9a (doc: sha256 is no longer
experimental, 2023-07-31).

It's possible there are some third party helpers that tried to follow
the documentation, and are broken. Changing the code will fix them. It's
also possible that there are ones that follow the code and will be
broken if we change it. I suspect neither is the case given that no
helper authors have brought this up as an issue (I only noticed it
because I was running t5801 in verbose mode for other reasons and
wondered about the weird shell error). That, coupled with the relative
new-ness of sha256, makes me think nobody has really worked on helpers
for it yet, which gives us an opportunity to correct the code before too
much time passes.

And doing so has some value: it brings "object-format" in line with the
syntax of other options, making the protocol more consistent. It also
lets us use set_helper_option(), which has better error reporting.

Note that we don't really need to allow any other values like "false"
here. The point is for Git to tell the helper that it understands
":object-format" lines coming back as part of the ref listing. There's
no point in future versions saying "no, I don't understand that".

To make sure everything works as expected, we can improve the
remote-testgit helper from t5801 to send the ":object-format" line only
if the other side correctly asked for it (which modern Git will always
do). With that test change and without the matching code fix here, t5801
will fail when run with GIT_TEST_DEFAULT_HASH=sha256.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5801/git-remote-testgit | 4 +++-
 transport-helper.c         | 7 ++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index bcfb358c51..c5b10f5775 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -30,6 +30,7 @@ GIT_DIR="$url/.git"
 export GIT_DIR
 
 force=
+object_format=
 
 mkdir -p "$dir"
 
@@ -61,7 +62,8 @@ do
 		echo
 		;;
 	list)
-		echo ":object-format $(git rev-parse --show-object-format=storage)"
+		test -n "$object_format" &&
+			echo ":object-format $(git rev-parse --show-object-format=storage)"
 		git for-each-ref --format='? %(refname)' 'refs/heads/' 'refs/tags/'
 		head=$(git symbolic-ref HEAD)
 		echo "@$head HEAD"
diff --git a/transport-helper.c b/transport-helper.c
index 7f6bbd06bb..8d284b24d5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1210,11 +1210,8 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	data->get_refs_list_called = 1;
 	helper = get_helper(transport);
 
-	if (data->object_format) {
-		write_constant(helper->in, "option object-format\n");
-		if (recvline(data, &buf) || strcmp(buf.buf, "ok"))
-			exit(128);
-	}
+	if (data->object_format)
+		set_helper_option(transport, "object-format", "true");
 
 	if (data->push && for_push)
 		write_constant(helper->in, "list for-push\n");
-- 
2.44.0.650.g4615f65fe0
