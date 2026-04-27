Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E31B78F3
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249548; cv=none; b=YkQbK/B8cOPuihHM2C6s8tZIvjfYl6QLfoO7sE8QrMoAauOyT9uQgQhrtRyNiR0j9UKxoOvEwyjyo1dxDJney63rtSXgdeyHr3MtjN6t5hIIupMTCwURbyZBye7AeJBbT9h9pctxr/i6XodUABiF1E6eFaH1aPB54yu1W+ecwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249548; c=relaxed/simple;
	bh=5UrVN6jnc2zfaXAoR4Xac8PsovHmrD9vF7uraDwi1Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnhU76P/cdaW5hOeL65BGZpiPI5mRkeIa6edcYOuIM6gnU32Y204eVNBxPvZUggwv3pYsSrzqMHTa7iXdn2L4gJynUrKYBuTRFflRYg/JujbAMOPU8nngpolEI/xyvT9Hgey9px3W5tivlRQkvavoqOtbvVU7mWoFCTrfh6rk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=WnDyyIoX; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="WnDyyIoX"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1777249538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NGq3ty7017QE+T3OLciHLcMq2wpNHhE/PzxQXcd5QI=;
	b=WnDyyIoXrZDkNwtsUsbO3GMg784QjAQuv0FUgACO2LC97emdYgnkybD6/40lKpdHCjlptd
	qxZReLedm3HaFQhpnJKiusKNeI4KDMQEySU9mLFkHBDiV/+f67nL7THosT6C8DDMdWO0iD
	6S39gtyrBmjF+LmLPLgHfSAG1bTweGFH8ZfaIK7g98oR67j7+c1XEh0Nd1Bf+UnOUPIShO
	LMLgBxX7IMf/nHQBcamQjt3l1z4DHCO/Q6hDkKgHVbcyFG0Opm7exu+V/sLW+hVwbiSOZy
	LXx67Qhv/ubfu3E8faJyHP39Uwex1j19tjIZliS2u0IH85GNdn8+SwYb2JOe6w==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v4 0/2] revision.c: implement --reverse=before for walks
Date: Mon, 27 Apr 2026 02:24:56 +0200
Message-ID: <cover.1777249165.git.mroik@delayed.space>
In-Reply-To: <cover.1776984666.git.mroik@delayed.space>
References: <cover.1776984666.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=mroik@delayed.space; h=from:subject:message-id; bh=5UrVN6jnc2zfaXAoR4Xac8PsovHmrD9vF7uraDwi1Cs=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp7qzYPevhmGzKmc+gt9RfjjvMboZBDXoLcExbA 6frIF3SXJKJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCae6s2AAKCRBIeX6hnBm+ 0RtxD/95v+LIhGR+K5dWWhvimZhslUIdUgLwkdY3S3tXTs0joNhs8Yco/AQ3C35RslrJLok+jgs Q2nsOsD6/Y4woYUYGT4vKDvdhNT5RSevO6M1qvd3RYiQkdSsp41vyERJA3d7d09ci7ACjZo53nK GYcUffnCx5DGOHxkF5qj11HudXeO4c4fDDajUGwDm4xGCh2oAdbsmNdKf5XACObk9Eq2LStOI7p JssQuvlglI/BzuD7hhht0CMjMiLoDTgYjWcMrlkdDCFNCooI4BZycw2rOmRtS/7qp8FwqosdPR/ 2HVvXNtjX7IWSF3kt4BGNNInMEAN84a1uEfnPVkBXJBHnFfVbSM/OPTDK2hhlmNzzNZs/iN46VX meemWfavXTfRO85lpQuQp5IWvcIJk3RGDC88p9R9o5hifQn7FbAoG4CnBf+g/dzRcbgItduQBnS du48n6TPmoMOBKxbP6VV5aPEzFA/C3lQr0VEnbkmTv1+tXkc/cIBu+eshHb4tmim21fg7rI5uQH 7mtJ0bQBmns4Q/vjSbmErwctymtyP1nBt7QMbO8RCgsoxTt01XKOt8g4vLtdFhFJgVeY4GbenEJ oUFjWy/vtugLZrTurWX91m4XcRKEdgtpYNnI3TwgFBmu0aqWJ5vyR4yMLSf1qXu2MDpRNxfrVuU kFFL7ReMA
 nzJbCg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

v4 aligns the behaviour for --reverse=before and --reverse=after on
negative numbers that are less than -1 to treat them the same as -1,
which is current behaviour (before this series).

[1/2] revision.c: implement --reverse=before for walks (Mirko Faina)
[2/2] revision.c: reduce memory usage on reverse before (Mirko Faina)

 Documentation/rev-list-options.adoc | 16 +++++--
 revision.c                          | 73 +++++++++++++++++++++++++++--
 revision.h                          |  8 +++-
 t/t4202-log.sh                      | 66 ++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 10 deletions(-)

Range-diff against v3:
1:  4864ac46dd = 1:  4864ac46dd revision.c: implement --reverse=before for walks
2:  00489b0e52 ! 2:  7c0bab5d14 revision.c: reduce memory usage on reverse before
    @@ Commit message
         revision with --reverse=before and --max-count=<k>. We do this through a
         simple queue. With N nodes and K as the --max-count argument, assuming K
         < N, we go from a space complexity of O(N) to O(K). When it comes down
    -    to time complexity, the queue has an ammortized time of O(1) for pops,
    -    so the complexity remains O(N).
    +    to time complexity, the queue has an amortized time of O(1) for pops, so
    +    the complexity remains O(N).
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
     
    @@ revision.c: struct commit *get_revision(struct rev_info *revs)
      		reversed = NULL;
     -		while ((c = get_revision_internal(revs)))
     -			commit_list_insert(c, &reversed);
    -+		if (revs->reverse == REVERSE_BEFORE && max_count != -1) {
    ++		if (revs->reverse == REVERSE_BEFORE && max_count >= 0) {
     +			retrieve_with_window(revs, max_count, &reversed);
     +		} else {
     +			while ((c = get_revision_internal(revs)))

base-commit: e8955061076952cc5eab0300424fc48b601fe12d
-- 
2.54.0

