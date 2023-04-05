Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753DC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjDEVXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDEVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2A19D
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:23:03 -0700 (PDT)
Received: (qmail 6462 invoked by uid 109); 5 Apr 2023 21:23:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Apr 2023 21:23:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15910 invoked by uid 111); 5 Apr 2023 21:23:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 17:23:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 17:23:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230405212301.GA529421@coredump.intra.peff.net>
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5zmukp5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 01:40:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, we send a special capability line in that case. If you do:
> >
> >   GIT_TRACE_PACKET=1 git clone a b
> >
> > you can see that upload-pack indicates that ls-refs understands the
> > "unborn" capability:
> >
> >   packet:  upload-pack> version 2
> >   packet:  upload-pack> agent=git/2.40.0.824.g7b678b1f643
> >   packet:  upload-pack> ls-refs=unborn
> >   packet:  upload-pack> fetch=shallow wait-for-done
> >   packet:  upload-pack> server-option
> >   packet:  upload-pack> object-format=sha256
> >   packet:  upload-pack> object-info
> >   packet:  upload-pack> 0000
> >
> > And then clone asks for it say "yes, I also understand unborn":
> >
> >   packet:        clone> command=ls-refs
> >   packet:        clone> agent=git/2.40.0.824.g7b678b1f643
> >   packet:        clone> object-format=sha256
> >   packet:        clone> 0001
> >   packet:        clone> peel
> >   packet:        clone> symrefs
> >   packet:        clone> unborn
> >   packet:        clone> ref-prefix HEAD
> >   packet:        clone> ref-prefix refs/heads/
> >   packet:        clone> ref-prefix refs/tags/
> >   packet:        clone> 0000
> >
> > And then upload-pack can send us the extra information:
> >
> >   packet:  upload-pack> unborn HEAD symref-target:refs/heads/maestro
> >   packet:  upload-pack> 0000
> >
> > I think we'd need to do something similar here for object-format.
> 
> I guess we only need to touch "git clone" then.  Without being
> asked, it advertsizes object-format=sha256 already, and when the
> maestro repository is prepared without --object-format=sha256,
> upload-pack advertises object-format=sha1 instead.  So it probably
> is just the matter of capturing it and using it to populate the
> extensions.objectformat with an appropriate value.

Ah, yeah, you're right. I was thinking that capability advertisement was
"by the way, I understand sha256". But I may just be showing my
ignorance of the current state of the hash-transition protocol
extensions. :)

I'm actually surprised this does not Just Work already. The client gets
the intended algorithm from that capability line, which is how we know
how to parse any ls-refs output at all (we are not just guessing from
the length). But we only bother to set it in the local config if we have
refs to fetch, which seems like a bug.

So the solution is maybe something like this:

diff --git a/builtin/clone.c b/builtin/clone.c
index 462c286274c..5eca95cb892 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1296,19 +1296,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			clear_bundle_list(transport->bundles);
 			FREE_AND_NULL(transport->bundles);
 		}
 	}
 
-	if (mapped_refs) {
+	{
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
 		/*
 		 * Now that we know what algorithm the remote side is using,
 		 * let's set ours to the same thing.
 		 */
 		initialize_repository_version(hash_algo, 1);
 		repo_set_hash_algo(the_repository, hash_algo);
+	}
+
+	if (mapped_refs) {
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
 		 * comment). In that case we need fetch it early because
 		 * remote_head code below relies on it.
