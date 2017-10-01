Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E55202A5
	for <e@80x24.org>; Sun,  1 Oct 2017 03:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbdJADtl (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 23:49:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51469 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750899AbdJADtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 23:49:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D71C6A9423;
        Sat, 30 Sep 2017 23:49:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ta06IWaq5neZpDFxDNi+g43S1hE=; b=R6Ix6U
        15gHqYeKo8MFshsnRfc7C9Kxqj7b9pSi8PYLjeY7GPEixlzzUH+Qp/eq8u8mau05
        Dj72FrJaRT0hpQjOudnORSR+YUNhRKLZqaAkpnzHDQXVU7SzLRMNPq8iILk0mYfL
        sZUwWEbFUdCtlabEkJ5kz4jReQ5AspMM4e5/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jKMS4N9uyGd6uxxc7Qm2ct2IUGe8DN7a
        vlihYCDShaplEe2AuUn1KfJ/aeWHI/adCzKp6uePHGqZBqORatvu5EjO/mJ75TgZ
        DUNWjZzi7ny5PES4kCxiHhHrJi6tfkpTg4GVKCNAHzrnoWVtk00Mg8gnkrAIVHfo
        czFLcxF8gOo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC4E5A9422;
        Sat, 30 Sep 2017 23:49:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FF14A9421;
        Sat, 30 Sep 2017 23:49:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-checkout", man page is inconsistent between SYNOPSIS and details
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
        <20170930143258.GA20886@alpha.vpn.ikke.info>
        <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
Date:   Sun, 01 Oct 2017 12:49:38 +0900
In-Reply-To: <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 30 Sep 2017 18:04:05 -0400
        (EDT)")
Message-ID: <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CD00D50-A65B-11E7-AD81-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   it's simply a matter of the forms not matching between the SYNOPSIS
> and the DESCRIPTION sections. am i making sense?

I think the whole thing is wrong and the root cause is because the
(relatively newer) description of the "--patch" mode lazily tried to
piggy-back the description of existing "check out from the index or
tree-ish" mode, ending up in a confusing description.

"git checkout [<tree-ish>] -- <pathspec>..." is a way to overwrite
the working tree files with what is in the object store.  When you
give <tree-ish>, the paths that match the <pathspec> are grabbed
from the tree-ish, added to the index, and overwrites the working
tree files.  In this mode, you need to have at least one pathspec
element on the command line, so <pathspec> is mandatory.  With no
pathspec, if <tree-ish> happens to be a commit-ish, then the
operation is "check out the commit, so that we can prepare to make
a new commit as its child".

"git checkout -p/--patch [<tree-ish>]" is quite different.  It can
be used without any <pathspec> to pick and choose from all changes
treewide, but you can use <pathspec> to limit the changes you need
to choose from.

Something like the following may be a good starting point.  As I
didn't spend many brain-cycles to come up with a description for the
"--patch" mode, that paragraph needs a total rewrite on top, but I
think the structure to separate the normal "per-path" checkout mode
and "patch" mode and describe it separately should make it a lot
clearer to see what is being described.

Short of such a fundamental correction,

	git checkout [-p|--patch] [<tree-ish>] -- [<pathspec>...]

would allow you to give none of -p/--patch/<pathspec>, which is
totally a different operation from what is being described in the
text.

 Documentation/git-checkout.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d6399c0af8..3d88f703e9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
+'git checkout' [<tree-ish>] [--] <pathspec>...
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -78,10 +79,9 @@ be used to detach HEAD at the tip of the branch (`git checkout
 +
 Omitting <branch> detaches HEAD at the tip of the current branch.
 
-'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
+'git checkout' [<tree-ish>] [--] <pathspec>...::
 
-	When <paths> or `--patch` are given, 'git checkout' does *not*
-	switch branches.  It updates the named paths in the working tree
+	Updates the named paths in the working tree
 	from the index file or from a named <tree-ish> (most often a
 	commit).  In this case, the `-b` and `--track` options are
 	meaningless and giving either of them results in an error.  The
@@ -89,7 +89,7 @@ Omitting <branch> detaches HEAD at the tip of the current branch.
 	(i.e.  commit, tag or tree) to update the index for the given
 	paths before updating the working tree.
 +
-'git checkout' with <paths> or `--patch` is used to restore modified or
+'git checkout' with <paths> is used to restore modified or
 deleted paths to their original contents from the index or replace paths
 with the contents from a named <tree-ish> (most often a commit-ish).
 +
@@ -101,6 +101,13 @@ specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
+	This is similar to the "check out paths to the working tree"
+	mode described above, but lets you use the interactive
+	interface show the "diff" output and choose which hunks to
+	use in the result.
+
+
 OPTIONS
 -------
 -q::
