Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D36720401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdFOU21 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:28:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:19183 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbdFOU20 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:28:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6153C844E0;
        Thu, 15 Jun 2017 16:28:25 -0400 (EDT)
Received: from [10.160.98.126] (unknown [167.220.148.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 24C23844DE;
        Thu, 15 Jun 2017 16:28:25 -0400 (EDT)
Subject: Re: [WIP v2 2/2] pack-objects: support --blob-max-bytes
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <cover.1496361873.git.jonathantanmy@google.com>
 <cover.1496432147.git.jonathantanmy@google.com>
 <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
 <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <14b1fbb0-d4fb-1dd3-936c-deea6d20a99b@jeffhostetler.com>
Date:   Thu, 15 Jun 2017 16:28:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/2/2017 6:26 PM, Jeff King wrote:
> On Fri, Jun 02, 2017 at 12:38:45PM -0700, Jonathan Tan wrote:
...
> We have a name-hash cache extension in the bitmap file, but it doesn't
> carry enough information to deduce the .git-ness of a file. I don't
> think it would be too hard to add a "flags" extension, and give a single
> bit to "this is a .git file".
> 
> I do also wonder if the two features would need to be separated for a
> GVFS-style solution. If you're not just avoiding large blobs but trying
> to get a narrow clone, you don't want the .git files from the
> uninteresting parts of the tree. You want to get no blobs at all, and
> then fault them in as they become relevant due to user action.
> 
> -Peff
> 

I agree with Peff here.  I've been working on my partial/narrow/sparse
clone/fetch ideas since my original RFC and have come to the conclusion
that the server can do the size limiting efficiently, but we should
leave the pathname filtering to the client.  That is, let the client
get the commits and trees and then locally apply pattern matching,
whether that be a sparse-checkout definition or simple ".git*"
matching and then make a later request for the "blobs of interest".

Whether we "fault-in" the missing blobs or have a "fetch-blobs"
command (like fetch-pack) to get them is open to debate.

There are concerns about the size of the requested blob-id list in a
fetch-blobs approach, but I think there are ways to say I need all
of the blobs referenced by the directory /foo in commit xxxx (and
optionally, that aren't present in directory /foo in commit yyyy
or in the range yyyy..xxxx).  (handwave)

Jeff
