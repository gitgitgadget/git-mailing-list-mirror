Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D31709
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:10:31 -0800 (PST)
Received: (qmail 9807 invoked by uid 109); 7 Dec 2023 07:10:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:10:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 835 invoked by uid 111); 7 Dec 2023 07:10:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:10:34 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:10:30 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 0/7] fix segfaults with implicit-bool config
Message-ID: <20231207071030.GA1275835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Carlos reported to the security list a case where you can cause Git
to segfault by using an implicit bool like:

  [core]
  someVariable

when the parsing side for core.someVariable does not correctly check a
NULL "value" string. This is mostly harmless, as anybody who can feed
arbitrary config can already execute arbitrary code. There is one case
of this when parsing .gitmodules (which we don't trust), but even there
I don't think the security implications are that interesting. A
malicious repo can get "clone --recurse-submodules" to segfault, but
always with a strict NULL dereference, not any kind of controllable
pointer. See patch 5 for more details.

I audited the whole code base for instances of the problem. It was
fairly manual, so it's possible I missed a spot, but I think this should
cover everything.

The first patch has vanilla cases, and the rest are instances where I
thought it was worth calling out specific details.

  [1/7]: config: handle NULL value when parsing non-bools
  [2/7]: setup: handle NULL value when parsing extensions
  [3/7]: trace2: handle NULL values in tr2_sysenv config callback
  [4/7]: help: handle NULL value for alias.* config
  [5/7]: submodule: handle NULL value when parsing submodule.*.branch
  [6/7]: trailer: handle NULL value when parsing trailer-specific config
  [7/7]: fsck: handle NULL value when parsing message config

 builtin/blame.c        |  2 ++
 builtin/checkout.c     |  2 ++
 builtin/clone.c        |  2 ++
 builtin/log.c          |  5 ++++-
 builtin/pack-objects.c |  6 +++++-
 builtin/receive-pack.c | 11 +++++++----
 compat/mingw.c         |  2 ++
 config.c               |  8 ++++++++
 diff.c                 | 19 ++++++++++++++++---
 fetch-pack.c           | 12 ++++++++----
 fsck.c                 |  8 ++++++--
 help.c                 |  5 ++++-
 mailinfo.c             |  2 ++
 notes-utils.c          |  2 ++
 setup.c                |  2 ++
 submodule-config.c     |  4 +++-
 trace2/tr2_sysenv.c    |  2 ++
 trailer.c              |  8 ++++++++
 18 files changed, 85 insertions(+), 17 deletions(-)
