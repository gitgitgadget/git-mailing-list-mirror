Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E372520A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLMIEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 03:04:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726609AbeLMIEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 03:04:24 -0500
Received: (qmail 23673 invoked by uid 109); 13 Dec 2018 08:04:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Dec 2018 08:04:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22441 invoked by uid 111); 13 Dec 2018 08:03:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Dec 2018 03:03:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2018 03:04:22 -0500
Date:   Thu, 13 Dec 2018 03:04:22 -0500
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any
 context
Message-ID: <20181213080422.GA12132@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
 <20181212110206.GA30673@sigill.intra.peff.net>
 <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 05:17:01PM -0800, Masaya Suzuki wrote:

> > This is a change in the spec with an accompanying change in the code,
> > which raises the question: what do other implementations do with this
> > change (both older Git, and implementations like JGit, libgit2, etc)?
> 
> JGit is similar to Git. It parses "ERR " in limited places. When it sees an ERR
> packet in an unexpected place, it'll fail somewhere in the parsing code.
> 
> https://github.com/eclipse/jgit/blob/30c6c7542190c149e2aee792f992a312a5fc5793/org.eclipse.jgit/src/org/eclipse/jgit/transport/PacketLineIn.java#L145-L147
> https://github.com/eclipse/jgit/blob/f40b39345cd9b54473ee871bff401fe3d394ffe3/org.eclipse.jgit/src/org/eclipse/jgit/transport/BasePackConnection.java#L208
> 
> I'm not familiar with libgit2 code, but it seems it handles this at a
> lower level. An error type packet is parsed out at a low level, and
> the error handling is done by the callers of the packet parser.
> 
> https://github.com/libgit2/libgit2/blob/bea65980c7a42e34edfafbdc40b199ba7b2a564e/src/transports/smart_pkt.c#L482-L483
> 
> I cannot find an ERR packet handling in go-git. It seems to me that if
> an ERR packet appears it treats it as a parsing error.
> 
> https://github.com/src-d/go-git/blob/master/plumbing/protocol/packp/common.go#L60-L62

Thanks for digging into these. It does make sense that other
implementations would give a parsing error. Hopefully they also produce
a sensible error message (ideally printing the bogus pktline), but even
if they don't we're probably no worse off than the status quo. With the
current scheme, the server can't give any message, and just has to hang
up anyway.

> > I think the answer for older Git is "hang up unceremoniously", which is
> > probably OK given the semantics of the change. And I'd suspect most
> > other implementations would do the same. I just wonder if anybody tested
> > it with other implementations.
> 
> I'm thinking aloud here. There would be two aspects of the protocol
> compatibility: (1) new clients speak to old servers (2) old clients
> speak to a new server that speaks the updated protocol.
> 
> For (1), I assume that in the Git pack protocol, a packet starting
> from "ERR " does not appear naturally except for a very special case
> that the server doesn't support sideband, but using the updated
> protocol. As you mentioned, at first it looks like this can mistakenly
> parse the pack file of git-receive-pack as an ERR packet, assuming
> that git-receive-pack's pack file is packetized. Actually
> git-receive-pack's pack file is not packetized in the Git pack
> protocol (https://github.com/git/git/blob/master/builtin/receive-pack.c#L1695).
> I recently wrote a Git protocol parser
> (https://github.com/google/gitprotocolio), and I confirmed that this
> is the case at least for the HTTP transport. git-upload-pack's pack
> file is indeed packetized, but packetized with sideband. Except for
> the case where sideband is not used, the packfiles wouldn't be
> considered as an ERR packet accidentally.

Right, that matches my understanding.

> For (2), if the old clients see an unexpected ERR packet, they cannot
> parse it. They would handle this unparsable data as if the server is
> not speaking Git protocol correctly. Even if the old clients just
> ignore the packet, due to the nature of the ERR packet, the server
> won't send further data. The client won't be able to proceed. Overall,
> the clients anyway face an error, and the only difference would be
> whether the clients can show an error nicely or not. The new clients
> will show the errors nicely to users. Old clients will not.

Yeah, this was the case I was more concerned about, and I think it is
probably OK (by this rationale, and what I wrote above).

> > So I think it's probably not a good idea to unconditionally have callers
> > of packet_read_with_status() handle this. We'd need a flag like
> > PACKET_READ_RESPECT_ERR, and to trigger it from the appropriate callers.
> 
> This is outside of the Git pack protocol so having a separate parsing
> mode makes sense to me.

Yeah. Here's a sample script which works with current Git (the index
contains the uppercased content "ERR FOO"), but fails after this patch
(Git thinks the filter reported an error and dies; it's not great that
we die in the packet-reading code at all for this case, but your patch
is hardly the first call to die() in that function).

-- >8 --
git init -q repo
cd repo

echo '*.magic filter=magic' >.git/info/attributes
git config filter.magic.process $PWD/filter

# toy filter to uppercase content
cat >filter <<-\EOF
#!/usr/bin/perl
sub read_pkt {
  my @r;
  while (1) {
    read(STDIN, my $len, 4);
    last if $len eq "0000";
    read(STDIN, my $buf, hex($len)-4);
    push @r, $buf;
  }
  return @r;
}
sub write_pkt {
  local $| = 1;
  while (@_) {
    my $buf = shift;
    printf "%04x", length($buf) + 4;
    print $buf;
  }
  print "0000";
}

read_pkt(); # handshake
write_pkt(qw(git-filter-server version=2));
read_pkt(); # capabilities
write_pkt(qw(capability=clean));

read_pkt(); # clean command
@content = read_pkt();

write_pkt(qw(status=success));
write_pkt(map { uc } @content);
write_pkt(); # final status
EOF
chmod +x filter

echo 'err foo' >foo.magic
git add foo.magic
git cat-file blob :foo.magic
