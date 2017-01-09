Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E17F205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 02:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759337AbdAICdk (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 21:33:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757384AbdAICdi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 21:33:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 755375F2C3;
        Sun,  8 Jan 2017 21:33:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9KlZxfQYkMvwG2pNJvIS//ObkFM=; b=VIZPv0
        wpqQ0mGNt1KkfzP27KZh4ugf8LN6gVP3HbS3Ivz8CU5hwHxcj/U0zqtfX1hOcrvI
        TKxIkQYSLhZVhqYrW87Wx/j2hF89PA1s6NCn7t7WaAKbtaYUDqAPgw+pGZ7FwJ2d
        NTzvJ3gv/fvCk6W37vToopWNGIrGKony1jFzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PJPk8homBBw0/K/G2KWWEk9Z25jbP5Wf
        B6fvjsgWlqaIs77nfJV2a3z7TuHxX2ui2VNnptIcTlBDrjUv6SHVKCufYPwYL9gW
        lDyTBCNpVniJfkGHl1bMTDdVMoIVRTrRV7iAy7fHrpVE5QKY9yj3e0dUgxx5mMY8
        6H/93j21KHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BD705F2C2;
        Sun,  8 Jan 2017 21:33:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC8355F2C1;
        Sun,  8 Jan 2017 21:33:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCHv6 1/2] submodule tests: don't use itself as a submodule
References: <20170105192904.1107-1-sbeller@google.com>
        <20170105192904.1107-2-sbeller@google.com>
Date:   Sun, 08 Jan 2017 18:33:35 -0800
In-Reply-To: <20170105192904.1107-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 5 Jan 2017 11:29:03 -0800")
Message-ID: <xmqqh959ynb4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05D9934C-D614-11E6-80EB-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This provides an easier way to have submodules in tests, by just setting
> TEST_CREATE_SUBMODULE to a non empty string, similar to
> TEST_NO_CREATE_REPO.

Yuck.  

I find it doubtful that it is a good idea to create two submodule
repositories by merely dot-including the test-lib.sh; I find it
doubly doubtful that it is a good idea to make test_create_repo
pay attention to the special variable to implement that.

I am OK with a solution where callers that set TEST_CREATE_SUBMODULE
variable in this patch to instead have an explicit call

	test_create_repo --submodule pretzel

That would be a lot more obvious.

The primary reason why I hate the implementation in this patch is
that it is very easy for a test that says TEST_CREATE_SUBMODULE
upfront, only to get the initial test repository (which everybody
else gets) with two test submodules, to later gain a test that wants
to use a separate repository and call "test_create_repo".  It will
always get the pretzel submodules, which may or may not match what
the test writer who adds a new test needs.

> Make use of it in those tests that add a submodule from ./. except for
> the occurrence in create_lib_submodule_repo as there it seems we craft
> a repository deliberately for both inside as well as outside use.

But isn't the point of this change that use of ./. cannot be
mimicking any real-world use, hence pointless for the purpose of
really testing the components of the system?  If "we craft
deliberately for both inside and outside use" indeed _IS_ a good
thing, then perhaps use of ./. has practical real-world use---if
not, wouldn't we want to fix the scripts that include the
lib-submodule-repo helper not to test such an unrealistic layout?

