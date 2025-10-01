Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E555231832
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280304; cv=none; b=pfg7n9hJyGiub/tKDJUBHkMO2zvQtnUFF4qqt4SjkPtA19s2cnbhKRNv5tNotw07GYpowpTxoPALV2WT9fja8sJrM4lqR5SIyGGepn2+jLUfctFU2DPesXJJRYd/knlmlJQnu9bbqFx8jG/qYl/vebN4KzxhQRr7hwPcaBTYaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280304; c=relaxed/simple;
	bh=hgOy2Igt/QmC8SCKNJ9zJy9+vlCPzB1NHn5+Q/wVkt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYYVssONDI/DGvBIfnYvqgXZ9jE6klT1Cly871GrVU6WJaDengEbVsASVRP1k30Lu5ZkG3F2J43EWSZukSR9QIdBf1doZaYIRJivxj9pySOYIEGTcniZokdzKA3jpLFPPxsPGUhFEbnLD+dcD14V1YldovhVYNHRP+jo13p7V+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=H2x3fMGX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H2x3fMGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759280300;
	bh=hgOy2Igt/QmC8SCKNJ9zJy9+vlCPzB1NHn5+Q/wVkt0=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=H2x3fMGX0uwG0Hc4NQdx/+5qKDIY1EMk5r2uI3EFm9V/5cO2C/ypy86wMydOugDpv
	 W1+z4ZhtLplRwUwvEerF+IV+YS7HlIKkaCkatlxMhzyPp6WzZzHJFDroSGuEvbFJlN
	 iEk17RU2UidqTvMporRrL9B+w0boGZkX9UBN3J4WzYv+uwYBXhnjHfzpzSUE01FDh/
	 xjxshq1HxIv03+TRWXuMDPpFrapK5eTr4JMVOHdD0EaPsaJqQdlPRr+rX/hoGW5AI9
	 UudnF4fi+ePfvBxoeYLin/Y3h3oWCbErTt2yCkqdOWN/ODDuauBXe/9oguGRMczj9o
	 8epv+QLwkA78x5jXR7YS+aAHTaXjycmcsowYyJD18BLEaaOKImYK1m1jKPFNN+PCxy
	 W1Gw2McBd0v4j1zOUp07MIvSYwEjeAlQtEPiOo63k4co6xSq2mD7iNqYVcFgfWnYdk
	 ZtFtoJ9TH0IjAJS7iInBmOXtR/rQfSIeZxdPRhwxjX/OE6UUUmL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c0c:de88:5b0d:9364])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CF1E520113;
	Wed,  1 Oct 2025 00:58:20 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
Subject: [RFC PATCH 0/1] Extended tree format for mixed submodules and conflicts
Date: Wed,  1 Oct 2025 00:58:13 +0000
Message-ID: <20251001005814.846992-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today at the Contributor Summit we discussed two different proposals
that might benefit from some extensions to trees: submodules of a
different hash algorithm and first-class conflicts.

Peff suggested that we could do something hideous to the tree format to
allow for extensions to submodules of different algorithms.  In the
interests of prototyping things to see how much people like or hate the
idea, I've written up an example spec and included a script below so we
can see how current Git implementations handle this.  (This was part of
my lunchtime activity.)

Git itself handles this data as a submodule, which seems to be the least
bad option for a new mode type.  `git fsck` complains about the mode, as
expected.

I don't intend to actually implement this proposal or do anything
serious with it, but I offer it as a discussion piece about what we
could do if we wanted in a minimally incompatible way.  If you really
hate it, that's okay; I agree it's a little gross.

----
#!/bin/sh -e

# This script requires a printf that supports hex escapes because I'm too lazy
# to convert things into octal.

rm -fr test-repo
git init --object-format=sha1 -b dev test-repo
cd test-repo
tree_oid=$(/usr/bin/printf '130000 \x91\x82\x80s256\x01\xdf\xac\xbf\xee\xdf\xac\xbf\xee\xdf\xac\xbf\xeesubmodule\x00\xde\xad\xbe\xef\xde\xad\xbe\xef\xde\xad\xbe\xef\xde\xad\xbe\xef\xde\xad\xbe\xef' | git hash-object -t tree -w --literally --stdin)
commit_oid=$(git commit-tree -m + "$tree_oid")
git reset --hard "$commit_oid"
git show HEAD
----

brian m. carlson (1):
  Define an extended tree format

 Documentation/Makefile                     |  1 +
 Documentation/gitformat-extended-tree.adoc | 77 ++++++++++++++++++++++
 Documentation/meson.build                  |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/gitformat-extended-tree.adoc

