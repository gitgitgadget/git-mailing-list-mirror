Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D4C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6376F2070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbhA0D6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52636 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317764AbhA0BTo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:19:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D50AF1180D9;
        Tue, 26 Jan 2021 20:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1W9cwtif3CPxJ+0tUFLv41UoQok=; b=IFKXHB
        f1CMX2t2ilPEhjyLHW5fgcUHcN+VeThJWvOhru8TIhIzYaWgFnbDXJZahFZmHBV7
        IbcSEQz6dTnKxYH5n/59Bw0jTW86ol/GAf3SQi66Enij2VW10/kYzYnsBAqm2DYb
        beiP2j9x8lOUjfkHb05+57Aws4JVsMCDS8k/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PwAxOV6VAxmpXwN/zbV4Mh3Xd+NbuSXG
        Ig6tTitzjR8OwvkZrmFTxZ3enKexZi9d/vfdqa7UqVRu6W/pkXKcu39j21h8XlPq
        o9Ejwow0S1XuYtyrvq94VmtOefq2TSvBCSzNSSkS2yVMty0ppG7OvzQ3PP70waWd
        p+IvX8R+Gdg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD9F01180D8;
        Tue, 26 Jan 2021 20:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 223A11180D7;
        Tue, 26 Jan 2021 20:11:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
Date:   Tue, 26 Jan 2021 17:11:42 -0800
In-Reply-To: <cover.1611686656.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 26 Jan 2021 10:55:54 -0800")
Message-ID: <xmqqeei7yyi9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EAFDBCE-603C-11EB-8F0A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Peff, for your review. I have addressed your comments (through
> replies to your emails and here in this v5 patch set).
>
> Jonathan Tan (3):
>   ls-refs: report unborn targets of symrefs
>   connect, transport: encapsulate arg in struct
>   clone: respect remote unborn HEAD

Applying this alone to 'master' seems to pass all tests, but
the topic seems to have funny interactions with another topic
in flight, jk/peel-iterated-oid

There is textual conflict whose resolution seems trivial, but with
that resolved ...

diff --cc builtin/clone.c
index e335734b4c,77fdc61f4d..0000000000
--- i/builtin/clone.c
+++ w/builtin/clone.c
@@@ -1326,10 -1330,21 +1330,21 @@@ int cmd_clone(int argc, const char **ar
  		remote_head = NULL;
  		option_no_checkout = 1;
  		if (!option_bare) {
- 			const char *branch = git_default_branch_name(0);
- 			char *ref = xstrfmt("refs/heads/%s", branch);
+ 			const char *branch;
+ 			char *ref;
+ 
+ 			if (transport_ls_refs_options.unborn_head_target &&
+ 			    skip_prefix(transport_ls_refs_options.unborn_head_target,
+ 					"refs/heads/", &branch)) {
+ 				ref = transport_ls_refs_options.unborn_head_target;
+ 				transport_ls_refs_options.unborn_head_target = NULL;
+ 			} else {
 -				branch = git_default_branch_name();
++				branch = git_default_branch_name(0);
+ 				ref = xstrfmt("refs/heads/%s", branch);
+ 			}
  
  			install_branch_config(0, branch, remote_name, ref);
+ 			create_symref("HEAD", ref, "");
  			free(ref);
  		}
  	}


... numerous tests fail.

For example, t5702 dies like so:

expecting success of 5702.15 'clone of empty repo propagates name of default branch':
        test_when_finished "rm -rf file_empty_parent file_empty_child" &&

        GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
        git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&

        GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
        git -c init.defaultBranch=main -c protocol.version=2 \
                clone "file://$(pwd)/file_empty_parent" file_empty_child &&
        grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD

Initialized empty Git repository in /usr/local/google/home/jch/w/git.git/t/trash directory.t5702-protocol-v2/file_empty_parent/.git/
Cloning into 'file_empty_child'...
fatal: expected flush after ref listing
not ok 15 - clone of empty repo propagates name of default branch
