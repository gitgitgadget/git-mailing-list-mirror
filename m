Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE883DD521
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523032; cv=none; b=XyO10f//esUdLA0bZrKKY5bJorjYrPPsn746KtcYn7YQyTTiTlFFrTB+fMlkSqaZjcYZSTZfF7HsNptbOK5UxDd9WzvjuxNoOEFGW0w9ZpdhKyTfZYL2gfcH7QEy026dqWReATJyV5sE9bEYHL/3Am1QNpG56XknbV+2Y4E8UrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523032; c=relaxed/simple;
	bh=gogqgf0fbkvltCFIDaAxazSLQJkAE+YXDdBcJ/o7GHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=b5q0nthBbOgPhVy+BnFVj5Nfl/5+INB5sBCGdYWwZEMoUlogEtqPz5HXQkAcMbPhSS/mMrguvZVsF/rYDAmhhgz2QCEIQryzjyZTKUeXEqvwXklb4lJCJkJOJ4SjQGlAf0MctOyrh/WWC/BdqPPYAYb9DjdsJT1bG6Wl+/npNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pNH4e2wN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pNH4e2wN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783523026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEPHydkMkoRxBUy9CRoqtTV6ok1PFYu0CAlwFCHeHNA=;
	b=pNH4e2wN+pPq+CUxcwMHrM4RrDdPZZqrhRLoWH2DlokkN6hZqQm5JUxckiZc8i0UBYPXo1
	hv7ecUHw15naGJ3XxYBvsgnExRCtkIA3EnECIxSgqcrFPihiZJsP5QZ2ZRVtgBiyIMJtEK
	rnUsCf7E+EVJ+DQgnBS/CwvL8tJw+9E=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/2] Fix fatal error in git-clone(1) when reading empty
 bundle-URI
Date: Wed, 08 Jul 2026 17:03:33 +0200
Message-Id: <20260708-toon-bundle-uri-no-uri-v2-0-09a03d8db556@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkxbGgRX3sOwKGWQMdghbSEaw
 t0FPICrn5f8/98iIgbCKK7ZIgLOFIn9BvqUCddb/0CgdmOhpS6kkSUkZg/N5NsBYQoEno/Qpis
 KZU1VWiu28Riwo/dxfK9/HKfmiS7tb3ujp5g4fA7zrPbeX8msQEFrrMS8yi/Y2BtxcsPZ8UvU6
 7p+AeYVw6fOAAAA
X-Change-ID: 20260408-toon-bundle-uri-no-uri-24f661a498aa
In-Reply-To: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
References: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

This patch is a leftover from [1]. In that series I submitted two
patches. Because that series was submitted a long time ago, I'm
submitting this as a new series.

The first patch is in meantime superseded by [2], and thus is dropped
from this series.

The second patch fixes a misleading "fatal: expected 'packfile'" error
that occurs when cloning over HTTP from a server with misconfigured
bundle-URIs. It is modified to address Junio's concerns[3]:

> I tend to agree.  Instead of papering over a misconfiguration, it
> would be better to let the users know, so they have a chance to
> report and/or correct such a misconfiguration.

To reiterate, in the previous series I changed the error() to a
warning() and Justin and Junio both didn't like this. In this series I
didn't remove the error(), but instead I'm ensuring the read buffer is
flushed before get_remote_bundle_uri() exits. This leaves a clean state
behind and clone can continue. (more details in the commit message).

In reply to that other series, Justin also insisted to implement a
server-side fix when bundles are misconfigured, and thus he provided the
second patch. This patch fixes bundles with an empty `uri`, but not with
a missing `uri`, that would require a substantial change which is
outside the scope of this series.

Because bundle-URIs are optional by design, I believe the changes in
this series are sufficient. Also, the series [2] takes a similar
approach: have the client gracefully continue in case of misconfigured
bundles.

[1]: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
[2]: <pull.2134.v2.git.git.1766160106521.gitgitgadget@gmail.com>
[3]: <xmqqbjnfmvwo.fsf@gitster.g>

Greets,
Toon

---
Changes in v2:
- Add second patch provided by Justin that fixes empty bundle `uri` on
  the server-side.
- Extend inline code comments about continuing the loop in
  get_remote_bundle_uri().
- Extend tests to check error message presented to the user.
- Link to v1: https://patch.msgid.link/20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com

---
Justin Tobler (1):
      bundle-uri: stop sending invalid bundle configuration

Toon Claes (1):
      bundle-uri: drain remaining response on invalid bundle-uri lines

 bundle-uri.c                 |  8 ++++++--
 connect.c                    | 15 ++++++++++++---
 t/lib-bundle-uri-protocol.sh | 23 +++++++++++++++++++++++
 t/t5558-clone-bundle-uri.sh  | 29 +++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 5 deletions(-)

Range-diff versus v1:

1:  b2e52ca7fc ! 1:  22a9017826 bundle-uri: drain remaining response on invalid bundle-uri lines
    @@ Commit message
     
         This error is bubbled up to `transport_get_remote_bundle_uri()`, which
         is called by `cmd_clone()` in builtin/clone.c. Over here, the return
    -    value of is ignored, so clone continues.
    +    value is ignored, so clone continues.
     
         Despite this, it still dies with this error:
     
    @@ connect.c: int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
      		const char *line = reader->line;
      		line_nr++;
      
    -+		/* Do not parse if an error was encountered */
    ++		/*
    ++		 * Do not parse if an error was encountered, but
    ++		 * continue draining the response so no stale data
    ++		 * is left in the reader for subsequent protocol
    ++		 * exchanges.
    ++		 */
     +		if (err)
     +			continue;
     +
    @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'bundles with newline in target
     +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.bundle-1.creationToken 1 &&
     +
     +	git -c transfer.bundleURI=true clone \
    -+		"$HTTPD_URL/smart/no-uri.git" target-no-uri
    ++		"$HTTPD_URL/smart/no-uri.git" target-no-uri 2>err &&
    ++	test_grep "bundle ${SQ}bundle-1${SQ} has no uri" err &&
    ++	test_grep ! "expected packfile" err
     +'
     +
     +test_expect_success 'bundles advertised with empty URI' '
    @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'bundles with newline in target
     +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.creationToken 1 &&
     +
     +	git -c transfer.bundleURI=true clone \
    -+		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri
    ++		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri 2>err &&
    ++	test_grep "bundle ${SQ}bundle-1${SQ} has no uri" err &&
    ++	test_grep ! "expected packfile" err
     +'
     +
      # Do not add tests here unless they use the HTTP server, as they will
-:  ---------- > 2:  5d31c12afb bundle-uri: stop sending invalid bundle configuration


---
base-commit: f85a7e662054a7b0d9070e432508831afa214b47
change-id: 20260408-toon-bundle-uri-no-uri-24f661a498aa

