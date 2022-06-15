Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A0C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiFOVhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbiFOVhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 17:37:01 -0400
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CF562D0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:36:59 -0700 (PDT)
Received: from 77.116.2.81.in-addr.arpa ([81.2.116.77] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1o1ah7-0000LS-K2; Wed, 15 Jun 2022 22:36:57 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1o1ah6-001Hsm-Tc; Wed, 15 Jun 2022 22:36:56 +0100
Date:   Wed, 15 Jun 2022 22:36:56 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths
 containing colons
Message-ID: <20220615213656.zp36wdwbcz7yevac@lucy.dinwoodie.org>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
 <20220528231118.3504387-3-gitster@pobox.com>
 <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org>
 <xmqqpmj9zohk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpmj9zohk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 01:00:07PM -0700, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> 
> >> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> >> index d6027189e2..3992d08158 100755
> >> --- a/t/t5003-archive-zip.sh
> >> +++ b/t/t5003-archive-zip.sh
> >> @@ -207,13 +207,21 @@ check_zip with_untracked
> >>  check_added with_untracked untracked untracked
> >>  
> >>  test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
> >> +	if test_have_prereq FUNNYNAMES
> >> +	then
> >> +		PATHNAME="pathname with : colon"
> >> +	else
> >> +		PATHNAME="pathname without colon"
> >> +	fi &&
> >>  	git archive --format=zip >with_file_with_content.zip \
> >> +		--add-virtual-file=\""$PATHNAME"\": \
> >>  		--add-virtual-file=hello:world $EMPTY_TREE &&
> >>  	test_when_finished "rm -rf tmp-unpack" &&
> >>  	mkdir tmp-unpack && (
> >>  		cd tmp-unpack &&
> >>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
> >>  		test_path_is_file hello &&
> >> +		test_path_is_file "$PATHNAME" &&
> >>  		test world = $(cat hello)
> >>  	)
> >>  '
> >
> > This test is currently failing on Cygwin: it looks like it's exposing a
> > bug in Cygwin that means files with colons in their name aren't
> > correctly extracted from zip archives.  I'm going to report that to the
> > Cygwin mailing list, but I wanted to note it for the record here, too.
> 
> Does this mean that our code to set FUNNYNAMES prerequiste is
> slightly broken?  IOW, should we check with a path with a colon in
> it, as well as whatever we use currently for FUNNYNAMES?
> 
> Something like the attached patch?  
> 
> Or does Cygwin otherwise work perfectly well with a path with a
> colon in it, but only $GIT_UNZIP command has problem with it?  If
> that is the case, then please disregard the attached.

The latter: Cygwin works perfectly with paths containing colons, except
that Cygwin's `unzip` is seemingly buggy and doesn't work.  The file
systems Cygwin runs on don't support colons in paths, but Cygwin hides
that problem by rewriting ASCII colons to some high Unicode code point
on the filesystem, meaning Cygwin-native applications see a regular
colon, while Windows-native applications see an unusual but perfectly
valid Unicode character.

I tested the same patch to FUNNYNAMES myself before reporting, and the
test fails exactly the same way.  If we wanted to catch this, I think
we'd need a test that explicitly attempted to unzip an archive
containing a path with a colon.

(The code to set FUNNYNAMES *is* slightly broken, per the discussions
around 6d340dfaef ("t9902: split test to run on appropriate systems",
2022-04-08), and my to-do list still features tidying up and
resubmitting the patch Ævar wrote in that discussion thread.  But it
wouldn't help here because this issue is specific to Cygwin's `unzip`,
rather than a general limitation of running on Cygwin.)
