Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F1E1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935135AbeFMS6G (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:58:06 -0400
Received: from mail132-26.atl131.mandrillapp.com ([198.2.132.26]:64698 "EHLO
        mail132-26.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754484AbeFMS6F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jun 2018 14:58:05 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 14:58:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=5L6dEou7H9Maj/Io9HPP0uj73w+Te7TNE1xUpyeJaUc=;
 b=DK1tpbAVpYVu8H/yX9XhhpZ+swzf3mlp4GfmXoKeDgKghwdbfRszhrzyKAzT6p1YBHoUtNh+IHN2
   +NsE+jJxY+06z8+RklRKcRde9BN9/isNdsWeJqVDamNjGXwyhFdkeRyKRYWaZZ3h5YTZGxbq/5uh
   zdT1caxw7y71zGBtspM=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail132-26.atl131.mandrillapp.com id h45kjq1sar89 for <git@vger.kernel.org>; Wed, 13 Jun 2018 18:43:05 +0000 (envelope-from <bounce-md_31050260.5b2165b9.v1-b3377503657c4a7597ab4e87dea03495@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528915385; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=5L6dEou7H9Maj/Io9HPP0uj73w+Te7TNE1xUpyeJaUc=; 
 b=Pd7A0Rk0rv31dN/+UJ6zl1KLfpT/pvi+1aSMiwCQ/Q7q6yvf9sHbEqCfL9piZI6R9KcvNo
 1PYQd3kItPXVSX9Zk3cz+wNnwTG5atlT+AGep+X2v0IPNSrPCjHMy975uczCZMGSZZiaQP5g
 eUkJ82FjqtL+mCsta12krz/73w6ZA=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
Received: from [87.98.221.171] by mandrillapp.com id b3377503657c4a7597ab4e87dea03495; Wed, 13 Jun 2018 18:43:05 +0000
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Message-Id: <20180613184301.GB22854@deco.navytux.spb.ru>
References: <20180612185413.GA21856@deco.navytux.spb.ru> <20180613111840.1427-1-kirr@nexedi.com> <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.b3377503657c4a7597ab4e87dea03495
X-Mandrill-User: md_31050260
Date:   Wed, 13 Jun 2018 18:43:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 10:42:33AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > Fetch-pack --all became broken with respect to unusual tags in
> > 5f0fc64513 (fetch-pack: eliminate spurious error messages, 2012-09-09),
> > and was fixed only recently in e9502c0a7f (fetch-pack: don't try to fetch
> > peel values with --all, 2018-06-11). However the test added in
> > e9502c0a7f does not explicitly cover all funky cases.
> 
> Thanks.  Very much appreciated

Thanks.


> > In order to be sure fetching funky tags will never break, let's
> > explicitly test all relevant cases with 4 tag objects pointing to 1) a
> > blob, 2) a tree, 3) a commit, and 4) another tag objects. The referenced
> > tag objects themselves are referenced from under regular refs/tags/*
> > namespace. Before e9502c0a7f `fetch-pack --all` was failing e.g. this way:
> >
> >         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
> >         440858748ae905d48259d4fb67a12a7aa1520cf7        HEAD
> >         ...
> >         bc4e9e1fa80662b449805b1ac29fc9b1e4c49187        refs/tags/tag-to-blob                   # <-- NOTE
> >         038f48ad0beaffbea71d186a05084b79e3870cbf        refs/tags/tag-to-blob^{}
> >         520db1f5e1afeaa12b1a8d73ce82db72ca036ee1        refs/tags/tag-to-tree                   # <-- NOTE
> >         7395c100223b7cd760f58ccfa0d3f3d2dd539bb6        refs/tags/tag-to-tree^{}
> >         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
> >         fatal: A git upload-pack: not our ref 038f48ad0beaffbea71d186a05084b79e3870cbf
> >         fatal: The remote end hung up unexpectedly
> 
> ... except for this bit.  I am not sure readers understand what
> these two overlong lines want to say.  Would it be easier to
> understand if you wrote the above like this?
> 
>          .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
>          44085874...        HEAD
>          ...
>          bc4e9e1f...        refs/tags/tag-to-blob
>          038f48ad...        refs/tags/tag-to-blob^{}	# peeled
>          520db1f5...        refs/tags/tag-to-tree
>          7395c100...        refs/tags/tag-to-tree^{}	# peeled
>          .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
>          fatal: A git upload-pack: not our ref 038f48ad...
>          fatal: The remote end hung up unexpectedly
> 
> Instead of marking the tag-to-blob and tag-to-tree entries (which
> are not where the 'fatal' breakage comes from), I think it makes
> more sense to mark the entries that show peeled version (which also
> matches the object name in the error message), and by shortening the
> line, readers can see more easily which lines are highlighted.

Makes sense. I've amended the patch description with your suggestion.

> > +test_expect_success 'test --all wrt tag to non-commits' '
> > +	blob=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
> > +	git tag -a -m "tag -> blob" tag-to-blob $blob &&
> > + \
> > +	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
> > +	git tag -a -m "tag -> tree" tag-to-tree $tree &&
> > + \
> > +	tree2=$(printf "100644 blob $blob\tfile2" | git mktree) &&
> > +	commit=$(git commit-tree -m "hello commit" $tree) &&
> > +	git tag -a -m "tag -> commit" tag-to-commit $commit &&
> > + \
> > +	blob2=$(echo "hello blob2" | git hash-object -t blob -w --stdin) &&
> > +	tag=$(printf "object $blob2\ntype blob\ntag tag-to-blob2\n\
> > +tagger author A U Thor <author@example.com> 0 +0000\n\nhello tag" | git mktag) &&
> > +	git tag -a -m "tag -> tag" tag-to-tag $tag &&
> 
> All of the above, while may not be techincallly wrong per-se, look
> unnecessarily complex.
> 
> I guess the reason why you do the above is because you do not want
> to use any object that is reachable via other existing refs and
> instead want to ensure these objects are reachable only via the tags
> you are creating in this test.  Otherwise using HEAD~4:test.txt and
> HEAD^{tree} instead of $blob and $tree constructed via hash-object
> and mktree would be sufficient and more readable.  Oh well.

Yes, it is exactly the reason here. I've added corresponding comment
explaining this to the test case.

Kirill

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Wed, 13 Jun 2018 12:28:21 +0300
Subject: [PATCH v2] fetch-pack: test explicitly that --all can fetch tag
 references pointing to non-commits

Fetch-pack --all became broken with respect to unusual tags in
5f0fc64513 (fetch-pack: eliminate spurious error messages, 2012-09-09),
and was fixed only recently in e9502c0a7f (fetch-pack: don't try to fetch
peel values with --all, 2018-06-11). However the test added in
e9502c0a7f does not explicitly cover all funky cases.

In order to be sure fetching funky tags will never break, let's
explicitly test all relevant cases with 4 tag objects pointing to 1) a
blob, 2) a tree, 3) a commit, and 4) another tag objects. The referenced
tag objects themselves are referenced from under regular refs/tags/*
namespace. Before e9502c0a7f `fetch-pack --all` was failing e.g. this way:

        .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
        44085874...        HEAD
        ...
        bc4e9e1f...        refs/tags/tag-to-blob
        038f48ad...        refs/tags/tag-to-blob^{}	# peeled
        520db1f5...        refs/tags/tag-to-tree
        7395c100...        refs/tags/tag-to-tree^{}	# peeled

        .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
        fatal: A git upload-pack: not our ref 038f48ad...
        fatal: The remote end hung up unexpectedly

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 t/t5500-fetch-pack.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f20bb59d22..5879ee44d7 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -528,6 +528,37 @@ test_expect_success 'test --all with tag to non-tip' '
 	)
 '
 
+test_expect_success 'test --all wrt tag to non-commits' '
+	# create tag-to-{blob,tree,commit,tag}, making sure all tagged objects
+	# are reachable only via created tag references.
+	blob=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
+	git tag -a -m "tag -> blob" tag-to-blob $blob &&
+ \
+	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
+	git tag -a -m "tag -> tree" tag-to-tree $tree &&
+ \
+	tree2=$(printf "100644 blob $blob\tfile2" | git mktree) &&
+	commit=$(git commit-tree -m "hello commit" $tree) &&
+	git tag -a -m "tag -> commit" tag-to-commit $commit &&
+ \
+	blob2=$(echo "hello blob2" | git hash-object -t blob -w --stdin) &&
+	tag=$(printf "object $blob2\ntype blob\ntag tag-to-blob2\n\
+tagger author A U Thor <author@example.com> 0 +0000\n\nhello tag" | git mktag) &&
+	git tag -a -m "tag -> tag" tag-to-tag $tag &&
+ \
+	# `fetch-pack --all` should succeed fetching all those objects.
+	mkdir fetchall &&
+	(
+		cd fetchall &&
+		git init &&
+		git fetch-pack --all .. &&
+		git cat-file blob $blob >/dev/null &&
+		git cat-file tree $tree >/dev/null &&
+		git cat-file commit $commit >/dev/null &&
+		git cat-file tag $tag >/dev/null
+	)
+'
+
 test_expect_success 'shallow fetch with tags does not break the repository' '
 	mkdir repo1 &&
 	(
-- 
2.18.0.rc1.256.g331a1db143
