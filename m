Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511DF2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 17:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965356AbcKDR5O (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 13:57:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62618 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934840AbcKDR5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 13:57:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 900984AA06;
        Fri,  4 Nov 2016 13:57:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=rgiGoMolZBIr/AHosUefDClMR6g=; b=Y6jL/rlMxtHRFUUCvFRsHkco/2dQ
        3ewBgSKKY9BAWJxlj1S4cbVlritn5W6vAdjXuSabyOTSbk7uCsRH82wey3a+ociI
        BS2a4WSC33brdgaCwDseVCidMlW0J+x8s+P+F4C5BBDdY8vkrREDIndrac/p5J2a
        JkuWQxf/7WDKsJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        IERcAXYwpYItYGTLquNq0sOhKt6+wF/x9EP4WVpZAdOfJoCszFs1Xi82MLJSwu+f
        +Wf9b5LCMBLQhB4KCZ+SAGYNWnP5ovx8OthHr9sl/IiFTYhoXsGNpaaKtilt57Pb
        nsMqwxW9JDwAC8Up1/9gloXF01Zx3/bQGPlD/fFOL0k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8746E4AA05;
        Fri,  4 Nov 2016 13:57:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E77B24AA01;
        Fri,  4 Nov 2016 13:57:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Subject: Regarding "git log" on "git series" metadata
cc:     git@vger.kernel.org
Date:   Fri, 04 Nov 2016 10:57:09 -0700
Message-ID: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C0C7948-A2B8-11E6-BF56-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After your talk at LPC2016, I was thinking about your proposal to
give an option to hide certain parents from "git log" traversal.

While I do not think we would terribly mind a new feature in the
core to support third-party additions like "git series" better, I
think this particular one is a big mistake that we shouldn't take.

For those listening from sidelines, here is a version of my
understanding of "git series":

 * "git series" wants to represent a patch series evolution.  It is
   a history of history, and each element of this evolution is
   represented by:

   - a commit object, that is used to describe what this reroll of
     the topic is about, and its parent links point at previous
     rerolls (it could be a merge of two independent incarnations of
     a series).

   - the tree contained in the commit object records the base commit
     where the topic forks from the main history, and the tip commit
     where the topic ends.  These are pointers into the main history
     DAG.

   - the tree may have other metadata, an example of which is the
     cover letter contents to be used when the topic becomes ready
     for re-submission.  There may be more metadata you would want
     to add in the future versions of "git series".

   Needless to say, the commits that represent the history of a
   series record a tree that is completely differently shaped.  The
   only relation between the series history and main history is that
   the former has pointers into the latter.

 * You chose to represent the base and tip commit object as gitlinks
   in the tree of a series commit, simply because it was a way that
   was already implemented to record a commit object name in a tree.

 * However, because gitlink is designed to be used for "external"
   things (the prominent example is submodule), recording these as
   gitlinks would guarantee that they will get GCed as a series
   progresses, the main history rewound and rewritten thereby making
   the base and tip recorded in the older part of the series history
   unreachable from the main history.  Because you want to make sure
   that base and tip objects will stay in the repository even after
   the topic branch in the main history gets rewound, this is not
   what you want.

 * In order to workaround that reachability issue, the hack you
   invented is to add the tip commit as a "parent" of a commit that
   represents one step in the series.  This may guarantee the
   reachability---as long as a commit in a series history is
   reachable from a ref, the tip and base commits will be reachable
   from there even if they are rebased away from the main history.
   But of course, there are downsides.

 * Due to this hack, feeding "gitk" (or "git log") a commit in the
   series history will give you nonsense results.  You are not
   interested in traversing or viewing the commits in the main
   history.

 * Because of the above, you propose another hack to tell the
   revision traversal machinery to optionally omit a parent commit
   that appear as a gitlink in the tree.

I think this is backwards.  The root cause of the issue you have
with "gitk" is because you added something that is *NOT* a parent to
your commit.  We shouldn't have to add a mechanism to filter
something that shouldn't have been added there in the first place.

I am wondering if an alternative approach would work better.

Imagine we invent a new tree entry type, "gitref", that is similar
to "gitlink" in that it can record a commit object name in a tree,
but unlike "gitlink" it does imply reachability.  And you do not add
phony parents to your commit object.  A tree that has "gitref"s in
it is about annotating the commits in the same repository (e.g. the
tree references two commits, "base" and "tip", to point into a slice
of the main history).  And it is perfectly sensible for such a
pointer to imply reachability---after all it serves different
purposes from "gitlink".

Another alternative that I am negative about (but is probably a
better hack than how you abused the "parent" link) might be to add a
new commit object header field that behaves similarly to "parent"
only in that it implies reachability.  But recording the extra
parent in commit object was not something you wanted to do in the
first place (i.e. your series processing is done solely on the
contents of the tree, and you do not read this extra parent). If you
need to add an in-tree reference to another commit in your future
versions of "git series", with either this variant or your original
implementation, you would end up needing adding more "parent" (or
pseudo parent) only to preserve reachability.  At that point, I
think it makes more sense to have entries in the tree to directly
ensure reachability, if you want these entries to always point at an
in-tree object.

I am afraid that I probably am two steps ahead of myself, because I
am reasonably sure that it is quite possible that I have overlooked
something trivially obvious that makes the "gitref" approach
unworkable.

