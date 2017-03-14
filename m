Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1DF20951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdCNW6B (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:58:01 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35697 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdCNW6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:58:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id j5so280964pfb.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=COK86s2PnSIfof+MfDsBHJ5c7OJymdvC8ByalB9vzXQ=;
        b=mpbiqgys3Nkx+agnVIdQe4WysvYQz/SbGoSUve318lUsw2Z/r97GXJvZTEhRLeSFv/
         A6yPbzehVyg70bl6qbwY5mlGCZ5ouObdcLFrUKWEmawnihkXNP///t1lREwy7qHJfKx1
         B3v3UfqtXfE4tSFPlPFqHkZ1soA2/nZ7m2ZFhTRAUmVhLLtg5QbDPI7MZ6eVxHGuZsAm
         OEXcxSpDQQYbnRKNZxTIUTJOqUo6g8iGAAWXb7yiP6NTNdySGXELj7Li6yV2iL8x0Kfg
         T/bPKpDwMeVtkyfy2UGeDKVIfcsj7fwNCIwR8KYmqU2ZOt61RaAQCd1XsGlHpKcPQBAb
         smyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=COK86s2PnSIfof+MfDsBHJ5c7OJymdvC8ByalB9vzXQ=;
        b=bmhP4ttN8rge/sm9U9qfDys3STbmZnfI6d661NtwRtiyR+gteBaEJ8Waw6ItcE4Umh
         bKn+5tOzwoYlOfNJXq2Etj7/YeJ7ordpzuuEquI5MJhOpFYUKRXT1bx6d0bvuK4hCEvP
         oGcg4MYgXlO08za+ubnwBJdrCKfTFAd7ZTBXq5PTUMMt0v/2wketU45Bz5iaEAbyuo/1
         ssVlsMRmk/OSIrcLiouKWlG0O1snWsJrAVutQHsZGaCKMfyDedfb7f0fRS8BMZIx15Kj
         2tOW+oy7fZwBlZCe+3gbELWobofcrSrVLQ+fYWS9mL9myEil53nd66aO29FVZscZ5wnT
         6/pg==
X-Gm-Message-State: AFeK/H2n0z0Ud4bIJJRVnzxuIfDT6xHlMDKV1AQa22JMJZb5R6l/aCFByYKAfzSylAIQuCFU
X-Received: by 10.99.127.83 with SMTP id p19mr106472pgn.125.1489532278988;
        Tue, 14 Mar 2017 15:57:58 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:4ccf:4726:3691:3d8a])
        by smtp.gmail.com with ESMTPSA id n15sm66981pfj.18.2017.03.14.15.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 15:57:58 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Jonathan Tan <jonathantanmy@google.com>
Subject: Proposal for "fetch-any-blob Git protocol" and server design
Cc:     markbt@efaref.net, git@jeffhostetler.com
Message-ID: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
Date:   Tue, 14 Mar 2017 15:57:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described in "Background" below, there have been at least 2 patch 
sets to support "partial clones" and on-demand blob fetches, where the 
server part that supports on-demand blob fetches was treated at least in 
outline. Here is a proposal treating that server part in detail.

== Background

The desire for Git to support (i) missing blobs and (ii) fetching them 
as needed from a remote repository has surfaced on the mailing list a 
few times, most recently in the form of RFC patch sets [1] [2].

A local repository that supports (i) will be created by a "partial 
clone", that is, a clone with some special parameters (exact parameters 
are still being discussed) that does not download all blobs normally 
downloaded. Such a repository should support (ii), which is what this 
proposal describes.

== Design

A new endpoint "server" is created. The client will send a message in 
the following format:

----
fbp-request = PKT-LINE("fetch-blob-pack")
               1*want
               flush-pkt
want = PKT-LINE("want" SP obj-id)
----

The client may send one or more SHA-1s for which it wants blobs, then a 
flush-pkt.

The server will then reply:

----
server-reply = flush-pkt | PKT-LINE("ERR" SP message)
----

If there was no error, the server will then send them in a packfile, 
formatted like described in "Packfile Data" in pack-protocol.txt with 
"side-band-64k" enabled.

Any server that supports "partial clone" will also support this, and the 
client will automatically assume this. (How a client discovers "partial 
clone" is not covered by this proposal.)

The server will perform reachability checks on requested blobs through 
the equivalent of "git rev-list --use-bitmap-index" (like "git 
upload-pack" when using the allowreachablesha1inwant option), unless 
configured to suppress reachability checks through a config option. The 
server administrator is highly recommended to regularly regenerate the 
bitmap (or suppress reachability checks).

=== Endpoint support for forward compatibility

This "server" endpoint requires that the first line be understood, but 
will ignore any other lines starting with words that it does not 
understand. This allows new "commands" to be added (distinguished by 
their first lines) and existing commands to be "upgraded" with backwards 
compatibility.

=== Related improvements possible with new endpoint

Previous protocol upgrade suggestions have had to face the difficulty of 
allowing updated clients to discover the server support while not 
slowing down (for example, through extra network round-trips) any 
client, whether non-updated or updated. The introduction of "partial 
clone" allows clients to rely on the guarantee that any server that 
supports "partial clone" supports "fetch-blob-pack", and we can extend 
the guarantee to other protocol upgrades that such repos would want.

One such upgrade is "ref-in-want" [3]. The full details can be obtained 
from that email thread, but to summarize, the patch set eliminates the 
need for the initial ref advertisement and allows communication in ref 
name globs, making it much easier for multiple load-balanced servers to 
serve large repos to clients - this is something that would greatly 
benefit the Android project, for example, and possibly many others.

Bundling support for "ref-in-want" with "fetch-blob-pack" simplifies 
matters for the client in that a client needs to only handle one 
"version" of server (a server that supports both). If "ref-in-want" were 
added later, instead of now, clients would need to be able to handle two 
"versions" (one with only "fetch-blob-pack" and one with both 
"fetch-blob-pack" and "ref-in-want").

As for its implementation, that email thread already contains a patch 
set that makes it work with the existing "upload-pack" endpoint; I can 
update that patch set to use the proposed "server" endpoint (with a 
"fetch-commit-pack" message) if need be.

== Client behavior

This proposal is concerned with server behavior only, but it is useful 
to envision how the client would use this to ensure that the server 
behavior is useful.

=== Indication to use the proposed endpoint

The client will probably already record that at least one of its remotes 
(the one that it successfully performed a "partial clone" from) supports 
this new endpoint (if not, it can’t determine whether a missing blob was 
caused by repo corruption or by the "partial clone"). This knowledge can 
be used both to know that the server supports "fetch-blob-pack" and 
"fetch-commit-pack" (for the latter, the client can fall back to 
"fetch-pack"/"upload-pack" when fetching from other servers).

=== Multiple remotes

Fetches of missing blobs should (at least by default?) go to the remote 
that sent the tree that points to them. This means that if there are 
multiple remotes, the client needs to remember which remote it learned 
about a given missing blob from.

== Alternatives considered

The "fetch-blob-pack" and "fetch-commit-pack" messages could be split 
into their own endpoints. It seemed more reasonable to combine them 
together since they serve similar use cases (large repos), and (for 
example) reduces the number of binaries in PATH, but I do not feel 
strongly about this.

The client could supply commit information about the blobs it wants (or 
other information that could help the reachability analysis). However, 
these lines wouldn’t be used by the proposed server design. And if we do 
discover that these lines are useful, the protocol could be extended 
with new lines that contain this information (since old servers will 
ignore all lines that they do not understand).

We could extend "upload-pack" to allow blobs in "want" lines instead of 
having a new endpoint. Due to a quirk in the Git implementation (but 
possibly not other implementations like JGit), this is already supported 
[4]. However, each invocation would require the server to generate an 
unnecessary ref list, and would require both the server and the client 
to undergo more network traffic.

Also, the new "server" endpoint might be made to be discovered through 
another mechanism (for example, a capability advertisement on another 
endpoint). It is probably simpler to tie it to the "partial clone" 
feature, though, since they are so likely to be used together.

[1] <20170304191901.9622-1-markbt@efaref.net>
[2] <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
[3] <cover.1485381677.git.jonathantanmy@google.com>
[4] <20170309003547.6930-1-jonathantanmy@google.com>
