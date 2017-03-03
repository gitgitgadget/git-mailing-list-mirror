Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CD220279
	for <e@80x24.org>; Fri,  3 Mar 2017 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbdCCSIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:08:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59871 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbdCCSI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 13:08:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91CEE6331A;
        Fri,  3 Mar 2017 13:04:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zb6KwJT+eMVbsaiBhj0kGgQ2WAU=; b=Cc1vS8
        0tx1GCmsxGEbDI+GYAau7gV0GX3FMCtnBpmq+g7D8g+WP95+FKkGRbC2+hLXdd5k
        UQlBe7dp3dBhXPlVJ8lP6vCqfDH5CcnQQqF6qCILpemebrqDh0O93jtz9MniHkSa
        hbMWNnFUYKyj3Ul0YG9lqQldJT+PVtvU/4ZkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oiEUUgwqcLvarW/G+OgzIfVU1dLmyCiB
        duRK3N58zMHyX75g8Z0+g3cudmm5ZF4hJ+Y6vV/aWR079cxVTvN143InTqOv1Yqe
        SjNLeQMX9qaiD7Q4b8vAida6E0jTWVdxbcpDSgKxdQogA22uks3uft5VLACM8ps+
        eDWM6NGOJxU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A74563319;
        Fri,  3 Mar 2017 13:04:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F36AC63318;
        Fri,  3 Mar 2017 13:04:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Finding a tag that introduced a submodule change
References: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
Date:   Fri, 03 Mar 2017 10:04:25 -0800
In-Reply-To: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
        (Robert Dailey's message of "Fri, 3 Mar 2017 09:40:04 -0600")
Message-ID: <xmqqy3wm1bkm.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D71C3DC8-003B-11E7-A1DF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Sometimes I run into a situation where I need to find out which
> release of the product a submodule change was introduced in. This is
> nontrivial, since there are no tags in the submodule itself.

Does your superproject rewind the commit in the submodule project as
it goes forward?  That is, is this property guaranteed to hold by
your project's discipline:

	Given any two commits C1 and C2 in the superproject, and the
	commit in the submodule bound to C1's and C2's tree (call
	them S1 and S2, respectively), if C1 is an ancestor of C2,
	then S1 is the same as S2 or an ancestor of S2.

If so, I think you can do a bisection of the history in the
superproject.  Pick an old commit in the superproject that binds an
old commit from the submodule that does not have the change and call
it "good".  Similarly pick a new one in the superproject that binds
a newer commit from the submodule that does have the change, and
call it "bad".  Then do

	$ git bisect start $bad $good -- $path_to_submodule

which would suggest you to test commits that change what commit is
bound at the submodule's path.

When testing each of these commits, you would see if the commit
bound at the submodule's path has the change or not.

	$ current=$(git rev-parse HEAD:$path_to_submodule)

would give you the object name of that commit, and then

	$ git -C $path_to_submodule merge-base --is-ancestor $change $current

would tell you if the $change you are interested in is already
contained in that $current commit.  Then you say "git bisect good"
if $current is too old to contain the $change, and "git bisect bad"
if $current is sufficiently new and contains the $change, to
continue.

If your superproject rewinds the commit in the submodule as it goes
forward, e.g. an older commit in the superproject used submodule
commit from day X, but somebody who made yesterday's commit in the
superproject realized that that submodule commit was broken and used
an older commit in the submodule from day (X-1), then you cannot
bisect.  In such a case, I think you would essentially need to check
all superproject commits that changed the commit bound at the
submodule's path.

	$ git rev-list $bad..$good -- $path_to_submodule

would give a list of such commits, and you would do the "merge-base"
check for all them to see which ones have and do not have the
$change (replace "HEAD" with the commit you are testing in the
computation that gives you $current).


