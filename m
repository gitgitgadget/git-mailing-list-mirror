Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941211F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdAYWDU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:20 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36856 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdAYWDT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:19 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so61031174pfu.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jNnlGCQmzf8nY+QotmM5oJ3clfxz+gbqREbWzvRfFKs=;
        b=ZMaHPsOL6jTwz8qol17UZFKxMw0Fp/Z3xTDpVyN2K7bKs8+5hLq8kl7hGXnF2KGsC8
         xliYwAmCESkoJ0BBsfQncVdSJUbshMf3gEEgV2Rl7j+dRZSHaVrHIdlTprXK77jEEJJs
         XmlardQ05ouDsjGizMvcZ8brNYlQJ0q8jEfOVlVtER9DkBZw3Zqg/B9jZZqY4vIAzp1w
         teyOwnHNMvj4yh5jCVQ5FTSaB2tFH+x5oWzRWSY8Xb1fF4NpAR8+0zXTXr9YjdZYKOrK
         0Cz8fWzZpN3eU9PIpRL9FKNqNDhLC03sP5xXBZ4JRh5EmrwTBDGA63lpSzw/tJpb8D/4
         w6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jNnlGCQmzf8nY+QotmM5oJ3clfxz+gbqREbWzvRfFKs=;
        b=YWebbEzOq+lV0E2PKc8+hDhFDqKP8D4NCU2s+o5uXHUvsxfkC2ySTvUEkG/uxffXz3
         jdYYlFpbASMO8sVNNo7mHUMCvMS9bqtgIdpzu+7fjR7NM/4snM9mo4NxXYB8sBeYhTwK
         OjMVVwNtRO4DSi9aHntyECijQb8n8V1FPl9fpQM6egzqILEWiOrZpIuumfjbYTEpZn4Z
         dw175U5C5yu07yjts8eDssb9FHMSKGZ4qK3+AVEBGoqpwx6RHm7XGqkoBtHUulcXjrXj
         eO4Ry9gvxvPviOFuhZdRefW0WfcyxbMuxW+4B/dd3aoYoNJAUkfKnpVmyk53hf7fAlGI
         WK9A==
X-Gm-Message-State: AIkVDXJu8x0eYgGJY6oummxhI84NOh18nXrVDb5FRUjrpdmYwo5Kftz7Yvc/fnmtvo6v3bwo
X-Received: by 10.99.111.138 with SMTP id k132mr1708567pgc.138.1485381798237;
        Wed, 25 Jan 2017 14:03:18 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:17 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
Date:   Wed, 25 Jan 2017 14:02:53 -0800
Message-Id: <cover.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone - this is a proposal for a protocol change to allow the
fetch-pack/upload-pack to converse in terms of ref names (globs
allowed), and also an implementation of the server (upload-pack) and
fetch-from-HTTP client (fetch-pack invoked through fetch).

Negotiation currently happens by upload-pack initially sending a list of
refs with names and SHA-1 hashes, and then several request/response
pairs in which the request from fetch-pack consists of SHA-1 hashes
(selected from the initial list). Allowing the request to consist of
names instead of SHA-1 hashes increases tolerance to refs changing
(due to time, and due to having load-balanced servers without strong
consistency), and is a step towards eliminating the need for the server
to send the list of refs first (possibly improving performance).

The protocol is extended by allowing fetch-pack to send
"want-ref <name>", where <name> is a full name (refs/...) [1], possibly
including glob characters. Upload-pack will inform the client of the
refs actually matched by sending "wanted-ref <SHA-1> <name>" before
sending the last ACK or NAK.

This patch set is laid out in this way:
 1-2:
  Upload-pack, protocol documentation, tests that test upload-pack
  independently. A configuration option is added to control if the
  "ref-in-want" capability is advertised. (It is always supported even
  if not advertised - this is so that this feature in multiple
  load-balanced servers can be switched on or off without needing any
  atomic switching.)
 3:
  Mechanism to test a repo that changes over the negotiation (currently,
  only with the existing mechanism).
 4-9:
  The current transport mechanism takes in an array of refs which is
  used as both input and output. Since we are planning to extend the
  transport mechanism to also allow the specification of ref names
  (which may include globs, and thus do not have a 1-1 correspondence to
  refs), refactor to make this parameter to be solely an input
  parameter.
 10-11:
  Changes to fetch-pack (which is used by remote-curl) to support
  "want-ref".
 12-13:
  Changes to the rest (fetch -> transport -> transport-helper ->
  remote-curl) to support "want-ref" when fetching from HTTP. The
  transport fetch function signature has been widened to allow passing
  in ref names - transports may use those ref names instead of or in
  addition to refs if they support it. (I chose to preserve refs in the
  function signature because many parts of Git, including remote
  helpers, only understand the old functionality anyway, and because
  precalculating the refs allows some optimizations.)
 14:
  This is not meant for submission - this is just to show that the tests
  pass if ref-in-want was advertised by default (except for some newly
  added tests that explicitly check for the old behavior).

[1] There has been some discussion about whether the server should
accept partial ref names, e.g. [2]. In this patch set, I have made the
server only accept full names, and it is the responsibility of the
client to send the multiple patterns which it wants to match. Quoting
from the commit message of the second patch:

  For example, a client could reasonably expand an abbreviated
  name "foo" to "want-ref foo", "want-ref refs/heads/foo", "want-ref
  refs/tags/foo", among others, and ensure that at least one such ref has
  been fetched.

[2] <20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net>

Jonathan Tan (14):
  upload-pack: move parsing of "want" line
  upload-pack: allow ref name and glob requests
  upload-pack: test negotiation with changing repo
  fetch: refactor the population of hashes
  fetch: refactor fetch_refs into two functions
  fetch: refactor to make function args narrower
  fetch-pack: put shallow info in out param
  fetch-pack: check returned refs for matches
  transport: put ref oid in out param
  fetch-pack: support partial names and globs
  fetch-pack: support want-ref
  fetch-pack: do not printf after closing stdout
  fetch: send want-ref and receive fetched refs
  DONT USE advertise_ref_in_want=1

 Documentation/technical/http-protocol.txt         |  20 +-
 Documentation/technical/pack-protocol.txt         |  24 +-
 Documentation/technical/protocol-capabilities.txt |   6 +
 builtin/clone.c                                   |  16 +-
 builtin/fetch-pack.c                              |  64 ++--
 builtin/fetch.c                                   | 178 +++++++---
 fetch-pack.c                                      | 226 +++++++++----
 fetch-pack.h                                      |   6 +-
 remote-curl.c                                     |  91 +++--
 remote.c                                          |  67 +++-
 remote.h                                          |  20 +-
 t/lib-httpd.sh                                    |   1 +
 t/lib-httpd/apache.conf                           |   8 +
 t/lib-httpd/one-time-sed.sh                       |   8 +
 t/t5500-fetch-pack.sh                             |  82 +++++
 t/t5536-fetch-conflicts.sh                        |   2 +
 t/t5552-upload-pack-ref-in-want.sh                | 386 ++++++++++++++++++++++
 transport-helper.c                                | 105 ++++--
 transport.c                                       |  40 ++-
 transport.h                                       |  23 +-
 upload-pack.c                                     | 117 +++++--
 21 files changed, 1232 insertions(+), 258 deletions(-)
 create mode 100644 t/lib-httpd/one-time-sed.sh
 create mode 100755 t/t5552-upload-pack-ref-in-want.sh

-- 
2.11.0.483.g087da7b7c-goog

