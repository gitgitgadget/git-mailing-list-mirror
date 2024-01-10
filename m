Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3BC495C5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=to1.studio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="GUH7Gq6Z"
From: Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1704896188;
	bh=CJmDSCYVQG7fBiAf+4PYa4MA9ksU65l6lTncYi395ws=;
	h=From:To:Subject:Date:Message-ID:Mime-Version:
	 Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition:Mime-Version:
	 Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=GUH7Gq6Zj56cY+myr+rCxpiaFgbHPsdUnx0CKmuXDCwwQmqCPYm/gXG3egYtNSdov
	 KdeTpmW4pqUmBUozBhoxheUv16+p0EDfr1jZLDpxEnkCOwpobQw9k6h7YVoDnepLWv
	 I0dVSl5/77O4HhcD5TKsjTzBpviqraxiMyDyAyZCBm57jgOtsOHK6wXLnT+NvF5n4n
	 BUAzBTRgrjeGjkBqUa0CJG5vBs4a0yA7c2Tpz83l7LXvFGSzi1sb8BbSV1XlSEQSwV
	 K3Z/6A/XzdRusPjY0VtJnf5U3rnpQv7S6ERuq7BDniZDtl52m3VjXPfeKFyDqSJHMu
	 MkYxUh6JMciDQ==
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/1] Fix error message in git-show-ref(1) --exists
Date: Wed, 10 Jan 2024 15:15:58 +0100
Message-ID: <20240110141559.387815-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

References can validly contain forward slashes in their name. With the ref files
backend, these are stored as a directory tree. This means when you look up a
reference, you might find a directory where you expected a file.

This causes the option --exists, recently added to git-show-ref(1), to return
the following error:

    error: failed to look up reference: Is a directory

Other backends, like reftables, might store refs with forward slashes
differently. So they will not encounter the same error.

To make the error consistent across refs backend implementations, and to be more
clear to user, hide the error about having found a directory as a generic error:

    error: reference does not exist

Toon Claes (1):
  builtin/show-ref: treat directory directory as non-existing in
    --exists

 builtin/show-ref.c  | 2 +-
 t/t1403-show-ref.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
--
2.42.1
