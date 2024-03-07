Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A713A24B
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844637; cv=none; b=LKTSQzc5ZcJGcoY7pp3GYcjwn1AWw96SIROIJwheDQBCFHiKfoa2/P6vFLt+yFZ1h5QY+ySCgrmLm20ZshCfU4uC6es8VCHFzZ4pX3n0ahFKehsu82rOG/9TYoRiTONF15LfjGR2clRRWoudT2PPLa3OW9MMweyQArxZoid70cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844637; c=relaxed/simple;
	bh=SH399uAtQAUGBz9OOdRwBNfJ96xCl0MwOCBHN7SOFLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMxRl8gC+1AOUy2bCOSDfsvbw9PtwmSmKpXSBkgeI3MZcAg9wZrGF4WoH68/DIJDTZfXejOiD5PLBC4aVZ+kNp+RYkPTCygfMcgyOx4KBT90269ncop9iymU4zeRW7KdP/QEWCs+qTtFYl2i3Uf+6YPpizYzXzzpdlu8iXUFkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=SNoVFQHh; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="SNoVFQHh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1709844634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0suVef8CxKuo1yRiZdfLSLzbyJC5A3RBylIp6QHI8c=;
	b=SNoVFQHhypFVnfciezdE7DDmKJymsgL8cc2TD6974SXknmmZ402QN8udUDvEburCQiiOZa
	Q2vC8YLWyjxK3jfMMat+nZkcRh+O73PaaYhWN5crG5Hj5aehXa/z3bRtfRaAjQWDY42+hK
	xhTD+q/wD368fqKs7l3k22ldho0a1hxbuGQ4lTpk5SVzOHJtwv5MTZKGxSOlikApOlRkTj
	UBXpjfWj8T1h8YFO1PpiCck+EsTvzQr3AW0D8YLcizMqgkEtOSSjurGxHtF0dOlms+OPiP
	TAS/+MvEAxtjhti3ARl1PGzGq8XWSMkt99eL64OgeTHyMskzO53pjoeO/WvAwA==
From: Ignacio Encinas <ignacio@iencinas.com>
To: git@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>
Subject: [RFC PATCH 1/1] config: learn the "hostname:" includeIf condition
Date: Thu,  7 Mar 2024 21:50:06 +0100
Message-ID: <20240307205006.467443-2-ignacio@iencinas.com>
In-Reply-To: <20240307205006.467443-1-ignacio@iencinas.com>
References: <20240307205006.467443-1-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, customizing the configuration depending on the machine running
git has to be done manually.

Add support for a new includeIf keyword "hostname:" to conditionally
include configuration files depending on the hostname.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 Documentation/config.txt  |  9 +++++++++
 config.c                  | 16 ++++++++++++++++
 t/t1305-config-include.sh | 22 ++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e3a74dd1c1..9a22fd2609 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
+`hostname`::
+	The data that follows the keyword `hostname:` is taken to be a
+	pattern with standard globbing wildcards. If the current
+	hostname matches the pattern, the include condition is met.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -261,6 +266,10 @@ Example
 	path = foo.inc
 [remote "origin"]
 	url = https://example.com/git
+
+; include only if the hostname of the machine matches some-hostname
+[includeIf "hostname:some-hostname"]
+	path = foo.inc
 ----
 
 Values
diff --git a/config.c b/config.c
index 3cfeb3d8bd..e0611fc342 100644
--- a/config.c
+++ b/config.c
@@ -317,6 +317,20 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	return ret;
 }
 
+static int include_by_hostname(const char *cond, size_t cond_len)
+{
+	int ret;
+	char my_host[HOST_NAME_MAX + 1];
+	struct strbuf pattern = STRBUF_INIT;
+	if (xgethostname(my_host, sizeof(my_host)))
+		return 0;
+
+	strbuf_add(&pattern, cond, cond_len);
+	ret = !wildmatch(pattern.buf, my_host, 0);
+	strbuf_release(&pattern);
+	return ret;
+}
+
 static int add_remote_url(const char *var, const char *value,
 			  const struct config_context *ctx UNUSED, void *data)
 {
@@ -406,6 +420,8 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
+		return include_by_hostname(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 5cde79ef8c..ee78d9cade 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -357,4 +357,26 @@ test_expect_success 'include cycles are detected' '
 	grep "exceeded maximum include depth" stderr
 '
 
+test_expect_success 'conditional include, hostname' '
+	echo "[includeIf \"hostname:$(hostname)a\"]path=bar12" >>.git/config &&
+	echo "[test]twelve=12" >.git/bar12 &&
+	test_must_fail git config test.twelve &&
+
+	echo "[includeIf \"hostname:$(hostname)\"]path=bar12" >>.git/config &&
+	echo 12 >expect &&
+	git config test.twelve >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'conditional include, hostname, wildcard' '
+	echo "[includeIf \"hostname:$(hostname)a*\"]path=bar13" >>.git/config &&
+	echo "[test]thirteen=13" >.git/bar13 &&
+	test_must_fail git config test.thirteen &&
+
+	echo "[includeIf \"hostname:$(hostname)*\"]path=bar13" >>.git/config &&
+	echo 13 >expect &&
+	git config test.thirteen >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0

