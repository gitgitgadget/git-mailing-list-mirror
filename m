Received: from flyer.ispras.ru (flyer.ispras.ru [83.149.199.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142B2BCFB
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729956; cv=none; b=iQTHMlzeCAkY62t5XEOnwfQ2yd/nB3m0+1K+28PheaBHYUhmCZS6g7P07UBJfn9ueR2DcCS702fWwacCyOONnYEnHQd55ltnY6Mtn88SorLKn1OaVb9P0P1c1SocLeczEVcVfK7tiLSASm0ZWhVBKoTIrNlAqbeJtwZ6z0WfKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729956; c=relaxed/simple;
	bh=OnJe1xeXpvmotF2SuA/43ElhOC0q1eCJ5ZuhTGyZX4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zhr6tOz255A13ecmZ693n4qBPHiKxdX5ueajMJnKqhyUB1tQgg1hCNdbyKumVffVF2tvcImS30vQjs+XzjiEMDQaCTisznwaGkLcjViBGhHrlHCSYSSOXqCzXGV592KOh+g7ab6EMK2+ehIUUdWe0hT41ObEUYc7OgN/qQ0IgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Ov26ggr7; arc=none smtp.client-ip=83.149.199.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Ov26ggr7"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by flyer.ispras.ru (Postfix) with ESMTP id 960D51407048;
	Mon, 28 Jul 2025 22:05:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 flyer.ispras.ru 960D51407048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1753729529;
	bh=klSyRtFrglWAfXJ7xZKQcGwfF6URJ3yoS6Qo1+ruvao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ov26ggr7vhg8X1lBTTqF/38ptVUj62xFlmiDko2tAJMJKBRwhBo7VfQIoRNjD4czd
	 1si5Z0hT0+6O/JgOBg0Mn0V9iTahjKKBK24jPlOpgthINf6dYEoKQl8PI6AiMAXiws
	 bbugggrdJcbZ3Im446x8wDsXWBgmWbcw607YCyi8=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 1/2] xdiff: refactor xdl_hash_record()
Date: Mon, 28 Jul 2025 22:05:19 +0300
Message-ID: <20250728190520.10962-2-amonakov@ispras.ru>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20250728190520.10962-1-amonakov@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Inline the check for whitespace flags so that the compiler can hoist
it out of the loop in xdl_prepare_ctx(). This improves the performance
by 8%.

$ hyperfine --warmup=1 -L rev HEAD,HEAD^  --setup='git checkout {rev} -- :/ && make git' ': {rev}; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'
Benchmark 1: : HEAD; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
  Time (mean ± σ):      1.670 s ±  0.044 s    [User: 1.473 s, System: 0.196 s]
  Range (min … max):    1.619 s …  1.754 s    10 runs

Benchmark 2: : HEAD^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
  Time (mean ± σ):      1.801 s ±  0.021 s    [User: 1.605 s, System: 0.192 s]
  Range (min … max):    1.766 s …  1.831 s    10 runs

Summary
  ': HEAD^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0' ran
    1.08 ± 0.03 times faster than ': HEAD^^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xutils.c |  7 ++-----
 xdiff/xutils.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 444a108f87..e070ed649f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -249,7 +249,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	return 1;
 }
 
-static unsigned long xdl_hash_record_with_whitespace(char const **data,
+unsigned long xdl_hash_record_with_whitespace(char const **data,
 		char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
@@ -294,13 +294,10 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 	return ha;
 }
 
-unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
+unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
 
-	if (flags & XDF_WHITESPACE_FLAGS)
-		return xdl_hash_record_with_whitespace(data, top, flags);
-
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		ha += (ha << 5);
 		ha ^= (unsigned long) *ptr;
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fd0bba94e8..13f6831047 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -34,7 +34,15 @@ void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_blankline(const char *line, long size, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
-unsigned long xdl_hash_record(char const **data, char const *top, long flags);
+unsigned long xdl_hash_record_verbatim(char const **data, char const *top);
+unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top, long flags);
+static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
+{
+	if (flags & XDF_WHITESPACE_FLAGS)
+		return xdl_hash_record_with_whitespace(data, top, flags);
+	else
+		return xdl_hash_record_verbatim(data, top);
+}
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-- 
2.44.2

