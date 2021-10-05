Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41FDC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916EB610CC
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 22:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhJEWDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 18:03:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:33424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236093AbhJEWDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 18:03:33 -0400
Received: (qmail 17777 invoked by uid 109); 5 Oct 2021 22:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 22:01:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8660 invoked by uid 111); 5 Oct 2021 22:01:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 18:01:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 18:01:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: ab/fsck-unexpected-type (and "cat-file replace handling and
 optimization")
Message-ID: <YVzLRSa9/vUWJPL0@coredump.intra.peff.net>
References: <xmqqo884tkxd.fsf@gitster.g>
 <87bl43jit5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl43jit5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 10:47:26PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > * ab/fsck-unexpected-type (2021-10-01) 17 commits
> [...]
> Note that Jeff's just-submitted cat-file series[3] will conflict with
> this, as they both adjust the same "garbage" object tests. The semantic
> conflict is minimal/none, but the textual one is probably annoying
> (e.g. his 1/5 uses a variable I split/renamed).
> 
> Jeff: Depending on what Junio thinks of queuing ab/fsck-unexpected-type
> for next what do you think about rebasing your series on top, or perhaps
> take a look at the v10[4] of it/ack it in case that helps with that (since
> you've been looking at some related code just now...).

The conflict is pretty easy to resolve: just keep my new cleanup tests,
but swap out the variable name. The combined diff is below for
reference (this is more readable than a remerge diff, but I guess a
remerge diff could actually be applied).

I don't mind rebasing on top if that's easier for Junio, but in that
case it may make sense to float the test cleanup to the front of the
series.

I can also just change mine to do the --batch-all-objects tests in a
separate repository (which is what the existing ones do). That has the
minor advantage that we know all objects in the repository, so rather
than picking out the interesting object with perl, we could generate the
full expected output.

-Peff

---
diff --cc t/t1006-cat-file.sh
index a5e7401af8,4a753705ec..0000000000
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@@ -475,9 -332,18 +475,13 @@@ test_expect_success "Size of broken obj
  	test_cmp expect actual
  '
  
+ test_expect_success 'clean up broken object' '
 -	rm .git/objects/$(test_oid_to_path $bogus_sha1)
++	rm .git/objects/$(test_oid_to_path $bogus_short_sha1)
+ '
+ 
 -bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
 -bogus_content="bogus"
 -bogus_size=$(strlen "$bogus_content")
 -bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 -
  test_expect_success "Type of broken object is correct when type is large" '
 -	echo $bogus_type >expect &&
 -	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
 +	echo $bogus_long_type >expect &&
 +	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
  	test_cmp expect actual
  '
  
@@@ -487,56 -353,8 +491,8 @@@ test_expect_success "Size of large brok
  	test_cmp expect actual
  '
  
- test_expect_success 'cat-file -t and -s on corrupt loose object' '
- 	git init --bare corrupt-loose.git &&
- 	(
- 		cd corrupt-loose.git &&
- 
- 		# Setup and create the empty blob and its path
- 		empty_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$EMPTY_BLOB")) &&
- 		git hash-object -w --stdin </dev/null &&
- 
- 		# Create another blob and its path
- 		echo other >other.blob &&
- 		other_blob=$(git hash-object -w --stdin <other.blob) &&
- 		other_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$other_blob")) &&
- 
- 		# Before the swap the size is 0
- 		cat >out.expect <<-EOF &&
- 		0
- 		EOF
- 		git cat-file -s "$EMPTY_BLOB" >out.actual 2>err.actual &&
- 		test_must_be_empty err.actual &&
- 		test_cmp out.expect out.actual &&
- 
- 		# Swap the two to corrupt the repository
- 		mv -f "$other_path" "$empty_path" &&
- 		test_must_fail git fsck 2>err.fsck &&
- 		grep "hash mismatch" err.fsck &&
- 
- 		# confirm that cat-file is reading the new swapped-in
- 		# blob...
- 		cat >out.expect <<-EOF &&
- 		blob
- 		EOF
- 		git cat-file -t "$EMPTY_BLOB" >out.actual 2>err.actual &&
- 		test_must_be_empty err.actual &&
- 		test_cmp out.expect out.actual &&
- 
- 		# ... since it has a different size now.
- 		cat >out.expect <<-EOF &&
- 		6
- 		EOF
- 		git cat-file -s "$EMPTY_BLOB" >out.actual 2>err.actual &&
- 		test_must_be_empty err.actual &&
- 		test_cmp out.expect out.actual &&
- 
- 		# So far "cat-file" has been happy to spew the found
- 		# content out as-is. Try to make it zlib-invalid.
- 		mv -f other.blob "$empty_path" &&
- 		test_must_fail git fsck 2>err.fsck &&
- 		grep "^error: inflate: data stream error (" err.fsck
- 	)
+ test_expect_success 'clean up broken object' '
 -	rm .git/objects/$(test_oid_to_path $bogus_sha1)
++	rm .git/objects/$(test_oid_to_path $bogus_long_sha1)
  '
  
  # Tests for git cat-file --follow-symlinks
