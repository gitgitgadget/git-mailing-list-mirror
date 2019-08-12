Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C321F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 00:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHLAWt (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 20:22:49 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44349 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLAWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 20:22:49 -0400
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BE109200007;
        Mon, 12 Aug 2019 00:22:46 +0000 (UTC)
Date:   Mon, 12 Aug 2019 05:52:44 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Farhan Khan <farhan@farhan.codes>
Cc:     Git <git@vger.kernel.org>
Subject: Re: How to determine when to stop receiving pack content
Message-ID: <20190812002244.lvsokkxcpfshjiyq@localhost.localdomain>
References: <20190811150450.5pvgvwcqrrvzggbo@localhost.localdomain>
 <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes>
 <53515e0fb56928114a63bfe87e24c743@farhan.codes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53515e0fb56928114a63bfe87e24c743@farhan.codes>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/19 11:31PM, Farhan Khan wrote:
> August 11, 2019 11:04 AM, "Pratyush Yadav" <me@yadavpratyush.com> wrote:
> 
> > On 10/08/19 11:47PM, Farhan Khan wrote:
> > 
> >> Hi,
> >> 
> >> I am trying to write an implementation of git clone over ssh and am a little confused how to
> >> determine a server response has ended. Specifically, after a client sends its requested 'want', the
> >> server sends the pack content over. However, how does the client know to stop reading data? If I
> >> run a simple read() of the file descriptor:
> >> 
> >> A. If I use reading blocking, the client will wait until new data is available, potentially
> >> forever.
> >> B. If I use non-blocking, the client might terminate reading for new data, when in reality new data
> >> is in transit.
> >> 
> >> I do not see a mechanism to specify the size or to indicate the end of the pack content. Am I
> >> missing something?
> > 
> > Well, I am not very familiar with git-clone internals, but I did some
> > digging around, and I think I know what answer to your problem is.
> > 
> > Looking at Documentation/technical/protocol-v2.txt:34, the flush packet
> > indicates the end of a message. Looking in the output section of the
> > fetch command (protocol-v2.txt:342), it sends you some optional
> > sections, and then the packfile and then sends a flush packet.
> > 
> > So your read should stop reading data when it sees the flush packet.
> > 
> > Another way would be to look at the packfile contents. Looking at
> > Documentation/technical/pack-format.txt, the packfile contains the
> > number of objects in the packfile, and each object entry has the object
> > size. So you can stop reading after you have received the last object in
> > the packfile (plus the 20-byte trailer).
> > 
> > I don't know which is the better way, but the former seems like a better
> > choice to me.
> > 
> > --
> > Regards,
> > Pratyush Yadav
> 
> Hi Pratyush,
> 
> Thanks for your reply!
> 
> Unless I am mistaken, a pack file does not end in a flush_pkt. I ran some tests and did not see the stream end in "0000". Is there is a mistake somewhere on my end?
 
Hm, turns out I was on the pu branch, not master when I looked at 
protocol-v2.txt. The file was updated about 3 days ago (not in master 
yet) (7ee4ab7e8c3310fc28d9dd7d47da26e497e73556), where it seems to imply 
that flush-pkt will be sent after the packfile (see excerpt below).

--- protocol-v2.txt ---
    output = acknowledgements flush-pkt |
	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
	     packfile flush-pkt
---

So either something changed in the protocol with that merge, or there is 
a discrepancy in the documentation, because the above output format 
seems to imply the packfile will be followed by a flush packet. I 
haven't looked at the full contents of the merge, but none of the commit 
messages mention changing this behaviour.

Either way, you can probably parse the packfile to know how many objects 
you will get, and stop after the last object. Or like Junio said, just 
wait for an EOF.

Sorry for the wrong information.

-- 
Regards,
Pratyush Yadav
