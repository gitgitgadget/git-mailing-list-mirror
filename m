Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CBA1F731
	for <e@80x24.org>; Sun, 11 Aug 2019 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfHKPEz (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 11:04:55 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46189 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfHKPEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 11:04:55 -0400
Received: from localhost (unknown [157.45.8.145])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 35B2C240009;
        Sun, 11 Aug 2019 15:04:52 +0000 (UTC)
Date:   Sun, 11 Aug 2019 20:34:50 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Farhan Khan <farhan@farhan.codes>
Cc:     Git <git@vger.kernel.org>
Subject: Re: How to determine when to stop receiving pack content
Message-ID: <20190811150450.5pvgvwcqrrvzggbo@localhost.localdomain>
References: <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/19 11:47PM, Farhan Khan wrote:
> Hi,
> 
> I am trying to write an implementation of git clone over ssh and am a little confused how to determine a server response has ended. Specifically, after a client sends its requested 'want', the server sends the pack content over. However, how does the client know to stop reading data? If I run a simple read() of the file descriptor:
>
> A. If I use reading blocking, the client will wait until new data is available, potentially forever.
> B. If I use non-blocking, the client might terminate reading for new data, when in reality new data is in transit.
> 
> I do not see a mechanism to specify the size or to indicate the end of the pack content. Am I missing something?

Well, I am not very familiar with git-clone internals, but I did some 
digging around, and I think I know what answer to your problem is.

Looking at Documentation/technical/protocol-v2.txt:34, the flush packet 
indicates the end of a message. Looking in the output section of the 
fetch command (protocol-v2.txt:342), it sends you some optional 
sections, and then the packfile and then sends a flush packet.

So your read should stop reading data when it sees the flush packet.

Another way would be to look at the packfile contents. Looking at 
Documentation/technical/pack-format.txt, the packfile contains the 
number of objects in the packfile, and each object entry has the object 
size. So you can stop reading after you have received the last object in 
the packfile (plus the 20-byte trailer).

I don't know which is the better way, but the former seems like a better 
choice to me.

-- 
Regards,
Pratyush Yadav
