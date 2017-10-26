Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB60A2055E
	for <e@80x24.org>; Thu, 26 Oct 2017 02:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbdJZC2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 22:28:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52448 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932204AbdJZC2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 22:28:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63037989C0;
        Wed, 25 Oct 2017 22:28:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pBn0Xj+KmCPLlLyYFAUj2eFCuxg=; b=G+qyZq
        7CjR/0tv3aYGHzwCPpb1pBGUc4vTCtQsBi8F+cvMI80diydXuxzDnv3VRhcz5e8C
        2DOWOAXcJaC5UaxDB/EAXn5ILwj2pRMmVEJm1NaB28hE61JEGbU8wlq72QmjFYyf
        DOV98H8pzcBXG/T6HWQIN+n3LfNJua7z8D84g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W5wNov7OCOuetiHzN4Yiqu7wooKzbKne
        g3WBt6/1ImR5K8fp8SjXRb+uhgazZuX1wMJIn8CgpSFS6g/Kp4749M3ho0iDd1eA
        uvd24xEKPRkaHmzqL3VknTtIHw3OVDSNIVdOSFIQYxVxxhYcEuCVOypfVGg7BFIQ
        6j5b2na481Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A4D1989BF;
        Wed, 25 Oct 2017 22:28:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2117989BA;
        Wed, 25 Oct 2017 22:28:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/1] status: do not get confused by submodules in excluded directories
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
        <cover.1508964005.git.johannes.schindelin@gmx.de>
        <33355d901d5f1c4d040b33bfd5b94e01803c03cd.1508964005.git.johannes.schindelin@gmx.de>
Date:   Thu, 26 Oct 2017 11:28:32 +0900
In-Reply-To: <33355d901d5f1c4d040b33bfd5b94e01803c03cd.1508964005.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 25 Oct 2017 22:40:40 +0200
        (CEST)")
Message-ID: <xmqqtvymfxrj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D193264-B9F5-11E7-8CD5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We meticulously pass the `exclude` flag to the `treat_directory()`
> function so that we can indicate that files in it are excluded rather
> than untracked when recursing.
>
> But we did not yet treat submodules the same way.
>
> Because of that, `git status --ignored --untracked` with a submodule
> `submodule` in a gitignored `tracked/` would show the submodule in the
> "Untracked files" section, e.g.
>
> 	On branch master
> 	Untracked files:
> 	  (use "git add <file>..." to include in what will be committed)
>
> 		tracked/submodule/
>
> 	Ignored files:
> 	  (use "git add -f <file>..." to include in what will be committed)
>
> 		tracked/submodule/initial.t
>
> Instead, we would want it to show the submodule in the "Ignored files"
> section:

Makes sense.  Also listing the paths in the embedded working tree
like initial.t as if it were part of our project is utterly wrong,
especially because we are not doing any --recurse-submodules thing.

Both the change and the updated description looks good.  Thanks.
