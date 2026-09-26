Received: from smtp122.ord1d.emailsrvr.com (smtp122.ord1d.emailsrvr.com [184.106.54.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5D2DCBE3
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790446613; cv=none; b=QoNCoIOufB5eRIDZBorlg+shZ0xr/Qdna1wIsIr7dwIyhLoXQXDeg6WstcqVwchJYb1f/l6qMBpK4Q4q06qNJ1zxHt0nAz0UMEFc9QwEvzpZt9yXN3WKrLRrCqMnhak/exCvd0xXqJyem/vxnZlIsUE7qyODhHAHciQ2j8DG0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790446613; c=relaxed/simple;
	bh=hk+1oLeewzqEHpWSpLQz8RKcG9oqYIy2qVb2Fs4xemM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2O/p0iDRdKt/pMAGWeDy6xty1XE8k65KkOaq7rbHTLv0mhoo8fVhL8a5cUnONM2bI78ae4t1TP62A9TojpZzMGmxYiUI8YiEkH0niIHK+yv1MO4RUMuR9UGOFnCjUKkPrrhA8ko3starVe6rXcteZEUo9lR0bvnAUKyLWi6BSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=cKbNI1Wz; arc=none smtp.client-ip=184.106.54.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="cKbNI1Wz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1790446018;
	bh=hk+1oLeewzqEHpWSpLQz8RKcG9oqYIy2qVb2Fs4xemM=;
	h=From:To:Subject:Date:From;
	b=cKbNI1Wzyd1v4/VNw1VuLO+u3QgIpxe03fzcu8VpUxIwkZpSqQGs5Hf6kwXUEDbfF
	 v99G6XuTNAzqcIUoYrXOv8bp0vl9n/NrPaBgpb4YbWk5gPUrs0XKDmwfZ4a+4SrK1k
	 r3p9TkyHBpWyGyjgLg+Z+wH8Qr0f28wUxe7wkfTI=
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 6529BA01E2;
	Sat, 26 Sep 2026 14:06:58 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH] p5551: fix repeated runs with update-ref --no-deref
Date: Sat, 26 Sep 2026 14:06:48 -0400
Message-ID: <20260926180648.60770-1-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 59f5d56c-e2f6-4e23-9d83-b44f64f96617-1-1

Update p5551-fetch-rescan.sh to pass `--no-deref` when deleting child
test refs before each measured `git fetch`.  Otherwise, for repeated
runs, the second iteration will fail with:

    fatal: multiple updates for 'refs/remotes/origin/master' (including
    one via symref 'refs/remotes/origin/HEAD') are not allowed

Starting with 3f763ddf28 (fetch: set remote/HEAD if it does not exist,
2024-11-22), `git fetch` instantiates the HEAD symref.

The test, introduced in 7893bf1720 (p5551: add a script to test fetch
pack-dir rescans, 2017-11-20), predates that.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/perf/p5551-fetch-rescan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p5551-fetch-rescan.sh b/t/perf/p5551-fetch-rescan.sh
index b99dc23e32..0b3ff632fc 100755
--- a/t/perf/p5551-fetch-rescan.sh
+++ b/t/perf/p5551-fetch-rescan.sh
@@ -45,7 +45,7 @@ test_perf 'fetch' '
 	(
 		cd child &&
 		$MODERN_GIT for-each-ref --format="delete %(refname)" refs/remotes |
-		$MODERN_GIT update-ref --stdin &&
+		$MODERN_GIT update-ref --stdin --no-deref &&
 		rm -vf .git/objects/$(echo $obj | sed "s|^..|&/|") &&
 
 		git fetch

base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
2.55.0

