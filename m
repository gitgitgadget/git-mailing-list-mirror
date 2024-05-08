Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75485F861
	for <git@vger.kernel.org>; Wed,  8 May 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172311; cv=none; b=g6PCgfTQ8QJpcJOZHSdocdzycSRwIOCfOr+hPsFpyluUlo1/eEltZcPIxtexS02bCjwV69Y/q672FGPRSIAL/AB9yTnNEC/DTwYrV2+MMNx4xCAtQewQBdDGVhj9olVLznUtOhwrvSI2NGof9UZHvF2NpDYt9y16lggyJRd3I+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172311; c=relaxed/simple;
	bh=IYTnD0G9jQWqnFqDvsQ4PiJUdJAD+aieaSbJWpOM23c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1XzYh3L4qJdAhPfr+eFGIK6x2+NVwQSAeKhobvd3prbYg3MKOmeA3KtHMgrvPOQc33k2r/HVUttFdnPMYU16YQVuH8rtMVSzgwb79Blfr6F7U7pzfW6S5hRE1e2fZiYUTdmM9KdmgN6XJDYVyCPxl1qscpKd0PVJfxoVudlDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=XHDB4LL0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="XHDB4LL0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1715172305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eg/vmbO1yj0HUUJEai0tPtfCzbxwidHWDwKHejoBkyM=;
	b=XHDB4LL0188/sf7Nzy+cTsfRWpDDSUSvfBtJl6bOWAfScPgNK8RdZxdth1Re3NX4EBxxLo
	Z5lvIdFAIzNuUVXgAWWA6JX5+DNmwvsv8BJYwAbjJ5F6LIzUKwEd3vqrZngNXgA38xANzi
	h9+wUypuGAm6RfJlBrpGSSGOuLnOaIE=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/4] bundle-uri: show progress when downloading from bundle URIs
Date: Wed,  8 May 2024 14:44:49 +0200
Message-ID: <20240508124453.600871-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a user clones a repository, they see what's happening in the
messages like "Enumerating objects" and "Receiving objects". But when
a user clones a repository that uses bundle URIs they see:

    Cloning into 'repo.git'

And then they have to wait until all bundles are downloaded before they
see any other message. When the bundles are large, this can take a lot
of time and the user might consider the process hangs and they kill it.

This patch series introduces progress displayed to the user while
bundles are downloaded. The full output of a clone using bundle URIs
will look something like:

    Cloning into 'repo.git'...
    Downloading via HTTP:  21% (351812809/1620086598), 315.34 MiB | 49.84 MiB/s
    Downloading via HTTP:  77% (1247493865/1620086598), 1.15 GiB | 34.31 MiB/s
    Downloading via HTTP: 100% (1620086598/1620086598), 1.50 GiB | 37.97 MiB/s, done.
    remote: Enumerating objects: 1322255, done.
    remote: Counting objects: 100% (611708/611708), done.
    remote: Total 1322255 (delta 611708), reused 611708 (delta 611708), pack-reused 710547
    Receiving objects: 100% (1322255/1322255), 539.66 MiB | 31.57 MiB/s, done.
    etc...

Toon Claes (4):
  progress: add function to set total
  http: add the ability to log progress
  remote-curl: optionally show progress for HTTP get
  bundle-uri: enable git-remote-https progress

 bundle-uri.c                |  4 +++-
 http.c                      | 32 ++++++++++++++++++++++++++++++++
 http.h                      |  5 +++++
 progress.c                  |  6 ++++++
 progress.h                  |  1 +
 remote-curl.c               |  8 +++++++-
 t/helper/test-progress.c    |  5 +++++
 t/t0500-progress-display.sh | 24 ++++++++++++++++++++++++
 t/t5557-http-get.sh         | 15 +++++++++++++++
 9 files changed, 98 insertions(+), 2 deletions(-)

--
2.44.0
