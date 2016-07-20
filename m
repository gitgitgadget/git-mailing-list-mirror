Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30A61F744
	for <e@80x24.org>; Wed, 20 Jul 2016 18:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbcGTStZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 14:49:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753461AbcGTStY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 14:49:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8E212B795;
	Wed, 20 Jul 2016 14:49:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b4Gj6dtlSVDxVFucCae1k9JcafA=; b=a4pvRP
	3G9uo+qQMleupF7p64M6fxRR/yecd8eBDR4dw6swUfyHrIgcV8iO/UkU5d0GXzw2
	Z+XMBZSGfR9AZl2bN930NNoAXMsp0SeB7MSpbwy862MIKFGbr1IGd+LinLTmy/Ye
	h8x+WAwu7Ersr8/9JaP2GdqwtsAW5FnDxUSo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ollHEhCTSCBlPIJrCmJk/b/liBgTBm+v
	yCn4D3k7pGh7ocIfDRvxbDECk+NcKdZMHmDFeZ/56jYgCdiBXuKTVAefCGpOg+S9
	T2e3pcXYkkueQ5ZRT0LA9zYpLDPUy419/5/pDt3td8ST1m/SaHNGlFvThwlGHfQR
	jb9LN0tzV1I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D16D82B794;
	Wed, 20 Jul 2016 14:49:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57F7B2B793;
	Wed, 20 Jul 2016 14:49:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Ernesto Maserati <ernesto.2.maserati@gmail.com>,
	git@vger.kernel.org
Subject: Re: How to generate feature branch statistics?
References: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
	<20160720131424.GC17469@sigill.intra.peff.net>
Date:	Wed, 20 Jul 2016 11:49:20 -0700
In-Reply-To: <20160720131424.GC17469@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Jul 2016 07:14:24 -0600")
Message-ID: <xmqqd1m8du1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC4FFC44-4EAA-11E6-A0F1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In a workflow that merges feature branches to master, you can generally
> recognize them by looking for merges along the first-parent chain of
> commits:
>
>   git log --first-parent --merges master
>
> (Depending on your workflow, some feature branches may be fast-forwards
> with no merge commit, so this is just a sampling. Some workflows use
> "git merge --no-ff" to merge in feature branches, so this would see all
> of them).
> And then for each merge, you can get the set of commits that were merged
> in (it is the commits in the second parent that are not in the first).
> The bottom-most one is the "start" of the branch (or close to it; of
> course the author started writing code before they made a commit), and
> the "end" is the merge itself.

A few things to keep in mind are

 * A feature branch may be merged to the master multiple times,
   when the feature branch is properly managed.

   E.g. It may have been once thought to be complete with 3 commits,
   get merged to 'master', then a bug is discovered and gain its
   fourth commits to fix the bug and merged to 'master' again,
   resulting in a topology like this:

         A---B---C-----------D (feature)
        /         \           \
    ---o---o---o---1---o---o---2---o (master)

   "git log --first-parent --merges master" will first find commit
   '2' that merged the feature for the second time, bringing in
   commit 'D', and then it will find commit '1' that merged the
   feature previously, bringing in commit 'A', 'B' and 'C'.

 * A feature branch that depends on other feature may have merges on
   their own.  You may start a feature X that depends on another
   features Y and Z that are not yet in 'master', in addition to
   depending on things in 'master' that have been added since Y and
   Z forked from it.  In such a case, your feature X may look like
   this:

                 .-------------------1----------2--------x---x (feature X)
                /                   /          /
       y---y---y (feature Y)       /          /
      /                           /          /
  ---o---o---o---o---o---o---o---0 (master) /
          \                                /
           z---z (feature Z)              /
                \                        /
                 .----------------------.

   where '1' and '2' are merges of feature Y and then Z into the tip
   of 'master' when you start working on feature X.

   And then feature Y and feature Z may graduate to 'master' before
   your feature X is ready to do so, resulting in something like:

                 .-------------------1----------2--------x---x (feature X)
                /                   /          /
       y---y---y (feature Y) ----  / -------  /  --.
      /                           /          /      \
  ---o---o---o---o---o---o---o---o---o---o---o---o---Y---Z (master)
          \                                /            /
           z---z (feature Z) ----------   /  ----------.
                \                        /
                 .----------------------.

   where 'Y' and 'Z' are merges of features Y and Z to 'master'.
   After that, feature X may become ready to be merged, resulting in:

                 .-------------------1----------2--------x---x (feature X)
                /                   /          /              \    
       y---y---y (feature Y) ----  / -------  /  --.           \
      /                           /          /      \           \
  ---o---o---o---o---o---o---o---o---o---o---o---o---Y---Z---o---X (master)
          \                                /            /
           z---z (feature Z) ----------   /  ----------.
                \                        /
                 .----------------------.

  When "git log --first-parent --merges master" finds X, it would
  notice that it pulled in commits '1', '2' and two 'x'.  The "tool"
  to inspect the history needs to be careful deciding if '1' and '2'
  are the part of feature X.  There are variants that make it tricky
  (e.g. 'Y' may not have yet been merged to 'master' when 'X' is
  merged, in which case you may end up pulling both 'x' and 'y' into
  'master' with a single merge), which should be avoided if feature
  branches are managed carefully, but not everybody is careful when
  managing their history.

Coming back to the introduction of the original message:

>> I assume that feature branches are not frequently enough merged into
>> master. Because of that we discover bugs later than we could with a more
>> continuous code integration. I don't want to discuss here whether feature
>> branches are good or bad.

For our own history and workflow, the duration between the inception
of a topic branch and the time it gets merged to 'master' is not all
that interesting.  More interesting numbers are:

 * The duration between the time a topic hits 'next' and the time it
   gets merged to 'master'.  This is the time the developers and
   testers are using the new feature in their own work to make sure
   it does not have any ill effect.

 * The percetage of topics that is merged to 'master' with some
   follow-up changes since it hits 'next'.  This is an approximate
   for the number of bugs that are caught by developers and testers
   before a new feature goes to the general public.
