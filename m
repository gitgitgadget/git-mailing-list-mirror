Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EEF1F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 02:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfJHC4m (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 22:56:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54046 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbfJHC4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 22:56:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 05A371F4BD;
        Tue,  8 Oct 2019 02:56:41 +0000 (UTC)
Date:   Tue, 8 Oct 2019 02:56:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 21/20] convert: drop invalid comment for
 subprocess_entry
Message-ID: <20191008025641.zinxoqsrncgzyjcq@dcvr>
References: <20191006233043.3516-1-e@80x24.org>
 <20191006233043.3516-21-e@80x24.org>
 <xmqqeezp490w.fsf@gitster-ct.c.googlers.com>
 <20191007084339.GA7808@dcvr>
 <xmqq4l0koucn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4l0koucn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > "struct hashmap_entry" inside "struct subprocess_entry"
> > no longer needs to be the first member of any struct,
> > so the old comment is no longer true.
> 
> Hmm, is that true?
> 
> struct cmd2process {
> 	struct subprocess_entry subprocess;
> 	unsigned int supported_capabilities;
> };
> 
> static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
> {
> 	static int versions[] = {2, 0};
> 	static struct subprocess_capability capabilities[] = {
> 		{ "clean",  CAP_CLEAN  },
> 		{ "smudge", CAP_SMUDGE },
> 		{ "delay",  CAP_DELAY  },
> 		{ NULL, 0 }
> 	};
> 	struct cmd2process *entry = (struct cmd2process *)subprocess;
> 	return subprocess_handshake(subprocess, "git-filter", versions, NULL,
> 				    capabilities,
> 				    &entry->supported_capabilities);
> }
> 
> The cast "struct subprocess_entry *" to "struct cmd2process *" we
> see here does require that the address of the subprocess field must
> be the same as the address of the structure itself.  So I'd have to
> say that the comment still is true, but not for the reasons of what
> is in "struct subprocess_entry".

Oops, right.   Let's just leave it at 20 patches for this series
and skip this one, for now.

I seem to recall there's a bunch of places where we do casts
like that which could be rewritten more flexibly with container_of.
