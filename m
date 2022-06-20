Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CD5C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 09:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiFTJm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiFTJmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 05:42:25 -0400
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC9513DCD
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 02:42:23 -0700 (PDT)
Received: from b.8.0.0.8.9.b.0.2.f.0.9.2.a.d.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:bda2:90f2:b98:8b] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1o3DvG-0007K1-OA; Mon, 20 Jun 2022 10:42:18 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1o3Duf-005S5j-FQ; Mon, 20 Jun 2022 10:41:41 +0100
Date:   Mon, 20 Jun 2022 10:41:41 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths
 containing colons
Message-ID: <20220620094141.uwvofvefoq26xxdu@lucy.dinwoodie.org>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
 <20220528231118.3504387-3-gitster@pobox.com>
 <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org>
 <xmqqpmj9zohk.fsf@gitster.g>
 <20220615213656.zp36wdwbcz7yevac@lucy.dinwoodie.org>
 <nycvar.QRO.7.76.6.2206182213290.349@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2206182213290.349@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 18, 2022 at 10:19:28PM +0200, Johannes Schindelin wrote:
> Hi Adam,
> 
> On Wed, 15 Jun 2022, Adam Dinwoodie wrote:
> 
> > On Wed, Jun 15, 2022 at 01:00:07PM -0700, Junio C Hamano wrote:
> > > Adam Dinwoodie <adam@dinwoodie.org> writes:
> > >
> > > >> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> > > >> index d6027189e2..3992d08158 100755
> > > >> --- a/t/t5003-archive-zip.sh
> > > >> +++ b/t/t5003-archive-zip.sh
> > > >> @@ -207,13 +207,21 @@ check_zip with_untracked
> > > >>  check_added with_untracked untracked untracked
> > > >>
> > > >>  test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
> > > >> +	if test_have_prereq FUNNYNAMES
> > > >> +	then
> > > >> +		PATHNAME="pathname with : colon"
> > > >> +	else
> > > >> +		PATHNAME="pathname without colon"
> > > >> +	fi &&
> > > >>  	git archive --format=zip >with_file_with_content.zip \
> > > >> +		--add-virtual-file=\""$PATHNAME"\": \
> > > >>  		--add-virtual-file=hello:world $EMPTY_TREE &&
> > > >>  	test_when_finished "rm -rf tmp-unpack" &&
> > > >>  	mkdir tmp-unpack && (
> > > >>  		cd tmp-unpack &&
> > > >>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
> > > >>  		test_path_is_file hello &&
> > > >> +		test_path_is_file "$PATHNAME" &&
> > > >>  		test world = $(cat hello)
> > > >>  	)
> > > >>  '
> > > >
> > > > This test is currently failing on Cygwin: it looks like it's exposing a
> > > > bug in Cygwin that means files with colons in their name aren't
> > > > correctly extracted from zip archives.  I'm going to report that to the
> > > > Cygwin mailing list, but I wanted to note it for the record here, too.
> > >
> > > Does this mean that our code to set FUNNYNAMES prerequiste is
> > > slightly broken?  IOW, should we check with a path with a colon in
> > > it, as well as whatever we use currently for FUNNYNAMES?
> > >
> > > Something like the attached patch?
> > >
> > > Or does Cygwin otherwise work perfectly well with a path with a
> > > colon in it, but only $GIT_UNZIP command has problem with it?  If
> > > that is the case, then please disregard the attached.
> >
> > The latter: Cygwin works perfectly with paths containing colons, except
> > that Cygwin's `unzip` is seemingly buggy and doesn't work.  The file
> > systems Cygwin runs on don't support colons in paths, but Cygwin hides
> > that problem by rewriting ASCII colons to some high Unicode code point
> > on the filesystem,
> 
> Let me throw in a bit more detail: The forbidden characters are mapped
> into the Unicode page U+f0XX, which is supposed to be used "for private
> purposes". Even more detail can be found here:
> https://github.com/cygwin/cygwin/blob/cygwin-3_3_5-release/winsup/cygwin/strfuncs.cc#L19-L23
> 
> > meaning Cygwin-native applications see a regular colon, while
> > Windows-native applications see an unusual but perfectly valid Unicode
> > character.
> 
> Now, I have two questions:
> 
> - Why does `unzip` not use Cygwin's regular functions (which should all be
>   aware of that U+f0XX <-> U+00XX mapping)?

That is an excellent question!  This behaviour came from an `#ifdef
__CYGWIN__` in the upstream unzip package; with that #ifdef removed,
everything works as expected.  The folk on the Cygwin mailing list had
no idea *why* that #ifdef was there, given it's evidently unnecessary;
my best guess is that it was added a long time ago before Cygwin could
handle those characters in the general case.

Since my report, the Cygwin package has picked up a new maintainer who
has released a version of the unzip package with that #ifdef removed, so
this test is now passing.

> - Even more importantly: would the test case pass if we simply used
>   another forbidden character, such as `?` or `*`?

The set of characters that had special handling in unzip was "*:?|<> all
of which are handled appropriately by Cygwin applications in general,
and all of which had this unnecessary handling in `unzip`

> > I tested the same patch to FUNNYNAMES myself before reporting, and the
> > test fails exactly the same way.  If we wanted to catch this, I think
> > we'd need a test that explicitly attempted to unzip an archive
> > containing a path with a colon.
> >
> > (The code to set FUNNYNAMES *is* slightly broken, per the discussions
> > around 6d340dfaef ("t9902: split test to run on appropriate systems",
> > 2022-04-08), and my to-do list still features tidying up and
> > resubmitting the patch Ævar wrote in that discussion thread.  But it
> > wouldn't help here because this issue is specific to Cygwin's `unzip`,
> > rather than a general limitation of running on Cygwin.)
> 
> I'd rather avoid changing FUNNYNAMES at this stage, if we can help it.

Oh yes, I definitely wasn't proposing changing things for 2.37.0!  I
just wanted to acknowledge that there is a known issue here that has
been discussed on this list previously, that we (I) would hopefully get
around to fixing at some point.

Adam
