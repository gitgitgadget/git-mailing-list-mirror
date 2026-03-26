Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356433A9EB
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568279; cv=none; b=gvGxUoYAjmzkm3BcGj1btXZ8e5Y/epIzUMT84GchEd1oKokWmUuZT0waQPpBZRe0jsEdTeOi4haDoRKHGFoZ1XFriZGrRV2CjcTIcOHaE0/RG9TznL5b/76/aPGvGrznr25n79FeZgolGOeyBcm1d95IcDjJ9Q82kOmwWfrinlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568279; c=relaxed/simple;
	bh=A7yVDABCk3IShqAhBJgQnVhwBzoCcbk0qYZuZV6Aov0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LxEisd3K5wuiWJiusPEGZvruq0RdaOYdGf9dogyuxco2p2kMBYlZ8v9vHS2wgW84rl1tAi7sSfeafpwxieMirAj6IIHjkpJF32OqmHE+ok23ZE20sZfVZXTykuMiWIUSXZ01P1QfcIL9qs0BqDhCvCiI1rF3uI6HthUkH36bZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fhgDp2hQyz9vD7;
	Fri, 27 Mar 2026 00:37:46 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
From: Wesley Schwengle <wesleys@opperschaap.net>
To: git@vger.kernel.org
Subject: [PATCH 0/3] Add support for per-remote and per-namespace SSH options
Date: Thu, 26 Mar 2026 19:37:35 -0400
Message-ID: <20260326233739.2911354-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4fhgDp2hQyz9vD7

With this changeset applied git is now aware of `sshIdentityFiles' and
`sshOpts'. This allows users to have multiple accounts on the same forges.
A common problem within the developer community. This problem is often
solved by hacking in one's `.ssh/config' and changing hostname URIs to
ensure the correct key is being used.

For years I had zsh wrapper script that was used as the `core.sshCommand' and
is a reference implementation of this change.

In order of importance:

Configuration on the remotes itself. This is easy, straight forward and
should allow people to get it to work quickly:

* `remote.*.sshIdentityFile' and `remote.*.sshOpts'

Configuration set on owner/path style. This is to support `includeIf`
configuration management. For example, a git-forge that host both
employer/client repo's. Eg, `git@gitlab.com/waterkip/git.git' and
`git@gitlab.com/corp/git.git' would have something configured as:

* `core.sshIdentityFile.*', eg

    [core "sshIdentityFile"]
      waterkip = ~/.ssh/id_ed25519_me
      corp     = ~/.ssh/id_ed25519_corporate

And finally, a global override for everything:

* `core.sshIdentityFile' and `core.sshOpts'

I stayed within the `core' namespace, mainly because `core.sshCommand'. I'm
happy to move it to `ssh' or something similar. It would perhaps make
`ssh.*.sshIdentifyFile' more structured, because now that's split between two
core subsections.

The following assumptions have been made to make it safe and sound for
users. When an `sshIdentityFile' is used and no `sshOpts' are configured git
will inject `-F /dev/null' to prevent cycling over all sshIdentityFiles
a user has in their `.ssh/config'. When a user configures `sshOpts', these
take precedence and a user itself is responsible for setting
`-F /dev/null'.

Separate push/pull URIs are not supported by the feature. The biggest problem
with this is that I don't know how to properly configure them with the
namespace constraints. `remote.*.xyz' is as deep as git can go and a push/pull
would require additional configuration. I filed it under edge-case.

There are two new structs introduced: `ssh_options' and `cnx_context'.
They are there to limit the amount of argument passing down the wire. And this
is especially true for `ssh_options' because it keeps `push_ssh_options' dumb.

Wesley Schwengle (3):
  connect: Rename name to command in connect_git()
  connect: Add transport->remote->name to git_connect()
  connect: Add support for per-remote and per-namespace SSH options

 Documentation/config/core.adoc   |  22 ++++
 Documentation/config/remote.adoc |   9 ++
 builtin/fetch-pack.c             |   2 +-
 builtin/send-pack.c              |   2 +-
 connect.c                        | 144 ++++++++++++++++++++--
 connect.h                        |   2 +-
 t/t57xx-ssh-options-config.sh    | 198 +++++++++++++++++++++++++++++++
 transport.c                      |   9 +-
 8 files changed, 375 insertions(+), 13 deletions(-)
 create mode 100755 t/t57xx-ssh-options-config.sh

-- 
2.53.0.722.g8e572876c5

