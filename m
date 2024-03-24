Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA210F7
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711243212; cv=none; b=TutrO2PDvEHQnUgZBodRpFy2v8lR3NX7lz8aa2Xij68/jNI0mK2kwSAC1eIgWmaCz+UakYfy3lVb2rhAJMYqYw1aX1n1WbIan7ZsP77r0to6RZx12cXkBoVFg1Ve/6XoscXdAe1wGch+kD3phuxJ/pL7exDBwIRpDQtC/dYiC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711243212; c=relaxed/simple;
	bh=xnSW/yySgf9Z131zLOiqkdVcjqMykkAvoe8uQMhnDZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQfpmBrLiI1iQkd5nHulWUSzhd099kNP5V0PTswP7FoBrOa7NGg34501Sb9wjIAWrcV58q75P923s42LJr6w3oBUwbX+M78F3FTVhPZUfqaH1iDSIe45xJPLGgSTNv1eqzAQ0tateG8+mW7CvaiIxsVNhdXWXZzuf9/VPaxQdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Unsb8Htv; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Unsb8Htv"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A83745B41A;
	Sun, 24 Mar 2024 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242785;
	bh=xnSW/yySgf9Z131zLOiqkdVcjqMykkAvoe8uQMhnDZM=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Unsb8HtvpQWEJjgFP0YcVdgNOSurGmkKTZi6d7Lh7mwXLK1BbfXocq2P4ZyQiEXW4
	 1ltGuF+yUG71Yma2cVwSI4oCAJY2jqEXdHwOwRsBsmj3lR85zpGKX690WzklDidRAs
	 F3qlLlVAzy71fQN2gJp6F5gLE8BvQEwb378+3PyMEzO8dW23emdFmkCe/CyFTO9jx4
	 XDeZhawoyMa+9FiAZDAfAPuNCBTl8Bk9UXqFzfArysEJ+ktA1wm/g6IikzzUyPMWyh
	 3nhu4GfLD37d5N1OeeD50T5NYafJ/m/8uV0eNHjUfi2eVd3GuUW5KCw7itosSB+e+/
	 EzRk7zWGeiGNXPsPXebDYVFrTwolHBwq8NFT/OSaRpSdYc1nntgAkCetIseJk2fzcg
	 VYLH6csYsJU2a6xE5z3oNsAbprqXjPLhXZMYo2a7XFKcgJJlXROWtUGjCFBccF60X5
	 AexUztNBogBtGfgX/qUfSSR5nAd5AZxprshSEE45jlCKuj3X7/R
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 00/13] Support for arbitrary schemes in credentials
Date: Sun, 24 Mar 2024 01:12:48 +0000
Message-ID: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, HTTP authentication in Git is mostly limited to approaches
that require a username and password or are Kerberos (GSSAPI).  In
addition, we effectively require that libcurl (or, for other software,
such as Git LFS, using the credential helper, that HTTP library) knows
how to implement the authentication scheme.

However, this poses two sets of problems.  First, some sites, such as
Azure DevOps, want to use Bearer authentication, which we don't support.
This is implemented using `http.extraHeader`, which is not a secure way
to store credentials, since our credential helper protocol does not
support this functionality.

In addition, other tools using the credential helper protocol do not
support the variety of authentication mechanisms that Git does.
Specifically, making NTLM function in a useful way on Windows is
nontrivial and requires extensive integration and testing with C code,
and because of this difficulty and the fact that NTLM uses cryptography
known to be insecure since 1995, there is often little interest in
implementing this support outside of libcurl. However, it would be
helpful if people who want to use it can still use it.

This series introduces new functionality to the credential helper
protocol that allows helpers to produce credentials for arbitrary HTTP
authentication schemes using the `authtype` and `credential`[0] fields.
This allows a suitable credential helper to send Bearer credentials or
any other standard or custom authentication scheme.  (It may be able to
be extended to other functionality in the future, such as
git-send-email, to implement custom SASL functionality, and due care has
been taken to make the protocol adequately flexible for that purpose.)

In addition, the protocol is also expanded to include per-helper state
and multi-legged authentication (the former is effectively required for
the latter).  The per-helper state can be useful to help credential
helpers identify where the credential is stored, or any other
information necessary.  Because NTLM and Negotiate (Kerberos/wrapped
NTLM) require two rounds of authentication, the multi-legged
authentication support along with per-helper state allows the helper to
support these authentication methods without Git or other clients having
to be aware of how they work.  (This would also be useful for SASL, as
mentioned above.)

This series introduces a capability mechanism to announce this
functionality, which allows a helper to provide a username and password
on older versions of Git while supporting more advanced functionality on
newer versions.  (This is especially important on Azure DevOps, where
NTLM uses a username and password but Basic or Bearer can use a personal
access token.)  It is also designed such that extremely simple
credential helpers, such as the shell one-liner in the Git FAQ that
reads from the environment, don't accidentally claim to support
functionality they don't offer.

In addition, there is documentation for the expanded protocol, although
none of the built-in helpers have been updated (that will be a future
series for those for which it's possible).

My personal interest here is getting credentials out of config files
with `http.extraHeader` (which a future series will produce a warning
for) and also allowing Git LFS to support Digest and NTLM with a
suitable credential helper.  Git LFS used to support NTLM using custom
code (because the Go standard library does not), but it was found to be
broken in lots of ways on Windows, and nobody with a Windows system
wanted to fix it or support it, so we removed it.  However, there are
still some people who do want to use it, so allowing them to use a
custom credential helper they maintain themselves seems like the best
way forward.  Despite the advantages of this series for Azure DevOps, I
have no personal or professional stake in their product; my only
interest is the general one in whether their users can securely store
credentials.  I believe the changes here are of general advantage to the
Git userbase in a variety of ways such that the goal of this series
should be uncontroversial.

Feedback on any portion of this series is of course welcome.

[0] A name different from `password` was explicitly chosen to avoid
confusion from less capable protocol helpers so that they don't
accidentally send invalid data.  This does have the downside that
credential helpers must learn a new field to not log, but that should be
generally easy to fix in most cases.

brian m. carlson (13):
  credential: add an authtype field
  remote-curl: reset headers on new request
  http: use new headers for each object request
  credential: add a field for pre-encoded credentials
  credential: gate new fields on capability
  docs: indicate new credential protocol fields
  http: add support for authtype and credential
  credential: add an argument to keep state
  credential: enable state capability
  docs: set a limit on credential line length
  t5563: refactor for multi-stage authentication
  strvec: implement swapping two strvecs
  credential: add support for multistage credential rounds

 Documentation/git-credential.txt   |  59 +++++-
 builtin/credential-cache--daemon.c |   2 +-
 builtin/credential-store.c         |   2 +-
 builtin/credential.c               |   7 +-
 credential.c                       | 114 ++++++++++-
 credential.h                       |  69 ++++++-
 http.c                             | 128 +++++++-----
 http.h                             |   5 +
 imap-send.c                        |   2 +-
 remote-curl.c                      |  14 +-
 strvec.c                           |   7 +
 strvec.h                           |   5 +
 t/lib-httpd/nph-custom-auth.sh     |  17 +-
 t/t0300-credentials.sh             | 136 ++++++++++++-
 t/t5563-simple-http-auth.sh        | 308 +++++++++++++++++++++++++----
 15 files changed, 760 insertions(+), 115 deletions(-)

