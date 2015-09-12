From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Bloom filters for have/want negotiation
Date: Sat, 12 Sep 2015 12:21:42 -0700
Message-ID: <CAJo=hJucwWJWBDXay8ZmxVGYyM3GmpN5fnmyq8MMubo+1GRMEA@mail.gmail.com>
References: <55F343F5.6010903@alum.mit.edu> <CAJo=hJstD8c2RPUAj2OznFSCuyJsKFmvymsQMHOPhGdaqPgyvg@mail.gmail.com>
 <xmqqtwqzxy09.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Wilhelm Bierbaum <bierbaum@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaqNY-00005q-8K
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 21:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbILTWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 15:22:16 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33912 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbILTWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 15:22:03 -0400
Received: by vkhf67 with SMTP id f67so41081008vkh.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=B1xqzFmWBSolKAMiIDv7vlT+0eKIOXLeIpwUBh3NfU8=;
        b=bQfCws5FLEy0MCPboKjGum0GzABNK9NduSZ2/oI6iHZO0qqFTYgywtSK8Z27pBY5VC
         VgHEUjK/xMxcy0x+REasq8BpKIpVbQl89LWR2YME3jXdIlg7Op1Kys9rykAHOUFPVnXH
         LY+CjMPs0xmZq2TncCIsiayLWS7jYUKNkKT94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=B1xqzFmWBSolKAMiIDv7vlT+0eKIOXLeIpwUBh3NfU8=;
        b=iP4yw1DDoePaYZ4k7R/UvVsilS/qV96/bJ/oMx0TCBEhfJ6vytmzTUGEqBbQbmuFvz
         gBdsimclg4n6APFjAt1d7t+PmSlf+0xpfrWfXx9V07XzP+fNrpws4sJXY9liDEuoYiDI
         tbJbaGxoLrqOhB+LPR+LsKVM2DO5dagWaWSbPjrW9qFVm4JYzroYPR9GYA8OQGtbcTDf
         iVh7u9VA74Wo4YhOo8MHOLCvbW3atkJrIa3KjiPuoy/J/Iwd4/9QB1UNm9uZOju4CjJD
         NdO0AdKTew9jXlhUZf3xKJRQgQpOhqheNZJDfxBzbWuoFLKprPfrfDZECa2zLwQgAn1I
         Wscw==
X-Gm-Message-State: ALoCoQk9eXsy8UwFoaRccn7/61yYIxjj8YShzHnCMDw3f455t0Lqzn1mM4hA0MIPMQvdhzlmk9fe
X-Received: by 10.31.54.87 with SMTP id d84mr4741427vka.127.1442085721611;
 Sat, 12 Sep 2015 12:22:01 -0700 (PDT)
Received: by 10.103.10.65 with HTTP; Sat, 12 Sep 2015 12:21:42 -0700 (PDT)
In-Reply-To: <xmqqtwqzxy09.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277734>

On Sat, Sep 12, 2015 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> The worst case is due to a bug in the negotiation. With nothing
>> common, the client just goes on forever until it reaches roots
>> (something is wrong with MAX_IN_VAIN). We saw 56,318 have lines ... a
>> 2.6 MiB section. But smart HTTP gzips, so this may be only 1.3 MiB on
>> the wire.
>
> This one is interesting.
>
>> But average/worst doesn't tell the entire picture. Bucketing requests
>> by have lines gives us more:
>>
>>   %req | have_lines
>>   -----|-----------
>>   100%   56,318
>>    99%       88
>>    98%       52
>>    97%       35
>>    96%       31
>>    95%       26
>
> So is this.  From this observation, at least for your audience, it
> is expected that we would usually not need a very long back and
> forth session to discover where the history diverges.
>
> But that is kind of expected.  Because the current protocol, in
> which the upload-pack speaks first and advertises all tips it has,
> allows the fetcher to omit what is known to be common very early and
> to concentrate on sending the "have"s from the branches the fetcher
> has worked on since the last time it fetched.  The amount of "have"s
> needed is expected to be small in an "everybody meets at the same
> central place and pushes into and fetches out of there" workflow,
> because the amount of work done by a single fetcher since the last
> fetch will by definition be a lot smaller than what happened in the
> central meeting place.

Correct... this was based around a very central meeting place.

Linus pulling from lieutenants likely has very different behavior.
During the merge window, Linus' repo probably has hundreds of commits
not in the peer he is currently pulling from. The have line
transmission may take some time to find a common base.

>> Ergo, if this is all working correctly on smart HTTP, clients can
>> fetch from a server they already "know" with decent efficiency, and
>> smaller than your 2 KiB Bloom filter estimate for git.git at 1% error
>> rate.
>
> Isn't this part a bit of oranges and apples comparison?  If I
> understand the motivation of Michael's looking into Bloom filter or
> some other techniques correctly, it is to find a way to address the
> initial advertisement from the sender.  Your analysis is about the
> amount of "have", which is an orthogonal issue.

No, I think you confused parts of the thread.

Michael started this thread with a lead-in about ref advertisement
then punted and went to a discussion about the have negotiation. The
Bloom filter estimates he was writing were for the client to explain
his current state to the server, replacing the "have" negotiation.

>> I do wonder if we are stuffing the pipe deep enough with multi_ack on
>> Internet links. Git doesn't need very long to walk 16 commits,
>> certainly less than the 200 ms RTT a user might have talking to a
>> server on the other side of the US. It is possible both sides are
>> spending most of their time waiting for data transfer of the batches
>> in flight.
>
> Yes, this is a very useful insight.  An experiment or two with
> larger amount of data in flight may be an interesting thing to try.
> Do we still have the deadlock possibility caused by our implicit
> reliance on the fact that a single batch was expected to fit in a
> pipe buffer, by the way, or have we addressed that issue already?

We still deadlock if the pipe buffer is smaller than the batch size.

I was thinking last night this could be reworked in fetch-pack.c to be
a select() based process.

Instead of immediately writing each have line to the socket, queue
them in a strbuf like we do with stateless_rpc. If the strbuf length
is > 0 add the socket to the writeable FD_SET. Run select() with 0
timeout every 5 commit iterations to see if the remote side is
readable or writeable.

If its readable, read the replies from the server and see how that
leaves the client state. If we are done we can break out, discard our
buffered strbuf, and send "done" to begin the pack stream. If not we
keep running the loop.

If its writeable, attempt to send out the current strbuf, trimming off
the prefix of whatever was successfully written.

fetch-pack can put its own cap on the amount of data its willing to
store in that strbuf, Maybe its 100,000 have lines, which is about 5
MiB of data. If the strbuf is exceeding that we stop queuing and just
pump the select() loop.

When sending "done" there may still be "NAK" or "ACK" lines coming
back from the peer due to the deeper buffering. The client would have
to consume those off before it finds the PACK header. We can handle
that by keeping track of how many flush-pkts were written but have not
yet been NAKed by the peer. When breaking out to send "done" we read
until the remaining number of NAK lines were consumed.


The nice part is we can do an improvement strictly in fetch-pack.c.
upload-pack is not affected and wouldn't care. So we may be able to
experiment with clients, and users who want more aggressive
negotiation could upgrade.
